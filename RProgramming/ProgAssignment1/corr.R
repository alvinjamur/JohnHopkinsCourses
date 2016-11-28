
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


