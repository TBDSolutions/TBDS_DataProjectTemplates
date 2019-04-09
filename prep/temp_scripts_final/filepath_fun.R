##function for file paths

tbdsuser <- Sys.info()[["login"]]

onedrive.path.fun <- function(tbdsuser){
  if (tbdsuser == "joshh"){
    path = Sys.getenv(JH_filepath)
  }  else {
      path = paste0("C:/Users/",tbdsuser,Sys.getenv(elsefilepath))
  }
  return(path)
  }
  
  
onedrive.path <- onedrive.path.fun(tbdsuser)
#test
#paste0(onedrive.path, "file")
