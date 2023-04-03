library(dplyr)

setwd("C:/Users/ftw712/Desktop/archive/catalogue-of-centroids/")

readr::read_tsv("centroids.tsv") %>%
glimpse() %>%
sf::st_as_sf(coords = c("decimal_longitude", "decimal_latitude"), crs = 4326) %>%
sf::st_write("centroids.geojson")

