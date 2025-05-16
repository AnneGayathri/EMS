create table t_cus_stage (CRMId varchar(255), CName varchar(255) not null,  CIdentifier varchar(100) unique,
Description varchar(510), RefId varchar(255), ExternalId varchar(255) unique,
Address varchar(100), Region varchar(100),
Country varchar(100));

create table t_custom_attr_stage (Address Varchar(255), Region Varchar(100), Country Varchar(100));

drop table t_cus_stage;
create table t_market_group_stage (marketgroupid int not null primary key auto_increment, marketgroupname varchar(360) not null unique, descr varchar(510), refid1 varchar(100) unique,
refid2 varchar(100) unique);





select * from t_tmpl_attrs;
select * from t_cus_stage;
select * from t_custom_attr_stage;

select e.EId, c.CSTMRName, co.EmailId, p.PRDName,lt.quantity, f.FTRName, l.LMName 
from t_ent e
inner join t_cstmr c on e.CSTMRId = c.CSTMRId
left join t_contact co on e.CONTId = co.CONTId
inner join t_ent_line_item lt on e.ENTId = lt.ENTId
inner join t_ent_ftr_lm efl on e.ENTID = efl.ENTID
inner join t_prd p on p.PRDId = efl.PRDId
inner join t_ftr f on f.FTRId = efl.FTRId
inner join t_lm l on efl.LMId = l.LMId where lt.quantity > 1 order by e.ENTId desc limit 100 ;
