#'---
#' title: Test parameterized reporting
#' author: ""
#' date: ""
#' params:
#'  variable: cyl
#'  selected_value: 4
#' output:
#'  github_document: default
#'  html_document:
#'    toc: true
#'    toc_depth: 2
#'    toc_float: true
#'    code_folding: hide
#'    keep_md: true
#'---

#+ message=FALSE
pacman::p_load(
    rio,            # import and export files
    here,           # locate files 
    tidyverse,      # data management and visualization
    glue
)

#' # Data
# data #-----------
(data <- rio::import(here("gnu_make/data_mtcars.csv")) %>% 
     tibble())

(res <- data %>% 
        filter(.data[[params$variable]] == params$selected_value))

rio::export(res,
            glue(here(),
                 "/parameterized_report/processed_{params$variable}_{params$selected_value}.csv"))

#' # Plot
# plot #------------------------
(data <- rio::import(glue(here(), "/parameterized_report/processed_{params$variable}_{params$selected_value}.csv")) %>% 
     tibble())

fig <- data %>% 
    ggplot(aes(x = mpg, y = hp)) +
    geom_point() +
    theme_bw()

fig

lehuynh::ggsave_elsevier(glue(here(), "/parameterized_report/plot_{params$variable}_{params$selected_value}.png"),
                         fig,
                         width = "one_column",
                         height = 240/3)

