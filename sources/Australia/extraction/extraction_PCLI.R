# setwd("C:/Users/ftw712/Desktop/catalogue-of-centroids/")

library(dplyr)

d_PCLI = tibble::tribble(
~decimal_latitude,~decimal_longitude,
-25.274, 133.775,
-23.1166667, 132.33333,
-25.610111, 134.3548056,
-23.033333, 132.1666667,
-23.5527472, 133.396111,
-25.9470278, 133.2096389
) %>% 
mutate(source_locality_name = "Australia") %>%
mutate(index = row_number()) %>% 
glimpse()

geocode_PCLI = rgbif::gbif_geocode(d_PCLI$decimal_latitude,d_PCLI$decimal_longitude) %>%
filter(type == "Political") %>% 
group_by(index) %>% 
top_n(1) %>%
ungroup() %>% 
glimpse() %>%
saveRDS("C:/Users/ftw712/Desktop/geocode_PCLI.rda") 

geocode_PCLI = readRDS("C:/Users/ftw712/Desktop/geocode_PCLI.rda") %>% 
select(index,iso2=isoCountryCode2Digit,gbif_name=title) %>% 
group_by(index) %>%
mutate(n = n()) %>% 
ungroup() %>% 
mutate(iso2 = ifelse(n==2,NA,iso2)) %>%
glimpse()

d_PCLI = merge(d_PCLI,geocode_PCLI,id="index",all.x=TRUE) %>% glimpse()

PCLI_area_sqkm = readr::read_tsv("supplement_data/PCLI_area_sqkm.tsv") %>%
glimpse()

merge(d_PCLI,PCLI_area_sqkm,by="iso2",all.x=TRUE) %>% 
merge(rgbif::enumeration_country() %>% select(iso2,iso3),by="iso2",all.x=TRUE) %>% 
distinct(decimal_longitude,decimal_latitude,.keep_all=TRUE) %>% 
mutate(source = "Australia") %>% 
mutate(source_reference = "https://www.ga.gov.au/scientific-topics/national-location-information/dimensions/centre-of-australia-states-territoriess") %>% 
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
readr::write_tsv("sources/Australia/export/PCLI.tsv",na = "")


