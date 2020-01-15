DROP TABLE course;
select * from users;
SELECT * FROM course;
insert into users(username,pwd)  values('周朗','1997');
--以时间进行排序
SELECT * FROM Spring2017_2018 ORDER BY cTime
SELECT * FROM Autumn2017_2018 ORDER BY cTime

SELECT * FROM Autumn2017_2018 WHERE cclass='a309' ORDER BY cTime
SELECT * FROM Autumn2017_2018 WHERE ctime='112' ORDER BY cTime
--confilt test!!!!
SELECT * FROM Autumn2017_2018 p1,Autumn2017_2018 p2 
where p1.ctime=p2.ctime and p1.cstudent=p2.cstudent and p1.time_id!=p2.time_id;
SELECT * FROM Autumn2017_2018 WHERE ctime='112' ORDER BY cTime;
--solve too many conlumn

SELECT* FROM (SELECT p1.time_id, p1.cName, p1.cTime, p1.cTeacher, p1.cClass,p1.cStudent FROM Autumn2017_2018 p1,Autumn2017_2018 p2 
where p1.ctime=p2.ctime and p1.cClass=p2.cClass and p1.time_id!=p2.time_id);

--change TABLE name
ALTER TABLE Spring RENAME to Spring2017_2018;
ALTER TABLE users RENAME to studentInf;
create  table teacherInf as(select * from studentInf);

create  table secretaryInf as(select * from studentInf);
SELECT * FROM studentinf;
SELECT * FROM teacherInf;
SELECT * FROM secretaryInf;
DELETE  FROM studentinf WHERE userid='003';
DELETE  FROM teacherInf WHERE pwd='0002';
DELETE FROM secretaryInf WHERE pwd='0003';
UPDATE teacherInf set username='zhou2' WHERE pwd='1996';
UPDATE secretaryInf set username='zhou3' WHERE pwd='1996';

INSERT INTO studentinf(username,pwd,userid,cclass) VALUES('zhou','1997','001','信息16');
INSERT INTO teacherInf VALUES ('zhou2','1997','002');
INSERT INTO secretaryInf VALUES ('zhou3','1997','003');

UPDATE studentinf set userid='0001' WHERE pwd='1997';
UPDATE teacherInf set pwd='0002' WHERE pwd='1997';
UPDATE secretaryInf set pwd='0003' WHERE pwd='1997';

ALTER TABLE studentinf add userid VARCHAR(20);
ALTER TABLE studentinf add cclass VARCHAR(20);

ALTER TABLE teacherInf add userid VARCHAR(20);
ALTER TABLE secretaryInf add userid VARCHAR(20);

--copy table Spring2017_2018 to a new table

create  table Autumn2017_2018 as(select * from Spring2017_2018);
--reject
INSERT INTO Autumn2017_2018(cName,cTime,cTeacher,cClass,cStudent) VALUES ('信息系统开发',157,'lv','a309','信息16')
--change some information is NULL
UPDATE Autumn2017_2018 set cName='',cTeacher='',cclass='' WHERE ctime=151
UPDATE Autumn2017_2018 set cName='',cTeacher='',cclass='' WHERE ctime=157

--delect a DATA
DELETE FROM Autumn2017_2018 WHERE ctime=151;
--delete TABLE myCourse and create again
DROP TABLE myCourse;
create table myCourse
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
--创建自增序列之后不能删除列
--have a try 
DELETE FROM autumn2017_2018 WHERE ctime=2;
DELETE FROM autumn2017_2018 WHERE time_id='199';
TRUNCATE TABLE autumn2017_2018;
SELECT * FROM autumn2017_2018;
UPDATE autumn2017_2018 set cname='',cTeacher='',cClass='',cStudent=''  WHERE ctime='111';


select cName,cTeacher,cClass,cTime from Autumn2017_2018 where cStudent='信息16'  ORDER BY cTime

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

('',211,'','','信息16'),
('网络经济学',212,'王玲','b105','信息16'),
('',213,'','','信息16'),
('',214,'','','信息16'),
('',215,'','','信息16'),
('',216,'','','信息16'),
('',217,'','','信息16'),

('',221,'','','信息16'),
('',222,'','','信息16'),
('',223,'','','信息16'),
('',224,'','','信息16'),
('',225,'','','信息16'),
('',226,'','','信息16'),
('',227,'','','信息16'),

('',311,'','','信息16'),
('',312,'','','信息16'),
('',313,'','','信息16'),
('',314,'','','信息16'),
('',315,'','','信息16'),
('',316,'','','信息16'),
('',317,'','','信息16'),

('13',114,'高数','某某','工业16'),
('1231',115,'现代','某某','工业16'),
('3',114,'计算机基础','某某','工业16'),
('32312',317,'大英','某某','工业16');
SELECT distinct p1.time_id, p1.cName, p1.cTime, p1.cTeacher, p1.cClass,p1.cStudent 
FROM Autumn2017_2018 p1,Autumn2017_2018 p2
where p1.ctime=p2.ctime and p1.cTeacher=p2.cTeacher and p1.time_id!=p2.time_id;
SELECT distinct p1.time_id, p1.cName, p1.cTime, p1.cTeacher, p1.cClass,p1.cStudent 
FROM Autumn2017_2018 p1,Autumn2017_2018 p2
where p1.ctime=p2.ctime and p1.cClass=p2.cClass and p1.time_id!=p2.time_id;