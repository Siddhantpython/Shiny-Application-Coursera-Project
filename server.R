library(shiny)
library(dplyr)
library(ggplot2)
data("storms")

shinyServer(function(input, output) {

  storms <- dplyr::storms

  output$tableStorms <- DT::renderDataTable({

    if(input$status != "All"){
      storms <- storms %>%
        filter(status == input$status)
    }
      stormsNoFilter <- storms %>%
        select(-ts_diameter, -hu_diameter, -lat, -long) %>%
        filter(wind >= input$wind[1] & wind <= input$wind[2]) %>%
        filter(pressure >= input$pressure[1] & pressure <= input$pressure[2])
  })

  output$boxplot1 <- renderPlot({

    if(input$status != "All"){
      storms %>%
        filter(wind >= input$wind[1] & wind <= input$wind[2]) %>%
        filter(status == input$status) %>%
        filter(pressure >= input$pressure[1] & pressure <= input$pressure[2]) %>%
        ggplot(aes(x = status, y = pressure, fill = status)) +
        geom_boxplot(outlier.colour = "grey") +
        theme_light() +
        theme(legend.position = "none")
    } else {
      storms %>%
        filter(wind >= input$wind[1] & wind <= input$wind[2]) %>%
        filter(pressure >= input$pressure[1] & pressure <= input$pressure[2]) %>%
        ggplot(aes(x = status, y = pressure, fill = status)) +
        geom_boxplot(outlier.colour = "grey") +
        theme_light() +
        theme(legend.position = "none")
    }
  })

  output$barplot1 <- renderPlot({
    if(input$status != "All"){
      storms %>%
        filter(wind >= input$wind[1] & wind <= input$wind[2]) %>%
        filter(status == input$status) %>%
        filter(pressure >= input$pressure[1] & pressure <= input$pressure[2]) %>%
        count(status) %>%
        ggplot(aes(x = status, y = n, fill = status)) +
        geom_bar(stat = "identity") +
        theme_light() +
        ylab(label = "Count") +
        geom_text(aes(label = n), vjust = 1.2) +
        theme(legend.position = "none")
    } else {
      storms %>%
        filter(wind >= input$wind[1] & wind <= input$wind[2]) %>%
        filter(pressure >= input$pressure[1] & pressure <= input$pressure[2]) %>%
        count(status) %>%
        ggplot(aes(x = status, y = n, fill = status)) +
        geom_bar(stat = "identity") +
        theme_light() +
        ylab(label = "Count") +
        geom_text(aes(label = n), vjust = 1.2) +
        theme(legend.position = "none")
    }

  })

  output$timeplot1 <- renderPlot({
    if(input$status != "All"){
      storms %>%
        filter(wind >= input$wind[1] & wind <= input$wind[2]) %>%
        filter(status == input$status) %>%
        filter(pressure >= input$pressure[1] & pressure <= input$pressure[2]) %>%
        count(year) %>%
        ggplot(aes(x = year, y = n)) +
        geom_line(col="blue", lwd=1.3) +
        theme_light() +
        ylab(label = "Count")
    } else {
      storms %>%
        filter(wind >= input$wind[1] & wind <= input$wind[2]) %>%
        filter(pressure >= input$pressure[1] & pressure <= input$pressure[2]) %>%
        count(year) %>%
        ggplot(aes(x = year, y = n)) +
        geom_line(col="blue", lwd=1.3) +
        theme_light() +
        ylab(label = "Count")
    }



  })

  output$heatmap1 <- renderPlot({
    if(input$status != "All"){
      storms %>%
        filter(wind >= input$wind[1] & wind <= input$wind[2]) %>%
        filter(status == input$status) %>%
        filter(pressure >= input$pressure[1] & pressure <= input$pressure[2]) %>%
        mutate(month = as.factor(month)) %>%
        count(year, month) %>%
        ggplot(aes(x = month, y = year, fill = n)) +
        scale_fill_gradient(low="lightblue", high="red") +
        geom_tile() +
        theme_light()
    } else {
      storms %>%
        filter(wind >= input$wind[1] & wind <= input$wind[2]) %>%
        filter(pressure >= input$pressure[1] & pressure <= input$pressure[2]) %>%
        mutate(month = as.factor(month)) %>%
        count(year, month) %>%
        ggplot(aes(x = month, y = year, fill = n)) +
        scale_fill_gradient(low="lightblue", high="red") +
        geom_tile() +
        theme_light()
    }
  })

  output$summary1 <- renderPrint({
    if(input$status != "All"){
      storms %>%
        filter(wind >= input$wind[1] & wind <= input$wind[2]) %>%
        filter(status == input$status) %>%
        filter(pressure >= input$pressure[1] & pressure <= input$pressure[2]) %>%
        mutate(status = as.factor(status), category = as.factor(category)) %>%
        select(status, category, wind, pressure) %>%
        summary()
    } else {
      storms %>%
        filter(wind >= input$wind[1] & wind <= input$wind[2]) %>%
        filter(pressure >= input$pressure[1] & pressure <= input$pressure[2]) %>%
        mutate(status = as.factor(status), category = as.factor(category)) %>%
        select(status, category, wind, pressure) %>%
        summary()
    }
  })

})
