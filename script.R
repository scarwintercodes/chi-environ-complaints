#install.packages(c("httr", "jsonlite", "tidyverse", "sf", "terra", "geojsonR")) #enable API requests, data analysis, spatial processing
library(pacman)

pacman::p_load(sf, jsonlite, httr, tidyverse, terra, geojsonR)
#API call from Visual Crossing
res <- GET("https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/Chicago/yeartodate/today?unitGroup=us&include=fcst%2Cremote%2Cstats%2Cobs%2Cdays&key=AMUYTVER39XM8FVY84ZLQSDHS&contentType=json")
res

#extract JSON format and preview
rawToChar(res$content)

data <- fromJSON(rawToChar(res$content))
names(data)

######################################

## load CDPH data as geoJSON file
cdph <-  sf::st_read("https://data.cityofchicago.org/resource/fypr-ksnz.geojson?$limit=50000")

# find and remove missing lat/longs
sum(is.na(cdph$latitude))
sum(is.na(cdph$longitude))

cdph_clean <- cdph %>% 
  filter(!is.na(latitude), !is.na(longitude))

