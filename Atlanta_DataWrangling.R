setwd("E:\\GitHub Repositories\\cpln675finalproject")

rm(list = ls())

library(tidycensus)
library(tidyverse)
library(ggplot2)
library(sf)

vars <- load_variables(year = 2019, dataset = "acs5")

Counties <- c("Barrow", "Bartow", "Carroll", "Cherokee", 
              "Clayton", "Cobb", "Coweta", "Dawson", 
              "DeKalb", "Douglas", "Fayette", "Forsyth", 
              "Fulton", "Gwinnett", "Hall", "Henry", 
              "Newton", "Paulding", "Rockdale", "Spalding"
              , "Walton") 

# NOT INCLUDED: Lamar, Harrelson, Merriwether, Pickens, Heard, Butts, Jasper, Pike 


ATL_countyPopData_2020 <- get_acs(geography = "tract", variables = "B01003_001",
                state = "GA", county = Counties, geometry = TRUE, year = 2020)


ATL_countyPopData_2010 <- get_acs(geography = "tract", variables = "B01003_001",
                                  state = "GA", county = Counties, geometry = TRUE, year = 2010)

ATL_pop20 <- ATL_countyPopData_2020 %>% select(GEOID, estimate)

ATL_pop10 <- ATL_countyPopData_2010 %>% select(GEOID, estimate)


colnames(ATL_pop10)[2] <- "population"

colnames(ATL_pop20)[2] <- "population"


ggplot(data = ATL_pop10) + geom_sf(aes(fill = population)) 

ggplot(data = ATL_pop20) + geom_sf(aes(fill = population)) 

st_write(ATL_pop10, "Atlanta_pop_byCensusTract_2010.geojson")
st_write(ATL_pop20, "Atlanta_pop_byCensusTract_2020.geojson")

st_crs(ATL_pop20)

ATL_MSA <- st_read("Metro Boundary/Metro Boundary/ATLMetroBoundary.shp")

184000000000/5760000 # no of cells

ATL_fishnet <- 
  st_make_grid(ATL_MSA,
               cellsize = 2400, 
               square = TRUE) %>%
  .[ATL_MSA] %>%            # clips the grid to the chesterBoundary file
  st_sf() %>%
  mutate(uniqueID = rownames(.))

ggplot(data = ATL_fishnet) + geom_sf() 

st_write(ATL_fishnet, "Atlanta_fishnet.geojson")



