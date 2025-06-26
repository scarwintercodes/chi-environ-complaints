#install.packages(c("httr", "jsonlite", "tidyverse", "sf", "terra", "geojsonR")) #enable API requests, data analysis, spatial processing
library(pacman)

pacman::p_load(sf, jsonlite, httr, tidyverse, terra, geojsonR)
#API call from Visual Crossing
res <- sf::st_read("https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/Chicago/yeartodate/today?unitGroup=us&include=fcst%2Cremote%2Cstats%2Cobs%2Cdays&key=AMUYTVER39XM8FVY84ZLQSDHS&contentType=json")
res

#extract JSON format and preview
rawToChar(res$content)

data <- fromJSON(rawToChar(res$content))
names(data)

######################################

## load CDPH data as geoJSON file
cdph <-  sf::st_read("https://data.cityofchicago.org/resource/fypr-ksnz.geojson?$limit=50000")

str(cdph)

# find and remove missing lat/longs
sum(is.na(cdph$latitude))
sum(is.na(cdph$longitude))


cdph_clean <- cdph %>% 
  filter(!is.na(latitude), !is.na(longitude))

########## INSPECTION STEPS #################
#print CRS, WGS 84
print(sf::st_crs(cdph_clean))

cdph_attributes_only <- sf::st_drop_geometry(cdph_clean)
cdph_geo_only <- sf::st_geometry(cdph_clean)

# Investigate geo object
glimpse(cdph_geo_only)


#explore combo cdph dataset

colnames(cdph_clean)
class(cdph_geo_only)

# Interested in complaint dates from 2025 onward, need to filter out
cdph_clean <- cdph_clean %>% 
  filter(complaint_date >= "2025-01-01", complaint_date <= "2025-12-31")


