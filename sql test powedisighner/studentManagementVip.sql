/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2014                    */
/* Created on:     6/15/2021 7:49:52 PM                         */
/*==============================================================*/

create database DBK16_TEST
use  DBK16_TEST
if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('STUDENT') and o.name = 'FK_STUDENT_FK_MAJOR__MAJOR')
alter table STUDENT
   drop constraint FK_STUDENT_FK_MAJOR__MAJOR
go

if exists (select 1
            from  sysobjects
           where  id = object_id('MAJOR')
            and   type = 'U')
   drop table MAJOR
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('STUDENT')
            and   name  = 'FK_MAJOR_STUDENT_FK'
            and   indid > 0
            and   indid < 255)
   drop index STUDENT.FK_MAJOR_STUDENT_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('STUDENT')
            and   type = 'U')
   drop table STUDENT
go

/*==============================================================*/
/* Table: MAJOR                                                 */
/*==============================================================*/
create table MAJOR (
   MID                  char(2)              not null,
   NAME                 varchar(40)          null,
   constraint PK_MAJOR primary key (MID)
)
go

/*==============================================================*/
/* Table: STUDENT                                               */
/*==============================================================*/
create table STUDENT (
   SID                  char(10)             not null,
   MID                  char(2)              not null,
   FIRSTNAME            varchar(40)          null,
   LASTNAME             varchar(40)          null,
   EMAIL                varchar(40)          not null,
   constraint PK_STUDENT primary key (SID)
)
go

/*==============================================================*/
/* Index: FK_MAJOR_STUDENT_FK                                   */
/*==============================================================*/




create nonclustered index FK_MAJOR_STUDENT_FK on STUDENT (MID ASC)
go

alter table STUDENT
   add constraint FK_STUDENT_FK_MAJOR__MAJOR foreign key (MID)
      references MAJOR (MID)
go


