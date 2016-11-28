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

################################################################################
# FUNCTION NAME : corr
#
# INPUTS : 
#
#   'directory' points to directory where files are located
#   'threshold' indicates number of completely obs vars (on all
#               vars) required to compute corr between nitrate/sulfate
#
# RETURNS :
#
# Vector of correlations
#
###############################################################################

source("pollutantmean.R")
source("complete.R")

corr <- function(directory, threshold = 0) {
  
  if(grep("specdata", directory) == 1) {
    directory <- ("./specdata/")  
  }  
  
  
  # use complete to get at fill table, then get number of obs
  
  completetable <- complete("specdata",1:332)
  nobs <- completetable$nobs
  
  # we now need ids in table that pass above threshold
  
  ids <- completetable$id[nobs > threshold]
  
  # now lenth of this vector
  
  idlen <- length(ids)
  
  # init corr vector
  
  corrvector <- rep(0, idlen)
  
  # get at files in the folder
  
  all_files <- as.character( list.files(directory) )
  file_paths <- paste(directory, all_files, sep="")
  
  j <- 1
  for(i in ids) {
    current_file <- read.csv(file_paths[i], header=T, sep=",")
    corrvector[j] <- cor(current_file$sulfate, current_file$nitrate, use="complete.obs")
    j <- j + 1
  }
  
  res <- corrvector
  return(res)   
  
}