DROP TABLE course;

--以时间进行排序

--confilt test!!!!
SELECT * FROM Autumn2017_2018 p1,Autumn2017_2018 p2 
where p1.ctime=p2.ctime and p1.cstudent=p2.cstudent and p1.time_id!=p2.time_id;
SELECT * FROM Autumn2017_2018 WHERE ctime='112' ORDER BY cTime;
--solve too many conlumn

SELECT p1.time_id, p1.cName, p1.cTime, p1.cTeacher, p1.cClass,p1.cStudent FROM Autumn2017_2018 p1,Autumn2017_2018 p2 
where p1.ctime=p2.ctime and p1.cstudent=p2.cstudent and p1.time_id!=p2.time_id;


--change TABLE name
SELECT * FROM studentinf;
SELECT * FROM teacherInf;
SELECT * FROM secretaryInf;
SELECT * FROM users;
SELECT * FROM autumn2017_2018;
SELECT * FROM Spring2017_2018;



--delete TABLE myCourse and create again
CREATE TABLE studentinf
(
    username CHAR(50),
    pwd CHAR(20),
    userid INT
);
create  table teacherInf as(select * from studentInf);
create  table secretaryInf as(select * from studentInf);
ALTER TABLE studentinf add cclass VARCHAR(20);

INSERT INTO studentinf(username,pwd,userid,cclass) VALUES('zhou','1997','001','信息16');
INSERT INTO teacherInf VALUES ('zhou2','1997','002');
INSERT INTO secretaryInf VALUES ('zhou3','1997','003');

UPDATE teacherInf set pwd='0002' WHERE pwd='1997';
UPDATE secretaryInf set pwd='0003' WHERE pwd='1997';
CREATE TABLE users
(
    username CHAR(50),
    pwd CHAR(20));
insert into users(username,pwd)  values('zhou','1997');


create table autumn2017_2018
(
    time_id serial primary key,
    cName VARCHAR(10),
    cTime INT,
    cTeacher VARCHAR(10),
    cClass VARCHAR(10),
    cStudent VARCHAR(20)
);
-- 给time_id创建一个自增序号
CREATE SEQUENCE seq_Autumn_sn 
    START 100 INCREMENT 1 OWNED BY Autumn2017_2018.time_id;
ALTER TABLE Autumn2017_2018 ALTER time_id 
    SET DEFAULT nextval('seq_Autumn_sn');


--copy table Spring2017_2018 to a new table

create  table Spring2017_2018  as(select * from Autumn2017_2018);

--创建自增序列之后不能删除列


--have a try 
TRUNCATE TABLE autumn2017_2018;--????
SELECT * FROM autumn2017_2018;


INSERT INTO autumn2017_2018(cName,cTime,cTeacher,cClass,cStudent) VALUES
('',111,'','','信息16'),
('信息系统开发',112,'吕成功','a305','信息16'),
('',113,'','','信息16'),
('信息系统开发',114,'吕成功','a305','信息16'),
('管理统计学',115,'李稚','c113','信息16'),
('',116,'','','信息16'),
('人工智能',117,'刘丁、党鑫','a107','信息16'),

('博弈论',121,'井彩霞','b309','信息16'),
('',122,'','','信息16'),
('管理统计学',123,'李稚','c113','信息16'),
('系统工程',124,'刘凤英','a111','信息16'),
('',125,'','','信息16'),
('',126,'','','信息16'),
('',127,'','','信息16'),

('',131,'','','信息16'),
('网络经济学',132,'王玲','b105','信息16'),
('',133,'','','信息16'),
('',134,'','','信息16'),
('',135,'','','信息16'),
('',136,'','','信息16'),
('',137,'','','信息16'),

('',141,'','','信息16'),
('',142,'','','信息16'),
('',143,'','','信息16'),
('',144,'','','信息16'),
('',145,'','','信息16'),
('',146,'','','信息16'),
('',147,'','','信息16'),

('',151,'','','信息16'),
('',152,'','','信息16'),
('',153,'','','信息16'),
('',154,'','','信息16'),
('',155,'','','信息16'),
('',156,'','','信息16'),
('',157,'','','信息16'),

('13',154,'','','工业16'),
('1231',155,'','','工业16'),
('3',156,'','','工业16'),
('32312',157,'','','工业16');

INSERT INTO Spring2017_2018(cName,cTime,cTeacher,cClass,cStudent) VALUES
('信息系统开发',111,'lv','a309','信息16'),
('信息系统开发',112,'lv','a309','信息16'),
('信息系统开发',113,'lv','a309','信息16'),
('信息系统开发',114,'lv','a309','信息16'),
('信息系统开发',115,'lv','a309','信息16'),
('信息系统开发',116,'lv','a309','信息16'),
('信息系统开发',117,'lv','a309','信息16'),

('信息系统开发',121,'lv','a309','信息16'),
('信息系统开发',122,'lv','a309','信息16'),
('信息系统开发',123,'lv','a309','信息16'),
('信息系统开发',124,'lv','a309','信息16'),
('信息系统开发',125,'lv','a309','信息16'),
('信息系统开发',126,'lv','a309','信息16'),
('信息系统开发',127,'lv','a309','信息16'),

('信息系统开发',131,'lv','a309','信息16'),
('信息系统开发',132,'lv','a309','信息16'),
('信息系统开发',133,'lv','a309','信息16'),
('信息系统开发',134,'lv','a309','信息16'),
('信息系统开发',135,'lv','a309','信息16'),
('信息系统开发',136,'lv','a309','信息16'),
('信息系统开发',137,'lv','a309','信息16'),

('信息系统开发',141,'lv','a309','信息16'),
('信息系统开发',142,'lv','a309','信息16'),
('信息系统开发',143,'lv','a309','信息16'),
('信息系统开发',144,'lv','a309','信息16'),
('信息系统开发',145,'lv','a309','信息16'),
('信息系统开发',146,'lv','a309','信息16'),
('信息系统开发',147,'lv','a309','信息16'),

('信息系统开发',151,'lv','a309','信息16'),
('信息系统开发',152,'lv','a309','信息16'),
('信息系统开发',153,'lv','a309','信息16'),
('信息系统开发',154,'lv','a309','信息16'),
('信息系统开发',155,'lv','a309','信息16'),
('信息系统开发',156,'lv','a309','信息16'),
('信息系统开发',157,'lv','a309','信息16');