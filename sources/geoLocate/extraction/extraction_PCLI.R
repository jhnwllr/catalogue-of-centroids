
# setwd("C:/Users/ftw712/Desktop/catalogue-of-centroids/")
library(dplyr)

d_PCLI = CoordinateCleaner::countryref %>% 
filter(type == "country") %>%
filter(source == "geolocate") %>%
select(
decimal_longitude=centroid.lon,
decimal_latitude=centroid.lat,
source_locality_name=name
) %>%
mutate(index = row_number()) %>%
glimpse()

geocode_PCLI = rgbif::gbif_geocode(d_PCLI$decimal_latitude,d_PCLI$decimal_longitude) %>%
filter(type == "Political") %>% 
group_by(index) %>% 
top_n(1) %>%
ungroup() %>% 
glimpse() 

geocode_PCLI = geocode_PCLI %>% 
select(index,iso2=isoCountryCode2Digit,gbif_name=title) %>% 
group_by(index) %>%
mutate(n = n()) %>% 
ungroup() %>% 
mutate(iso2 = ifelse(n==2,NA,iso2)) %>%
glimpse()

d_PCLI = merge(d_PCLI,geocode_PCLI,by="index",all.x=TRUE) %>% glimpse()

PCLI_area_sqkm = readr::read_tsv("supplement_data/PCLI_area_sqkm.tsv") %>%
glimpse()

merge(d_PCLI,PCLI_area_sqkm,by="iso2",all.x=TRUE) %>% 
merge(rgbif::enumeration_country() %>% select(iso2,iso3),by="iso2",all.x=TRUE) %>% 
distinct(decimal_longitude,decimal_latitude,.keep_all=TRUE) %>% 
mutate(source = "geoLocate") %>% 
mutate(source_reference = "https://www.geo-locate.org/") %>% 
mutate(type = "PCLI") %>% 
mutate(gadm1 = NA) %>%
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
readr::write_tsv("sources/geoLocate/export/PCLI.tsv",na = "")


