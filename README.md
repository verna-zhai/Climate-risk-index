# Climate-risk-index

This project uses  **R** and **Stata** construct two climate risk indexes as proxy of climate physical risk and climate policy uncertainty.

# Files

The folder climate physical risk contains code and rawdata.  Given that the rawdata ZIP file of climate policy uncertainty is over 1GB, so we didn't upload directly and you can download in this [OneDrive link](https://1drv.ms/u/c/75642e0591651e23/EZ_PBbjqfvdBvbQmsq-ZA-oBoDptDXclNcmDuoyniCpuNw).


# Climate physical risk



## Code

You can use Stata to open the do file and process the rawdata to get the Standardized temperature. Specifically, we select 1973-1982 as the reference period to calculate the climate physical risk.

# Climate policy uncertainty


## Data

The rawdata ZIP file of climate policy uncertainty contains the original textual data of four newspaper from 2010 to 2021 (gmrb.dta, rmrb.dta, jjrb.dta and zqb.dta). The four cpu_*.dta files represent the four policy time series and the CPU.xlsx is the time seies of CPU indexes from 2010 to 2021.

## Code

You can open the CPU.R by R studio to calculate the climate policy uncertainty indexes. The line 24, 26 and 28 of code represent the glossary of climate, policy and uncertainty, respectively. To get the CPU indexes, you can repeat the line 1 to line 60 for each newspaper textual data and get each newspaper's policy series. After that, line 63 to line 96 aggregate the four time series and calculate the CPU indexes time series.
