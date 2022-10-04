# setwd("C:/Users/ftw712/Desktop/catalogue-of-centroids/sources/CoordinateCleaner/")

library(dplyr)
library(purrr)

d_ADM1 = CoordinateCleaner::countryref %>% 
select(
iso3,
iso2,
source_locality_name=name,
type,
decimal_longitude = centroid.lon,
decimal_latitude = centroid.lat,
area_sqkm,
source) %>%
mutate(type=ifelse(type=="country","PCLI","ADM1")) %>% 
mutate(source=ifelse(is.na(source),"CoordinateCleaner","geoLocate")) %>% 
filter(type == "ADM1") %>%
mutate(index = row_number()) %>% 
glimpse()

geocode_ADM1 = rgbif::gbif_geocode(d_ADM1$decimal_latitude,d_ADM1$decimal_longitude) %>%
glimpse() %>%
filter(type == "GADM1") %>% 
group_by(index) %>% 
top_n(1) %>%
ungroup() %>% 
glimpse() 
# %>% 
# saveRDS("C:/Users/ftw712/Desktop/geocode_ADM1.rda") 

# geocode_ADM1 = readRDS("C:/Users/ftw712/Desktop/geocode_ADM1.rda") %>% 
geocode_ADM1 = geocode_ADM1 %>% 
select(index,gadm1=id,iso2=isoCountryCode2Digit,gbif_name=title) %>% 
group_by(index) %>%
mutate(n = n()) %>% 
ungroup() %>% 
mutate(gadm1 = ifelse(n>1,NA,gadm1)) %>%
mutate(iso2 = ifelse(n>1,NA,iso2)) %>%
glimpse()

d_ADM1 = merge(d_ADM1,geocode_ADM1,id="index",all.x=TRUE) %>%
distinct(decimal_longitude,decimal_latitude,.keep_all=TRUE) %>% 
mutate(source_reference = "https://ropensci.github.io/CoordinateCleaner/reference/cc_cen.html") %>% 
select(
iso3,
iso2,
gadm1,
gbif_name,
type,
area_sqkm,
decimal_longitude,
decimal_latitude,
source_locality_name,
source_reference,
source
) %>% 
glimpse() %>%
readr::write_tsv("sources/CoordinateCleaner/export/ADM1.tsv",na = "")
