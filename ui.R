library(data.table)
library(shiny)
library(leaflet)

topData <- fread("./data/State_MedianListingPrice_TopTier.csv")
colnames(topData)[1] <- "state"
topData <- topData[ ,3:113]

## Define UI for application that draws a bar graph and leaflet map.
ui <- fluidPage(
  
  ## Application title 
  titlePanel("US median house sale price 2010-2019"),
  

  sidebarLayout(
    
  sidebarPanel(
      selectInput("time", "select the year to display", 
                  choices = colnames(topData))
    ),
    

    mainPanel(
      tabsetPanel(
        tabPanel("Price change comparison map", plotOutput("map")),
        tabPanel("01/2010--03/2019 median price map", leafletOutput("map2"), leafletOutput("map3"))
        )
      
    )
  )
)