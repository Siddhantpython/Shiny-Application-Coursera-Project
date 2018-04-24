library(shiny)

shinyUI(fluidPage(

  titlePanel("Storm tracks data"),

  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "status",
                  label = "Chose storm classification", c("All", unique(storms$status))),
      sliderInput(inputId = "pressure", label = "Pressure", min = 882, max = 1022, value = c(822, 1022)),
      sliderInput(inputId = "wind", label = "Wind", min = 10, max = 160, value = c(10, 160))
    ),
    mainPanel(
      shiny::tabsetPanel(
        tabPanel("Data",
                 hr(),
                 DT::dataTableOutput("tableStorms")
                 ),
        tabPanel("Visualization 1",
                 h3("Atlantic hurricanes over the years"),
                 plotOutput("timeplot1")
                 ),
        tabPanel("Visualization 2",
                 h2("Total storms by period (month and year)"),
                 plotOutput("heatmap1")

        ),
        tabPanel("Visualization 3",
                 h3("Atlantic hurricanes vs pressure"),
                 plotOutput("boxplot1")
        ),
        tabPanel("Visualization 4",
                 h3("Atlantic hurricanes by classification"),
                 plotOutput("barplot1")
        ),
        tabPanel("Summary",
                 h3("Summary"),
                 verbatimTextOutput("summary1")
        )
      )
    )
  )
))
