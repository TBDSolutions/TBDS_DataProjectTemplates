##Error Checking template script


#when updating date:
#1. run the application and make sure that the new data is being displayed by checking widgets that have ranges 
#2. make notes in the branch check-in if application was deployed or not


#use this library for testing the entire application
library(shinytest) 
#https://rstudio.github.io/shinytest/articles/shinytest.html
#shinytest::installDependencies()
#Run when: 
#1. Deploying application for the first time
#2. Updating a section of the application that includes widgets or display areas

# Launch the target app (replace with the correct path)
shinytest::recordTest("")

#you have to develop a set of snapshots for each application


#use this to test parts of scripts to make sure that the are running quickly 
#(example: dplyr functions and data frame creation)
library(profvis)
#recommend copy/past smaller chunks of code to use this; can't run on an entire application