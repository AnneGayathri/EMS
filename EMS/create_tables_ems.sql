-- EMS tables
create table t_cus_stage (CRMId varchar(255), CName varchar(255) not null,  CIdentifier varchar(100) unique,
Description varchar(510), RefId varchar(255), ExternalId varchar(255) unique,
Address varchar(100), Region varchar(100),
Country varchar(100));

create table t_migration_log (MId int primary key auto_increment, log varchar(510), CreationTime datetime);

-- Students Database tables
create table student (SId int primary key auto_increment, SName varchar(100), SAddress varchar(255));

create table course (CId int primary key auto_increment, CName varchar(255) unique, CDuration varchar(255));

create table student_course (SId int, CId int, primary key(SId, CId),
foreign key (SId) references student(SId) on delete cascade on update cascade,
foreign key (CId) references Course(CId) on update cascade on delete cascade);

create table teacher (Tid int primary key auto_increment, TName varchar(255), Email varchar(255) unique);

create table teacher_course(TId int , CId int, primary key(TId, CId),
foreign key (TId) references teacher(TId) on delete cascade on update cascade,
foreign key (CId) references Course(CId) on update cascade on delete cascade );