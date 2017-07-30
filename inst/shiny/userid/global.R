# desirable <- matrix(data = NA,
#                     nrow = 5,
#                     ncol = 9,
#                     dimnames = list(rows = c("a", "b", "c", "d", "e"),
#                                     columns = c("01", "02", "03", "04", "05", "06", "07", "08", "09")))
#
#
# make_newsort <- function(cells, emptymat) {
#   # emptymat <- desirable
#   # cells <- list(b02_drop = "foo", a03_drop = "bar", e09_drop = "lirum")
#   # set all to NA
#   emptymat[,] <- NA
#   newmat <- emptymat
#   for (row_i in rownames(emptymat)) {
#     for (col_i in 1:ncol(emptymat)) {
#       thisel <- paste0(row_i, "0", col_i, "_", "drop")
#       if(!is.null(cells[[thisel]])) {
#         newmat[row_i, col_i] <- cells[[thisel]]
#       }
#     }
#   }
#   return(newmat)
# }
#
# test_oldmat <- structure(c(NA, NA, NA, NA, NA, NA, "foo", NA, NA, NA, "bar",
#             NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,
#             NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,
#             NA, "lirum"), .Dim = c(5L, 9L), .Dimnames = structure(list(rows = c("a",
#                                                                                 "b", "c", "d", "e"), columns = c("01", "02", "03", "04", "05",
#                                                                                                                  "06", "07", "08", "09")), .Names = c("rows", "columns")))
# test_newmat <- structure(c(NA, NA, NA, NA, NA, NA, "foo", NA, NA, NA, "bar",
#                                           NA, NA, NA, NA, NA, NA, "foo", NA, NA, NA, NA, NA, NA, NA, NA, NA,
#                                           NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,
#                                           NA, "lirum"), .Dim = c(5L, 9L), .Dimnames = structure(list(rows = c("a",
#                                                                                                               "b", "c", "d", "e"), columns = c("01", "02", "03", "04", "05",
#                                                                                                                                                "06", "07", "08", "09")), .Names = c("rows", "columns")))
#
# update_sort <- function(oldsort, newsort) {
#   # newsort <- test_newmat
#   # oldsort <- test_oldmat
#   for (row_i in rownames(newsort)) {
#     for (col_i in 1:ncol(newsort)) {
#       current_item <- newsort[row_i, col_i]
#       # current_item <- "as"
#       # current_item <- "foo"
#       if (sum(current_item == newsort, na.rm = TRUE) > 1) {
#         newsort[which(oldsort == newsort & newsort == current_item, arr.ind = TRUE)] <- NA
#       }
#     }
#   }
#   return(newsort)
# }
#
