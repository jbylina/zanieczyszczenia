shinyServer(function(input, output) {
  
  dane = read.table(file = "bazaa.csv", header = TRUE, sep =";")
  
  
  attach(dane)
  
  data_odczytu = as.numeric(data_odczytu)
  output$wykres <- renderPlot({
      
    x=seq(input$Daty[1],input$Daty[2], by = 1)
    
   
     if(input$opcje == 'O3')
     {
        y=c(O3[x])
        plot(x,y) 
     }
    
    if(input$opcje == 'NO2')
    {
      y=c(NO2[x])
      plot(x,y)
    }
    
    if(input$opcje == 'PM10')
    {
      y=c(PM10[x])
      plot(x,y)
    }
    
    if(input$opcje == 'PM25')
    {
      y=c(PM25[x])
      plot(x,y)
    }
    
    if(input$opcje == 'SO2')
    {
      y=c(SO2[x])
      plot(x,y)
    }
    
    if(input$opcje == 'C6H6')
  { 
      y=c(C6H6[x])
      plot(x,y)
    }
    
  })
  
  output$text1 <- renderText({ 
          
   (paste("Wykres zaleznosci", input$opcje, "od czasu"))
    
    })

  #paste0("x=", round(e$x, 1), " y=", round(e$y, 1), "\n")
    
  output$info <- renderText({
    
    if(is.null(input$plotClick)) return("Wskaz wartosc kursorem\n")
    paste0("Data= ",floor(input$plotClick$x), "\nWartosc=", round(input$plotClick$y,1))
    
  })  
  
  
 # output$wykres <- renderPlot({
    
 #   x=seq(input$Daty[1],input$Daty[2], by = 1)
    
  #  if(input$opcje == 'O3')
  #  {
   #   y=c(O3[x])
      
    #  approxfun(x, y)
      
    #}
    
    
    
    
  #})
  
  
})