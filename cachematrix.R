# Caching the inverse of a matrix. See test_cachematrix.R for some unit tests.

# This function creates a special "matrix" object that can cache its inverse.

makeCacheMatrix <- function(x = matrix()) {
    # The variables x (formal argument) and x_inv below hold the matrix
    # and its inverse, respectively. x_inv is initialized to NULL until the
    # inverse is computed for the first time.
    x_inv <- NULL

    # These functions allow getting and setting the value of the matrix
    # wrapped by the special "matrix" object.
    get <- function() x
    set <- function(new_x) {
        # Update the matrix and reset its inverse, since the old x_inv value
        # is no longer valid. Update the variables in the parent environment.
        x <<- new_x
        x_inv <<- NULL
    }

    # These function allow getting and setting the value of the inverse.
    getInverse <- function() x_inv
    setInverse <- function(new_x_inv) {
        # Update the variable in the parent environment.
        x_inv <<- new_x_inv
    }

    # Return a list with the helper functions.
    list(get = get, set = set, getInverse = getInverse, setInverse = setInverse)
}


# Compute the inverse of the special "matrix" returned by makeCacheMatrix above.

cacheSolve <- function(x, ...) {
    x_inv <- x$getInverse()
    if (is.null(x_inv)) {
        # If x_inv is NULL the inverse has not been computed yet. Compute its
        # value using solve() and save it in the special "matrix" object.
        message("computing matrix inverse")
        x_inv <- solve(x$get(), ...)
        x$setInverse(x_inv)
    } else {
        # The cached value is being used, inform the user.
        message("returning cached inverse")
    }

    # Return the matrix inverse (computed or cached).
    x_inv
}
