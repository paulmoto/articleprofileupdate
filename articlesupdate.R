load("C:/Users/Admin/Documents/Motofuze/Recommendation/articles/articleupdateenvironment.RData")
starttime<-as.POSIXct(as.numeric(Sys.time()),origin='1970-01-01',tz='GMT')
timestamp<-paste(as.character(Sys.Date()),gsub("\\.","T",as.character(round(as.numeric(format(starttime, "%H")) +as.numeric(format(starttime, "%M"))/60+as.numeric(format(starttime, "%S"))/360,digits=4))))
sink(sprintf("C:/Users/Admin/Documents/Motofuze/Recommendation/articles/logs/%sOutput.Rout",timestamp),append=TRUE)
print(Sys.time())
library(elastic)
library(jsonlite)
library(httr)

# dfbodyjson<-function(df,row){
#   if(row<=nrow(df)){
#     return(substr(toJSON(df[row,]),start=2,stop=nchar((toJSON(df[row,])))-1))
#   }  else(print("SOMETHING'S ALL WRONG AND YOU SHOULD FIX IT"))
# }
# 
# indexdf<-function(df,row,index,type){
#   return(noquote(sprintf('{"index" : { "_index" : "%s", "_type" : "%s"}}
# %s',index,type,dfbodyjson(df,row))))
# }
# 
#   getactions<-function(){
#      getvariable<-function(i,variable){
#     if(!is.null(eval(parse(text=sprintf('tempthings[[%i]]$`_source`$%s',i,variable))))){
#       return(eval(parse(text=sprintf('tempthings[[%i]]$`_source`$%s',i,variable))))}   else(return(NA))
#   }
#   fieldnames<-names(content(map)$curator_v2$mappings$published$properties)
#   temp<-Search(index="curator_v2", type="published", body=sprintf('{"size":1000,
#                                                                   "query": {
#                                                                   "filtered": {
#                                                                   "filter": {
#                                                                   "bool": {
#                                                                   "must": [
#                                                                   {"term":{"_type":"published"}},
#                                                                   {"range": {
#                                                                   "createDT": {
#                                                                   "gte": "%s",
#                                                                   "lte": "%s"
#                                                                   }
#                                                                   }
#                                                                   }
#                                                                   ],
#                                                                   "must_not": []
#                                                                   }
#                                                                   }
#                                                                   }
#                                                                   }
#                                                                   
# }
# ',gsub(" ","T",lastupdatetime),gsub(" ","T",starttime)), from=length(tempthings))  
#   
#   if(length(temp$hits$hits)>0){
#     tempthings<<-c(tempthings,temp$hits$hits)
#     print(length(tempthings))
#     getactions()
#   } 
#     if(length(temp$hits$hits)==0&&length(tempthings)>0){
#       things<-data.frame(sapply(1:length(tempthings),getvariable,variable='articleID'),sapply(1:length(tempthings),getvariable,variable='accountStaffID'))
#       names(things)[1]<-'articleID'
#       names(things)[2]<-'accountStaffID'
#       print('articleID found')
#       for(n in which(!fieldnames%in%c('articleID','accountStaffID'))){
#         assign(sprintf('fields%s',fieldnames[n]),sapply(1:length(tempthings),getvariable,variable=fieldnames[n]))
#         if (!is.list(get(sprintf('fields%s',fieldnames[n])))){
#           things[,ncol(things)+1]<-get(sprintf('fields%s',fieldnames[n]))
#           names(things)[ncol(things)]<-fieldnames[n]
#           print(sprintf('%s vector found',fieldnames[n]))
#         }        else{
#           assign(sprintf('list%s',fieldnames[n]),get(sprintf('fields%s',fieldnames[n])),pos=1)
#           print(sprintf('list%s found',fieldnames[n]))
#         }
#       }
#       actions<<-things
#     }
#         return()
#   }
# 
# 
# getnewarticles<-function(){
#   getvariable<-function(i,variable){
#     if(!is.null(eval(parse(text=sprintf('newresults[[%i]]$fields$%s',i,variable))))){
#       return(eval(parse(text=sprintf('tempthings[[%i]]$fields$%s',i,variable))))}    else(return(NA))
#   }
#   getsourcevariable<-function(i,variable){
#     if(!is.null(eval(parse(text=sprintf('newresults[[%i]]$`_source`$%s',i,variable))))){
#       return(eval(parse(text=sprintf('tempthings[[%i]]$`_source`$%s',i,variable))))}    else(return(NA))
#   }
#   
#   fieldnames<-c("Id",
#   "title",
#   "publishDt",
#   "createDT",
#   "sourceId",
#   "source",
#   "socialTotal",
#   "socialFacebook",
#   "socialFacebookLikes",
#   "socialFacebookShares",
#   "socialFacebookComments",
#   "socialTwitter",
#   "socialGoogleplus",
#   "socialPinterest",
#   "socialLinkedIn",
#   "socialStumbleUpon",
#   "languageCode",
#   "processStatusId",
#   "processStatus",
#   "staffLikes",
#   "staffDislikes",
#   "staffPreview",
#   "staffImpressions",
#   "staffPosted",
#   "staffViews",
#   "category",
#   "categoryID",
#   "url")
#   temp<-Search(index="curator_v2",type="article",body= sprintf('{"size":1000,
#   "_source": [
#                                                                "concepts",
#                                                                "taxonomies"
#                                                                ],
#                                                                "fields": [
#                                                                "Id",
#                                                                "title",
#                                                                "publishDt",
#                                                                "createDT",
#                                                                "sourceId",
#                                                                "source",
#                                                                "socialTotal",
#                                                                "socialFacebook",
#                                                                "socialFacebookLikes",
#                                                                "socialFacebookShares",
#                                                                "socialFacebookComments",
#                                                                "socialTwitter",
#                                                                "socialGoogleplus",
#                                                                "socialPinterest",
#                                                                "socialLinkedIn",
#                                                                "socialStumbleUpon",
#                                                                "languageCode",
#                                                                "processStatusId",
#                                                                "processStatus",
#                                                                "staffLikes",
#                                                                "staffDislikes",
#                                                                "staffPreview",
#                                                                "staffImpressions",
#                                                                "staffPosted",
#                                                                "staffViews",
#                                                                "category",
#                                                                "categoryID",
#                                                                "url"
#                                                                ],
#                                                                "query": {
#                                                                "filtered": {
#                                                                "filter": {
#                                                                "bool": {
#                                                                "must": [
#                                                                {
#                                                                "range": {
#                                                                "publishDt": {
#                                                                "lt": "%s",
#                                                                "gt": "%s"
#                                                                }
#                                                                }
#                                                                }
#                                                                ],
# "must_not":[
# {"term":{"categoryID":20}}
# ]
#                                                                }
#                                                                }
#                                                                }
#                                                                }
# }',gsub(" ","T",as.character(starttime)),gsub(" ","T",as.character(lastupdatetime))), from = length(newresults))
#   if(length(temp$hits$hits)==0){
#   return(length(newresults))
#     }  else{
#     newresults<<-c(newresults,temp$hits$hits)
#     print(length(newresults))
#     getnewarticles()
#     }
# }
# 
# 
# indexJSON<-function(object,index,type,ID){
#   return(noquote(sprintf('{"index" : { "_index" : "%s", "_type" : "%s","_id": "%s"}}
# %s',index,type,ID,toJSON(object, auto_unbox=T))))
# }
# gettaxon<-function(i,list){
#   if(length(list[[i]]$`_source`$taxonomies)>0){
#     temp<-data.frame(matrix(unlist(list[[i]]$`_source`$taxonomies),ncol=2,byrow=T))
#     temp[,1]<-as.numeric(as.character(temp[,1]))
#     temp[,2]<-as.character(temp[,2])
#     colnames(temp)<-c("relevance","taxonomy")
#     temp$taxL1[1]<-strsplit(temp$taxonomy,"/")[[1]][2]
#     temp$taxL1[2]<-strsplit(temp$taxonomy,"/")[[2]][2]
#     temp$taxL1[3]<-strsplit(temp$taxonomy,"/")[[3]][2]
#     temp$taxL2[1]<-strsplit(temp$taxonomy,"/")[[1]][3]
#     temp$taxL2[2]<-strsplit(temp$taxonomy,"/")[[2]][3]
#     temp$taxL2[3]<-strsplit(temp$taxonomy,"/")[[3]][3]
#     temp$taxL3[1]<-strsplit(temp$taxonomy,"/")[[1]][4]
#     temp$taxL3[2]<-strsplit(temp$taxonomy,"/")[[2]][4]
#     temp$taxL3[3]<-strsplit(temp$taxonomy,"/")[[3]][4]
#     temp$articleID<-list[[i]]$`_id`
#     return(temp)
#   }
# }
# getconcepts<-function(i,listname){
#   if(length(listname[[i]]$`_source`$concepts)>0){
#     temp<-data.frame(matrix(unlist(listname[[i]]$`_source`$concepts),ncol=2,byrow=T))
#     temp[,1]<-as.character(temp[,1])
#     temp[,2]<-as.numeric(as.character(temp[,2]))
#     temp[,3]<-listname[[i]]$`_id`
#     colnames(temp)<-c("concept","relevance","articleID")
#     return(temp)
#   }
# }
# getID<-function(n,list){return(list[[n]]$`_id`)}
# getdayint<-function(day){
#   return(daysofweek[which(names(daysofweek)==day)])
# }

connect(es_base='http://coldfuze01.motofuze.com',es_port=9200)
newresults<-list()
getnewarticles()
updatenumber<-updatenumber+1

if(length(newresults)==0){print('no new articles')}
if(length(newresults)>0){
print(sprintf('%s new articles',length(newresults)))
  conceptrecords<-list()
  tempentries<-list()
  temp<-list()
  z<-1
for (i in 1:length(newresults)){
  if(length(newresults[[i]]$`_source`$taxonomies)>0){
  articletax<-data.frame(matrix(unlist(newresults[[i]]$`_source`$taxonomies),nrow=3, byrow=T))
  if(all(!is.na(as.numeric(as.character(articletax[,1]))))){
  articletax[,1]<-as.numeric(as.character(articletax[,1]))
  articletax[,2]<-as.character(articletax[,2])
  for(n in 1:nrow(articletax)){
    articletax[n,3]<-strsplit(articletax[,2],"/")[[n]][2]
    articletax[n,4]<-strsplit(articletax[,2],"/")[[n]][3]
    articletax[n,5]<-strsplit(articletax[,2],"/")[[n]][4]
  }
  }
  datavector<-as.list(c(articletax[1,],articletax[2,],articletax[3,],unlist(newresults[[i]]$fields),"topconcept"=FALSE))
  names(datavector)<-c('taxonomy1Relevance','fulltaxonomy1','taxonomy1L1','taxonomy1L2','taxonomy1L3','taxonomy2Relevance','fulltaxonomy2','taxonomy2L1','taxonomy2L2','taxonomy2L3','taxonomy3Relevance','fulltaxonomy3','taxonomy3L1','taxonomy3L2','taxonomy3L3',names(newresults[[i]]$fields), "topconcept")
  datavector[is.na(datavector)]<-NULL
    }  else{datavector<-as.list(c(unlist(newresults[[i]]$fields),"topconcept"=FALSE))
    datavector[is.na(datavector)]<-NULL
  }
  
  if(length(newresults[[i]]$`_source`$concepts)>0){
  for(j in 1:length(newresults[[i]]$`_source`$concepts)){
    tempdatavector<-datavector
    if (j==1){
      tempdatavector[which(names(tempdatavector)=="topconcept")]<-TRUE}
    conceptentry<-as.list(c(newresults[[i]]$`_source`$concepts[[j]],tempdatavector))
    names(conceptentry)[1]<-"concept"
    if(length(tempentries)>0){
      tempentries[[length(tempentries)+1]]<-conceptentry
      if(length(tempentries)>=10000|(i==length(newresults)&j==length(newresults[[i]]$`_source`$concepts))){
        for(x in 1:length(tempentries)){
          temp[[x]]<-indexJSON(tempentries[[x]],index='fuzecast_user_profiles_v2',type='article_concept', ID=sprintf('%i0%i0%i',z,updatenumber,x))
        }
        conceptrecords<-c(conceptrecords,tempentries)
        writeLines(unlist(temp),sprintf("C:/Users/Admin/Documents/Motofuze/Recommendation/articles/articleconcepts/%s %ibulkarticleconcepts.txt",timestamp,z),useBytes = T)
        temp<-list()
        tempentries<-list()
        z<-z+1
      }
    }    else(tempentries<-list(conceptentry))
}
  }  else{
    datavector<-as.list(c(unlist(newresults[[i]]$fields),"topconcept"=FALSE))
    datavector[is.na(datavector)]<-NULL
    conceptentry<-datavector
    tempentries[[length(tempentries)+1]]<-conceptentry
    if(length(tempentries)>=10000|(i==length(newresults))){
      for(x in 1:length(tempentries)){
        temp[[x]]<-indexJSON(tempentries[[x]],index='fuzecast_user_profiles_v2',type='article_concept', ID=sprintf('%i0%i0%i',z,updatenumber,x))
      }
      conceptrecords<-c(conceptrecords,tempentries)
      writeLines(unlist(temp),sprintf("C:/Users/Admin/Documents/Motofuze/Recommendation/articles/articleconcepts/%s %ibulkarticleconcepts.txt",timestamp,z),useBytes = T)
      temp<-list()
      tempentries<-list()
      z<-z+1
    }
    
  }
}


IDs<-unlist(conceptrecords)[which(names(unlist(conceptrecords))=="Id")]
names(conceptrecords)<-IDs
errors<-list()
bulkfiles<-list.files(path='C:/Users/Admin/Documents/Motofuze/Recommendation/articles/articleconcepts',pattern=sprintf('%s [0-9]*bulkarticleconcepts.txt',timestamp))
for (file in bulkfiles){
closeAllConnections()
sink(sprintf("C:/Users/Admin/Documents/Motofuze/Recommendation/articles/logs/%sOutput.Rout",timestamp),append=TRUE)
resp<-PUT(url='http://coldfuze01.motofuze.com:9200/fuzecast_user_profiles_v2/article_concept/_bulk',body=upload_file(sprintf("C:/Users/Admin/Documents/Motofuze/Recommendation/articles/articleconcepts/%s",file)))
if(content(resp)$errors==F){
print(sprintf('bulk %i/%i completed',which(bulkfiles==file),length(bulkfiles)))
  file.copy(from=sprintf("C:/Users/Admin/Documents/Motofuze/Recommendation/articles/articleconcepts/%s",file),to=sprintf("C:/Users/Admin/Documents/Motofuze/Recommendation/articles/written/uploaded_%s",file))
  file.remove(sprintf("C:/Users/Admin/Documents/Motofuze/Recommendation/articles/articleconcepts/%s",file))
  }else{
  errors[[length(errors)+1]]<-file=resp
  print(sprintf('error uploading %s',file))
}
}

print(sprintf('article concepts updated %i errors',length(errors)))
}

# for (file in bulkfiles[18:length(bulkfiles)]){
#  print(file)
#    resp<-PUT(url='http://coldfuze01.motofuze.com:9200/fuzecast_user_profiles_v2/article_concept/_bulk',body=upload_file(sprintf("C:/Users/Admin/Documents/Motofuze/Recommendation/articles/articleconcepts/%s",file)))
# }


#Actions
actions<-data.frame()
print('updating actions')
connect(es_base = 'http://coldfuze01.motofuze.com',es_port = 9200)
tempthings<-list()
map<-GET(url='http://coldfuze01.motofuze.com:9200/curator_v2/_mapping/published')
getactions()
nrow(actions)
daysofweek<-c("Sunday"=1, "Monday"=2, "Tuesday"=3, "Wednesday"=4,"Thursday"=5,"Friday"=6,"Saturday"=7)

if(nrow(actions)==0){print('No Actions')}
if(nrow(actions)>0){
  print(sprintf('%i actions found',nrow(actions)))
  actions$hourPublished<-substr(actions$publishedDT,start=12,stop=13)
  actions$publishedDay<-weekdays(as.Date(substr(actions$publishedDT,start=1,stop=10)))
  actions$publishedIntDay<-sapply(actions$publishedDay,getdayint)
  fuzecast<-actions[!is.na(actions$accountStaffID)&actions$publishStatusID==4,]
  curator<-actions[is.na(actions$accountStaffID)&actions$publishStatusID==4,]
  print(sprintf('%s fuzecast posts',nrow(fuzecast)))
  print(sprintf('%s curator posts',nrow(curator)))
  tempentries<-list()
  writethisnow<-list()
  z<-1
  if(nrow(fuzecast)>0){
  for(i in 1:nrow(fuzecast)){
    publisheddata<-fuzecast[i,c(2:9,14,17,20,22,24,25,26,27,28,29,31,32,33,34,35,36,37,38,39,40,42,45,46,47,48,49,50,52,53,57:64)]
    names(publisheddata)[1]<-"publishedId"
   if(fuzecast$articleID[i]%in%names(conceptrecords)){#Article concepts were just written to ES
     records<-conceptrecords[which(names(conceptrecords)==fuzecast$articleID[i])]
     for(j in 1:length(records)){
       temp<-as.list(c(publisheddata,records[[j]]))
       temp[is.na(temp)]<-NULL
       tempentries[[length(tempentries)+1]]<-temp
       if(j==length(records)&(length(tempentries)>=10000|i==nrow(fuzecast))){
         for(l in 1:length(tempentries)){
           writethisnow[[l]]<-indexJSON(tempentries[[l]],index="fuzecast_user_profiles_v2",type="fuzecast_concept",ID=sprintf('1%i0%i0%i',z,updatenumber,l))
         }
         writeLines(unlist(writethisnow),sprintf("C:/Users/Admin/Documents/Motofuze/Recommendation/articles/fuzecastconcepts/%s %ibulkfuzecastconcepts.txt",timestamp,z),useBytes = T)
         z<-z+1
         writethisnow<-list()
         tempentries<-list()
     }
     } 
   }    else{
      print("searching concepts")
      temp<-content(GET(sprintf('http://coldfuze01.motofuze.com:9200/fuzecast_user_profiles_v2/article_concept/_search?q=Id:%s',fuzecast$articleID[i])))
      if(length(temp$hits$hits)>0){#article concepts have previously been written to ES
      temp<-temp$hits$hits
      for(k in 1:length(temp)){
        tempcon<-as.list(temp[[k]]$`_source`)
        temprecord<-c(publisheddata,tempcon)
        temprecord[is.na(temprecord)]<-NULL
        tempentries[[length(tempentries)+1]]<-temprecord
        if(k==length(temp)&(length(tempentries)>=10000|i==nrow(fuzecast))){
          for(l in 1:length(tempentries)){
           writethisnow[[l]]<-indexJSON(tempentries[[l]],index="fuzecast_user_profiles_v2",type="fuzecast_concept",ID=sprintf('1%i0%i0%i',z,updatenumber,l))
          }
          writeLines(unlist(writethisnow),sprintf("C:/Users/Admin/Documents/Motofuze/Recommendation/articles/fuzecastconcepts/%s %ibulkfuzecastconcepts.txt",timestamp,z),useBytes = T)
          z<-z+1
          writethisnow<-list()
          tempentries<-list()
        }
      }
      }    else{#article concepts have not been written to ES
      print("searching articles")
          temp<-Search(index="curator_v2",type="article",body= sprintf('{
  "_source": [
                                                                           "concepts",
                                                                           "taxonomies"
                                                                           ],
                                                                           "fields": [
                                                                           "Id",
                                                                           "title",
                                                                           "publishDt",
                                                                           "createDT",
                                                                           "sourceId",
                                                                           "source",
                                                                           "socialTotal",
                                                                           "socialFacebook",
                                                                           "socialFacebookLikes",
                                                                           "socialFacebookShares",
                                                                           "socialFacebookComments",
                                                                           "socialTwitter",
                                                                           "socialGoogleplus",
                                                                           "socialPinterest",
                                                                           "socialLinkedIn",
                                                                           "socialStumbleUpon",
                                                                           "languageCode",
                                                                           "processStatusId",
                                                                           "processStatus",
                                                                           "staffLikes",
                                                                           "staffDislikes",
                                                                           "staffPreview",
                                                                           "staffImpressions",
                                                                           "staffPosted",
                                                                           "staffViews",
                                                                           "category",
                                                                           "categoryID",
                                                                           "url"
                                                                           ],
                                                                           "query": {
                                                                           "filtered": {
                                                                           "filter": {
                                                                           "bool": {
                                                                           "must": [
                                                                           {
                                                                           "term": {
                                                                           "Id": "%s"
                                                                           
                                                                           
                                                                           }
                                                                           }
                                                                           ],
                                                                           "must_not":[]
                                                                           }
                                                                           }
                                                                           }
                                                                           }
    }',fuzecast$articleID[i]),size=1)
      if(length(temp$hits$hits)>0){
        temp<-temp$hits$hits[[1]]
      if(length(temp$`_source`$taxonomies)>0){
        articletax<-data.frame(matrix(unlist(temp$`_source`$taxonomies),nrow=3, byrow=T))
        if(all(!is.na(as.numeric(as.character(articletax[,1]))))){
        articletax[,1]<-as.numeric(as.character(articletax[,1]))
        articletax[,2]<-as.character(articletax[,2])
        
        for(n in 1:nrow(articletax)){
          articletax[n,3]<-strsplit(articletax[,2],"/")[[n]][2]
          articletax[n,4]<-strsplit(articletax[,2],"/")[[n]][3]
          articletax[n,5]<-strsplit(articletax[,2],"/")[[n]][4]
        }
        }        else {
          if (all(!is.na(as.numeric(as.character(articletax[,2]))))){
            articletax[,2]<-as.numeric(as.character(articletax[,2]))
            articletax[,1]<-as.character(articletax[,1])
            
            for(n in 1:nrow(articletax)){
              articletax[n,3]<-strsplit(articletax[,1],"/")[[n]][2]
              articletax[n,4]<-strsplit(articletax[,1],"/")[[n]][3]
              articletax[n,5]<-strsplit(articletax[,1],"/")[[n]][4]
            }
          }
        }
        
          
        datavector<-c(articletax[1,],articletax[2,],articletax[3,],unlist(temp$fields),"topconcept"=FALSE)
        names(datavector)<-c('taxonomy1Relevance','fulltaxonomy1','taxonomy1L1','taxonomy1L2','taxonomy1L3','taxonomy2Relevance','fulltaxonomy2','taxonomy2L1','taxonomy2L2','taxonomy2L3','taxonomy3Relevance','fulltaxonomy3','taxonomy3L1','taxonomy3L2','taxonomy3L3',names(temp$fields),"topconcept")
        datavector[is.na(datavector)]<-NULL
      }
      else{datavector<-as.list(c(unlist(temp$fields),"topconcept"=FALSE))
      datavector[is.na(datavector)]<-NULL
      }
      
      if(length(temp$`_source`$concepts)>0){
        for(j in 1:length(temp$`_source`$concepts)){
          tempdatavector<-datavector
          if (j==1){
            tempdatavector[which(names(tempdatavector)=="topconcept")]<-TRUE}
          conceptentry<-as.list(c(publisheddata,temp$`_source`$concepts[[j]],tempdatavector))
          conceptentry[is.na(conceptentry)]<-NULL
          names(conceptentry)[1]<-"concept"
          tempentries[[length(tempentries)+1]]<-conceptentry
          conceptrecords[[length(conceptrecords)+1]]<-conceptentry
          names(conceptrecords)[length(conceptrecords)]<-conceptentry$Id
          if(j==length(temp$`_source`$concepts)&(length(tempentries)>=10000|i==nrow(fuzecast))){
            for(l in 1:length(tempentries)){
              writethisnow[[l]]<-indexJSON(tempentries[[l]],index="fuzecast_user_profiles_v2",type="fuzecast_concept",ID=sprintf('1%i0%i0%i',z,updatenumber,l))
            }
            writeLines(unlist(writethisnow),sprintf("C:/Users/Admin/Documents/Motofuze/Recommendation/articles/fuzecastconcepts/%s %ibulkfuzecastconcepts.txt",timestamp,z),useBytes = T)
            z<-z+1
            writethisnow<-list()
            tempentries<-list()
          }
      }
      } else{
        datavector[which(names(datavector)=="topconcept")]<-TRUE
        conceptentry<-as.list(c(publisheddata,datavector))
        tempentries[[length(tempentries)+1]]<-conceptentry
        conceptrecords[[length(conceptrecords)+1]]<-conceptentry
        names(conceptrecords)[length(conceptrecords)]<-conceptentry$Id
        if(length(tempentries)>=10000|(i==nrow(fuzecast))){
          for(x in 1:length(tempentries)){
            writethisnow[[x]]<-indexJSON(tempentries[[x]],index='fuzecast_user_profiles_v2',type='fuzecast_concept', ID=sprintf('1%i0%i0%i',z,updatenumber,x))
          }
          writeLines(unlist(writethisnow),sprintf("C:/Users/Admin/Documents/Motofuze/Recommendation/articles/fuzecastconcepts/%s %ibulkfuzecastconcepts.txt",timestamp,z),useBytes = T)
          writethisnow<-list()
          tempentries<-list()
          z<-z+1
        }
        
      }
  }
}
   }
    
  }
    errors2<-list()
    bulkfiles<-list.files(path='C:/Users/Admin/Documents/Motofuze/Recommendation/articles/fuzecastconcepts',pattern=sprintf('%s [0-9]*bulkfuzecastconcepts.txt',timestamp))
    for (file in bulkfiles){
      closeAllConnections()
      sink(sprintf("C:/Users/Admin/Documents/Motofuze/Recommendation/articles/logs/%sOutput.Rout",timestamp),append=TRUE)
      resp<-PUT(url='http://coldfuze01.motofuze.com:9200/fuzecast_user_profiles_v2/fuzecast_concept/_bulk',body=upload_file(sprintf("C:/Users/Admin/Documents/Motofuze/Recommendation/articles/fuzecastconcepts/%s",file)))
      if(content(resp)$errors==F){
        print(sprintf('bulk %i/%i completed',which(bulkfiles==file),length(bulkfiles)))
        file.copy(from=sprintf("C:/Users/Admin/Documents/Motofuze/Recommendation/articles/fuzecastconcepts/%s",file),to=sprintf("C:/Users/Admin/Documents/Motofuze/Recommendation/articles/written/uploaded_%s",file))
        file.remove(sprintf("C:/Users/Admin/Documents/Motofuze/Recommendation/articles/fuzecastconcepts/%s",file))
      }  else{
        errors2[[length(errors2)+1]]<-resp
        print(sprintf('error uploading %s',file))
      }
    }
    print(sprintf('fuzecast concepts updated: %i errors',length(errors2)))  
    
  }
  if(nrow(curator)>0){
  tempentries<-list()
  writethisnow<-list()
  z<-1
  for(i in 1:nrow(curator)){
    publisheddata<-curator[i,c(2:4,6:9,14,17,20,22,24,25,26,27,28,29,31,32,33,34,35,36,37,38,39,40,42,45,46,47,48,49,50,52,53,57:64)]
    names(publisheddata)[1]<-"publishedId"
    if(curator$articleID[i]%in%names(conceptrecords)){#Article concepts were just written to ES
      records<-conceptrecords[which(names(conceptrecords)==curator$articleID[i])]
      for(j in 1:length(records)){
        temp<-as.list(c(publisheddata,records[[j]]))
        temp[is.na(temp)]<-NULL
        tempentries[[length(tempentries)+1]]<-temp
        if(j==length(records)&(length(tempentries)>=10000|i==nrow(curator))){
          for(l in 1:length(tempentries)){
            writethisnow[[l]]<-indexJSON(tempentries[[l]],index="fuzecast_user_profiles_v2",type="curator_concept",ID=sprintf('2%i0%i0%i',z,updatenumber,l))
          }
          writeLines(unlist(writethisnow),sprintf("C:/Users/Admin/Documents/Motofuze/Recommendation/articles/curatorconcepts/%s %ibulkcuratorconcepts.txt",timestamp,z),useBytes = T)
          z<-z+1
          writethisnow<-list()
          tempentries<-list()
        }
      } 
    }    else{
      temp<-content(GET(sprintf('http://coldfuze01.motofuze.com:9200/fuzecast_user_profiles_v2/article_concept/_search?q=Id:%s',curator$articleID[i])))
      if(length(temp$hits$hits)>0){#article concepts have previously been written to ES
        temp<-temp$hits$hits
        for(k in 1:length(temp)){
          tempcon<-as.list(temp[[k]]$`_source`)
          temprecord<-c(publisheddata,tempcon)
          temprecord[is.na(temprecord)]<-NULL
          tempentries[[length(tempentries)+1]]<-temprecord
          if(k==length(temp)&(length(tempentries)>=10000|i==nrow(curator))){
            for(l in 1:length(tempentries)){
              writethisnow[[l]]<-indexJSON(tempentries[[l]],index="fuzecast_user_profiles_v2",type="curator_concept",ID=sprintf('2%i0%i0%i',z,updatenumber,l))
            }
            writeLines(unlist(writethisnow),sprintf("C:/Users/Admin/Documents/Motofuze/Recommendation/articles/curatorconcepts/%s %ibulkcuratorconcepts.txt",timestamp,z),useBytes = T)
            z<-z+1
            writethisnow<-list()
            tempentries<-list()
          }
        }
      }      else{#article concepts have not been written to ES
        temp<-Search(index="curator_v2",type="article",body= sprintf('{
                                                                     "_source": [
                                                                     "concepts",
                                                                     "taxonomies"
                                                                     ],
                                                                     "fields": [
                                                                     "Id",
                                                                     "title",
                                                                     "publishDt",
                                                                     "createDT",
                                                                     "sourceId",
                                                                     "source",
                                                                     "socialTotal",
                                                                     "socialFacebook",
                                                                     "socialFacebookLikes",
                                                                     "socialFacebookShares",
                                                                     "socialFacebookComments",
                                                                     "socialTwitter",
                                                                     "socialGoogleplus",
                                                                     "socialPinterest",
                                                                     "socialLinkedIn",
                                                                     "socialStumbleUpon",
                                                                     "languageCode",
                                                                     "processStatusId",
                                                                     "processStatus",
                                                                     "staffLikes",
                                                                     "staffDislikes",
                                                                     "staffPreview",
                                                                     "staffImpressions",
                                                                     "staffPosted",
                                                                     "staffViews",
                                                                     "category",
                                                                     "categoryID",
                                                                     "url"
                                                                     ],
                                                                     "query": {
                                                                     "filtered": {
                                                                     "filter": {
                                                                     "bool": {
                                                                     "must": [
                                                                     {
                                                                     "term": {
                                                                     "Id": "%s"
                                                                     
                                                                     
                                                                     }
                                                                     }
                                                                     ],
                                                                     "must_not":[]
                                                                     }
                                                                     }
                                                                     }
                                                                     }
      }',curator$articleID[i]),size=1)
      if(length(temp$hits$hits)>0){
        temp<-temp$hits$hits[[1]]
        if(length(temp$`_source`$taxonomies)>0){
          articletax<-data.frame(matrix(unlist(temp$`_source`$taxonomies),nrow=3, byrow=T))
          if(all(!is.na(as.numeric(as.character(articletax[,1]))))){
            articletax[,1]<-as.numeric(as.character(articletax[,1]))
            articletax[,2]<-as.character(articletax[,2])
            
            for(n in 1:nrow(articletax)){
              articletax[n,3]<-strsplit(articletax[,2],"/")[[n]][2]
              articletax[n,4]<-strsplit(articletax[,2],"/")[[n]][3]
              articletax[n,5]<-strsplit(articletax[,2],"/")[[n]][4]
            }
          }          else {
            if (all(!is.na(as.numeric(as.character(articletax[,2]))))){
              articletax[,2]<-as.numeric(as.character(articletax[,2]))
              articletax[,1]<-as.character(articletax[,1])
              
              for(n in 1:nrow(articletax)){
                articletax[n,3]<-strsplit(articletax[,1],"/")[[n]][2]
                articletax[n,4]<-strsplit(articletax[,1],"/")[[n]][3]
                articletax[n,5]<-strsplit(articletax[,1],"/")[[n]][4]
              }
            }
          }
          
          
          datavector<-c(articletax[1,],articletax[2,],articletax[3,],unlist(temp$fields),"topconcept"=FALSE)
          names(datavector)<-c('taxonomy1Relevance','fulltaxonomy1','taxonomy1L1','taxonomy1L2','taxonomy1L3','taxonomy2Relevance','fulltaxonomy2','taxonomy2L1','taxonomy2L2','taxonomy2L3','taxonomy3Relevance','fulltaxonomy3','taxonomy3L1','taxonomy3L2','taxonomy3L3',names(temp$fields),"topconcept")
          datavector[is.na(datavector)]<-NULL
        }        else{datavector<-as.list(c(unlist(temp$fields),"topconcept"=FALSE))
        datavector[is.na(datavector)]<-NULL
        }
        
        if(length(temp$`_source`$concepts)>0){
          for(j in 1:length(temp$`_source`$concepts)){
            tempdatavector<-datavector
            if (j==1){
              tempdatavector[which(names(tempdatavector)=="topconcept")]<-TRUE}
            conceptentry<-as.list(c(publisheddata,temp$`_source`$concepts[[j]],tempdatavector))
            conceptentry[is.na(conceptentry)]<-NULL
            names(conceptentry)[1]<-"concept"
            tempentries[[length(tempentries)+1]]<-conceptentry
            conceptrecords[[length(conceptrecords)+1]]<-conceptentry
            names(conceptrecords)[length(conceptrecords)]<-conceptentry$Id
            if(j==length(temp$`_source`$concepts)&(length(tempentries)>=10000|i==nrow(curator))){
              for(l in 1:length(tempentries)){
                writethisnow[[l]]<-indexJSON(tempentries[[l]],index="fuzecast_user_profiles_v2",type="curator_concept",ID=sprintf('2%i0%i0%i',z,updatenumber,l))
              }
              writeLines(unlist(writethisnow),sprintf("C:/Users/Admin/Documents/Motofuze/Recommendation/articles/curatorconcepts/%s %ibulkcuratorconcepts.txt",timestamp,z),useBytes = T)
              z<-z+1
              writethisnow<-list()
              tempentries<-list()
            }
          }
        }
        else{
          datavector[which(names(datavector)=="topconcept")]<-TRUE
          conceptentry<-as.list(c(publisheddata,datavector))
          tempentries[[length(tempentries)+1]]<-conceptentry
          conceptrecords[[length(conceptrecords)+1]]<-conceptentry
          names(conceptrecords)[length(conceptrecords)]<-conceptentry$Id
          if(length(tempentries)>=10000|(i==nrow(curator))){
            for(x in 1:length(tempentries)){
              writethisnow[[x]]<-indexJSON(tempentries[[x]],index='fuzecast_user_profiles_v2',type='curator_concept', ID=sprintf('2%i0%i0%i',z,updatenumber,x))
            }
            writeLines(unlist(writethisnow),sprintf("C:/Users/Admin/Documents/Motofuze/Recommendation/articles/curatorconcepts/%s %ibulkarticleconcepts.txt",timestamp,z),useBytes = T)
            writethisnow<-list()
            tempentries<-list()
            z<-z+1
          }
          
        }
    }
  }
    }}
  
  
  errors3<-list()
  bulkfiles<-list.files(path='C:/Users/Admin/Documents/Motofuze/Recommendation/articles/curatorconcepts',pattern=sprintf('%s [0-9]*bulkcuratorconcepts.txt',timestamp))
  for (file in bulkfiles){
    closeAllConnections()
    sink(sprintf("C:/Users/Admin/Documents/Motofuze/Recommendation/articles/logs/%sOutput.Rout",timestamp),append=TRUE)
    resp<-PUT(url='http://coldfuze01.motofuze.com:9200/fuzecast_user_profiles_v2/curator_concept/_bulk',body=upload_file(sprintf("C:/Users/Admin/Documents/Motofuze/Recommendation/articles/curatorconcepts/%s",file)))
    if(content(resp)$errors==F){
      print(sprintf('bulk %i/%i completed',which(bulkfiles==file),length(bulkfiles)))
      file.copy(from=sprintf("C:/Users/Admin/Documents/Motofuze/Recommendation/articles/curatorconcepts/%s",file),to=sprintf("C:/Users/Admin/Documents/Motofuze/Recommendation/articles/written/uploaded_%s",file))
      file.remove(sprintf("C:/Users/Admin/Documents/Motofuze/Recommendation/articles/curatorconcepts/%s",file))
    }  else{
      errors3[[length(errors3)+1]]<-resp
      print(sprintf('error uploading %s',file))
    }
  }
  print(sprintf('curator concepts updated: %i errors',length(errors3)))
  
  }
}

print('cleaning environment')
deletethis<-ls(pattern="field")
if(length(deletethis)>0){
for(i in 1:length(deletethis)){eval(parse(text=sprintf('remove(%s)',deletethis[i])))}}
deletethis<-ls(pattern="temp")
if(length(deletethis)>0){
for(i in 1:length(deletethis)){eval(parse(text=sprintf('remove(%s)',deletethis[i])))}}
deletethis<-ls(pattern="list")
if(length(deletethis)>0){
for(i in 1:length(deletethis)){eval(parse(text=sprintf('remove(%s)',deletethis[i])))}}
remove(deletethis)
remove(newresults)
remove(actions)
remove(records)
remove(curator)
remove(IDs)
remove(fuzecast)
remove(conceptrecords)
lastupdatetime<-starttime
save.image("C:/Users/Admin/Documents/Motofuze/Recommendation/articles/articleupdateenvironment.RData")
print('environment saved')
quit(save="no")