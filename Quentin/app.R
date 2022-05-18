#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
# install.packages("gt")
library(gt)
library(dplyr)



df <- filter(mtcars, cyl == 6)



ui <- fluidPage(
    
    titlePanel("Test case"),
    
    
    
    sidebarLayout(
        
        sidebarPanel(
            
            selectInput("Horsepower", "Select Horsepower", choices = sort(unique(df$hp))),
            
            downloadButton(outputId = "download", label = "Download image")
            
        ),
        
        
        
        mainPanel(
            
            gt_output("dataset")
            
        )
        
    )
    
)





server <- function(input, output) {
    
    t <- reactive({
        
        subset(df, df$hp == input$Horsepower) %>%
            
            gt()
        
    })
    
    
    
    output$dataset <- render_gt(t())
    
    
    
    output$download <- downloadHandler(
        
        filename = "abc.png",
        
        content = function(file) {
            
            png(file)
            t()
            dev.off()
            
        }
        
    )
    
}



shinyApp(ui = ui, server = server)
