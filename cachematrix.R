## Put comments here that give an overall description of what your
## functions do


## Write a short comment describing this function

makeCacheMatrix <- function(x = matrix()) {

    x_inv <- NULL

    get <- function() x
    set <- function(new_x) {
        x <<- new_x
        x_inv <<- NULL
    }

    getInverse <- function() x_inv
    setInverse <- function(new_x_inv) {
        x_inv <<- new_x_inv
    }

    list(get = get, set = set, getInverse = getInverse, setInverse = setInverse)
}


## Write a short comment describing this function

cacheSolve <- function(x, ...) {
    ## Return a matrix that is the inverse of 'x'

    x_inv <- x$getInverse()
    if (!is.null(x_inv)) {
        message("returning cached inverse")
        return(x_inv)
    }

    x_inv <- solve(x$get(), ...)
    x$setInverse(x_inv)
    x_inv
}
