# Climate-risk-index

This project uses  **R** and **Stata** construct two climate risk indexes as proxy of climate physical risk and climate policy uncertainty.

# Files

The folder climate physical risk contains code and rawdata.  Given that the rawdata zip file of climate policy uncertainty is over 1GB, so we didn't upload directly and you can download in this [OneDrive link.](https://1drv.ms/u/c/75642e0591651e23/EZ_PBbjqfvdBvbQmsq-ZA-oBoDptDXclNcmDuoyniCpuNw)


# Climate physical risk

## methodology
We use standardized temperature (*SdTemp*) as proxy of climate physical risk. the formula is as follows:

$$
SdTemp = \frac{Temp_t-Temp_{t0}}{\sigma_{t0}}
$$

where $Temp_t$ is the Chinese average temperature in year *t*, $Temp_{t0}$ is the Chinese average temperature in the reference period $t_0$ ,  and $\sigma_{t0}$ is the standard deviation of the temperature during the reference period $t_0$.

Specifically, the *SdTemp* measures the degree to which the average temperature deviates from the history period. The higher value of *SdTemp* indicates a higher level of abnormal temperature, which represents the physical risk stemming from global warming, extreme weather events, and sea levels rising to some extent.

## Data

The file temp-China-73-22.dta contains Chinese average temperature from shows the rawdata of Chinese average temperature. This file contains Chinese average temperature from 1 January 1973 to 31 December 2022. We aggregate all the Chinese station temperature as the Chinese average temperature. The original data obtained from [NCEI database](https://www.ncei.noaa.gov/data/global-summary-of-the-day/access/) (including the global data) and you can choose a country to download its station list in this [link](https://www.ncei.noaa.gov/maps/daily/).
