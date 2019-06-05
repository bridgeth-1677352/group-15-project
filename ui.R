library(data.table)
library(shiny)
library(leaflet)
library(shinythemes)

topData <- fread("./data/State_MedianListingPrice_TopTier.csv")
colnames(topData)[1] <- "state"
topData <- topData[ ,3:113]

## Define UI for application as navbarPage, and it will display different tab panels.
ui <- navbarPage(inverse = F,
                 fluid = T,
                 theme = shinytheme("flatly"),
                  "2010-2019 US house sale median price",
                 
                 ## Home page, shows information of data and team.
                 tabPanel("Home",
                          
                          tags$h3("welcome"),
                          
                          tags$h3("Median Prices of United States Homes"),
                          p("The two datasets that our group analyzed contained the median
                             prices of United States homes. Each dataset displayed different
                             tiers of homes: top tier houses and bottom tier
                             houses. This data came from the site 'Zillow', which is a
                             real estate marketing company. We were interested in this data
                             to see the trends in median prices throughout a period of time
                             in certain states."),
                          
                          tags$h3("Datasets Used"),
                          tags$h4("Top-Tier Homes (State_MedianListingPrice_TopTier.csv):"),
                          p("This dataset looks at the median prices of sold Homes categorized
                            as top-tier in the United States. The data includes the states in which
                            the data was curated, the ranking of each state based on population,
                            and median prices from the dates of January 2010 to March 2019. The dates
                            are in the form of yy-(first three letters of month).
                            For instance, January 2010 is written as 10-JAN."),
                          
                          tags$h3("Bottom-Tier Homes (State_MedianListingPrice_BottomTier.csv):"),
                          p("This dataset looks at the median prices of sold Homes categorized as
                            bottom-tier in the United States. The data includes the states in which
                            the data was curated, the ranking of each state based on population,
                            and median prices from the datesof January 2010 to March 2019.
                            The dates are in the form of yyyy-mm. For instance, January 2010
                            is written as 2010-01."),
                          
                          tags$h3("Target Audience"),
                          p("The target audience that would be interested in our data and
                            analysis are those legally of age, which in the United States is 18.
                            We also wanted to focus on demographics of individuals and couples. These
                            were the most likely audiences that would find our data useful."),
                          
                          tags$h3("Technical Aspects of Project"),
                          p("In order to design the interactive visualizations of our data,
                            we used Shiny. This allowed us to create an App of charts that
                            target certain trends in our chosen datasets. We used 'dplyr' to filter
                            out the columns and rows of data we wanted to extract. We also used
                            'ggplot2' and other map-oriented packages to create interactive maps
                            based on user input. The datasets were csv files, so they were easily
                            manipulated through R and Shiny coding."),
                          
                          tags$h3("Link to Zillow Datasets"),
                          p("https://www.zillow.com/research/data/

                            We specifically used the datasets under the 'Home Listing and Sales' section.
                            There we clicked data type 'Median List Price - Bottom Tier ($) with geography 'State'
                            to get the bottom-tier data, and data type 'Median List Price - Top Tier ($)' with geography
                            'State' to get top-tier data."),
                          
                          tags$h3("Group 15 Team"),
                          p("**Bridget Haney** github: https://github.com/bridgeth-1677352 

                            **Huawen Sun** github: https://github.com/529022366
                            
                            **Tyson Thoi** github: https://github.com/tpthoi
                            
                            **Alaa Amed** github: https://github.com/Alaa-Amed")
                 ),
                 
                 
                 ## This panel displays the comparison map, which user can choose
                 ## any month between 2010 and 2019, and map will change.
                 tabPanel("2010-2019 Price Comparison Map",
                          
                          tags$h3("2010-2019 US House Sale Median Price Comparison Map"),
                          p("You can select different dates at the left side panel
                            to see different price maps for comparison."),
                          sidebarLayout(
                            sidebarPanel(
                              selectInput("time", "select the year and month to display", 
                                          choices = colnames(topData)
                              )
                            ),
                            mainPanel(
                              plotOutput("map")
                            )
                          )
                 ),
                 
                 ## This panel displays two maps, one at 01/2010, and another 
                 ## at 03/2019.
                 tabPanel("01/2010--03/2019 price maps",
                          
                          tags$h3("01/2010--03/2019 US House Sale Median Price Map"),
                          p("These graphs are US house sale median price map at Jan/2010 and March/2019.
                            The shade of colors indicate different prices. You can hover mouse on a state
                            to see specific information."),
                          leafletOutput("map2"),
                          br(),
                          leafletOutput("map3")
                 )
)
