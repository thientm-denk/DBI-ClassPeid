/*==============================================================*/
/* DBMS name:      SAP SQL Anywhere 17                          */
/* Created on:     6/15/2021 7:45:12 PM                         */
/*==============================================================*/


if exists(select 1 from sys.sysforeignkey where role='FK_STUDENT_FK_MAJOR__MAJOR') then
    alter table STUDENT
       delete foreign key FK_STUDENT_FK_MAJOR__MAJOR
end if;

drop index if exists MAJOR.MAJOR_PK;

drop table if exists MAJOR;

drop index if exists STUDENT.FK_MAJOR_STUDENT_FK;

drop index if exists STUDENT.STUDENT_PK;

drop table if exists STUDENT;

/*==============================================================*/
/* Table: MAJOR                                                 */
/*==============================================================*/
create or replace table MAJOR 
(
   MID                  char(2)                        not null,
   NAME                 varchar(40)                    null,
   constraint PK_MAJOR primary key clustered (MID)
);

/*==============================================================*/
/* Index: MAJOR_PK                                              */
/*==============================================================*/
create unique clustered index MAJOR_PK on MAJOR (
MID ASC
);

/*==============================================================*/
/* Table: STUDENT                                               */
/*==============================================================*/
create or replace table STUDENT 
(
   SID                  char(10)                       not null,
   MID                  char(2)                        not null,
   FIRSTNAME            varchar(40)                    null,
   LASTNAME             varchar(40)                    null,
   EMAIL                varchar(40)                    not null,
   constraint PK_STUDENT primary key clustered (SID)
);

/*==============================================================*/
/* Index: STUDENT_PK                                            */
/*==============================================================*/
create unique clustered index STUDENT_PK on STUDENT (
SID ASC
);

/*==============================================================*/
/* Index: FK_MAJOR_STUDENT_FK                                   */
/*==============================================================*/
create index FK_MAJOR_STUDENT_FK on STUDENT (
MID ASC
);

alter table STUDENT
   add constraint FK_STUDENT_FK_MAJOR__MAJOR foreign key (MID)
      references MAJOR (MID)
      on update restrict
      on delete restrict;

