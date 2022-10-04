
setwd("C:/Users/ftw712/Desktop/catalogue-of-centroids/sources/CoordinateCleaner/")

library(dplyr)
library(purrr)

if(FALSE) { # AMD1 extract
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
mutate(source=ifelse(is.na(source),"CoordianteCleaner","geoLocate")) %>% 
filter(type == "ADM1") %>%
mutate(index = row_number()) %>% 
glimpse()

geocode_ADM1 = rgbif::gbif_geocode(d_ADM1$decimal_latitude,d_ADM1$decimal_longitude) %>%
glimpse() %>%
filter(type == "GADM1") %>% 
group_by(index) %>% 
top_n(1) %>%
ungroup() %>% 
glimpse() %>% 
saveRDS("C:/Users/ftw712/Desktop/geocode_ADM1.rda") 

geocode_ADM1 = readRDS("C:/Users/ftw712/Desktop/geocode_ADM1.rda") %>% 
select(index,gadm1=id,gbif_name=title) %>% 
glimpse()

d_ADM1 = merge(d_ADM1,geocode_ADM1,id="index",all.x=TRUE) %>%
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
readr::write_tsv("export/ADM1.tsv",na = "")
}

d_PCLI = CoordinateCleaner::countryref %>% 
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
mutate(source=ifelse(is.na(source),"CoordianteCleaner","geoLocate")) %>% 
filter(type == "PCLI") %>%
filter(source == "CoordianteCleaner") %>%
mutate(index = row_number()) %>% 
glimpse()

# geocode_PCLI = rgbif::gbif_geocode(d_PCLI$decimal_latitude,d_PCLI$decimal_longitude) %>%
# filter(type == "Political") %>% 
# group_by(index) %>% 
# top_n(1) %>%
# ungroup() %>% 
# glimpse() %>%
# saveRDS("C:/Users/ftw712/Desktop/geocode_PCLI.rda") 

geocode_PCLI = readRDS("C:/Users/ftw712/Desktop/geocode_PCLI.rda") %>% 
select(index,iso2=isoCountryCode2Digit,gbif_name=title) %>% 
group_by(index) %>%
mutate(n = n()) %>% 
ungroup() %>% 
mutate(iso2 = ifelse(n==2,NA,iso2)) %>%
glimpse() 

d_PCLI = merge(d_PCLI,geocode_PCLI,id="index",all.x=TRUE) %>% 
merge(rgbif::enumeration_country() %>% select(iso2,iso3),id="iso2",all.x=TRUE) %>% 
mutate(source_reference = "https://ropensci.github.io/CoordinateCleaner/reference/cc_cen.html") %>% 
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
readr::write_tsv("export/PCLI.tsv",na = "")


# **iso3** : ISO 3166-1 alpha-3
# **iso2** : ISO 3166-1 alpha-2 
# **gadm1** : GADM level one code
# **gbif_name** : GBIF standardized name of locality/iso place
# **type** : one of "PCLI" (places with an iso-code),"ADM1" (provinces,states,gadm1) 
# **area_sqkm** : The approximate area of the centroid's polygon
# **decimal_longitude** : longitude of centroid (WGS84)
# **decimal_latitude** : latitude of centroid (WGS84) 
# **source_locality_name** : the name given by the source
# **source_reference** : link to the source
# **source** : CoordinateCleaner, geoLocate, TGN, geoNames, Australia
