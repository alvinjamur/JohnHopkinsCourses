#
# Balaji Vinjamur
#
# Coursera Programming Assisgnment 2
#
#
# makeCacheMatrix & cacheSolve
#

# Function creates a "matrix" object that can cache its inverse

makeCacheMatrix <- function(x = matrix()) {
  
  inv <- NULL
  
  set <- function(y) {
    x <<- y
    inv <<- NULL
  }
  
  get <- function() x
  
  setInverse <- function(inverse) inv <<- inverse
  getInverse <- function() inv
  list(set = set,
       get = get,
       setInverse = setInverse,
       getInverse = getInverse)
}


# Function to compute inverse of a matrix returned by makeCacheMatrix

cacheSolve <- function(x, ...) {
  
  # Returns matrix that is the inverse of 'x'
  
  inv <- x$getInverse()
  
  if ( !is.null(inv) ) {
    message("Getting Cached of Inverted Matrix")
    return(inv)
  }
  
  mat <- x$get()
  inv <- solve(mat, ...)
  x$setInverse(inv)
  inv
}

