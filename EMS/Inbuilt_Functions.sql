-- Length function
SELECT LENGTH('हिंदी') as Length, CHAR_LENGTH('हिंदी') as CharLength;

-- Concat function
select concat('Hello',null,'world'), concat_ws(' ','Hello',null,'world');

-- Lower function
select lower('HELLO') as LowerCon, upper('hello') as UpperCon;

-- replace function
select replace('Hello','o','world');

-- reverse function
select reverse(cstmrname) from t_cstmr;

-- substring
select instr('Hello hello','llo');

-- returns first non null value
select ifnull(' ','Hi');
select coalesce(' ','Hi');
select coalesce(FileLoadId, 'Not Applicable') as FileLoadId, coalesce(CSTMRCRMId, 'Unique value') as CRMId from t_cstmr;
select coalesce(Null,null,'Hello');
select ifnull(Null,null,'Hello');
select coalesce(salary, custom , 'No value') from customers;

-- Ceil function
select ceil(salary) from customers;

-- rand function
select rand(salary) from customers;

-- Cast functions
select cast(12 as char);
SELECT CONVERT(CAST(keyfile AS CHAR) USING utf8) AS original_text
FROM t_license_key where AID = 'f549cdde-d306-4e54-9a5f-3ee51313de75';

-- generated globalid
select uuid();
select uuid_short();
 
-- Encryption function
SELECT md5('abc@123');
SELECT AES_DECRYPT(FROM_BASE64(cpassword), '123') FROM t_cstmr;

