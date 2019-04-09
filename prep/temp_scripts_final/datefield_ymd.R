
library(tidyverse); library(readxl); library(lubridate);
library(magrittr); library(stringr)

date.soldier <- function(dataset, DATEfield){
  
  dataset %<>%
    # Transform dates from multiple formats into single format
    mutate(
      mdy_date = mdy(DATEfield),
      ymd_date = ymd(DATEfield),
      hms_date = ymd_hms(DATEfield),
      hms_time = hms(DATEfield),
      # Keep only non-converted formats
      rem_date = ifelse(
        is.na(mdy_date) & is.na(ymd_date) & is.na(hms_date) & is.na(hms_time),
        yes = DATEfield, no = NA
      ),
      rem_date = ifelse(nchar(rem_date) <= 5,rem_date,NA),
      # Convert from Excel format
      rem_date = as.Date(as.numeric(rem_date), origin = "1899-12-30"),
      # Replace original variable with cleaned up date field
      DATEfield = case_when(
        is.na(mdy_date) == F ~ mdy_date,
        is.na(ymd_date) == F ~ ymd_date,
        is.na(hms_date) == F ~ as.Date(hms_date),
        is.na(rem_date) == F ~ rem_date
      )
    )
  return(dataset)
}

