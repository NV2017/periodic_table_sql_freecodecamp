#!/bin/bash

# Esabtlish link to SQL
PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

Step_1=$($PSQL "alter table properties rename column weight to atomic_mass;")

Step_2=$($PSQL "alter table properties rename column melting_point to melting_point_celsius;")

Step_3=$($PSQL "alter table properties rename column boiling_point to boiling_point_celsius;")

Step_4=$($PSQL "alter table properties alter column melting_point_celsius set not null;")

Step_5=$($PSQL "alter table properties alter column boiling_point_celsius set not null;")

Step_6=$($PSQL "alter table properties alter column boiling_point_celsius set not null;")

Step_7=$($PSQL "alter table elements add constraint c_e_s_u unique(symbol);")

Step_8=$($PSQL "alter table elements add constraint c_e_n_u unique(name);")

Step_9=$($PSQL "alter table elements alter column symbol set not null;")

Step_10=$($PSQL "alter table elements alter column name set not null;")

Step_11=$($PSQL "alter table properties add constraint fk_an_p_e_an foreign key(atomic_number) references elements(atomic_number);")

Step_12=$($PSQL "create table types(type_id int primary key,type varchar not null);")

Step_13=$($PSQL "insert into types(type_id,type) values(1,'metal'),(2,'metalloid'),(3,'nonmetal');")

Step_14=$($PSQL "alter table properties add column type_id int;")

Step_15=$($PSQL "update properties set type_id=1 where type='metal';")

Step_16=$($PSQL "update properties set type_id=2 where type='metalloid';")

Step_17=$($PSQL "update properties set type_id=3 where type='nonmetal';")

Step_18=$($PSQL "alter table properties alter column type_id set not null;")

Step_19=$($PSQL "alter table properties add constraint fk_p_ti_t_ti foreign key (type_id) references types(type_id);")

Step_20=$($PSQL "update elements set symbol=upper(left(symbol,1)) || substring(symbol,2,length(symbol));")

Step_21=$($PSQL "alter table properties alter COLUMN atomic_mass type decimal;")
Step_22=$($PSQL "update properties set atomic_mass=trim(trailing '0' from cast(atomic_mass as text))::decimal;")
Step_23=$($PSQL "insert into elements (atomic_number,symbol,name) values(9,'F','Fluorine');")
Step_24=$($PSQL "insert into properties (atomic_number,type,atomic_mass,melting_point_celsius,boiling_point_celsius,type_id) values(9,'nonmetal',18.998,-220,-188.1,3);")

Step_25=$($PSQL "insert into elements (atomic_number,symbol,name) values(10,'Ne','Neon');")
Step_26=$($PSQL "insert into properties (atomic_number,type,atomic_mass,melting_point_celsius,boiling_point_celsius,type_id) values(10,'nonmetal',20.18,-248.6,-246.1,3);")
Step_27=$($PSQL "alter table properties drop column type;")
Step_28=$($PSQL "delete from properties where atomic_number=1000;")
Step_29=$($PSQL "delete from elements where atomic_number=1000;")
