
library(dplyr)

# setwd("C:/Users/ftw712/Desktop/catalogue-of-centroids/sources/GeoNames/")

d_PCLI = data.table::fread("sources/GeoNames/data/allCountries.txt") %>% 
filter(V8 %in% c("PCLI","ADM1")) %>%
filter(V8 == "PCLI") %>%
glimpse() %>%
select(
decimal_longitude=V6,
decimal_latitude=V5,
source_locality_name=V2
) %>%
mutate(index = row_number()) %>% 
glimpse()

geocode_PCLI = rgbif::gbif_geocode(d_PCLI$decimal_latitude,d_PCLI$decimal_longitude) %>%
filter(type == "Political") %>% 
group_by(index) %>% 
top_n(1) %>%
ungroup() %>% 
glimpse() 
# %>%
# saveRDS("C:/Users/ftw712/Desktop/geocode_PCLI.rda") 

# geocode_PCLI = readRDS("C:/Users/ftw712/Desktop/geocode_PCLI.rda") %>% 
geocode_PCLI = geocode_PCLI %>% 
select(index,iso2=isoCountryCode2Digit,gbif_name=title) %>% 
group_by(index) %>%
mutate(n = n()) %>% 
ungroup() %>% 
mutate(iso2 = ifelse(n==2,NA,iso2)) %>%
glimpse()

d_PCLI = merge(d_PCLI,geocode_PCLI,id="index",all.x=TRUE) %>% glimpse()

cc_d = CoordinateCleaner::countryref %>% 
select(iso2,area_sqkm,type) %>%
mutate(type=ifelse(type=="country","PCLI","ADM1")) %>% 
filter(type == "PCLI") %>%
mutate(index = row_number()) %>% 
select(iso2,area_sqkm) %>%
unique() %>% 
glimpse() 

d_PCLI = merge(d_PCLI,cc_d,by="iso2",all.x=TRUE) %>% 
merge(rgbif::enumeration_country() %>% select(iso2,iso3),id="iso2",all.x=TRUE) %>% 
mutate(source = "GeoNames") %>% 
mutate(source_reference = "https://www.geonames.org/") %>% 
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
readr::write_tsv("sources/GeoNames/export/PCLI.tsv",na = "")

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
# **source** : CoordinateCleaner, geoLocate, TGN, GeoNames, Australia

