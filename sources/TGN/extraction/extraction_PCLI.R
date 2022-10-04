# setwd("C:/Users/ftw712/Desktop/catalogue-of-centroids/")

library(dplyr)
library(purrr)
library(countrycode)

d_PCLI = readRDS("sources/TGN/data/tgn_df.rda") %>% 
mutate(iso2 = countrycode(tgn_name, 'country.name', 'iso2c')) %>% 
filter(!is.na(iso2)) %>%
mutate(lon = as.numeric(lon)) %>% 
mutate(lat = as.numeric(lat)) %>% 
select(
decimal_longitude=lon,
decimal_latitude=lat,
source_locality_name=tgn_name
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

d_PCLI = merge(d_PCLI,geocode_PCLI,id="index",all.x=TRUE) %>% glimpse()

PCLI_area_sqkm = readr::read_tsv("supplement_data/PCLI_area_sqkm.tsv") %>%
glimpse()

merge(d_PCLI,PCLI_area_sqkm,by="iso2",all.x=TRUE) %>% 
merge(rgbif::enumeration_country() %>% select(iso2,iso3),by="iso2",all.x=TRUE) %>% 
distinct(decimal_longitude,decimal_latitude,.keep_all=TRUE) %>% 
mutate(source = "TGN") %>% 
mutate(source_reference = "https://www.getty.edu/research/tools/vocabularies/tgn/") %>% 
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
readr::write_tsv("sources/TGN/export/PCLI.tsv",na = "")






# tgn = read_xml("data/tgn_nations.xml") %>% 
# xmlParse() %>% 
# xmlToList() %>% 
# map(~ tibble(id=.x[[1]],name=.x[[2]])) %>%
# bind_rows()  

# tgn %>%
# pull(id) %>% 
# map(~ jsonlite::fromJSON(paste0("https://vocab.getty.edu/tgn/",.x,".json")) %>%
# saveRDS(paste0("data/res/",.x,".rda")) 
# ) 

# tgn_df = list.files("data/res/") %>% 
# gsub(".rda","",.) %>%
# map(~ 
# readRDS(paste0("data/res/",.x,".rda")) %>% 
# pluck("identified_by") %>% 
# filter(id == paste0("http://vocab.getty.edu/tgn/geometry/",.x)) %>%
# mutate(source_id = .x) %>%
# select(source_id,value) 
# ) %>% 
# bind_rows() %>%
# mutate(value=gsub("\\[|\\]","",value)) %>% 
# tidyr::separate(value, c("lon", "lat"),sep=",") %>%
# rename(id = source_id) %>%
# merge(tgn,id="id") %>%
# select(tgn_name=name,lon,lat) %>% 
# glimpse() %>%
# saveRDS("data/tgn_df.rda")
# sample_n(5) %>%

# mutate(iso2 = countrycode(tgn_name, 'country.name', 'iso2c')) %>% 
# filter(!is.na(iso2)) %>%
# filter(!iso2 == "AQ") %>%
# sf::st_as_sf(coords = c("lon","lat"), crs = 4326,remove=FALSE) %>%
# mutate(buffer_2km = sf::st_buffer(geometry,2000,nQuadSegs=5)) %>%
# mutate(buffer_2km = sf::st_make_valid(sf::st_simplify(buffer_2km,dTolerance = 100))) %>%
# mutate(wkt_2km = sf::st_as_text(buffer_2km)) %>% 
# mutate(n_preserved_specimen = wkt_2km %>% map_dbl(~rgbif::occ_search(geometry = .x,basisOfRecord="PRESERVED_SPECIMEN",limit=1)$meta$count)) %>% 
# mutate(n_human_observation = wkt_2km %>% map_dbl(~rgbif::occ_search(geometry = .x,basisOfRecord="HUMAN_OBSERVATION",limit=1)$meta$count)) %>% 
# mutate(centroid_link=paste("[link](https://www.gbif.org/occurrence/map?geometry=", wkt_2km,")")) %>%
# mutate(centroid_2km=gsub(" ","%20",centroid_link)) %>%
# mutate(source = "TGN") %>%
# select(iso2,tgn_name,lat,lon,n_preserved_specimen,n_human_observation,source,centroid_2km) %>%
# sf::st_drop_geometry() %>%
# arrange(-n_preserved_specimen) %>%
# glimpse() %>%
# knitr::kable()


