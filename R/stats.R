setwd("C:/Users/ftw712/Desktop/catalogue-of-centroids/")

library(dplyr)
library(purrr)

d = readr::read_tsv("centroids.tsv") %>%
glimpse()

d %>% 
group_by(type) %>%
summarise(distinct_points=n_distinct(decimal_longitude,decimal_latitude)) %>% 
ungroup() %>% 
knitr::kable()

d %>% 
group_by(source,type) %>%
summarise(distinct_points=n_distinct(decimal_longitude,decimal_latitude)) %>%
ungroup() %>% 
arrange(-distinct_points,type) %>% 
knitr::kable()

d %>% 
group_by(iso2,gbif_name) %>%
filter(type == "PCLI") %>%
summarise(distinct_points=n_distinct(decimal_longitude,decimal_latitude)) %>%
ungroup() %>% 
arrange(-distinct_points,iso2) %>% 
na.omit() %>%
knitr::kable()

