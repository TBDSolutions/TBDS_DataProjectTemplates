# read_load.R
#All copy to db related to data update goes here.  copy to db for prep files goes in the file the copy object was made

library(DBI); library(odbc);library(dbplyr);library(tidyverse);library(lubridate);library(stringr)

####################################################################################################################################
##App data updates ##  the major flaw iwth this plan is that we don't want raw data in db, we want clean data
#####################
#steps:
#1.: Run the read.R file with the previous timepoint files
#2.: Run update the file references in the test file and run it
#3.: Compare row counts, column counts and any other important feature
#4.: Update the read.R file with the new file references
#5.: Run load.R to read in and load new data to the database
#6.: Run all items in run_deploy.R

source("read/read.R")

# Load to database

copy_to( # takes ~ min.
  dest = conn_name,
  df = df_name,
  name = "name_db",
  overwrite = T,
  temporary = F
)



