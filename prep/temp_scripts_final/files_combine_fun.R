#################
#function to combine files in a directory (i.e. onedrive)

library(tidyverse); library(readxl); library(lubridate);
library(magrittr); library(stringr)

## Define local source of data
#note: onedrive.path comes from the filepath_fun.R template and that function is already loaded in global.R
directory <- paste0(onedrive.path,"directory/")

# Define function to read and combine ####
combine1 <- function(directory) {
  ## 'directory' is a char vector of len 1 indicating location of CSV files
  files <- list.files(directory,full.names = TRUE) # make list of full file names
  n <- length(files)
  
  # Create empty data frame
  df <- tibble() 
  
  # Loop through files, binding them together
  for (i in 1:n) {
    
    if (grepl("csv$",files[i]) == T) {
      x <- try(
        read.csv(files[i],colClasses = "character",na.strings = c('','NA','NULL'),strip.white = T)
      )
    } else if (grepl("xls$|xlsx$",files[i]) == T) {
      x <- try(
        read_excel(files[i],col_names = T,col_types = "text",na = c('','NA','NULL'),trim_ws = T)#set col_names to F if want to type them in
      )
    } else print("Unrecognized file format!")
    
    # If new file has same number of cols as previous, bind them together
    if (ncol(x) == 20) {
      # Define column names
      #names(x) <- c()
      df <- rbind(df, x)
    } else df <- df
    
  }
}
  
  
  