library(here)
library(rio)
library(tidyverse)
library(glue)

args <- commandArgs(trailingOnly = TRUE)
selected_cyl <- args[1]

(data <- rio::import(glue(here(), "/gnu_make/processed_cyl_{selected_cyl}.csv")) %>% 
        tibble())

fig <- data %>% 
    ggplot(aes(x = mpg, y = hp)) +
    geom_point() +
    theme_bw()

lehuynh::ggsave_elsevier(glue(here(), "/gnu_make/plot_cyl_{selected_cyl}.png"),
                         fig,
                         width = "one_column",
                         height = 240/3)

