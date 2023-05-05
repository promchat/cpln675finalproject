setwd("E:\\GitHub Repositories\\cpln675finalproject")

rm(list = ls())

library(tidycensus)
library(tidyverse)
library(ggplot2)
library(sf)
library(foreign)

ATL <- st_read("Atlanta_fishnet.shp")

ATL_counties <- read_csv("ATL_fnet_Counties.csv")
ATL_LC10 <- read_csv("ATL_fnet_LC10.csv")
ATL_LC20 <- read_csv("ATL_fnet_LC20.csv")
ATL_LU10 <- read_csv("ATL_fnet_LU10.csv")
ATL_pop10 <- read_csv("ATL_fnet_pop10.csv")
ATL_pop20 <- read_csv("ATL_fnet_pop20.csv")
ATL_stops <- read_csv("ATL_fnet_stops.csv")
ATL_roads <- read_csv("ATL_Roads.csv")

test <- ATL

summary(ATL_roads)
ATL_roads$uniqueID <- as.character(ATL_roads$uniqueID)

test <- left_join(test, ATL_roads, by = "uniqueID")

colnames(test) <- c("uniqueID", "countyName", "landCover10", "landCover20", "pop10", "pop20", "stops", "roadClass", "geometry")

test$pop10 <- round(test$pop10, 0)
test$pop20 <- round(test$pop20, 0)

test <- test %>% mutate(LC_Change = ifelse(landCover20 != landCover10, 1, 0), 
                        popChange = round(pop20/pop10-1*100, 1))

write_csv(test, "ATL_composite.csv")

ggplot(data = test) + geom_sf(aes(fill = dev)) 

subset <- test %>% filter(LC_Change == 1)

test <- test %>% 
  mutate(dev = ifelse(LC_Change == 1 & 
                        landCover20 == "Developed, Open Space/Developed, Low Intensity/Developed, Medium Intensity/Developed, High Intensity", 1, 0))



ATL <- st_read("ATL_Composite.shp")

ATL_data <- ATL %>% as.data.frame() %>% select(uniquID, contyNm, lndCv10, lndCv20, pop10, pop20, stops, rodClss, LC_Chng, dev)

ATL_LU10$uniqueID = as.character(ATL_LU10$uniqueID)

ATL_data <- left_join(ATL_data, ATL_LU10, by = c("uniquID" = "uniqueID"))

ATL_geom <- ATL %>% select(uniquID, geometry)

ATL_data <- left_join(ATL_geom, ATL_data, by = "uniquID")

x <- ATL_data %>% mutate(popChange = (pop20 - pop10)/pop10*100)

st_write(x, "ATL_Composite.shp")

