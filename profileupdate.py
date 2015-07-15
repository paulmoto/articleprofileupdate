# -*- coding: utf-8 -*-
"""
Created on Wed Jul 15 11:07:15 2015

@author: admin
"""

import httplib
import datetime
import time
starttime = datetime.datetime.utcnow().isoformat()
timestamp = time.time()
elastic = httplib.HTTPConnection('http://coldfuze01.motofuze.com:9200')
newarticles = []


def getnewarticles():
    articlequery = '{"size":1000,"from":{numarticles},"_source": ["concepts","taxonomies"],"fields": ["Id","title","publishDt","createDT","sourceId","source","socialTotal","socialFacebook","socialFacebookLikes","socialFacebookShares","socialFacebookComments","socialTwitter","socialGoogleplus","socialPinterest","socialLinkedIn","socialStumbleUpon","languageCode","processStatusId","processStatus","staffLikes","staffDislikes","staffPreview","staffImpressions","staffPosted","staffViews","category","categoryID","url"],"query": {"filtered": {"filter": {"bool": {"must": [{"range": {"publishDt": {"lt": {before},"gt": {after}}}}],"must_not":[{"term":{"categoryID":20}}]}}}}}'.format(numarticles = len(newarticles),before = starttime,after = lastupdatetime)    
    elastic.request(method='GET',url='http://coldfuze01.motofuze.com:9200/curator_v2/article',body=


lastupdatetime = starttime