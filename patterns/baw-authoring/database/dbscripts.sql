-- cat ban/postgresql/cloudpak/createICNDB.sql 
-- create user icn_user
CREATE ROLE icn_user WITH INHERIT LOGIN ENCRYPTED PASSWORD '';

-- create database icndb
create database icndb owner icn_user template template0 encoding UTF8 ;
revoke connect on database icndb from public;
grant all privileges on database icndb to icn_user;
grant connect, temp, create on database icndb to icn_user;

-- please modify location follow your requirement
create tablespace icndb_tbs owner icn_user location '/pgsqldata/icndb';
grant create on tablespace icndb_tbs to icn_user;

-- cat bas/postgresql/cloudpak/create_bas_studio_db.sql 
-- create the user
CREATE ROLE bas_user WITH INHERIT LOGIN ENCRYPTED PASSWORD '';

-- create the database:
CREATE DATABASE basdb WITH OWNER bas_user ENCODING 'UTF8';
GRANT ALL ON DATABASE basdb to bas_user;

-- Connect to your database and create schema
\c basdb;
SET ROLE bas_user;
CREATE SCHEMA IF NOT EXISTS bas_user AUTHORIZATION bas_user;


-- cat fncm/postgresql/cloudpak/createGCDDB.sql 
-- create user gcd_user
CREATE ROLE gcd_user WITH INHERIT LOGIN ENCRYPTED PASSWORD '';

-- create database gcddb
create database gcddb owner gcd_user template template0 encoding UTF8 ;
revoke connect on database gcddb from public;
grant all privileges on database gcddb to gcd_user;
grant connect, temp, create on database gcddb to gcd_user;

-- please modify location follow your requirement
create tablespace gcddb_tbs owner gcd_user location '/pgsqldata/gcd';
grant create on tablespace gcddb_tbs to gcd_user; 

-- cat fncm/postgresql/cloudpak/createbawdocs.sql 
-- create user bawdocs_user
CREATE ROLE bawdocs_user WITH INHERIT LOGIN ENCRYPTED PASSWORD '';

-- create database bawdocs
create database bawdocs owner bawdocs_user template template0 encoding UTF8 ;
revoke connect on database bawdocs from public;
grant all privileges on database bawdocs to bawdocs_user;
grant connect, temp, create on database bawdocs to bawdocs_user;

-- please modify location follow your requirement
create tablespace bawdocs_tbs owner bawdocs_user location '/pgsqldata/bawdocs';
grant create on tablespace bawdocs_tbs to bawdocs_user; 

-- cat fncm/postgresql/cloudpak/createbawdos.sql 
-- create user bawdos_user
CREATE ROLE bawdos_user WITH INHERIT LOGIN ENCRYPTED PASSWORD '';

-- create database bawdos
create database bawdos owner bawdos_user template template0 encoding UTF8 ;
revoke connect on database bawdos from public;
grant all privileges on database bawdos to bawdos_user;
grant connect, temp, create on database bawdos to bawdos_user;

-- please modify location follow your requirement
create tablespace bawdos_tbs owner bawdos_user location '/pgsqldata/bawdos';
grant create on tablespace bawdos_tbs to bawdos_user;

-- cat fncm/postgresql/cloudpak/createbawtos.sql 
-- create user bawtos_user
CREATE ROLE bawtos_user WITH INHERIT LOGIN ENCRYPTED PASSWORD '';

-- create database bawtos
create database bawtos owner bawtos_user template template0 encoding UTF8 ;
revoke connect on database bawtos from public;
grant all privileges on database bawtos to bawtos_user;
grant connect, temp, create on database bawtos to bawtos_user;

-- please modify location follow your requirement
create tablespace bawtos_tbs owner bawtos_user location '/pgsqldata/bawtos';
grant create on tablespace bawtos_tbs to bawtos_user;

-- cat fncm/postgresql/cloudpak/createchosdb.sql 
-- create user chos_user
CREATE ROLE chos_user WITH INHERIT LOGIN ENCRYPTED PASSWORD '';

-- create database chosdb
create database chosdb owner chos_user template template0 encoding UTF8 ;
revoke connect on database chosdb from public;
grant all privileges on database chosdb to chos_user;
grant connect, temp, create on database chosdb to chos_user;

-- please modify location follow your requirement
create tablespace chosdb_tbs owner chos_user location '/pgsqldata/chosdb';
grant create on tablespace chosdb_tbs to chos_user; 
