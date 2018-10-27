################# ~~~~~~~~~~~~~~~~~ ######## ~~~~~~~~~~~~~~~~~ #################
##                                                                            ##
##                        Data Science Capstone Project                       ##
##                                                                            ##            
##                            Rajesh Solanki                                  ##
##                                                                            ##
##                                                                            ##
################# ~~~~~~~~~~~~~~~~~ ######## ~~~~~~~~~~~~~~~~~ #################

suppressPackageStartupMessages(c(
  library(shinythemes),
  library(shiny),
  library(tm),
  library(stringr),
  library(markdown),
  library(stylo)))

shinyUI(
  fluidPage(
    # Application title
    titlePanel("Next Word Prediction, Using n-gram Model "),
    hr(),
    hr(),
    sidebarLayout(
      
      sidebarPanel(
        
        textInput("text",label = h3("Enter your text here:"),value = ""),
        tags$span(style="color:grey",("Only English Words are supported.")),
        hr(),
        hr(),
        hr()
      ),
      mainPanel(
        
        h4("The Predicted Next Word: First option"),
        
        tags$span(style="color:darkblue",tags$strong(tags$h3(textOutput("predictedWord1")))),
        br(),
        h4("The Predicted Next Word: Second option"),
        tags$span(style="color:darkred",tags$strong(tags$h3(textOutput("predictedWord2")))),
        
        br(),
        br(),
        h4("What you have entered:"),
         tags$em(tags$h4(textOutput("enteredWords"))),
        hr()
      )
    )
  )
)
