## global.R ##

# Load Libraries ####

library(shiny)
library(shinydashboard)
library(shinythemes)

library(viridis)
library(tidyverse)

library(DT)
library(plotly)




# Get base dataset(s) ####


#######################################################################################################################################
#make data frames, plot functions and variables

plotLink1 <- function(data, xaxis, yaxis){
  plot_ly(data,x=~xaxis,y=~yaxis,mode="markers", type ="scatter", source = "subset")
}



##function for file paths#

source("prep/temp_scripts_final/filepath_fun.R")
#test
#paste0(onedrive.path, "file")

# Load plotly functions ####
# 
# fun_histogram <- function(df,x_var,y_unit,x_title="",chart_title="") {
#   
#   library(magrittr)
#   viz <-
#     df %>%
#     mutate_(
#       x_var = x_var
#     ) %>%
#     plot_ly(
#       x = ~x_var
#     ) %>% 
#     add_histogram(
#       opacity = 0.6,
#       hoverinfo = "all",
#       name = y_unit
#     ) %>%
#     layout(
#       xaxis = list(title = x_title, showgrid = F),
#       yaxis = list(title = paste0("Number of ",y_unit), showgrid = F),
#       barmode = "overlay"
#     )
#   
#   desc <- 
#     shiny::tagList(
#       h3(
#         # Use a standard title if not supplied
#         ifelse(chart_title == "",paste0("Distribution of ",x_title),chart_title)
#       ),
#       p(
#         "This histogram displays the distribution of ", em(ifelse(x_title=="",x_var,x_title)), 
#         " across the population. ",  
#         "Histograms group numeric data into bins, displaying the bins as columns.  ",
#         "Here, the height of each column represents the number of ",y_unit," who fell into a given range of ",
#         em(ifelse(x_title=="",x_var,x_title)),".  ",
#         "For more information on interpreting histograms, here's a ",
#         a(href = "http://asq.org/learn-about-quality/data-collection-analysis-tools/overview/histogram2.html",
#           "resource"),
#         " showing common histogram shapes and what they indicate."
#       )
#     )
#   
#   return(list(viz = viz,desc = desc))
#   
# }
# 
# fun_boxplot <- function(df,x_var,y_var,color_var,x_title = "",y_title = "",color_title="",
#                         chart_title="",selected_palette = ordinal_palette,...) {
#   library(magrittr)
#   
#   viz <-
#     df %>%
#     mutate_(
#       x_var = x_var,
#       y_var = y_var,
#       color_var = color_var
#     ) %>%
#     plot_ly() %>%
#     add_boxplot(
#       x = ~x_var,
#       y = ~y_var,
#       color = ~as.character(color_var),
#       colors = selected_palette
#     ) %>%
#     layout(
#       xaxis = list(title = x_title, showgrid = F),
#       yaxis = list(title = y_title, showgrid = F),
#       boxmode = "group",
#       margin = list(l = 250, r = 10, b = 15, t = 5)
#     )
#   
#   desc <- 
#     shiny::tagList(
#       h3(
#         # Use a standard title if not supplied
#         ifelse(chart_title == "",paste0("Summary of ",x_title," by ",color_title),chart_title)
#       ),
#       p(
#         "The boxplot here displays the distribution of ", em(ifelse(x_title=="",x_var,x_title)), 
#         " for each ", em(ifelse(y_title == "",y_var,y_title)), 
#         " using five summary statistics: minimum, maximum, 1st and 3rd quartiles, and median.  ", 
#         "Outliers are depicted as dots.  ",
#         "Boxplots are displayed for each ", em(color_title), ".  ",
#         "Users can view the summary statistics by hovering over the plot.",
#         "For more information, here's a ",
#         a(href = "http://flowingdata.com/2008/02/15/how-to-read-and-use-a-box-and-whisker-plot/",
#           "diagram"),
#         " showing the parts of a boxplot."
#       )
#     )
#   
#   return(list(viz = viz,desc = desc))
# }
# 
# fun_heatmap <- function(df,x_var,y_var,z_var,selected_palette = palettes$palette_num_100_viridis) {
#   
#   library(magrittr)
#   df %>%
#     select_(
#       x_var = x_var,
#       y_var = y_var,
#       z_var = z_var
#     ) %>%
#     spread(key = x_var,value = z_var) %>%
#     # Replace NA with 0
#     mutate_all(funs(replace(., is.na(.), 0))) %>%
#     filter(is.na(y_var) == F) %>%
#     as.data.frame() %>%
#     column_to_rownames(var = "y_var") %>%
#     heatmaply()
#   
# }
# 
# fun_bar <- function(df,x_var,y_var,color_var,x_title="",y_unit="",color_title="",chart_title="",stacked=T,horizontal=F,...) {
#   
#   library(magrittr); library(forcats)
#   
#   viz <-
#     df %>% 
#     select_(
#       x_var = x_var,
#       y_var = y_var,
#       color_var = color_var
#     ) %>%
#     group_by(x_var) %>%
#     mutate(y_var_pct = round(y_var/sum(y_var)*100, digits = 1)) %>%
#     ungroup() %>%
#     plot_ly(
#       x = ~fct_reorder2(
#         .f = x_var, 
#         .x = y_var,
#         .y = color_var,
#         .fun = sum, 
#         .desc = T
#       ),
#       y = ~y_var,
#       color = ~as.character(color_var),
#       colors = ordinal_palette,
#       hoverinfo = 'text',
#       text = ~paste0(
#         "Number of ",y_unit, " : ", y_var,
#         "<br>Percent of ", y_unit, " : ", y_var_pct,
#         "<br>", x_title, " : ", x_var,
#         "<br>Group: ", color_var
#       )
#     ) %>%
#     add_bars() %>%
#     layout(
#       barmode = ifelse(stacked,'stack','group'),
#       orientation = ifelse(horizontal,'h','v'),
#       xaxis = list(title = x_title, tickangle = 45),
#       yaxis = list(title = paste0("Number of ",y_unit))
#     )
#   
#   desc <- 
#     shiny::tagList(
#       h3(
#         # Use a standard title if not supplied
#         # paste0(color_title," by ",x_title)
#         ifelse(chart_title == "",paste0(color_title," by ",x_title),chart_title)
#       ),
#       p(
#         "The bar chart here displays the number of ", y_unit, 
#         " for each ", em(x_title), 
#         ", broken down by ", em(color_title), ". ", 
#         em(x_title), "s are ordered by the number of ", em(y_unit),
#         ".  Users can select and deselect items from the ",
#         em(color_title)," groups by using the legend beside the chart."
#       )
#     )
#   
#   return(list(viz = viz, desc = desc))
#   
# }
# 

#######################################################################################################################################
# Color palettes and theme settings ####
# Make multiple color palettes for reference.  Accessible via `palettes$...` 
# ##themes - JH_locSW, bootswatch
# 
# # Add function to get theme ####
# # Note: .css files from Bootswatch 3.3.1 are best for Shiny: https://github.com/thomaspark/bootswatch/blob/v3.3.1/
# # Stylesheets found in www/ folder, and currently include: 'flatly.css', 'readable.css', 'journal.css'
# 

# fun_layout <- function(plot) {
#   plot %>%
#     layout(
#       font = list(
#         family = "'Glyphicons Halflings','Droid Sans','Open Sans', verdana, arial, sans-serif",
#         size = 14,
#         color = 'grey'
#       )
#     )
#   
# }


get_theme <- function(theme = c('journal','flatly','readable')){
  theme_css <-
    tags$head(
      tags$link(rel = "stylesheet", type = "text/css", href = paste0(theme,".css"))
    )
  return(theme_css)
}


palettes <- list()
palettes$palette_cat_12_intense <- c("#ff719d","#89003a","#ff8651","#9b4600","#4e2300","#ccca7a","#77c800","#014877","#6f99ff","#1270ff","#b223dc","#efb6d3")
palettes$palette_cat_12_hue_cb <- c("#653568","#7f412e","#4d6835","#7346c5","#ce3e57","#cd52b8","#7283c2","#d8723a","#d0889d","#59ada5","#b4a14a","#66b84f")
palettes$palette_cat_12_tarnish <- c("#645145","#3b5a5e","#4e5c48","#5f5c6f","#776063","#587679","#877769","#758b93","#7f8f78","#9f8b9a","#ae9a8c","#8aa6ae")
palettes$palette_cat_12_gorical <- c("#35618f", "#74ee65", "#255026", "#1abdc5", "#bad8f0", "#2a9739", "#b9e09b", "#743138", "#fd9f9f", "#ca2d22", "#f1d438", "#89975b")
palettes$palette_cat_5_flatly <- c("#18BC9C","#2C3E50","#F39C12","#E74C3C","#3498DB")
palettes$palette_num_10_viridis <- viridis_pal(option = "D", direction = -1)(10)
palettes$palette_num_100_viridis <- viridisLite::viridis(100, direction = -1)



#######################################################################################################################################
# Global options ####
ordinal_palette <- palettes$palette_num_10_viridis
categorical_palette <- palettes$palette_cat_12_intense
box_height <- 850
enableBookmarking(store = "url")



