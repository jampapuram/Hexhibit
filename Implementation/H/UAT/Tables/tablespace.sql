-- hamc
CREATE TABLESPACE HM_TBS DATAFILE 'E:\ORADATA\ORCL\DATAFILE\HM_TBS_01' SIZE 7000M;

CREATE TABLESPACE HHI_TBS DATAFILE 'E:\ORADATA\ORCL\DATAFILE\HHI_TBS_01' SIZE 7000M;

CREATE TABLESPACE HHINDX_TBS DATAFILE 'E:\ORADATA\ORCL\DATAFILE\HHINDX_TBS_01' SIZE 4000M;

CREATE TABLESPACE HHS_TBS  DATAFILE 'E:\ORADATA\ORCL\DATAFILE\HHS_TBS_01' SIZE 4000M;

-- user creation scripts
create user HG_HAMC identified by HG_HAMC_01 default tablespace HHI_TBS quota unlimited on HHI_TBS ACCOUNT UNLOCK;

-- grants
grant connect,resource,dba to HG_HAMC;
grant execute on dbms_lock to HG_HAMC;

-- repo

create directory HG_HAMC_PUMP_DIR as 'D:/HEXHIBIT/DataEx/HG_HAMC_PUMP_DIR';
grant read,write on directory HG_HAMC_PUMP_DIR to HG_HAMC;
grant select on dba_directories to HG_HAMC;


CREATE TABLESPACE HAMC_REPO_TBS DATAFILE 'E:\ORADATA\ORCL\DATAFILE\HAMC_REPO_TBS01' SIZE 712M;


-- user creation scripts
create user HAMC_REPO  identified by HAMC_REPO default tablespace HAMC_REPO_TBS quota unlimited on HAMC_REPO_TBS ACCOUNT UNLOCK;

-- grants
grant connect,resource,dba to HAMC_REPO  ;
grant execute on dbms_lock to HAMC_REPO  ;

-- directory
create directory HAMC_REP_PUMP_DIR as 'D:/HEXHIBIT/DataEx/HAMC_REP_PUMP_DIR';

grant read,write on directory HAMC_REP_PUMP_DIR to HAMC_REPO;

grant select on dba_directories to HAMC_REPO;


CREATE  TABLESPACE HAMC_DOCKIN_TBS DATAFILE 'E:\ORADATA\ORCL\DATAFILE\HAMC_STAGING_TBS01' SIZE 1024M;


create user HAMC_STAGING identified by HAMC_01 default tablespace HAMC_DOCKIN_TBS quota unlimited on HAMC_DOCKIN_TBS ACCOUNT UNLOCK;
grant connect,resource,dba to HAMC_STAGING;
grant execute on dbms_lock to HAMC_STAGING;

create directory HAMC_STAGING_PUMP_DIR as 'D:/HEXHIBIT/DataEx/HAMC_STAGING_PUMP_DIR';
grant read,write on directory HAMC_STAGING_PUMP_DIR to HAMC_STAGING;
grant select on dba_directories to HAMC_STAGING;
