-- loading data from csv to stage table
load data infile 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\t_cus_stage_data.csv'
into table t_cus_stage
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;
