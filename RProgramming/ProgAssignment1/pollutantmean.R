################################################################################
# FUNCTION NAME : pollutantmean
#
# INPUTS : 
#
# 'directory' points to directory where files are located
# 'pollutant' is character vector ("sulfate" or "nitrate")
# id is integer vector that indicates ID of monitoring stations
#
# RETURNS :
#
# Mean of pollutant passed through 'pollutant' across range of id 
# passed through 'id' vector
#
###############################################################################

# point to directory

setwd("D:/JohnHopkins/Assignment1/")
directory <- "D:/JohnHopkins/Assignment1/"

pollutantmean <- function(directory, pollutant, id){
  
  if(grep("specdata", directory) == 1) {
    directory <- ("./specdata/")
  }
  
  # init vector to hold pollutant data
  
  meanvector <- c()
  
  # find all file names in folder and store 'em all as character vector
  
  allfiles  <- as.character( list.files(directory) )
  
  # then create variable that spells out long paths/names for each file
  
  file_paths <- paste(directory, allfiles, sep="")
  
  # loop through all files in 'id' and create mean vectorof 'pollutant' readings 
  
  for(i in id) {
    currfile <- read.csv(file_paths[i], header=T, sep=",")
    na_removed <- currfile[!is.na(currfile[, pollutant]), pollutant]
    meanvector <- c(meanvector, na_removed)
  }
  
  result <- mean(meanvector)
  return(round(result, 3)) 
}

