setwd("D:/JohnHopkinsDataScience/R Programming/ProgAssignment3")

best <- function(state, outcome) {
  
# Read outcome data
  
  data <- read.csv("outcome-of-care-measures.csv", 
                   colClasses = "character", 
                   na.strings="Not Available")
  
# Get valid state and outcome

  validoutcome = c("heart attack","heart failure","pneumonia")
  validstate = unique(data[,7])
  
# ...then check that they are valid
  
    if (!outcome %in% validoutcome) { 
      stop("invalid outcome")
    }
  
    if (!state %in% validstate) { 
      stop("invalid state")
    }
  
# we need a few relevant columns to make a decision about best hospital
  
  relevantcolname <- c("Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack", 
                       "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure", 
                       "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia")
  
  colname <- relevantcolname[match(outcome,validoutcome)]
  
# Grab all the data of the relevant state and omit NA

    dataofstate <- na.omit( data[ data$State == state, ] )

# Get the index where the min of the 'relevantcolname' lies
    
    index <- which.min( as.numeric(dataofstate[ , colname]) )

# then look at the corresponding hospital name which happens to be the best in state
    
dataofstate[index, "Hospital.Name"]

}
