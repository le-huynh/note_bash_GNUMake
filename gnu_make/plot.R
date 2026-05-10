library(here)
library(rio)
library(tidyverse)
library(glue)

args <- commandArgs(trailingOnly = TRUE)
variable <- args[1]
selected_value <- as.numeric(args[2])

(data <- rio::import(glue(here(), "/gnu_make/processed_{variable}_{selected_value}.csv")) %>% 
        tibble())

fig <- data %>% 
    ggplot(aes(x = mpg, y = hp)) +
    geom_point() +
    theme_bw()

lehuynh::ggsave_elsevier(glue(here(), "/gnu_make/plot_{variable}_{selected_value}.png"),
                         fig,
                         width = "one_column",
                         height = 240/3)

