
library(dplyr)

setwd("C:/Users/ftw712/Desktop/catalogue-of-centroids/")

d_ADM1 = data.table::fread("sources/GeoNames/data/allCountries.txt") %>% 
filter(V8 %in% c("PCLI","ADM1")) %>%
filter(V8 == "ADM1") %>%
glimpse() %>%
select(
decimal_longitude=V6,
decimal_latitude=V5,
source_locality_name=V2
) %>%
mutate(index = row_number()) %>% 
glimpse()

geocode_ADM1 = rgbif::gbif_geocode(d_ADM1$decimal_latitude,d_ADM1$decimal_longitude) %>%
filter(type == "GADM1") %>% 
group_by(index) %>% 
top_n(1) %>%
ungroup() %>% 
glimpse() 
# %>%
# saveRDS("C:/Users/ftw712/Desktop/geocode_GADM1.rda") 

geocode_ADM1 = geocode_ADM1 %>% 
select(index,gadm1 = id,iso2=isoCountryCode2Digit,gbif_name=title) %>% 
group_by(index) %>%
mutate(n = n()) %>% 
ungroup() %>% 
mutate(gadm1 = ifelse(n>1,NA,gadm1)) %>%
mutate(iso2 = ifelse(n>1,NA,iso2)) %>%
mutate(gbif_name = ifelse(n>1,NA,gbif_name)) %>% 
glimpse()

d_ADM1 = merge(d_ADM1,geocode_ADM1,by="index",all.x=TRUE) %>% 
glimpse()

ADM1_area_sqkm = readr::read_tsv("supplement_data/ADM1_area_sqkm.tsv") %>%
glimpse()

merge(d_ADM1,ADM1_area_sqkm,by="gadm1",all.x=TRUE) %>% 
merge(rgbif::enumeration_country() %>% select(iso2,iso3),by="iso2",all.x=TRUE) %>% 
distinct(decimal_longitude,decimal_latitude,.keep_all=TRUE) %>% 
mutate(source = "GeoNames") %>% 
mutate(source_reference = "https://www.geonames.org/") %>% 
mutate(type = "ADM1") %>% 
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
readr::write_tsv("sources/GeoNames/export/ADM1.tsv",na = "")


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


