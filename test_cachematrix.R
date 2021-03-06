
# Test the implementation of makeCacheMatrix and cacheSolve. In order to run
# the tests you must install the testthat package (at least version 0.9.1)
# available at cran.r-project.org/package=testthat.

library("testthat")

source("cachematrix.R")

context("Caching the inverse of a matrix")

# A sample 2x2 matrix and its inverse.
x <- matrix(c(4, 3, 3, 2), ncol = 2)
x_inv <- matrix(c(-2, 3, 3, -4), ncol = 2)

test_that("makeCacheMatrix creates a special matrix", {
    cache_matrix <- makeCacheMatrix()
    expect_that(cache_matrix, has_names(c("get", "set", "getInverse", "setInverse")))
    expect_that(cache_matrix$get, is_a("function"))
    expect_that(cache_matrix$set, is_a("function"))
    expect_that(cache_matrix$getInverse, is_a("function"))
    expect_that(cache_matrix$setInverse, is_a("function"))
})

test_that("makeCacheMatrix can cache its inverse", {
    cache_matrix <- makeCacheMatrix()
    cache_matrix$set(x)
    expect_that(cache_matrix$get(), equals(x))
    expect_that(cache_matrix$getInverse(), is_null())
    cache_matrix$setInverse(x_inv)
    expect_that(cache_matrix$getInverse(), equals(x_inv))
    cache_matrix$set(t(x))
    expect_that(cache_matrix$getInverse(), is_null())
})

test_that("cacheSolve computes the inverse", {
    cache_matrix <- makeCacheMatrix(x)
    expect_that(suppressMessages(cacheSolve(cache_matrix)), equals(x_inv))
})

test_that("cacheSolve can cache the inverse", {
    cache_matrix <- makeCacheMatrix(x)
    expect_that(cacheSolve(cache_matrix), shows_message("computing matrix inverse"))
    expect_that(cacheSolve(cache_matrix), shows_message("returning cached inverse"))
    expect_that(suppressMessages(cacheSolve(cache_matrix)), equals(x_inv))
})
