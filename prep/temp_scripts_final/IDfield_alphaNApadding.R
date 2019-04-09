library(tidyverse); library(readxl); library(lubridate);
library(magrittr); library(stringr)


idfield.sweeper <- function(dataset, IDfield){
  
  dataset %<>%
    # Clean ID field
    mutate(
      # Remove alpha and special chars
      IDfield = str_replace_all(IDfield, "[[:alpha:]]", ""),
      IDfield = str_replace_all(IDfield, "[[:punct:]]", ""),
      # Convert blanks to NA
      IDfield = ifelse(IDfield == "", yes = NA, no = IDfield), 
      # If string > 10 chars, include only last 10 chars
      IDfield = ifelse(
        nchar(as.character(IDfield)) > 10,
        yes = substr(
          IDfield, 
          start = nchar(as.character(IDfield)) - 9, 
          stop = nchar(as.character(IDfield))),
        no = IDfield
      ),
      # If string < 10 chars, pad with leading zeroes
      IDfield = ifelse(
        nchar(as.character(IDfield)) < 10,
        yes = sprintf("%010d", as.integer(IDfield)),
        no = IDfield
      ),
      # Make 'NA' & 0000000000 to NA
      IDfield = ifelse(
        IDfield %in% c("        NA","NA","0000000000"), 
        yes = NA,
        no = IDfield
      )
    )
  return(dataset)
}


