setwd("D:/JohnHopkinsDataScience/R Programming/ProgAssignment3")

rankhospital <- function(state, outcome, num = "best") {

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
  

# Return hospital name in that state with the given rank 30-day death rate

    dataofstate <- data[ data$State == state, ]
  
# sort the data of state by outcome
  
    sorteddataofstate <- dataofstate[order(as.numeric(dataofstate[[colname]]), dataofstate[["Hospital.Name"]], 
                                           decreasing=FALSE, na.last=NA), ]
  
# handling numeric input for sorting
    
  if (num=="best") {
    num = 1
  }
    
  if (num=='worst') {
    num = nrow(sorteddataofstate)
  }
    
  
  sorteddataofstate[num,"Hospital.Name"]
}

