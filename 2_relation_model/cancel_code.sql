DROP TABLE Cancellation_code;

CREATE TABLE Cancellation_code
(
    code char(1) NOT NULL,
    code_description text NOT NULL,
    PRIMARY KEY (code)
);

\COPY Cancellation_code(code, code_description) FROM '/home/deep/Documents/dbms/2_relation_model/csv/cancellation_codes.csv' DELIMITER ',' ENCODING 'unicode' CSV HEADER;