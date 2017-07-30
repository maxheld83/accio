context("testthat")

test_that(desc = "works",
          code = {
   testthat::expect_equal(object = 1 + 1, expected = 2)
  })
