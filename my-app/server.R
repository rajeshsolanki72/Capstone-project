################# ~~~~~~~~~~~~~~~~~ ######## ~~~~~~~~~~~~~~~~~ #################
##                                                                            ##
##                        Data Science Capstone Project                       ##
##                                                                            ##            
##                               Rajesh Solanki                               ##
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

final4Data <- readRDS(file="final4Data.RData")
final3Data <- readRDS(file="final3Data.RData")
final2Data <- readRDS(file="final2Data.RData")

dataCleaner<-function(text){
  cleanText <- tolower(text)
  cleanText <- removePunctuation(cleanText)
  cleanText <- removeNumbers(cleanText)
  cleanText <- str_replace_all(cleanText, "[^[:alnum:]]", " ")
  cleanText <- stripWhitespace(cleanText)
  return(cleanText)
}

cleanInput <- function(text){
  textInput <- dataCleaner(text)
  textInput <- txt.to.words.ext(textInput, 
                                language="English.all", 
                                preserve.case = TRUE)
  return(textInput)
}

nextWordPrediction1 <- function(wordCount,textInput){
  if (wordCount>=3) {
    textInput <- textInput[(wordCount-2):wordCount] 
  }
  else if(wordCount==2) {
    textInput <- c(NA,textInput)   
  }
  else {
    textInput <- c(NA,NA,textInput)
  }
  
  ### 1 ###
  wordPrediction1 <- as.character(final4Data[final4Data$unigram==textInput[1] & 
                                              final4Data$bigram==textInput[2] & 
                                              final4Data$trigram==textInput[3],][1,]$quadgram)
  if(is.na(wordPrediction1)) {
    wordPrediction1 <- as.character(final3Data[final3Data$unigram==textInput[2] & 
                                                 final3Data$bigram==textInput[3],][1,]$trigram)
    if(is.na(wordPrediction1)) {
      wordPrediction1 <- as.character(final2Data[final2Data$unigram==textInput[3],][1,]$bigram)
     }
    }

cat(wordPrediction1)
}

nextWordPrediction2 <- function(wordCount,textInput){
  if (wordCount>=3) {
    textInput <- textInput[(wordCount-2):wordCount] 
  }
  else if(wordCount==2) {
    textInput <- c(NA,textInput)   
  }
  else {
    textInput <- c(NA,NA,textInput)
  }
  ### 2 ###
  wordPrediction2 <- as.character(final4Data[final4Data$unigram==textInput[1] & 
                                            final4Data$bigram==textInput[2] & 
                                            final4Data$trigram==textInput[3],][2,]$quadgram)
  
  if(is.na(wordPrediction2)) {
    wordPrediction2 <- as.character(final3Data[final3Data$unigram==textInput[2] & 
                                               final3Data$bigram==textInput[3],][2,]$trigram)
    
    if(is.na(wordPrediction2)) {
      wordPrediction2 <- as.character(final2Data[final2Data$unigram==textInput[3],][2,]$bigram)
    }
  }
cat(wordPrediction2)
}


shinyServer(function(input, output) {
  
  wordPrediction1 <- reactive({
    text <- input$text
    textInput <- cleanInput(text)
    wordCount <- length(textInput)
    wordPrediction1 <- nextWordPrediction1(wordCount,textInput)
  })
  
  wordPrediction2 <- reactive({
    text <- input$text
    textInput <- cleanInput(text)
    wordCount <- length(textInput)
    wordPrediction2 <- nextWordPrediction2(wordCount,textInput)
  })

 output$predictedWord1 <- renderPrint(wordPrediction1())
  
 output$predictedWord2 <- renderPrint(wordPrediction2())

  output$enteredWords <- renderText({ input$text }, quoted = FALSE)
})