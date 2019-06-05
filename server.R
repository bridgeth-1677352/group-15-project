library(shiny)
library(ggplot2)
library(dplyr)
library(data.table)
library(leaflet)
library(stringr)
library(R.utils)
library(geojsonio)
library(leaflet)
library(usmap)


topData <- fread("./data/State_MedianListingPrice_TopTier.csv")
colnames(topData)[1] <- "state"
states <- geojson_read(x = "./data/us-states.geojson", what = "sp")

labels <- sprintf(
  "<strong>%s</strong><br/>%g dollars </sup>",
  topData$state, topData$`10-Jan`
) %>% lapply(htmltools::HTML)

labels2 <- sprintf(
  "<strong>%s</strong><br/>%g dollars </sup>",
  topData$state, topData$`19-Mar`
) %>% lapply(htmltools::HTML)

bins <- c(0, 100000, 200000, 300000, 400000, 500000, Inf)


server <- function(input,output) {
  
  output$map <- renderPlot({
    plot_usmap(data = topData, values = input$time, lines = "white") +
      scale_fill_continuous(low = "Yellow", high = "Red", name = "Sale Median price",
                            label = scales::comma) + 
      theme(legend.position = "right")
  })
  
  output$map2 <- renderLeaflet({
    pal <- colorBin("YlOrRd", domain = topData$'01-Jan', bins = bins) 
    leaflet(states) %>% 
      setView(-96,37.8,4) %>% 
      addProviderTiles("MapBox", options = providerTileOptions(
        id = "mapbox.light",
        accessToken = 
          'pk.eyJ1IjoiNTI5MDIyMzY2IiwiYSI6ImNqd2ZxZ3V5aTE3a200OG84bjRtM3Z4am4ifQ.wPpU9iKUUn13FhijO951zg')) %>% 
        addPolygons(
          fillColor = ~pal(topData$`10-Jan`),
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
          addLegend(pal = pal, values = ~topData$`10-Jan`, opacity = 0.7, 
                    title = "Jan 2010 median price", position = "bottomright")
  })
  
  output$map3 <- renderLeaflet({
    pal <- colorBin("YlOrRd", domain = topData$'19-Mar', bins = bins)
    
    leaflet(states) %>% 
      setView(-96,37.8,4) %>% 
      addProviderTiles("MapBox", options = providerTileOptions(
        id = "mapbox.light",
        accessToken = 
          'pk.eyJ1IjoiNTI5MDIyMzY2IiwiYSI6ImNqd2ZxZ3V5aTE3a200OG84bjRtM3Z4am4ifQ.wPpU9iKUUn13FhijO951zg')) %>% 
      addPolygons(
        fillColor = ~pal(topData$`19-Mar`),
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
        label = labels2,
        labelOptions = labelOptions(
          style = list("front-weight" = "normal", padding = "3px 8px"),
          textsize = "15px",
          direction = "auto")) %>% 
      addLegend(pal = pal, values = ~topData$`03-Mar`, opacity = 0.7, 
                title = "March 2019 median price", position = "bottomright")
  })
}