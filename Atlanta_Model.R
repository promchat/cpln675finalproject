---
title: "Urban Growth Modeling in Atlanta Metro, CPLN 675 - Final Project, 2023"
students: "Promit Chattergee and Anastasia Osorio"
---
  
```
```{r load_packages, message=FALSE, warning=FALSE, results = "hide"}
#install.packages("rlang")
#library(rlang)
update.packages("tidyverse")
library(tidyverse)
library(caret)
library(plotROC) 
library(ggrepel)
library(viridis)


library(sf)
library(raster)
library(knitr)
library(kableExtra)
library(tidycensus)
library(tigris)
library(FNN)
#library(QuantPsyc) # JE Note: in R 4.1, QuantPsyc package not available.
library(yardstick)
library(pscl)
library(pROC)
library(grid)
library(gridExtra)
library(igraph)

plotTheme <- theme(
  plot.title =element_text(size=12),
  plot.subtitle = element_text(size=8),
  plot.caption = element_text(size = 6),
  axis.text.x = element_text(size = 10, angle = 45, hjust = 1),
  axis.text.y = element_text(size = 10),
  axis.title.y = element_text(size = 10),
  # Set the entire chart region to blank
  panel.background=element_blank(),
  plot.background=element_blank(),
  #panel.border=element_rect(colour="#F0F0F0"),
  # Format the grid
  panel.grid.major=element_line(colour="#D0D0D0",size=.75),
  axis.ticks=element_blank())

mapTheme <- theme(plot.title =element_text(size=12),
                  plot.subtitle = element_text(size=8),
                  plot.caption = element_text(size = 6),
                  axis.line=element_blank(),
                  axis.text.x=element_blank(),
                  axis.text.y=element_blank(),
                  axis.ticks=element_blank(),
                  axis.title.x=element_blank(),
                  axis.title.y=element_blank(),
                  panel.background=element_blank(),
                  panel.border=element_blank(),
                  panel.grid.major=element_line(colour = 'transparent'),
                  panel.grid.minor=element_blank(),
                  legend.direction = "vertical", 
                  legend.position = "right",
                  plot.margin = margin(1, 1, 1, 1, 'cm'),
                  legend.key.height = unit(1, "cm"), legend.key.width = unit(0.2, "cm"))

palette2 <- c("#41b6c4","#253494")
palette4 <- c("#a1dab4","#41b6c4","#2c7fb8","#253494")
palette5 <- c("#ffffcc","#a1dab4","#41b6c4","#2c7fb8","#253494")
palette10 <- c("#f7fcf0","#e0f3db","#ccebc5","#a8ddb5","#7bccc4",
               "#4eb3d3","#2b8cbe","#0868ac","#084081","#f7fcf0")
```
