#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(dplyr)
library(tidyr)
library(tidyverse)

#####Import Data

dat <- read_csv(url("https://www.dropbox.com/s/uhfstf6g36ghxwp/cces_sample_coursera.csv?raw=1")) %>%
  select(c("pid7","ideo5")) %>% drop_na()

ui <- fluidPage(
  
  sidebarLayout(
    sliderInput(inputId = "ideo5",
                label = "Select Five Point Ideology (1=Very liberal, 5=Very conservative)",
                min = min(dat[,2]),
                max = max(dat[,2]),
                value = 3),
    
    plotOutput("distPlot")
  )
)

server <- function(input, output) {
  
  output$distPlot <- renderPlot({
    
    c <- ggplot(dat %>% filter(ideo5 == input$ideo5), aes(pid7)) + labs(x = "7 Point Party ID, 1=Very D, 7=Very D")
    c + geom_bar()
  })
}
shinyApp(ui = ui, server = server)
