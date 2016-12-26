library(RSQLite)

con = dbConnect(drv = RSQLite::SQLite(), dbname="zanieczyszczenia.db")
dane = dbGetQuery( con,'SELECT * FROM zanieczyszczenia')
data_odczytu = as.Date(data_odczytu, format='%Y-%m-%d %H:%M')
attach(dane)

shinyServer(function(input, output) {
  output$wykres <- renderPlot({
    x = seq(input$Daty[1],input$Daty[2], by = 1)
    xdwa = x ^ 2
    xtrzy = x ^ 3
    xcztery = x ^ 4
    
    xpiec = x ^ 5
    xszesc = x ^ 6
    xsiedem = x ^ 7
    xosiem = x ^ 8
    xdziewiec = x ^ 9
    xdziesiec = x ^ 10
    
    
    if (input$opcje == 'O3')
    {
      y = c(O3[x])
      plot(x,y)
      fit = lm(y ~ x + xdwa + xtrzy + xcztery + xpiec + xszesc + xsiedem +
                 xosiem + xdziewiec + xdziesiec)
      xv = seq(min(x),max(x),0.01)
      yv = predict(
        fit, list (
          x = xv, xdwa = xv ^ 2, xtrzy = xv ^ 3, xcztery = xv ^ 4, xpiec = xv ^ 5,xszesc =
            xv ^ 6,xsiedem = xv ^ 7,xosiem = xv ^ 8,xdziewiec = xv ^ 9,xdziesiec = xv ^
            10
        )
      )
      lines(xv,yv,col = "green")
    }
    
    if (input$opcje == 'NO2')
    {
      y = c(NO2[x])
      plot(x,y)
      fit = lm(y ~ x + xdwa + xtrzy + xcztery + xpiec + xszesc + xsiedem +
                 xosiem + xdziewiec + xdziesiec)
      xv = seq(min(x),max(x),0.01)
      yv = predict(
        fit, list (
          x = xv, xdwa = xv ^ 2, xtrzy = xv ^ 3, xcztery = xv ^ 4, xpiec = xv ^ 5,xszesc =
            xv ^ 6,xsiedem = xv ^ 7,xosiem = xv ^ 8,xdziewiec = xv ^ 9,xdziesiec = xv ^
            10
        )
      )
      lines(xv,yv,col = "red")
    }
    
    if (input$opcje == 'PM10')
    {
      y = c(PM10[x])
      plot(x,y)
      fit = lm(y ~ x + xdwa + xtrzy + xcztery + xpiec + xszesc + xsiedem +
                 xosiem + xdziewiec + xdziesiec)
      xv = seq(min(x),max(x),0.01)
      yv = predict(
        fit, list (
          x = xv, xdwa = xv ^ 2, xtrzy = xv ^ 3, xcztery = xv ^ 4, xpiec = xv ^ 5,xszesc =
            xv ^ 6,xsiedem = xv ^ 7,xosiem = xv ^ 8,xdziewiec = xv ^ 9,xdziesiec = xv ^
            10
        )
      )
      lines(xv,yv,col = "red")
    }
    
    if (input$opcje == 'PM25')
    {
      y = c(PM25[x])
      plot(x,y)
      fit = lm(y ~ x + xdwa + xtrzy + xcztery + xpiec + xszesc + xsiedem +
                 xosiem + xdziewiec + xdziesiec)
      xv = seq(min(x),max(x),0.01)
      yv = predict(
        fit, list (
          x = xv, xdwa = xv ^ 2, xtrzy = xv ^ 3, xcztery = xv ^ 4, xpiec = xv ^ 5,xszesc =
            xv ^ 6,xsiedem = xv ^ 7,xosiem = xv ^ 8,xdziewiec = xv ^ 9,xdziesiec = xv ^
            10
        )
      )
      lines(xv,yv,col = "blue")
    }
    
    if (input$opcje == 'SO2')
    {
      y = c(SO2[x])
      plot(x,y)
      fit = lm(y ~ x + xdwa + xtrzy + xcztery + xpiec + xszesc + xsiedem +
                 xosiem + xdziewiec + xdziesiec)
      xv = seq(min(x),max(x),0.01)
      yv = predict(
        fit, list (
          x = xv, xdwa = xv ^ 2, xtrzy = xv ^ 3, xcztery = xv ^ 4, xpiec = xv ^ 5,xszesc =
            xv ^ 6,xsiedem = xv ^ 7,xosiem = xv ^ 8,xdziewiec = xv ^ 9,xdziesiec = xv ^
            10
        )
      )
      lines(xv,yv,col = "orange")
    }
    
    if (input$opcje == 'C6H6')
    {
      y = c(C6H6[x])
      plot(x,y)
      fit = lm(y ~ x + xdwa + xtrzy + xcztery + xpiec + xszesc + xsiedem +
                 xosiem + xdziewiec + xdziesiec)
      xv = seq(min(x),max(x),0.01)
      yv = predict(
        fit, list (
          x = xv, xdwa = xv ^ 2, xtrzy = xv ^ 3, xcztery = xv ^ 4, xpiec = xv ^ 5,xszesc =
            xv ^ 6,xsiedem = xv ^ 7,xosiem = xv ^ 8,xdziewiec = xv ^ 9,xdziesiec = xv ^
            10
        )
      )
      lines(xv,yv,col = "brown")
    }
  })
  
  output$text1 <- renderText({
    (paste("Wykres zaleznosci", input$opcje, "od czasu"))
    
  })

  output$info <- renderText({
    if (is.null(input$plotClick))
      return("Wskaz wartosc kursorem\n")
    paste0("Data= ",floor(input$plotClick$x), "\nWartosc=", round(input$plotClick$y,1))
  })
})