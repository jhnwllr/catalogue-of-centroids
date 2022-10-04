
setwd("C:/Users/ftw712/Desktop/catalogue-of-centroids/")
library(dplyr)

if(FALSE) { # PCL1_area_sqkm

PCL1_cc = CoordinateCleaner::countryref %>% 
filter(type == "country") %>%
filter(is.na(source)) %>% 
select(centroid.lat,centroid.lon,area_sqkm) %>% 
na.omit() %>% 
mutate(index = row_number()) %>%
glimpse() 

PCL1_geocode = rgbif::gbif_geocode(PCL1_cc$centroid.lat,PCL1_cc$centroid.lon) %>%
filter(type == "Political") %>% 
select(index,iso2 = isoCountryCode2Digit) %>%
glimpse() %>%
group_by(index) %>% 
top_n(1) %>%
ungroup() %>% 
glimpse()  %>%
group_by(index) %>%
mutate(n = n()) %>% 
ungroup() %>% 
mutate(iso2 = ifelse(n==2,NA,iso2)) %>%
glimpse()  

merge(PCL1_geocode,PCL1_cc,id="index") %>% 
select(iso2,area_sqkm) %>% 
glimpse() %>% 
readr::write_tsv("supplement_data/PCL1_area_sqkm.tsv",na="")
}


ADM1_cc = CoordinateCleaner::countryref %>% 
filter(type == "province") %>%
filter(is.na(source)) %>% 
select(centroid.lat,centroid.lon,area_sqkm) %>% 
na.omit() %>% 
mutate(index = row_number()) %>%
glimpse()

geocode_ADM1 = rgbif::gbif_geocode(ADM1_cc$centroid.lat,ADM1_cc$centroid.lon) %>%
glimpse() %>%
filter(type == "GADM1") %>% 
group_by(index) %>% 
top_n(1) %>%
ungroup() %>% 
glimpse() %>% 
saveRDS("C:/Users/ftw712/Desktop/geocode_ADM1.rda") 

ADM1_geocode = readRDS("C:/Users/ftw712/Desktop/geocode_ADM1.rda") %>% 
group_by(index) %>%
mutate(n = n()) %>% 
ungroup() %>% 
mutate(gadm1 = ifelse(n==2,NA,id)) %>%
glimpse()

merge(ADM1_geocode,ADM1_cc,id="index") %>% 
select(gadm1,area_sqkm) %>% 
unique() %>% 
glimpse() %>% 
na.omit() %>% 
glimpse() %>% 
distinct(gadm1,.keep_all=TRUE) %>% 
glimpse() %>% 
readr::write_tsv("supplement_data/ADM1_area_sqkm.tsv",na="")




# PCL1_area_sqkm = 

# 



