# -*- coding: utf-8 -*-

import web
import datetime

class secretaryRestHandler(web.RestHandler):
    def get(self, time_id):
        print("exacute quering!!!",time_id)
        #sql = '''SELECT time_id, cName, cTime, cTeacher, cClass,cStudent FROM Autumn2017_2018'''
        sql = '''SELECT time_id, cName, cTime, cTeacher, cClass,cStudent FROM Autumn2017_2018'''
        with self.db_cursor() as dc:
            if time_id :
                time_id = int(time_id)
                sql += " WHERE time_id=%s"
                dc.execute(sql, [time_id])
                self.write_json(dc.fetchone_dict())
            else:
                sql += ' ORDER BY cTime, time_id'
                dc.execute(sql)
                self.write_json(dc.fetchall_dicts())


    def post(self, time_id):
        print("exacute changing post(insert)!!!",time_id)
        stu = self.read_json()
        #if not stu.get('enrolled'):
            #stu['enrolled'] = datetime.date(1900, 1, 1)
        with self.db_cursor() as dc:
            sql = '''
            INSERT INTO Autumn2017_2018 
                (cName, cTime, cTeacher, cClass,cStudent)
                VALUES(%s, %s, %s, %s, %s) RETURNING time_id;'''
            dc.execute(sql, [stu.get('cName'), stu.get('cTime'),stu.get('cTeacher'), stu.get('cClass'), stu.get('cStudent')])
            
            time_id = dc.fetchone()[0]
            stu['time_id']=time_id
            self.write_json(stu)

    def put(self, time_id):
        print("exacute changing put(change)!!!",time_id)
        stu = self.read_json()
        #if not stu.get('enrolled'):
            #stu['enrolled'] = datetime.date(1900, 1, 1)
        with self.db_cursor() as dc:
            user_infos = mrd.select_table(dc,table="Autumn2017_2018",column="ctime,time_id",condition="time_id",value=time_id)
            print(user_infos)
            print(user_infos[0][0])

        with self.db_cursor() as dc:
            sql = ''' 
            UPDATE Autumn2017_2018  SET 
                 cName=%s, cTime=%s,cTeacher=%s, cClass=%s, cStudent=%s
            WHERE time_id=%s;'''
            dc.execute(sql, [stu['cName'], stu['cTime'],stu['cTeacher'], stu['cClass'],stu['cStudent'], time_id])
            sql2 = ''' 
            UPDATE Autumn2017_2018  SET cTime=%s WHERE cTime=%s;'''
            dc.execute(sql2,[user_infos[0][0],stu['cTime']])   
            dc.commit()
        self.write_json(stu)

    def delete(self, time_id):
        print("exacute deleting!!!",time_id)
        sn = int(time_id)
        with self.db_cursor() as cur:
            sql = "UPDATE autumn2017_2018 set cname='',cTeacher='',cClass='',cStudent=''  WHERE time_id= %s"
            cur.execute(sql, [sn])

class conflictHandler(web.RestHandler):
    def get(self):
        print("exacute quering conflict!!!")
        contain=['cTeacher', 'cClass','cStudent']
        rows=[]
        

        for conlumn in contain:
            with self.db_cursor() as dc:
                sql = '''SELECT distinct p1.time_id, p1.cName, p1.cTime, p1.cTeacher, p1.cClass,p1.cStudent FROM Autumn2017_2018 p1,Autumn2017_2018 p2 
                    where p1.ctime=p2.ctime and p1.%s=p2.%s and p1.time_id!=p2.time_id ;'''
                

                sql=(sql %(conlumn,conlumn))
                print(sql)
                dc.execute(sql)
                c=dc.fetchall_dicts()
                if c:
                    #print(bool(dc.fetchall_dicts()))
                    #ows.append(list(c))
                    print(c)
                    rows+=c
        list2=[]
        for i in rows:
            if i not in list2:
                list2.append(i)
        self.write_json(list2)

import readdb as mrd
import time

class IndexHandler(web.RestHandler):
    print('IndexHandler')
    def get(self):
        self.render("index.html")

    def post(self):
        print('the index.post began!!!')
        username = self.get_argument("username")
        password = self.get_argument("password")
        type = self.get_argument("type")

        print(username)
        print(password)
        print(type)
        tableName=""
        if type=="1":
            tableName="studentInf"
        elif type=="2":
            tableName="teacherInf"
        elif type=="3":
            tableName="secretaryInf"
        print(tableName)
        #test_value=mrd.select_course_info()
        with self.db_cursor() as dc:
            user_infos = mrd.select_table(dc,table=tableName,column="username,pwd",condition="username",value=username)
            print('get user_infos!!!')
            #print(type(user_infos))
            print(user_infos)
        if user_infos:
            db_pwd = user_infos[0][1]
            print('getting db_pwd success!!!')
            if db_pwd == password:
                print('determining success!!!')
                self.write("success")

            else:
                self.write("your password was not right.")
        else:
            self.write("There is no this user.")

class mainRestHandler(web.RestHandler):
    print('mainRestHandler')
    def get(self):
        print('mainRestHandler.get')
        
        self.render("student.html")
    
    def post(self):
        print('mainRestHandler.post')

        searchTerm=self.get_argument("otherTerm")
        with self.db_cursor() as dc:
            cur=mrd.select_table(dc,searchTerm,column="cName,cTeacher,cClass,cTime",condition="cStudent",value='信息16')
        #print(cur)
        html='''   <div>
            <table border="1" cellspacing='0' style="margin:0px auto;">
                    <tr id="header"><td></td><td>星期一</td><td>星期二</td><td>星期三</td><td>星期四</td><td>星期五</td><td>星期六</td><td>星期日</td></tr>
                    <tr><td colspan="8">上午</td></tr><tr>'''
        bc=[
            '<td>第一节<br/>(8：20-<br/>9：05)</td>','<td>第二节<br/>(9：15-<br/>10：00)</td>',
        '<td>第三节<br/>(10：20-<br/>11：05)</td>','<td>第四节<br/>(11：15-<br/>12：00)</td>',
        '<td>第五节<br/>(14：00-<br/>14：45)</td>','<td>第六节<br/>(14：55-<br/>15：40)</td>',
        '<td>第七节<br/>(16：00-<br/>16：45)</td>','<td>第八节<br/>(16：55-<br/>17：45)</td>',
        '<td>第九节<br/>(18：30-<br/>19：15)</td>','<td>第十节<br/>(19：25-<br/>20：10)</td>']
        i=0
        j=0
        m=''''''
        #print(cur)      #This 'cur' is cursor object!!!!!!!!!!!!!!!!!
        for row in cur:
            #This 'row' is a yuanzhu!
            #print(' %s, %s, %s' % (row[0], row[1], row[2]))
            #print(row)
            #print() 
           
            if bool(row[0]):
                
                #print('test the value of row[0]')
                #print(row[0])
                m+='<td rowspan="2">'+row[0]+'</br>('+row[1]+','+row[2]+')'+'</td>'
            else:
                m+='<td rowspan="2">'+'</td>'
            if i%7==6:
                if i==13:
                    html+=bc[j]+m+'</tr><tr>'+bc[j+1]+'</tr><tr><td colspan="8">下午</td></tr><tr>'  
                elif i==27:
                    html+=bc[j]+m+'</tr><tr>'+bc[j+1]+'</tr><tr><td colspan="8">晚上</td></tr><tr>'  

                else:
                    html+=bc[j]+m+'</tr><tr>'+bc[j+1]+'</tr><tr>'
                j+=2
                #print(m)
                m=''''''
            i+=1
        #print(html)
        
        html+='''</tr>
            </table>
            <style type="text/css">
                #header{background-color: rgb(0, 195, 255);}
                table tr{text-align: center;vertical-align:middle;}
                table tr td{height:50px;width:100px; text-align: center;vertical-align:middle;}
            </style>
        </div>'''
        #print(html)
        self.write(html)


class stRestHandler(web.RestHandler):
    print('stRestHandler')
    def get(self,type):

    
        print('mainRestHandler.get')
        if type=='student':
            self.render("secretaryStu.html")
        elif type=='teacher':
            self.render("secretaryTea.html")
        elif type=='1':
            self.render("SC1.html")
        elif type=='2':
            self.render("ST1.html")

class teaRestHandler(web.RestHandler):
    print('teaRestHandler')
    def get(self):    
        print('mainRestHandler.get')
        self.render("ST1.html")
