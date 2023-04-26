setwd("E:\\GitHub Repositories\\cpln675finalproject")

rm(list = ls())

library(tidycensus)
library(tidyverse)
library(ggplot2)

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


ggplot(data = ATL_countyPopData_2010) + geom_sf(aes(fill = estimate)) 

ggplot(data = ATL_countyPopData_2020) + geom_sf(aes(fill = estimate)) 

