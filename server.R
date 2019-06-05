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

## Read the top tier price file as 'topData', change the column name with state
## to 'state'.
topData <- fread("./data/State_MedianListingPrice_TopTier.csv")
colnames(topData)[1] <- "state"

## Read bottem tier file, name it 'data.
data <- fread("./data/State_MedianListingPrice_BottomTier.csv")

## Read geojson file for leaflet map.
states <- geojson_read(x = "./data/us-states.geojson", what = "sp")

## infomation for hovering over state of 01/2010 map.
labels <- sprintf(
  "<strong>%s</strong><br/>%g dollars </sup>",
  topData$state, topData$`10-Jan`
) %>% lapply(htmltools::HTML)

## infomation for hovering over state of 03/2019 map.
labels2 <- sprintf(
  "<strong>%s</strong><br/>%g dollars </sup>",
  topData$state, topData$`19-Mar`
) %>% lapply(htmltools::HTML)

bins <- c(0, 100000, 200000, 300000, 400000, 500000, Inf)

server <- function(input,output) {
  
  ## making the first map for comparison, which users can choose any month 
  ## between 2010 and 2019 to display.
  output$map <- renderPlot({
    plot_usmap(data = topData, values = input$time, lines = "white") +
      scale_fill_continuous(low = "Yellow", high = "Red", name = "Sale Median price",
                            label = scales::comma) + 
      theme(legend.position = "right")
  })
  
  ## Map of US median sale price 01/2010 with differnt shades of color according
  ## to different prices, hover on a state will show specific price information.
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
  
  ## Same as second map, but the date is 03/2019.
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
  
  ## Create a plot that shows the price change between two dates selected by
  ## user.
  output$plot <- renderPlot ({
    date_one <-  format(as.Date(input$date_one), "%Y-%m")
    date_two <- format(as.Date(input$date_one), "%Y-%m")
    
    plot(x = pull(data, date_one),
         y = pull(data, date_two),
         xlab = paste("First Date:", input$date_one),
         ylab = paste("Second Date:", input$date_two),
         main = "Difference Between Median Prices For Bottom Tier Homes",
         col = c(input$color_one, input$color_two),
         pch=19)
    legend("topleft", legend=c("First Date", "Second Date"),
           col=c(input$color_one, input$color_two), lty=1:2, cex=0.8)
  })
  
  ## Tells user the date being selected.
  output$message <- renderText ({
    paste("The dates you chose were", data[, input$date_one], "and", data[, input$date_two])
  })
}