## server.R ##


shinyServer(
  function(input, output, session) {
    
    # reactive data set##
    

    Data1 <- reactive({
      Theoph %>%
        filter(Theoph$Wt == input$wt)
      })
    
    # UI Outputs ####
    

    output$ui_main_sidebar <- renderMenu({
      
      sidebarMenu(
        id = "sidebar_tab"

      )
      
    })
    
    output$plot1 <- renderPlotly({
      #input$update
      plotLink1(Data1(),'Time',"conc")
      # isolate(plot_ly(Data1(),x=~Time,y=~conc,mode="markers", type ="scatter", source = "subset"))
      
    })
    
    output$table1 <- renderDataTable({
      #event_data(event = "plotly_selcted", source = "subset")
      input$update
      
        isolate(datatable(Data1(),options = list(paging = FALSE)))
    })

})