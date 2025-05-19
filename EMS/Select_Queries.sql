-- To get entitlement details 
select e.EId, c.CSTMRName, co.EmailId, p.PRDName,lt.quantity, f.FTRName, l.LMName 
from t_ent e
inner join t_cstmr c on e.CSTMRId = c.CSTMRId
left join t_contact co on e.CONTId = co.CONTId
inner join t_ent_line_item lt on e.ENTId = lt.ENTId
inner join t_ent_ftr_lm efl on e.ENTID = efl.ENTID
inner join t_prd p on p.PRDId = efl.PRDId
inner join t_ftr f on f.FTRId = efl.FTRId
inner join t_lm l on efl.LMId = l.LMId where lt.quantity > 1 order by e.ENTId desc limit 100 ;

-- To get customer details
select c.CSTMRId,c.CSTMRName,c.createdby, m.marketgroupname, coalesce(co.EmailId, 'No associated user') as EmailId from t_cstmr c
inner join t_market_group m on m.marketgroupid = c.marketgroupid
left join t_contact co on c.CSTMRId = co.CSTMRId limit 200;

-- To get customer details and their orders
select c.CSTMRName, e.EId, p.PRDName, lt.quantity, coalesce(par.PartnerName, 'No partner') as Partner_Name, coalesce(con.EmailId, 'No associated user') as EmailId,
 ca.AttrName, ca.AttrValue from t_cstmr c 
inner join t_ent e on c.CSTMRId = e.CSTMRId
inner join t_ent_line_item lt on e.ENTId = lt.ENTId
inner join t_prd p on lt.PRDId = p.PRDId
inner join t_ent_partner_ref pref on e.ENTId = pref.ENTId
left join t_partner par on pref.PartnerId = par.PartnerId
left join t_contact con on c.CSTMRId = con.CSTMRId
inner join t_tmpl_attr_value ca on c.CSTMRId = ca.EntityId  
where  c.CSTMRId = 4923 and ca.TemplateType = 4 and ca.AttrValue is not null limit 5;

-- To get Products with its features and license models
select p.PRDName, f.FTRName, l.LMName from t_prd p
inner join t_prd_ftr_ref pf on p.PRDId = pf.PRDId
inner join t_ftr f on pf.FTRId = f.FTRId
inner join t_prd_ftr_lm pfl on pf.Id = pfl.PrdFtrRefId
inner join t_lm l on pfl.LMId = l.LMId limit 10;

-- To get Activation details
select e.EId, c.CSTMRName, co.EmailId, par.PartnerName, p.PRDId, p.PRDName, f.FTRName, l.LMName, ea.AId, ea.ActivationDateTime, ea.quantity, lk.KeyID, 
convert(cast(lk.keyfile as char) using utf8) as KeyFileString 
from t_ent e
inner join t_cstmr c on e.CSTMRId = c.CSTMRId
left join t_contact co on e.CONTId = co.CONTId
left join t_ent_partner_ref epr  on epr.ENTId = e.ENTId
left join t_partner par on epr.PartnerId = par.PartnerId
inner join t_ent_line_item lt on e.ENTId = lt.ENTId
inner join t_ent_activation ea on lt.LineItemId = ea.LineItemId
inner join t_license_key lk ON ea.AID_ID = lk.AID_ID
inner join t_ent_ftr_lm efl on e.ENTID = efl.ENTID
inner join t_prd p on p.PRDId = efl.PRDId
inner join t_ftr f on f.FTRId = efl.FTRId
inner join t_lm l on efl.LMId = l.LMId where lt.quantity > 1 and ea.ActivationState = 2 order by e.ENTId desc limit 100 ;

-- To convert rows to columns
select Name, ExternalId, Identifier, min(case when AttributeName = 'Country' then AttributeValue else Null end) as 'Country',
									 min(case when AttributeName = 'Address' then AttributeValue else Null end) as 'Address',
                                     min(case when AttributeName = 'Region' then AttributeValue else Null end) as 'Region'
from view1 group by Name, ExternalId, Identifier;

-- To get customer who has custom attributes
select CSTMRId from t_cstmr where CSTMRId in (select EntityId from t_tmpl_attr_value);

-- To get customer who doesn't have custom attributes
select CSTMRId from t_cstmr where CSTMRId not in (select EntityId from t_tmpl_attr_value);