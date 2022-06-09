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
library(ggplot2)

options(
  # whenever there is one account token found, use the cached token
  gargle_oauth_email = TRUE,
  # specify auth tokens should be stored in a hidden directory ".secrets"
  gargle_oauth_cache = ".secrets"
)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Google Sheet test"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(HTML('<p>See code on <a href="https://github.com/AntoineSoetewey/statistics-201/issues">GitHub</a>.</p>')
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("distPlot")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  dat <- read_sheet("https://docs.google.com/spreadsheets/d/1hTQuCXrhik7K699jJHDxJH90gNPSrTWEHPMwNy0avMo/edit?usp=sharing")

    output$distPlot <- renderPlot({
        ggplot(dat) +
        aes(y = Value) +
        geom_boxplot(fill = "steelblue")
    })
}

# Run the application 
shinyApp(ui = ui, server = server)