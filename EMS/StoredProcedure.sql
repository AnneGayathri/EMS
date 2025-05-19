drop procedure if exists impcustomerdata;
delimiter $$
create procedure impcustomerdata()
begin
 -- Customer variables
 declare done1 boolean default false;
 declare crmid_c varchar(255);
 declare cusname varchar(255);
 declare identifier varchar(100);
 declare desr varchar(510);
 declare referenceid varchar(255);
 declare extid varchar(255);
 declare customerid int;
 declare flag int default 0;
 
declare cur1 cursor for select CRMId, CName, CIdentifier, Description, RefId, ExternalId from t_cus_stage;
declare continue handler for not found set done1 = true;
start transaction;
 open cur1;

 read_cstmr_data: loop
	fetch cur1 into crmid_c, cusname, identifier, desr, referenceid, extid;
    if done1 then
    leave read_cstmr_data;
    end if;
    begin
    declare continue handler for sqlexception
   	begin
			rollback;
           set flag = 1;
   	end;

insert into t_cstmr (CSTMRCRMId, CSTMRName, CSTMRIdentifier, Descr, isEnabled, RefId, PartnerId, ExternalId, globalid, TimeZone, 
createdby, createdate, modifiedby, modifieddate, marketgroupid) 
 values (crmid_c, cusname, identifier, desr, 1, referenceid, 1, extid, uuid(), 'UTC', 'MigrationData', now(), 'MigrationData',now(),1);

 
 set customerid = last_insert_id();
 
if flag = 0 then
	insert into t_migration_log (log, CreationTime) values (concat('Insertion into customer table successfull for customerid: ', last_insert_id()), now());
else
           insert into t_migration_log (log, CreationTime) values (concat('Insertion into customer failed for customerid: ',last_insert_id()), now());
end if;
 end;
  
  
  begin
 	-- custom attribute variables
       declare done2 boolean default false;
       declare AttributeValue varchar(2000);
       declare AttributeSource varchar(100);
       declare AttributeId int;
       declare AttributeName varchar(100);
       declare flag1 int default 0;

       declare cur2 cursor for 
         select Address, 'Address' from t_cus_stage where CIdentifier = identifier
         union all
         select Region, 'Region' from t_cus_stage where CIdentifier = identifier
         union all
         select Country, 'Country' from t_cus_stage where CIdentifier = identifier;

 	  declare continue handler for not found set done2 = true;
        start transaction;
 	  open cur2;
       

       read_attr_values: loop
         fetch cur2 into AttributeValue, AttributeSource;
         if done2 then
           leave read_attr_values;
         end if;
         begin
         declare continue handler for sqlexception
       begin
       rollback;
       set flag1 = 1;
       end;
         
 select AttrId, AttrName into AttributeId, AttributeName from t_tmpl_attrs where AttrName = AttributeSource;

 insert into t_tmpl_attr_value (AttrId, EntityId, AttrValue, AttrName, TemplateType) values (AttributeId, customerid, AttributeValue, AttributeName, 4);

  
 if flag1 = 0 then
 	insert into t_migration_log (log, CreationTime) values (concat('Insertion of custom attributes successfull for customerid: ', customerid), now());
else
       insert into t_migration_log (log, CreationTime) values (concat('Insertion into custom attributes failed for customerid: ',customerid), now());

 end if;
end;
 end loop;
  close cur2;
  commit;
  end;
 
 end loop;
 
 close cur1;
 commit;
 end$$
 delimiter ;
 
 call impcustomerdata();
