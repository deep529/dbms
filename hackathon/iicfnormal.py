import psycopg2
import time
import csv
from scipy import spatial

start = time.time()
connection = None
cursor = None

def connect():
    global connection, cursor
    try:
        connection = psycopg2.connect(
            user="postgres", password="postgres", host="127.0.0.1", port="5432", database="database")

        cursor = connection.cursor()
    except (Exception, psycopg2.Error) as err:
        print("Connection error", err)
        exit(1)

def similarity(p1, p2):
    cursor.execute("DROP VIEW IF EXISTS sim_view;")
    cursor.execute("CREATE VIEW sim_view AS SELECT t1.ConsumerId, t1.rating1, t2.rating as rating2 FROM p1_users as t1 JOIN pcr_view_limited as t2 ON (t2.ProductId = (%s) AND t1.ConsumerId = t2.ConsumerId) ;", [p2])

    cursor.execute("SELECT rating1 FROM sim_view;")
    r1 = [row[0] for row in cursor.fetchall()]

    cursor.execute("SELECT rating2 FROM sim_view;")
    r2 = [row[0] for row in cursor.fetchall()]

    if len(r1) == 0:
        return 0

    result = spatial.distance.cosine(r1, r2)

    cursor.execute("DROP VIEW sim_view;")
    return result

def get_top(n):
    cursor.execute("SELECT ProductId FROM (SELECT count(*), productid FROM test_data GROUP BY productid ORDER BY count(*) DESC LIMIT (%s)) t;", [n])
    return [row[0] for row in cursor.fetchall()]

def calculate_similarities():
    print("calculating similarities")

    pid_short = get_top(100)

    cursor.execute("SELECT DISTINCT ProductId FROM pcr_view;")
    pid_all = [row[0] for row in cursor.fetchall()]

    for i in range(len(pid_short)):
        print("\ni = {}, pid[i] = {}".format(i, pid_short[i]))
        cursor.execute("CREATE MATERIALIZED VIEW p1_users AS SELECT ConsumerId, Rating as Rating1 FROM pcr_view_limited where ProductId = (%s);", [pid_short[i]])

        for j in range(len(pid_all)):
            if pid_all[j] == pid_short[i]:
                continue

            cursor.execute("SELECT count(*) FROM sim_table where ((ProductId1, ProductId2) = (%s) OR (ProductId1, ProductId2) = (%s));", [(pid_short[i], pid_all[j]), (pid_all[j], pid_short[i])])

            if cursor.fetchone()[0] > 0:
                continue

            sim_value = similarity(pid_short[i], pid_all[j])
            print("\rj = {}, pid[j] = {}, sim = {}".format(j, pid_all[j], sim_value), end='')

            cursor.execute("INSERT INTO sim_table VALUES(%s, %s, %s);", [pid_short[i], pid_all[j], sim_value])

            if j % 100 == 0:
                connection.commit()

        cursor.execute("DROP MATERIALIZED VIEW IF EXISTS p1_users CASCADE;")

def is_sim_computed(pid):
    cur = connection.cursor()
    cur.execute("SELECT count(*) FROM sim_table WHERE ProductId1 = (%s);", [pid])

    return (cur.fetchone()[0] > 0)

def compute_from_sim(pid, cons):
    cur2 = connection.cursor()
    cur2.execute("SELECT SUM(dot_product) / SUM(Similarity) FROM (SELECT Rating * sim as dot_product, sim as Similarity FROM ((SELECT ProductId as p2, Rating FROM pcr_view where ConsumerId = (%s)) t1 JOIN (SELECT ProductId2 as p2, Similarity as sim FROM sim_table where ProductId1 = (%s)) t2 ON (t1.p2 = t2.p2)) b) a;", [cons, pid])
    return round(cur2.fetchone()[0])

def compute_from_mean(pid):
    cur2 = connection.cursor()
    cur2.execute("SELECT avg(rating) FROM pcr_view where productid = (%s);", [pid])
    return round(cur2.fetchone()[0])

def precompute_predict():
    cur2 = connection.cursor()
    cur2.execute("SELECT DISTINCT on (ProductId) Id, ProductId, ConsumerId FROM test_data;")

    pred = 0
    for row in cur2.fetchall():
        pid = row[1]
        cons = row[2]

        if is_sim_computed(pid):
            pred = compute_from_sim(pid, cons)
        else:
            pred = compute_from_mean(pid)

        cursor.execute("INSERT INTO pred_table VALUES(%s, %s);", [pid, pred])
    connection.commit()

def get_output():
    cursor.execute("DELETE FROM output_table;")
    cur2 = connection.cursor()

    cursor.execute("SELECT Id, ProductId FROM test_data;")

    for row in cursor.fetchall():
        pid = row[1]

        cur2.execute("SELECT Rating FROM pred_table where ProductId = (%s);", [pid])

        rating = cur2.fetchone()[0]
        cur2.execute("INSERT INTO output_table VALUES(%s, %s);", [row[0], rating])
    connection.commit()

connect()
cursor.execute("DROP TABLE IF EXISTS output_table;")
cursor.execute("DROP TABLE IF EXISTS pred_table;")
cursor.execute("DROP TABLE IF EXISTS sim_table;")
cursor.execute("CREATE TABLE output_table (Id INT NOT NULL, Rating INT NOT NULL);")
cursor.execute("CREATE TABLE pred_table (ProductId INT NOT NULL, Rating INT NOT NULL);")
cursor.execute("CREATE TABLE sim_table (ProductId1 INT NOT NULL, ProductId2 INT NOT NULL, Similarity NUMERIC NOT NULL, PRIMARY KEY(ProductId1, ProductId2));")
cursor.execute("DROP VIEW IF EXISTS sim_view;")
cursor.execute("DROP MATERIALIZED VIEW IF EXISTS p1_users;")

connection.commit()

calculate_similarities()
precompute_predict()
get_output()

end = time.time()
with open('time.csv', 'a') as csvfile:
    writer = csv.writer(csvfile)
    writer.writerow([9, str(end - start)])
