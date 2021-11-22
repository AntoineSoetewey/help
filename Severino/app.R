library(shiny)
library(shinydashboard)
library(flexdashboard)
library(shinyjs)
library(tidyverse)
library(dplyr)
library(data.table)
library(rgdal)
library(purrr)
library(packrat)
library(Rsymphony)
library(ggplot2)
library(sf)
library(rsconnect)

annual <- fread("SEAsia_annual_raw.csv")


#### Header ----
header <- dashboardHeader(
    title = "Mangrove Research in SE Asia",
    titleWidth = 500
)


#### Sidebar ----
sidebar <- dashboardSidebar(
    class = "main-sidebar",
    sidebarMenu(
        width = 350,
        br(),
        h4("Select Your Inputs Here", style = "padding-left:20px"),
        
        # Country Input ----
        checkboxGroupInput(inputId = "country", label = "country",
                           choices = c("Brunei", "Cambodia", "Indonesia", "Lao",
                                       "Malaysia", "Myanmar", "Philippines",
                                       "Singapore", "Thailand", "Vietnam", "SEAsia"),
                           selected = "SEAsia"
        )
    )
)

#### Body ----
body <- dashboardBody(
    tabsetPanel(
        type = "tabs",
        id = "tab_selected",
        tabPanel(
            title = "Country/Region",
            titleWidth = 800,
            tags$head(
                tags$style("#text1{body {color: blue; font-size: 40px; font-style: bold}")),  
            h1(style = "color:blue; text-align: center; font-family: 'calandra'; font-size: 20px", strong("Summary of researches conducted with different students from 2010-present")
            ),
            plotOutput("plot_annual", width = "100%", height = "600")
        )
    )
)

server <- shinyServer( function(input, output) {
    
    clean_annual <- reactive({
        annual %>%
            group_by(country, year) %>%
            summarize_all(sum) %>%
            select(country, year, npaper) %>%
            arrange(country) %>%
            filter(country %in% input$country)
    })
    
    output$plot_annual <- renderPlot({
        ggplot(data = clean_annual(), aes(y = npaper, x = year, color = country) ) +
            geom_line(size = 1.5) + theme_classic() +
            labs(color="country") +
            labs(color="country") + ylab("n papers") + xlab("year") +
            theme(axis.line.x = element_line(color = "black", size = 1)) +
            scale_x_continuous(breaks=seq(1975,2021,1), limits = c(1975, 2021)) +
            theme(axis.line.y = element_line(color = "black", size = 1)) +
            theme(legend.text = element_text(size = 10, family = "Times New Roman")) +
            theme(legend.title=element_text(size=10)) +
            theme(axis.text.x = element_text(family = "Times New Roman", color = "black", size = 10)) +
            theme(axis.text.y = element_text(family = "Times New Roman", color="black", size=10)) +
            theme(axis.title=element_text(size=10))
    })
})


shinyApp(ui = dashboardPage(header, sidebar, body), server = server)