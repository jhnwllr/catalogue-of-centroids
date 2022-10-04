library(dplyr)
library(purrr)

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
mutate(source=ifelse(is.na(source),"CoordinateCleaner","geoLocate")) %>% 
filter(type == "PCLI") %>%
filter(source == "CoordinateCleaner") %>%
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
mutate(iso2 = ifelse(n>1,NA,iso2)) %>%
glimpse() 

d_PCLI = merge(d_PCLI,geocode_PCLI,id="index",all.x=TRUE) %>% 
merge(rgbif::enumeration_country() %>% select(iso2,iso3),id="iso2",all.x=TRUE) %>% 
mutate(source_reference = "https://ropensci.github.io/CoordinateCleaner/reference/cc_cen.html") %>% 
mutate(gadm1 = NA) %>% 
distinct(decimal_longitude,decimal_latitude,.keep_all=TRUE) %>%
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
readr::write_tsv("sources/CoordinateCleaner/export/PCLI.tsv",na = "")


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
