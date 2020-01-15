#!/usr/bin/env Python
# coding=utf-8

def select_table(cur,table, column='',**kwargs):
    if len(kwargs)==2:
        print(kwargs)
        condition=kwargs["condition"]
        value=kwargs["value"]
        sql = "select " + column + " from " + table + " where " + condition + "='"+value+"'"
        if (table!="studentInf" and  table!="teacherInf" and  table!="secretaryInf"):
            sql=sql+"  ORDER BY cTime"
        
    if len(kwargs)==0:
        sql="select " + column + " from " + table+"  ORDER BY cTime"
    print(sql)
    cur.execute(sql)
    lines = cur.fetchall()#return a leiBiao!!!element is yuanZhu!!!

    print('ending inquiring!')
    return lines

