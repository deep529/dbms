-- dropping tables
DROP TABLE IF EXISTS product_consumer_train;
DROP TABLE IF EXISTS rating_train;
DROP TABLE IF EXISTS test_data;
DROP TABLE IF EXISTS sim_table;
DROP TABLE IF EXISTS pred_table;
DROP TABLE IF EXISTS output_table;

-- creating tables
CREATE TABLE product_consumer_train
(
	Id INT NOT NULL PRIMARY KEY,
	ProductId INT NOT NULL,
	ConsumerId INT NOT NULL
);

CREATE TABLE rating_train
(
	Id INT NOT NULL PRIMARY KEY,
	Rating INT NOT NULL,
	Timestamp TIMESTAMP NOT NULL
);

CREATE TABLE test_data
(
	Id INT NOT NULL PRIMARY KEY,
	ProductId INT NOT NULL,
	ConsumerId INT NOT NULL,
	Timestamp TIMESTAMP NOT NULL
);

-- dumping the tables
\COPY product_consumer_train(Id, ProductId, ConsumerId) FROM '/home/devansh/Desktop/dbms2/hackathon/rate-the-product/product_consumer_train.csv' DELIMITER ',' ENCODING 'unicode' CSV HEADER;
\COPY rating_train(Id, Rating, Timestamp) FROM '/home/devansh/Desktop/dbms2/hackathon/rate-the-product/rating_train.csv' DELIMITER ',' ENCODING 'unicode' CSV HEADER;
\COPY test_data(Id, ProductId, ConsumerId, Timestamp) FROM '/home/devansh/Desktop/dbms2/hackathon/rate-the-product/test_data.csv' DELIMITER ',' ENCODING 'unicode' CSV HEADER;

create materialized view pcr_view as select p.Id, p.ProductId, p.ConsumerId, r.Rating, r.Timestamp from rating_train as r join product_consumer_train as p on r.Id = p.Id;

-- for making final csv
\COPY output_table(Id, Rating) TO '/home/devansh/Desktop/out.csv' DELIMITER ',' ENCODING 'unicode' CSV HEADER;