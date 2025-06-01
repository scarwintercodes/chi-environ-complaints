#install.packages(c("httr", "jsonlite", "tidyverse", "sf")) #enable API requests, data analysis, spatial processing
library(sf)
library(jsonlite)
library(httr)
library(tidyverse)

res <-GET("https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/Chicago?unitGroup=us&key=AMUYTVER39XM8FVY84ZLQSDHS&contentType=json")
res

rawToChar(res$content)

data <- fromJSON(rawToChar(res$content))
names(data)
