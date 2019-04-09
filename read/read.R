#General Order of Hierarchy
#1. read
#2. prep_
#3. scrub
#4. scrubd_prep
#5. scrubd



library(DBI); library(odbc);library(dbplyr);library(tidyverse);library(lubridate);library(stringr)

##################################### All Connections ############################################################

#### Make connections ####
mdhhs_idd_db <- 
  DBI::dbConnect(
    odbc::odbc(), 
    Driver = "SQL Server", 
    Server = Sys.getenv("tbd_server_address"), 
    Database = "XXXX", 
    UID = Sys.getenv("tbd_server_uid"), 
    PWD = Sys.getenv("tbd_server_pw"), 
    Port = 1433
  )

## User name for file paths - also in the Global.R script
source("prep/temp_scripts_final/filepath_fun.R")

####################################################################################################################################
## - flat files ##
#####################

##### Read in local text  ####

## Define local source and combine multiple files if needed

dataset1 <- 
  read_delim(
    paste0(onedrive.path,""),  #update this file path monthly
    delim = "\t", col_types = cols(.default = "c")
  ) 
#update variables and combine files if needed


