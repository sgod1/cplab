--cat ae/postgresql/aaedb/create_app_engine_db.sql 
-- create a new user
create user aae_user with password 'yIpa1tbc3gGEp0Z0eDp5zf0H6FA7xREeTOyXAZTilgsDaxXYTjRGeMSIXPb3R3dC';

-- create database aaedb
create database aaedb owner aae_user;

-- The following grant is used for databases
grant all privileges on database aaedb to aae_user;

-- cat ban/postgresql/icndb/createICNDB.sql 
-- create user icn_user
CREATE ROLE icn_user WITH INHERIT LOGIN ENCRYPTED PASSWORD 'Jf50pjsm1BzI2YJZJb0EdNseSteMDIxTcak5tNyOQkFGoFT7SIBncTzWvjoJ604z';

-- create database icndb
create database icndb owner icn_user template template0 encoding UTF8 ;
revoke connect on database icndb from public;
grant all privileges on database icndb to icn_user;
grant connect, temp, create on database icndb to icn_user;

-- please modify location follow your requirement
create tablespace icndb_tbs owner icn_user location '/var/lib/postgresql/data/ts';
grant create on tablespace icndb_tbs to icn_user;

-- cat baw-aws/postgresql/bawdb/create_baw_db_instance1_for_baw.sql 
-- create user baw_user/baw_user
CREATE ROLE baw_user WITH INHERIT LOGIN ENCRYPTED PASSWORD 'veMKFAraQ4blXZz4bDoKRtyaUCtuHVz3IDLvgJzLzFfcTA36aFAhi0zk46heo0W1';

-- bawdb
CREATE DATABASE bawdb OWNER baw_user ENCODING UTF8;
GRANT ALL PRIVILEGES ON DATABASE bawdb to baw_user;
\c bawdb;
CREATE SCHEMA IF NOT EXISTS baw_user AUTHORIZATION baw_user;

-- cat fncm/postgresql/aeosdb/createAEOSDB.sql 
-- create user aeos_user
CREATE ROLE aeos_user WITH INHERIT LOGIN ENCRYPTED PASSWORD 'LpBUTuqGVKF3jERYcT7giq0we0HrDmc8TVhcGkQNHMzmz4bfDXM8sYlrEL5z9C0j';

-- create database aeosdb
create database aeosdb owner aeos_user template template0 encoding UTF8 ;
revoke connect on database aeosdb from public;
grant all privileges on database aeosdb to aeos_user;
grant connect, temp, create on database aeosdb to aeos_user;

-- please modify location follow your requirement
create tablespace aeosdb_tbs owner aeos_user location '/var/lib/postgresql/data/ts';
grant create on tablespace aeosdb_tbs to aeos_user;  

-- cat fncm/postgresql/bawdocs/createBAWDOCS.sql 
-- create user bawdocs_user
CREATE ROLE bawdocs_user WITH INHERIT LOGIN ENCRYPTED PASSWORD 'bJCsUNA7yLaskDr5BrVIfU2VIobrlNX6vwaLiiDJz3GfL109WKcC4KS6eElHiLDC';

-- create database bawdocs
create database bawdocs owner bawdocs_user template template0 encoding UTF8 ;
revoke connect on database bawdocs from public;
grant all privileges on database bawdocs to bawdocs_user;
grant connect, temp, create on database bawdocs to bawdocs_user;

-- please modify location follow your requirement
create tablespace bawdocs_tbs owner bawdocs_user location '/var/lib/postgresql/data/ts';
grant create on tablespace bawdocs_tbs to bawdocs_user; 

-- cat fncm/postgresql/bawdos/createBAWDOS.sql 
-- create user bawdos_user
CREATE ROLE bawdos_user WITH INHERIT LOGIN ENCRYPTED PASSWORD 'kndjE5F1ksaeOOqTq8YeWaHnrIpmUa23f2jIAYAnUFbD28FatiyywKOIam94kPtV';

-- create database bawdos
create database bawdos owner bawdos_user template template0 encoding UTF8 ;
revoke connect on database bawdos from public;
grant all privileges on database bawdos to bawdos_user;
grant connect, temp, create on database bawdos to bawdos_user;

-- please modify location follow your requirement
create tablespace bawdos_tbs owner bawdos_user location '/var/lib/postgresql/data/ts';
grant create on tablespace bawdos_tbs to bawdos_user; 

-- cat fncm/postgresql/bawtos/createBAWTOS.sql 
-- create user bawtos_user
CREATE ROLE bawtos_user WITH INHERIT LOGIN ENCRYPTED PASSWORD 'sOxAoASxHgcTLKWiy5n2g2lL0iJDNThUdt4aHJJIU9sGv6ZAsFuU0AnsE21eIeoK';

-- create database bawtos
create database bawtos owner bawtos_user template template0 encoding UTF8 ;
revoke connect on database bawtos from public;
grant all privileges on database bawtos to bawtos_user;
grant connect, temp, create on database bawtos to bawtos_user;

-- please modify location follow your requirement
create tablespace pg_default owner bawtos_user location '/var/lib/postgresql/data/ts';
grant create on tablespace pg_default to bawtos_user; 

-- cat fncm/postgresql/chosdb/createCHOSDB.sql 
-- create user chos_user
CREATE ROLE chos_user WITH INHERIT LOGIN ENCRYPTED PASSWORD 'KAudYUykrAYvsa2tmHKG3LDBzvWD7wJ5qo6GZ8yWYma8S9SbrrStQhPZBAC8T1lr';

-- create database chosdb
create database chosdb owner chos_user template template0 encoding UTF8 ;
revoke connect on database chosdb from public;
grant all privileges on database chosdb to chos_user;
grant connect, temp, create on database chosdb to chos_user;

-- please modify location follow your requirement
create tablespace chosdb_tbs owner chos_user location '/var/lib/postgresql/data/ts';
grant create on tablespace chosdb_tbs to chos_user; 

-- cat fncm/postgresql/gcddb/createGCDDB.sql 
-- create user gcd_user
CREATE ROLE gcd_user WITH INHERIT LOGIN ENCRYPTED PASSWORD 'rM8Er7MVshXZ2mR8Qa4R3ceow3cmUQQmCuKbRUkHEJQedWr0HWgV97CSFTqyBxvT';

-- create database gcddb
create database gcddb owner gcd_user template template0 encoding UTF8 ;
revoke connect on database gcddb from public;
grant all privileges on database gcddb to gcd_user;
grant connect, temp, create on database gcddb to gcd_user;

-- please modify location follow your requirement
create tablespace gcddb_tbs owner gcd_user location '/var/lib/postgresql/data/ts';
grant create on tablespace gcddb_tbs to gcd_user;
