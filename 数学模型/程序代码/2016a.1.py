# -*- coding: utf-8 -*-
"""
Created on Sun Jul 15 21:05:25 2018

@author: hello
这个是数据处理的脚本,主要是用来进行2016年研究生数学建模A题目的数据的处理的脚本.
涉及到的东西还是比较多的,数据的处理方式主要是满足可视化的要求.
"""

import pandas as pd

p="D:\\MarinaJacks\\project\\graduate\\数学模型\\历年真题\\2016试题\\A\\data.xlsx"

df=pd.read_excel(p,sheet_name='目标群')

A01=df.ix[2:11]

A02=df.ix[14:22]

A03=df.ix[25:29]

A04=df.ix[32:41]

A05=df.ix[51:57]

A06=df.ix[60:65]

A07=df.ix[69:74]

A08=df.ix[77:81]

A09=df.ix[84:88]

A10=df.ix[91:95]

A= pd.concat([A01, A02, A03, A04, A05, A06, A07, A08, A09,A10])

#这个函数是为了将数据处理成合理的方式,主要是excep本身的问题导致的。
def getvalue(a):
    b=[]
    for i in range(len(a)):
        c1=a.iloc[i,0]
        c=str(a.iloc[i,1]).replace('-','')
        print(c)
        if(len(c)==5):
            d=c[0:2]
            e=c[2:]
        else:
            d=c[0:3]
            e=c[3:6]
        d=int(d)
        e=int(e)
        b.append([c1,d,e])
        #b.append(str(c.replace('-',''))
    return b
        

B=getvalue(A)
    