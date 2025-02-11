## Simple script used to install all packages needed by the lecture/lab.

p <- c(
  "httpgd",
  "knitr",
  "markdown",
  "pacman",
  "rio",
  "rmarkdown",
  "tidyr",
  "tidyverse"
)
install.packages(p)

unlink("lecture_eda_complete.qmd")
unlink("lab-answers.qmd")
