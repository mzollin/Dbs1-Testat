-- Stocker Michael, Zollinger Marco

-- VARIABLES
\set user cocktailerswift
\set password '\'weakSwan'\'
\set database cocktailmixer_db
\set ON_ERROR_STOP on

-- DROP & CREATE
DROP DATABASE IF EXISTS :database;
DROP USER IF EXISTS :user;

CREATE USER :user WITH PASSWORD :password;
CREATE DATABASE :database WITH OWNER :user;
\c :database :user

set client_min_messages = ERROR
set client_encoding = 'UTF8'

-- IMPORT OTHER FILES
\i 2_schema.sql
\i 3_inserts.sql
\i 4_constraints.sql

\set ECHO all

\i 5_queries.sql
