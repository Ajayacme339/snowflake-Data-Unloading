CREATE OR REPLACE DATABASE UNLOAD_DEMO;
CREATE OR REPLACE SCHEMA UNLOAD_DEMO.DEMO;
USE SCHEMA UNLOAD_DEMO.DEMO;

CREATE OR REPLACE TABLE customers (
  id INT, name STRING, city STRING,
  signup_date DATE, amount NUMBER(10,2));

INSERT INTO customers VALUES
 (1,'Asha','Pune','2026-01-10',250.50),
 (2,'Ravi','Delhi','2026-02-15',120.00),
 (3,'John','Pune','2026-03-01',980.75);

CREATE OR REPLACE FILE FORMAT my_csv_ff
  TYPE = CSV FIELD_DELIMITER = ','
  FIELD_OPTIONALLY_ENCLOSED_BY = '"'
  NULL_IF = ('NULL') COMPRESSION = GZIP;

CREATE OR REPLACE STAGE my_int_stage
  FILE_FORMAT = my_csv_ff;

  select * from customers;

  SHOW FILE FORMATS;

  DESC STAGE my_int_stage;

  DROP STAGE my_int_stage;

  --------UNLOAD DATA FROM TABLE to Named Stage 
  COPY INTO @my_int_stage/customers
  FROM customers
  HEADER = TRUE;

  LIST @my_int_stage/customers;

  select $1,$2 from @my_int_stage/customers;
 --------UNLOAD DATA FROM TABLE to User Stage -----
COPY INTO @~/unload/customers
  FROM customers
  HEADER = TRUE;

  list @~/unload/customers;

  --------------------UNLOAD DATA FROM TABLE to Table Stage----
 COPY INTO @%customers/export/
  FROM customers
  HEADER = TRUE
  OVERWRITE = TRUE
  SINGLE = TRUE 
  DETAILED_OUTPUT = TRUE;
  --INCLUDE_QUERY_ID = TRUE;
  
  --FORCE = TRUE;

  list  @%customers/export/;

  150-250 MB ;

  

  

  
  