#---
# para_report_render.R
#
# This Rscript: 
# * generate multiple .csv and .png from a single .Rmd template
#
# Dependencies...
# gnu_make/data_mtcars.csv
# parameterized_report/para_report.R
#
# Produces...
# parameterized_report/processed_{variable}_{selected_value}.csv
# parameterized_report/plot_{variable}_{selected_value}.png
#---

pacman::p_load(
    rmarkdown,      # render .Rmd template
    here,           # locate files 
    tidyverse       # data management and visualization
)

variable <- c("cyl", "gear")
selected_value <- c(8, 5)

# Create a tibble with information on the:
# input R Markdown document
# output HTML file
# parameters needed to knit the document
reports <- tibble(
    input = "parameterized_report/para_report.R",
    output_format = "all",
    output_file = str_glue("report_{variable}_{selected_value}"),
    params = map2(.x = variable,
                  .y = selected_value,
                  ~ list(variable = .x,
                         selected_value = .y))
)

# Generate all of our reports
pwalk(reports, render)

