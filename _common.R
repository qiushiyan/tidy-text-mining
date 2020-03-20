set.seed(1112)
options(digits = 3)



knitr::opts_chunk$set(
  comment = "#>",
  collapse = TRUE,
  out.width = "90%",
  fig.width = 6,
  fig.asp = 0.618,  # 1 / phi
  message = F,
  warning = F
)

library(tidyverse)
library(tidytext)

options(dplyr.print_min = 6, dplyr.print_max = 6)
