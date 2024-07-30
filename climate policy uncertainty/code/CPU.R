library(dplyr)
library(readxl)
library(purrr)
library(readr)
library(tidyverse)
library(writexl)
library(haven)
setwd("E:/climate policy uncertainty")
df<-read_dta('./rawdata/zqb.dta')

#pre-process
names(df) = c("date","content")
split_strings <- strsplit(df$date,"-")
years <- lapply(split_strings, function(x) substr(x[[1]], 1, 8))
df$date <- years
df$count <- 1
df$date <- ymd(df$date)
df_newsnum <- aggregate(count~date,df,sum)
df1<- df_newsnum %>% left_join(df,by="date")
df1$count.y <- NULL
names(df1) = c("date","newsnum","content")

#set three glossaries of terms that present climate, policy, and uncertainty
words_climate <- c("气候政策", "气候变化", "气候风险", "全球变暖", "温室气体", "二氧化碳", "碳排放", "碳汇", "可再生能源", "清洁能源", "新能源", "低碳", "节能", "减排", "碳达峰", "碳中和", "双碳", "能源转型")

words_policy <- c("政策", "制度", "体制", "机制", "战略", "改革", "措施", "规章", "规划", "条例", "方案", "方法", "法规", "法律", "监管", "试点", "政府", "国务院", "人大", "人民代表大会", "中央", "人民银行", "央行", "国家发展和改革委员会", "国家发展改革委", "发改委", "生态环境部", "环境保护部", "国家能源局", "国家主席", "总书记", "国家领导人", "总理","外交部","国防部","教育部","科学技术部","工业和信息化部","国家民族事务委员会","公安部","国家安全部","民政部","司法部","财政部","人力资源和社会保障部","自然资源部","住房和城乡建设部","交通运输部","水利部","农业农村部","商务部","文化和旅游部","国家卫生健康委员会","退役军人事务局","应急管理部","中国人民银行","审计署")

words_uncertain <- c("不确定", "不明确", "波动", "震荡", "动荡", "不稳", "未明", "不明朗", "不清晰", "未清晰", "难料", "难以预料", "难以预测", "难以预计", "难以估计", "无法预料", "无法预测", "无法估计", "无法预计", "不可预料", "不可预测", "不可预计", "不可估计")

#select the climate policy-relevant articles that contains at list one term for each glossary
df_extract <- df1 %>% mutate(id = 1:nrow(.)) %>% 
  mutate(df_climate = map(id, .f = function(i) {content[[i]] %>% str_detect(.,words_climate) %>% sum(., na.rm = TRUE)})) %>% 
  
  mutate(df_policy = map(id, .f = function(i) {content[[i]] %>% str_detect(.,words_policy) %>% sum(., na.rm = TRUE)})) %>% 
  
  mutate(df_uncertain = map(id, .f = function(i) {content[[i]] %>% str_detect(.,words_uncertain) %>% sum(., na.rm = TRUE)})) %>% 
  
  filter(df_climate>=1 & df_policy>=1 & df_uncertain>=1)

#calculate the CPU of each day and standardized the time series
df_extract$count <- 1
df_policynum <- aggregate(count~date,df_extract,sum)
df2<- df_policynum %>% left_join(df_extract,by="date")
df2$id <- NULL
df2$df_climate <- NULL
df2$df_policy <- NULL
df2$df_uncertain <- NULL
df2$count.y <- NULL
names(df2) <- c("date","policynum","newsnum","content")
df2$YEAR <- year(df2$date) 
df2$content <- NULL
df2 <- df2 %>% filter(YEAR<=2021)
df2$YEAR <- NULL
df2$newsindex <- df2$policynum/df2$newsnum
df2 <- filter(df2,!duplicated(df2$date))
df3 <- scale(df2$newsindex,center = T, scale = T) %>% as.data.frame()
df2$newsindexstd <- df3$V1
df2$newsindex <- NULL
names(df2) <- c("date","policynum","newsnum","newsindex")
write_dta(df2, './rawdata/cpu_zqb.dta')

#after repeating the above code and get four time series, aggregate them and then calculate the CPU index for each year
df1<-read_dta('./rawdata/cpu_rmrb.dta')
df2<-read_dta('./rawdata/cpu_gmrb.dta')
df3<-read_dta('./rawdata/cpu_jjrb.dta')
df4<-read_dta('./rawdata/cpu_zqb.dta')
names(df1) = c("date","policynum1","newsnum1","newsindex1")
names(df2) = c("date","policynum2","newsnum2","newsindex2")
names(df3) = c("date","policynum3","newsnum3","newsindex3")
names(df4) = c("date","policynum4","newsnum4","newsindex4")
df<-read_dta('./rawdata/rmrb.dta')
df$text <- NULL
names(df) = c("date")
split_strings <- strsplit(df$date,"-")
years <- lapply(split_strings, function(x) substr(x[[1]], 1, 8))
df$date <- years
df$date <- ymd(df$date)
df <- filter(df,!duplicated(df$date))
df5<- df %>% left_join(df1,by="date") %>% left_join(df2,by="date") %>% left_join(df3,by="date") %>% left_join(df4,by="date")
df7 <- select(df5,newsindex1,newsindex2,newsindex3,newsindex4)
df5$newsindex <- rowMeans(df7,na.rm = T)
df5[is.na(df5)] = 0
df5$policynum <- df5$policynum1 + df5$policynum2 + df5$policynum3 + df5$policynum4
df6 <- filter(df5,policynum != 0)
df6$newsnum <- df6$newsnum1 + df6$newsnum2 + df6$newsnum3 + df6$newsnum4
df6 <- select(df6,date,newsindex,policynum,newsnum)
df8 <- scale(df6$newsindex,center = T, scale = T) %>% as.data.frame()
df6$newsindexstd <- df8$V1
df6$year <- year(df6$date)
df6$scale <- (df6$newsindexstd-min(df6$newsindexstd))/(max(df6$newsindexstd)-min(df6$newsindexstd))
df6$scale <- 100*(df6$scale)/mean(df6$scale)
df6$count <- 1
df_CPU <- aggregate(scale~year,df6,sum)/aggregate(count~year,df6,sum)
df_CPU$year <- c(2010,2011,2012,2013,2014,2015,2016,2017,2018,2019,2020,2021)
names(df_CPU) <- c("year","CPU")
write_xlsx(df_CPU, './rawdata/CPU.xlsx')




