import psycopg2
import time
import csv

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
print("started")
cursor.execute("DROP TABLE IF EXISTS output_table;")
cursor.execute("DROP TABLE IF EXISTS pred_table;")
cursor.execute("CREATE TABLE output_table (Id INT NOT NULL, Rating INT NOT NULL);")
cursor.execute("CREATE TABLE pred_table (ProductId INT NOT NULL, Rating INT NOT NULL);")
connection.commit()

cursor.execute("INSERT INTO pred_table SELECT ProductId, avg(Rating) FROM pcr_view GROUP BY ProductId;")
connection.commit()
print("getting output")
get_output()

end = time.time()
with open('time.csv', 'a') as csvfile:
    writer = csv.writer(csvfile)
    writer.writerow([9, str(end - start)])
