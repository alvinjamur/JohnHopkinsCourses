

################################################################################
# FUNCTION NAME : complete
#
# INPUTS : 
#
#   'directory' points to directory where files are located
#   'id' is integer vector that indicates ID of monitoring stations
#
# RETURNS :
#
# Data frame with complete observations in each file ie., 'id' range
#
###############################################################################

complete <- function(directory, id){
  
  if(grep("specdata", directory) == 1) {
    directory <- ("./specdata/")
  }
  
  lenid <- length(id)
  complete_data <- rep(0, lenid)   # assume no id is full 
  
  # now find files in directory and file paths
  
  allfiles <- as.character( list.files(directory) )
  file_paths <- paste(directory, allfiles, sep="")
  
  j <- 1
  for (i in id){
    
    currentfile <- read.csv(file_paths[i], header=TRUE, sep=",")
    complete_data[j] <- sum(complete.cases(currentfile))
    j <- j+1
    
  }
  
  res <- data.frame(id=id, nobs=complete_data)
  return(res)
  
}
