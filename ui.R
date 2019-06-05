library(data.table)
library(shiny)
library(leaflet)
library(shinythemes)
library(shinyWidgets)

topData <- fread("Data/State_MedianListingPrice_TopTier.csv")
colnames(topData)[1] <- "state"
topData <- topData[ ,3:113]

## Define UI for application as navbarPage, and it will display different tab panels.
ui <- fluidPage(includeCSS("style.css"), img(src = "logo.png", width = "100px", 
                height = "30px", style="position: absolute; left:1040px;top: 5px;"), 
                tags$h6("Zillow Tool for Home"),
                 tags$hr(),
                 ## Home page, shows information of data and team.
                 tabsetPanel(id = "Main",
                          tabPanel(title = "welcome",
                          
                          actionButton("do", "Learn More", style="color: #fff; 
                          background-color: #337ab7; border-color: #2e6da4; 
                          position: absolute; left: 530px;top: 550px;
                          padding: 8px 34px;"),
                          
                 
                          tags$img(src="m.png", width = "1120px", height = "600px")

                          
                             ),
                 
                 
                 tabPanel("Home",
                          tags$div(class = "myclass",
                            tags$h3("Median Prices of United States Homes"),
                            tags$p("The two datasets that our group analyzed contained the median
                                          prices of United States homes. Each dataset displayed different
                                          tiers of homes: top tier houses and bottom tier
                                          houses. This data came from the site 'Zillow', which is a
                                          real estate marketing company. We were interested in this data
                                          to see the trends in median prices throughout a period of time
                                          in certain states.")
                            ),

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
                          
                          tags$hr(),
                          
                          tags$h4("Link to Zillow Datasets"),
                          p("https://www.zillow.com/research/data/"),
                          p("We specifically used the datasets under the 'Home Listing and Sales' section.
                            There we clicked data type 'Median List Price - Bottom Tier ($) with geography 'State'
                            to get the bottom-tier data, and data type 'Median List Price - Top Tier ($)' with geography
                            'State' to get top-tier data."),
                          
                          tags$h4("Group 15 Team"),
                          a(href=" https://github.com/bridgeth-1677352", "Bridget Haney"),
                          tags$br(),
                          a(href=" Huawen Sun** github: https://github.com/529022366", "Huawen Sun"),
                          tags$br(),
                          a(href=" https://github.com/tpthoi", "Tyson Thoi"),
                          tags$br(),
                          a(href=" https://github.com/Alaa-Amed", "Alaa Amed"),
                          tags$br()
                 ),
                 
                 
                 
                 ## This panel displays the comparison map, which user can choose
                 ## any month between 2010 and 2019, and map will change.
                 tabPanel("2010-2019 Price Comparison Map",
                          
                          tags$h3("2010-2019 US House Sale Median Price Comparison Map"),
                          p("You can select different dates at the left side panel
                            to see different price maps for comparison."),
                          p("The colors indicated on the map represent different price ranges.
                            Generally higher states like California, New York, and Hawaii are represented by dark orange, meaning their median prices are the highest. 
                            The generally lower states, like Texas and Nebraska, are light yellow to reflect their lower median prices. As the year and month
                            increase, so does the median price. From the years of 2010-2019, Washington noticeably increases
                            in price, but still does not match the prices of California and New York"),
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
                            to see specific information. "),
                          p("It is clear that nearly all states increase 
                            median sale price after 9 years, New York, California and Hawaii still have
                            the highest price among all states."),
                          leafletOutput("map2"),
                          br(),
                          leafletOutput("map3")
                 ),
                 
                 tabPanel("Difference Between Median Prices for Bottom Tier Homes",
                          sidebarLayout(
                            sidebarPanel("The scatterplot compares median prices of bottom-tier homes on two
                                         different dates. It can be shown that generally later dates have
                                         higher median prices. However, there are earlier dates that are outliers and
                                         are higher. Overall, however, the generall trend of all dates are that the 
                                         median price increases.",
                              dateInput(inputId = "date_one",
                                        label = "First Date to Compare Data
                (format: yyyy-mm from 2010-01 to 2019-03)",
                                        value = "2010-01",
                                        format = "yyyy-mm"
                              ),
                              dateInput(inputId = "date_two",
                                        label = "Second Date to Compare Data
                (format: yyyy-mm from 2010-01 to 2019-03)",
                                        value = "2019-03",
                                        format = "yyyy-mm"
                              ),
                              
                              selectInput(inputId = "color_one",
                                          label = "Color of First Date Data:",
                                          choices = c("Blue" = "#0098fe",
                                                      "Green" = "#b0ffc0",
                                                      "Red" = "#b02f30",
                                                      "Purple" = "#3e015c")),
                              selectInput(inputId = "color_two",
                                          label = "Color of Second Date Data:",
                                          choices = c("Yellow" = "#ffd400",
                                                      "Orange" = "#f0865f",
                                                      "Pink" = "#ffacd9",
                                                      "Gray" = "#9ea7a6")),
                              
                              hr(),
                              helpText("Dates of Median Prices for Bottom Tier Homes.")
                            ),
                            mainPanel(
                              plotOutput("plot"),
                              textOutput("message")
                            )
                   
                 )
)
)
#)
)