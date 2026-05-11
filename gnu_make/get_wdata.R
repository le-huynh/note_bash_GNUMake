library(here)
library(rio)
library(tidyverse)
library(glue)

args <- commandArgs(trailingOnly = TRUE)
variable <- args[1]
selected_value <- as.numeric(args[2])
value1 <- args[3]

(data <- rio::import(here("gnu_make/data_mtcars.csv")) %>% 
    tibble())

(res <- data %>% 
    filter(.data[[variable]] == selected_value))

rio::export(res,
            glue(here(), "/gnu_make/processed_{variable}_{selected_value}.csv"))

print(value1)

