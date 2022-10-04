# get country centroids from the TGN
# source of ids 
# view-source:http://vocabsservices.getty.edu/TGNService.asmx/TGNGetNations

library(dplyr)
library(xml2)
library(XML)
library(purrr)
library(countrycode)

setwd("C:/Users/ftw712/Desktop/country centroids review/TGN/") 

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

readRDS("data/tgn_df.rda") %>%
mutate(iso2 = countrycode(tgn_name, 'country.name', 'iso2c')) %>% 
filter(!is.na(iso2)) %>%
filter(!iso2 == "AQ") %>%
sf::st_as_sf(coords = c("lon","lat"), crs = 4326,remove=FALSE) %>%
mutate(buffer_2km = sf::st_buffer(geometry,2000,nQuadSegs=5)) %>%
mutate(buffer_2km = sf::st_make_valid(sf::st_simplify(buffer_2km,dTolerance = 100))) %>%
mutate(wkt_2km = sf::st_as_text(buffer_2km)) %>% 
mutate(n_preserved_specimen = wkt_2km %>% map_dbl(~rgbif::occ_search(geometry = .x,basisOfRecord="PRESERVED_SPECIMEN",limit=1)$meta$count)) %>% 
mutate(n_human_observation = wkt_2km %>% map_dbl(~rgbif::occ_search(geometry = .x,basisOfRecord="HUMAN_OBSERVATION",limit=1)$meta$count)) %>% 
mutate(centroid_link=paste("[link](https://www.gbif.org/occurrence/map?geometry=", wkt_2km,")")) %>%
mutate(centroid_2km=gsub(" ","%20",centroid_link)) %>%
mutate(source = "TGN") %>%
select(iso2,tgn_name,lat,lon,n_preserved_specimen,n_human_observation,source,centroid_2km) %>%
sf::st_drop_geometry() %>%
arrange(-n_preserved_specimen) %>%
glimpse() %>%
knitr::kable()


