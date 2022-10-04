
setwd("C:/Users/ftw712/Desktop/catalogue-of-centroids/")

library(dplyr)
library(purrr)
library(dggridR) 
library(rnaturalearth)
library(ggplot2)
library(showtext)

# font_add("Roboto", "Roboto-Black.ttf")
# font_families()

# sf::sf_use_s2(FALSE)

d = readr::read_tsv("centroids.tsv") %>%
sf::st_as_sf(coords = c("decimal_longitude", "decimal_latitude")) %>%
st_set_crs(4326) %>%
glimpse()

world = ne_countries(scale = 'small', type = 'map_units',returnclass = 'sf') 

p = ggplot() + 
theme_void() + 
theme(text=element_text(size=16, family="Roboto")) +
geom_sf(data = world,color="#8D8D8D") +
geom_sf(data =d,size=0.5,aes(color=type)) +
theme(legend.position = "bottom") +
theme(plot.background = element_rect(fill = "#FFFFFF",color = "#FFFFFF")) +
scale_color_manual(
values = c(
"PCLI"="#EE4B2B",
"ADM1"="#000000"
)) +
guides(colour = guide_legend(override.aes = list(size=5)))

# ggsave("plots/point_map.pdf",plot=p,width=16,height=9,device=cairo_pdf,scale=1)
# ggsave("plots/point_map.svg",plot=p,width=16,height=9,scale=1)
ggsave("plots/point_map.png",plot=p,width=16,height=9,dpi=600,scale=1)

magick::image_read(path = paste0("plots/point_map.png")) %>%
magick::image_resize(geometry = "1600x900") %>%
magick::image_write(path = paste0("point_map.jpg")) 












