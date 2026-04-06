library(here)
library(rio)
library(tidyverse)
library(glue)

args <- commandArgs(trailingOnly = TRUE)
selected_cyl <- args[1]

(data <- rio::import(here("gnu_make/data_mtcars.csv")) %>% 
    tibble())

(res <- data %>% 
    filter(cyl == selected_cyl))

rio::export(res,
            glue(here(), "/gnu_make/processed_cyl_{selected_cyl}.csv"))

