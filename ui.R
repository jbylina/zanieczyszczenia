shinyUI(
  fluidPage(
    titlePanel("Zanieczyszczenia powietrza"),
    br(),
    style = 'background-image:url("tlo.png")',
    sidebarLayout(
      sidebarPanel(
        helpText(
          "Nasza aplikacja sluzy przedstawieniu poziomu zanieczyszczen powietrza z ostatnich X dni oraz przedstawieniu przewidywanego poziomu zanieczyszczen na nastepne Y dni"
        ),
        selectInput(
          "opcje",
          label = "Wybierz interesujace Cie informacje",
          choices = c(
            "PM10" = "PM10", "PM25", "O3" = "O3", "NO2","SO2","C6H6"
          ),
          selected = "O3"
        ),
        
        dateRangeInput('Data',
                       label = paste('Wybierz interesujacy Cie okres czasu'),
                       start = Sys.Date() - 3, end = Sys.Date() - 1,
                       min = Sys.Date() - 10, max = Sys.Date() + 10,
                       separator = " - ", format = "dd/mm/yy",
                       startview = 'year', language = 'pl', weekstart = 1
        )),
      
        # start = Sys.Date() - 10,
        # end = Sys.Date() + 3,
        # min = Sys.Date() - 10,
        # max = Sys.Date() + 3 )
    
      mainPanel(
        h3(textOutput("text1")),
        h3(textOutput("text2")),
        plotOutput("wykres", click = "plotClick"),
        verbatimTextOutput("info")
      )
    )
  )
)
