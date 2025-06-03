#install.packages(c("httr", "jsonlite", "tidyverse", "sf", "terra")) #enable API requests, data analysis, spatial processing
library(sf)
library(jsonlite)
library(httr)
library(tidyverse)
library(terra)

#API call from Visual Crossing
res <- GET("https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/Chicago?unitGroup=us&key=AMUYTVER39XM8FVY84ZLQSDHS&contentType=json")
res

#extract JSON format and preview
rawToChar(res$content)

data <- fromJSON(rawToChar(res$content))
names(data)

######################################

## load CDPH data
cdph_data <- read_csv("CDPH_Environmental_Complaints_20250601.csv")

# find and remove missing lat/lons
sum(is.na(cdph_data$LATITUDE))
sum(is.na(cdph_data$LONGITUDE))

cdph_data_clean <- cdph_data %>% 
  filter(!is.na(LATITUDE), !is.na(LONGITUDE))

# convert to sf object
cdph_data_sf <- st_as_sf(cdph_data_clean, 
                         coords = c("LONGITUDE", "LATITUDE"),  # Note: order is lon, lat
                         crs = 4326)
