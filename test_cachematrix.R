
library("testthat")

source("cachematrix.R")

context("Caching the inverse of a matrix")

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
