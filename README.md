# Climate-risk-index

This project uses  **R** and **Stata** construct two climate risk indexes as proxy of climate physical risk and climate policy uncertainty.

# Files

The folder climate physical risk contains code and rawdata.  Given that the rawdata zip file of climate policy uncertainty is over 1GB, so we didn't upload directly and you can download in this [OneDrive link](https://1drv.ms/u/c/75642e0591651e23/EZ_PBbjqfvdBvbQmsq-ZA-oBoDptDXclNcmDuoyniCpuNw).


# Climate physical risk

## methodology
We use standardized temperature (*SdTemp*) as proxy of climate physical risk. the formula is as follows:

$$
SdTemp = \frac{Temp_t-Temp_{t0}}{\sigma_{t0}},
$$

where $Temp_t$ is the Chinese average temperature in year *t*, $Temp_{t0}$ is the Chinese average temperature in the reference period $t_0$ ,  and $\sigma_{t0}$ is the standard deviation of the temperature during the reference period $t_0$.

Specifically, the *SdTemp* measures the degree to which the average temperature deviates from the history period. The higher value of *SdTemp* indicates a higher level of abnormal temperature, which represents the physical risk stemming from global warming, extreme weather events, and sea levels rising to some extent.

## Data

The file temp-China-73-22.dta contains the Chinese average temperature from 1 January 1973 to 31 December 2022. We aggregate all the Chinese station temperatures as the Chinese average temperature. The original data obtained from [NCEI database](https://www.ncei.noaa.gov/data/global-summary-of-the-day/access/) (including the global data) and you can choose a country to download its station list the [daily observation data](https://www.ncei.noaa.gov/maps/daily/) webpage of NCEI. 

## Code

You can use Stata to open the do file and process the rawdata to get the Standardized temperature. Specifically, we select 1973-1982 as the reference period $t_0$ to calculate the reference period.

# Climate policy uncertainty

## methodology
We use standardized temperature (*SdTemp*) as proxy of climate physical risk. the formula is as follows:
We construct climate policy uncertainty indexes in reference to the newspaper indexes method used by [Baker et al. (2016)]( https://doi.org/10.1093/qje/qjw024) and [Gavriilidis (2021)](https://papers.ssrn.com/sol3/papers.cfm?abstract_id=3847388)

First, we create three glossaries of terms that present climate, policy, and uncertainty, respectively. The glossaries of climate include terms representing climate change, climate risk, and Chinese development strategies to address climate change. The glossaries of policy include terms that represent the introduction of policy, and names of sectors in China. In the last glossary, we include the terms that describe the uncertainty.

Second, we select four major Chinese newspapers (i.e., People’s Daily, GuangMing Daily, Economic Daily, and China Youth Daily), which are highly authoritative and influential in China. Furthermore, we identify the newspaper articles that contain at least one term of three glossaries at the same time as climate policy-relevant articles (*relevant*). Beyond that, we constructed a time series of climate policy-relevant article percentages (*policy*) for each newspaper. Specifically, the policy time series are constructed as follows:

$$
policy_{i,t} = \frac{relevant_{i,t}}{N_{i,t}},
$$

where $policy_{i,t}$ represent the climate policy-relevant article percentages of newspaper *i* in day *t*; $relevant_{i,t}$ indicate the number of climate policy-relevant articles of newspaper *i* in day *t* and the $N_{i,t}$ is the number of articles for newspaper *i* on day *t*.

Third, to eliminate the effect of the dimension, we standardize each *policy* time series and average four *policy* time series to get the aggregate policy time series. Further after, we standardize and normalize the aggregation policy time series and scale its mean to 100 to get the CPU time series. The CPU time series are calculated as follows:

$$
CPU_t = normal(std(\sum_{i=1}^{n=4}\frac{std(policy_{i,t})}{n}))*100/mean),
$$

where CPU_t represent the CPU index of day *t*; *normal* represent the normalization of time series to make its value from 0 to 1; *std* represent standardizing the time series to make its mean as 0 and standard deviation is 1; *mean* denote the average value of the time series.

## Data

The file temp-China-73-22.dta contains the Chinese average temperature from 1 January 1973 to 31 December 2022. We aggregate all the Chinese station temperatures as the Chinese average temperature. The original data obtained from [NCEI database](https://www.ncei.noaa.gov/data/global-summary-of-the-day/access/) (including the global data) and you can choose a country to download its station list the [daily observation data](https://www.ncei.noaa.gov/maps/daily/) webpage of NCEI. 

## Code

You can use Stata to open the do file and process the rawdata to get the Standardized temperature. Specifically, we select 1973-1982 as the reference period $t_0$ to calculate the reference period.
