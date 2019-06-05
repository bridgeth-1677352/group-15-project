library(shiny)
library(ggplot2)
library(dplyr)
library(data.table)
library(leaflet)
library(stringr)
library(R.utils)
library(geojsonio)
library(usmap)



TopData <- fread("./data/State_MedianListingPrice_TopTier.csv")
colnames(TopData)[1] <- "state"

states <- geojson_read(x = "./data/us-states.geojson", what = "sp")

##a <- plot_usmap(data = TopData, values = "2010-01", lines = "white") + scale_fill_continuous(name = "price of 2010-01",
                                                                                            ## label = scales::comma) + 
 ## theme(legend.position = "right")

bins <- c(0, 100000, 200000, 300000, 400000, 500000, Inf)
pal <- colorBin("YlOrRd", domain = TopData$`10-Jan`, bins = bins)

labels <- sprintf(
  "<strong>%s</strong><br/>%g dollars </sup>",
  TopData$state, TopData$`10-Jan`
) %>% lapply(htmltools::HTML)

m <- leaflet(states) %>% 
  setView(-96,37.8,4) %>% 
  addProviderTiles("MapBox", options = providerTileOptions(
    id = "mapbox.light",
    accessToken = 'pk.eyJ1IjoiNTI5MDIyMzY2IiwiYSI6ImNqd2ZxZ3V5aTE3a200OG84bjRtM3Z4am4ifQ.wPpU9iKUUn13FhijO951zg')) %>% 
  addPolygons(
    fillColor = ~pal(TopData$`10-Jan`),
    weight = 2,
    opacity = 1,
    color = "white",
    dashArray = "3",
    fillOpacity = 0.7,
    highlight = highlightOptions(
      weight = 5,
      color = "#666",
      dashArray = "",
      fillOpacity = 0.7,
      bringToFront = TRUE),
    label = labels,
    labelOptions = labelOptions(
      style = list("front-weight" = "normal", padding = "3px 8px"),
      textsize = "15px",
      direction = "auto")) %>% 
  addLegend(pal = pal, values = ~TopData$`10-Jan`, opacity = 0.7, title = NULL, position = "bottomright")
