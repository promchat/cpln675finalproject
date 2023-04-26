setwd("D:\\Promit Chatterjee_UPenn_970401442\\CPLN 675\\Final Project")

library(tidycesnsus)
library(tidycensus)

vars <- load_variables(year = 2019, dataset = "acs5")

