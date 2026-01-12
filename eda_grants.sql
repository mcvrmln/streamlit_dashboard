select current_available_roles();

-- Create database and schemas
use role sysadmin;
create database proefkeuken;
use database proefkeuken;
create schema brons;
create schema zilver;
create schema goud;

create warehouse loader_wh;
create warehouse engineer_wh;

-- Create privileges
use role securityadmin;
create user sa_loader password='{change_this}';
create user sa_creator password='{change_this}';
create role loader;
grant usage on warehouse loader_wh to role loader;
GRANT USAGE ON DATABASE proefkeuken TO ROLE loader;
GRANT USAGE ON ALL SCHEMAS IN DATABASE proefkeuken TO ROLE loader;
GRANT SELECT, insert, update, delete ON future TABLES IN DATABASE proefkeuken TO ROLE loader;

grant role loader to user sa_loader;

create role engineer;
grant usage on warehouse engineer_wh to role engineer;
grant usage on database proefkeuken to role engineer;
grant usage on all schemas in database proefkeuken to role engineer;
grant all on future tables in database proefkeuken to role engineer;
grant create table on schema proefkeuken.brons to role engineer;
grant create table on schema proefkeuken.zilver to role engineer;
grant create table on schema proefkeuken.goud to role engineer;
grant role engineer to user sa_creator;

-- Create table 
-- Use SA_creator!

Use role enigneer;
use database proefkeuken;
use schema brons;
use warehouse engineer_wh;

drop table vektisdata;

create table vektisdata
(
    geslacht text,
    leeftijdsklasse text,
    gemeentenaam text,
    aantal_bsn number(20,0),
    aantal_verzekerdejaren number(20,2),
    kosten_medisch_specialistische_z  number(20,2),
    kosten_farmacie number(20,2),
    kosten_huisarts_inschrijftarief number(20,2),
    kosten_huisarts_consult number(20,2),
    kosten_huisarts_mdz number(20,2),
    kosten_huisarts_overig number(20,2),
    kosten_hulpmiddelen number(20,2),
    kosten_mondzorg number(20,2),
    kosten_paramedische_zorg_fysioth number(20,2),
    kosten_paramedische_zorg_overig number(20,2),
    kosten_ziekenvervoer_zittend number(20,2),
    kosten_ziekenvervoer_liggend number(20,2),
    kosten_kraamzorg number(20,2),
    kosten_verloskundige_zorg number(20,2),
    kosten_grensoverschrijdende_zorg number(20,2),
    kosten_eerstelijns_ondersteuning number(20,2),
    kosten_geriatrische_revalidatiez number(20,2),
    kosten_eerstelijnsverblijf number(20,2),
    kosten_verpleging_en_verzorging number(20,2),
    kosten_gzsp number(20,2),
    kosten_integrale_geboortezorg number(20,2),
    kosten_innovatiegelden_ggz number(20,2),
    kosten_overig number(20,2),
    kosten_consulten_ggz number(20,2),
    kosten_intramuraal_verblijf_ggz number(20,2),
    kosten_overige_prestaties_ggz number(20,2)
);




