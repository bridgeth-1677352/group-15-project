# Median Prices of United States Homes

The two datasets that our group analyzed contained the median
prices of United States homes. Each dataset displayed different
tiers of homes: top tier houses and bottom tier
houses. This data came from the site **Zillow**, which is a
real estate marketing company. We were interested in this data
to see the trends in median prices throughout a period of time
in certain states.

## Datasets Used:

###### Top-Tier Homes (State_MedianListingPrice_TopTier.csv):

This dataset looks at the median prices of sold Homes categorized
as top-tier in the United States. The data includes the states in which
the data was curated, the ranking of each state based on population,
and median prices from the dates of January 2010 to March 2019. The dates
are in the form of yy-(first three letters of month). For instance, January 2010 is written as 10-JAN.

###### Bottom-Tier Homes (State_MedianListingPrice_BottomTier.csv):

This dataset looks at the median prices of sold Homes categorized as
bottom-tier in the United States. The data includes the states in which
the data was curated, the ranking of each state based on population,
and median prices from the datesof January 2010 to March 2019.
The dates are in the form of yyyy-mm. For instance, January 2010
is written as 2010-01.

## Target Audience

The target audience that would be interested in our data and
analysis are those legally of age, which in the United States is 18.
We also wanted to focus on demographics of individuals and couples. These
were the most likely audiences that would find our data useful.

## Technical Aspects of Project

In order to design the interactive visualizations of our data,
we used Shiny. This allowed us to create an App of charts that
target certain trends in our chosen datasets. We used *'dplyr'* to filter
out the columns and rows of data we wanted to extract. We also used
*'ggplot2'* and other map-oriented packages to create interactive maps
based on user input. The datasets were csv files, so they were easily
manipulated through R and Shiny coding.

## Link to Zillow Datasets

https://www.zillow.com/research/data/

We specifically used the datasets under the "Home Listing and Sales" section.
There we clicked data type "Median List Price - Bottom Tier ($)" with geography "State"
to get the bottom-tier data, and data type "Median List Price - Top Tier ($)" with geography
"State" to get top-tier data.

## Group 15 Team

**Bridget Haney** <br>github: https://github.com/bridgeth-1677352 <br>

**Huawen Sun** <br>github: https://github.com/529022366<br>

**Tyson Thoi** <br>github: https://github.com/tpthoi

**Alaa Amed** <br>github: https://github.com/alaaamed
