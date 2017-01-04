

library(RSQLite)
library(anytime)

con = dbConnect(drv = RSQLite::SQLite(), dbname="zanieczyszczenia.db")
dane = dbGetQuery( con,'SELECT * FROM zanieczyszczenia')

data_odczytuGodz = strptime(data_odczytu, format='%Y-%m-%d %H:%M')
data_odczytu = as.Date(data_odczytu,format='%Y-%m-%d %H:%M' )
dlData_odczytu = length(data_odczytu)


attach(dane)
  

shinyServer(function(input, output) {
  
  
  output$wykres <- renderPlot({
    
    indeks1=match(format(input$Data[1]),format(data_odczytu))  
    CzyPrawda=(format(data_odczytu)==input$Data[2])
    indeks2=max(which(CzyPrawda))
    x=seq(indeks1,indeks2,by=1)
    
    plot(data_odczytuGodz[x],O3[x], xlab="data", ylab="stezenie[ug/m^3]")
    
  })

  output$text1 <- renderText({
    (paste("Wykres zaleznosci", input$opcje, "od czasu"))
    
  })
  
  output$text2 <-renderText({
    

  })

  output$info <- renderText({
    if (is.null(input$plotClick))
      return("Wskaz wartosc kursorem\n")
    paste0("Data= ",anytime (input$plotClick$x), "\nWartosc=", round(input$plotClick$y,1))
  })
})