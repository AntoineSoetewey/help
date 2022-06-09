#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(googlesheets4)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Google Sheet test"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(""
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("distPlot")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  dat <- read_sheet("https://docs.google.com/spreadsheets/d/1ZWkTwK8DwU70dDC7CnOm0EQL04cLo-g22FBdl5WiD70/edit?usp=sharing")

    output$distPlot <- renderPlot({
        hist(dat$Value)
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
