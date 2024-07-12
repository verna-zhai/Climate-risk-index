clear
use "E:\1PHD\github\climate physical risk\rawdata\temp-China-73-22.dta" 
egen mean_temp=mean(average_temp), by (year)
drop DATE Country average_temp
duplicates drop year mean_temp, force
summarize mean_temp if year <= 1982
gen mean_73_82 = r(mean)
gen std_73_82 = r(sd)
gen sdtemp = (mean_temp-mean_73_82)/std_73_82