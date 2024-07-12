library(tidyverse)
library(haven)
library(readxl)
setwd("E:/climate risk/Chinadata")
#读取数据
df<-read_dta('./masterdata/city-month-73-22.dta')
############计算基期平均温度与标准差###############
#计算1973-1982年每个city的平均温度和标准差
names(df)[2] <- "year"
names(df)[3] <- "month"
df_id80 <- df %>% filter(year>=1973 & year<=1982)
df_mean80 <- aggregate(x=df_id80$temp, by=list(df_id80$month,df_id80$city),mean)
names(df_mean80) = c("month","city","temp_mean_82")
df_id80 <- df_id80 %>% left_join(df_mean80,by=c("city","month"))

df_sd80 <- aggregate(x=df_id80$temp, by=list(df_id80$month,df_id80$city),sd)
names(df_sd80) = c("month","city","temp_sd_82")
df_id80 <- df_id80 %>% left_join(df_sd80,by=c("city","month"))

df_id80 <- select(df_id80,city,month,temp_mean_82,temp_sd_82)
df_id80 <- filter(df_id80,!duplicated(df_id80,by=c("city","month")))
df <- df %>% left_join(df_id80,by=c("city","month"))

#计算1973-1992年每个city的平均温度和标准差
df_id90 <- df %>% filter(year>=1973 & year<=1992)

df_mean90 <- aggregate(x=df_id90$temp, by=list(df_id90$month,df_id90$city),mean)
names(df_mean90) = c("month","city","temp_mean_92")
df_id90 <- df_id90 %>% left_join(df_mean90,by=c("city","month"))

df_sd90 <- aggregate(x=df_id90$temp, by=list(df_id90$month,df_id90$city),sd)
names(df_sd90) = c("month","city","temp_sd_92")
df_id90 <- df_id90 %>% left_join(df_sd90,by=c("city","month"))

df_id90 <- select(df_id90,city,month,temp_mean_92,temp_sd_92)
df_id90 <- filter(df_id90,!duplicated(df_id90,by=c("city","month")))
df <- df %>% left_join(df_id90,by=c("city","month"))
#write_dta(df, 'masterdata/sdtemp_city_73_22.dta')
#rm(list=ls())
#gc()
##################计算物理风险##################
#df<-read_dta('./rawdata/temp_70_22.dta')
df$sdtemp82 <- abs(df$temp-df$temp_mean_82)/df$temp_sd_82
df$sdtemp92 <- abs(df$temp-df$temp_mean_92)/df$temp_sd_92
names(df)[10] <- "temp_city"
df$temp_mean_82 <- NULL
df$temp_mean_92 <- NULL
df$temp_sd_82 <- NULL
df$temp_sd_92 <- NULL
write_dta(df, 'masterdata/sdtemp_city_73_22.dta')



