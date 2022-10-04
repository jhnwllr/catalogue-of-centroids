
# setwd("C:/Users/ftw712/Desktop/catalogue-of-centroids/")

library(dplyr)
library(purrr)

sources = c("CoordinateCleaner", "geoLocate", "TGN", "GeoNames", "Australia")

sources %>%
map(~list.files(paste0("sources/",.x,"/export"),full.names = TRUE)) %>%
flatten_chr() %>%
map(~readr::read_tsv(.x)) %>%
bind_rows() %>% 
glimpse() %>% 
readr::write_tsv("centroids.tsv",na="")

quit(save="no")

