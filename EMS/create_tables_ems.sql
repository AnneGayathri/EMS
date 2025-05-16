create table t_cus_stage (CRMId varchar(255), CName varchar(255) not null,  CIdentifier varchar(100) unique,
Description varchar(510), RefId varchar(255), ExternalId varchar(255) unique,
Address varchar(100), Region varchar(100),
Country varchar(100));


create table t_migration_log (MId int primary key auto_increment, log varchar(510), CreationTime datetime);