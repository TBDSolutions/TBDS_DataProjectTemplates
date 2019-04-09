## ui.R ##

# Header ####
#https://stackoverflow.com/questions/31440564/adding-a-company-logo-to-shinydashboard-header
header <- 
  dashboardHeader(
    title = "TBDS Shiny Template",
    tags$li(a(href = 'https://www.tbdsolutions.com/',
              img(src = 'tbdSolutions-logo.png',
                  height = "20px"),
              style = "padding-top:10px; padding-bottom:10px;"), class = "dropdown"
            )
    )



# Sidebar ####

sidebar <- 
  dashboardSidebar(
    sidebarMenuOutput("ui_main_sidebar"),
    br(),
    actionButton(inputId="update", label = "Update View"),
    br(),
    br(),
    sliderInput(inputId = "wt", label = "Weight:", min = min(Theoph$Wt), max = max(Theoph$Wt), value = c(min(Theoph$Wt),mean(Theoph$Wt))),
    br(),
    br(),
    tags$small(
      tags$i(
        p("Data updated 2019",style="position: fixed; bottom: 25px; left:15px;")
        )
      ),
    tags$sub(
      a(href = "https://www.tbdsolutions.com/", "© TBDSolutions LLC - 2019", style="position: fixed; bottom: 15px; left:15px;")
      )

  )

# Body ####

body <- 
  dashboardBody(
    plotlyOutput(outputId = "plot1", height = 400),
    br(),
    br(),
    tags$div(box(width = 12,height = 400, DT::dataTableOutput(outputId = "table1")), style = "overflow-y:scroll;")
    #DT::dataTableOutput(outputId = "table1")

  
  )

  bookmarkButton()



# Generate UI as a function to enable bookmarked state
function(req) { dashboardPage(skin = "black", header,sidebar,body) } #skin not working :/

