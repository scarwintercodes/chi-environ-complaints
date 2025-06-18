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
sf_read <-  sf::st_read("https://data.cityofchicago.org/resource/fypr-ksnz.geojson")

# find and remove missing lat/lons
sum(is.na(cdph_data$LATITUDE))
sum(is.na(cdph_data$LONGITUDE))

cdph_data_clean <- cdph_data %>% 
  filter(!is.na(LATITUDE), !is.na(LONGITUDE))

# convert to sf object
cdph_data_sf <- st_as_sf(cdph_data_clean, 
                         coords = c("LONGITUDE", "LATITUDE"),  # Note: order is lon, lat
                         crs = 4326)
