setwd("D:/John-Hopkins-Data-Science/R Programming/ProgAssignment3")

best <- function(state, outcome) { 
  
# Assume we are in right directory and then read in outcome data
  
    data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")  

# Check that state and outcome are valid
  
  validstates <- data[ , 7]
  validoutcomes  <- c("heart attack", "heart failure", "pneumonia")
  
# Error checking for 'state' and 'outcome' parameter
  
  if( (state %in% validstates) == FALSE) {
      stop(print("invalid state"))
  }
    else if ( (outcome %in% validoutcomes) == FALSE) {
      stop(print("invalid outcome"))
    }
  
# Get at the subset of the data with desired state
  
  filtered_data <- subset(data, State == state)
  
# Get desired outcome columns from data
  
  if (outcome == "heart attack") {
    outcome_col <- 11
  }
  else if (outcome == "heart failure") {
    outcome_col <- 17
  }
  else { # pneumonia 
    outcome_col <- 23
  }
  
# Starting required columns
  
  required_col <- as.numeric(filtered_data[, outcome_col])

#check for bad columns 
  
  bad <- is.na(required_col)
  
# throw away bad columns
  
  desired_data <- filtered_data[!bad, ]
  
# Find hospitals in rows with min outcome value
  
  col_considered <- as.numeric(desired_data[, outcome_col])
  desired_rows <- which(col_considered == min(col_considered))
  desired_hospitals <- desired_data[desired_rows, 2]
  
# If we get multiple hospitals with the minimal outcome values, we return 
# the first hospital name from an alphabetically sorted hospital list
  
  if (length(desired_hospitals) > 1) {
    hospitals_sorted <- sort(desired_hospitals)
    hospitals_sorted[1]
  }
  else {
    desired_hospitals
  }
}
