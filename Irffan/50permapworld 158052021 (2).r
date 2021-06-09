library(highcharter)
library(dplyr)
library(maps)

dat <- iso3166
dat <- rename(dat, "iso-a3" = a3)

makan=read.csv("hotel_bookings.csv")
head(makan)
myN=makan[,14]
str(myN)

countries_visited <- myN
dat$visited <- ifelse(dat$`iso-a3` %in% countries_visited, 1, 0)
dat$visited


hcmap(
  map = "custom/world-highres3", # high resolution world map
  data = dat, # name of dataset
  joinBy = "iso-a3",
  value = "visited",
  showInLegend = FALSE, # hide legend
  nullColor = "#CCFFFF",
  download_map_data = TRUE
) %>%
  hc_mapNavigation(enabled = TRUE) %>% #ZOOM
  hc_legend("none") %>%
  hc_title(text = "World map") # title

dat <- subset(dat, dat$visited == 1)
sort(dat$ISOname) # sort is to have the visited countries in alphabetical order

paste(
  "Total: ",
  sum(dat$visited),
  " countries."
)
