## ----setup-options, echo = FALSE, results = "hide", message = FALSE------
knitr::opts_chunk$set(comment=NA, fig.align = "center",
                      out.width = "0.7\\linewidth",
                      echo = TRUE, message = TRUE, warning = TRUE,
                      cache = TRUE)
knitr::knit_hooks$set(crop.plot = knitr::hook_pdfcrop)

## ----packages, echo = FALSE, results = "hide", message = FALSE, warning = FALSE----
library("ggplot2")
library("gapminder")
library("gridExtra")

## ----assignment----------------------------------------------------------
radius <- 5
pi * radius^2

## ----load-packages-example, eval = FALSE---------------------------------
## install.packages(c("gapminder", "ggplot2"))
## library("gapminder")
## library("ggplot2")

## ----read-gapminder------------------------------------------------------
gap <- system.file("gapminder.tsv", package = "gapminder")
gapminder <- read.delim(gap)
head(gapminder)

## ----gapminder-example, out.width = "0.6\\linewidth"---------------------
ggplot(subset(gapminder, continent != "Oceania"),
       aes(x = year, y = lifeExp, group = country, color = country)) +
  geom_line(show_guide = FALSE) + facet_wrap(~ continent) +
  scale_color_manual(values = country_colors) +
  theme_bw()

## ----str-gapminder-------------------------------------------------------
str(gapminder)
class(gapminder)

## ----subset-dollar-------------------------------------------------------
head(gapminder$country)

## ----subset-dollar-2-----------------------------------------------------
head(gapminder$cou)

## ----subset-double-bracket-----------------------------------------------
head(gapminder[["continent"]])

## ----subset-double-bracket-2---------------------------------------------
head(gapminder[[2]])

## ----subset-single-bracket-----------------------------------------------
head(gapminder[c("country", "continent")])

## ----subset-single-bracket-2---------------------------------------------
head(gapminder[1:2])

## ----subset-single-bracket-3---------------------------------------------
head(gapminder[1:4, c(1,3)])

## ----subset-single-bracket-4---------------------------------------------
head(gapminder[1:4, ])                  # all columns, rows 1--4

## ----subset-single-bracket-5---------------------------------------------
head(gapminder[, 1:3], 3)               # all rows, columns 1--3

## ----subset-single-bracket-6---------------------------------------------
head(gapminder[, 2], 3)                 # just column 2

## ----subset-single-bracket-7---------------------------------------------
head(gapminder[, 2, drop = FALSE], 3)   # all rows, columns 1--3

## ----subsetting-types----------------------------------------------------
(1:10)[c(FALSE, TRUE)]
(1:9)[c(FALSE, TRUE)]                   # no warning

## ----str-gapminder-2-----------------------------------------------------
str(gapminder)

## ----numeric-vectors-1---------------------------------------------------
class(gapminder$lifeExp)
class(gapminder$year)

## ----numeric-vectors-2---------------------------------------------------
c(1,3,5,7,9)
1:10

## ----character-vectors-1-------------------------------------------------
c("foo","bar")

## ----logical-vectors-1---------------------------------------------------
c(TRUE, TRUE, FALSE)

## ----logical-vectors-2---------------------------------------------------
as.numeric(c(TRUE, TRUE, FALSE))

## ----factors-1-----------------------------------------------------------
f <- factor(c("Male","Female","Male"))
levels(f)
f <- factor(c(1,2,5,5,2,1))
as.numeric(f)                           # WRONG! Gets internal codes
as.numeric(as.character(f))             # RIGHT! correct coercion

## ----seqs-patterns-------------------------------------------------------
seq(from = 1, to = 10, by = 2)
1:5
rep(1:3, each = 2)
rep(1:3, times = 3:1)

## ----functions-1---------------------------------------------------------
rnorm(10)
args(rnorm)
rnorm(10, mean = 2, sd = 4)

## ----functions-2---------------------------------------------------------
rnorm(10, 2, 4)                         # What the heck does this do?

## ----functions-3---------------------------------------------------------
rnorm(sd = 4, mean = 2, n = 10)

## ----functions-4---------------------------------------------------------
foo <- function(x) {                    # foo() squares it's input
    x * x                               # last statement determines return value
}
class(foo)
foo(10)

## ----split-apply-combine-1-----------------------------------------------
aggregate(pop ~ continent, data = gapminder, FUN = median)

## ----split-apply-combine-2-----------------------------------------------
with(gapminder, sapply(split(pop, f = continent), FUN = median)) 

## ----split-apply-combine-3-----------------------------------------------
apply(gapminder[, 4:5], 2, FUN = median)
tapply(gapminder$pop, gapminder$continent, FUN = median)

## ----split-apply-combine-4-----------------------------------------------
with(gapminder, lapply(split(pop, f = continent), FUN = median))

## ----base-plot-1, crop.plot = TRUE---------------------------------------
x <- rnorm(20)
y <- rnorm(20)
plot(x, y, pch = 1, col = "navyblue", cex = 1.2, type = "p")

## ----base-plot-2, crop.plot = TRUE, eval = FALSE-------------------------
## plot(x, y, lty = "dashed", col = "navyblue", cex = 1.2, type = "l")
## plot(x, y, pch = 2, col = "navyblue", cex = 1.2, type = "o")

## ----base-plot-3, crop.plot = TRUE, echo = FALSE, out.width = "0.85\\linewidth"----
layout(matrix(1:2, ncol = 2))
plot(x, y, lty = "dashed", col = "navyblue", cex = 1.2, type = "l")
plot(x, y, pch = 2, col = "navyblue", cex = 1.2, type = "o")
layout(1)

## ----base-plot-4, crop.plot = TRUE, out.width = "0.55\\linewidth", fig.show = "hold"----
op <- par(mar = c(5,4,5,4) + 0.1)       # alter margins
plot(x, y, pch = 1, col = "navyblue", cex = 1.2, type = "p", ann = FALSE, axes = FALSE)
axis(side = 1); axis(side = 2)          # add axis, can be customised
axis(side = 3); axis(side = 4)
box()                                   # draw the box round the plot
title(main = "My plot", xlab = "x-axis", ylab = "my y-axis label")
par(op)                                 # reset plotting parameters

## ----ggplot-1, fig.width = 7---------------------------------------------
library("ggplot2")             # load the package
plt <- ggplot(gapminder, mapping = aes(x = year, y = pop, colour = continent, group = country)) +
         geom_line()           # add a layer with a line geometry
plt                            # Have to print the object to draw plot

## ----ggplot-2, fig.width = 9, out.width = "0.9\\linewidth"---------------
plt + facet_wrap(~ continent)  # facet by continent

## ----ggplot-3, fig.width = 9, out.width = "0.9\\linewidth"---------------
ggplot(gapminder, mapping = aes(x = continent, y = lifeExp)) +
    geom_boxplot()                      # has a default stat "boxplot"

## ----ggplot-4, fig.width = 9, out.width = "0.9\\linewidth"---------------
ggplot(gapminder, mapping = aes(x = lifeExp)) +
    geom_histogram()                      # has a default stat "bin"

## ----ggplot-5, fig.width = 9, out.width = "0.9\\linewidth"---------------
ggplot(gapminder, mapping = aes(x = lifeExp)) +
    geom_line(stat = "density")         # change the stat

## ----ggplot-6, fig.width = 7, out.width = "0.7\\linewidth"---------------
(p2 <- ggplot(subset(gapminder, year == 2002 & continent != "Oceania"),
             aes(x = gdpPercap, y = lifeExp, colour = continent, group = continent)) +
        geom_point() + geom_smooth(method = "lm"))

## ----ggplot-7, fig.width = 7, out.width = "0.7\\linewidth"---------------
p2 + theme(legend.position = "top")     # move the legend, see ?theme

## ----ggplot-8, fig.width = 7, out.width = "0.7\\linewidth"---------------
p2 + theme_bw()                         # a simple theme

## ----ggsave-1, eval = FALSE----------------------------------------------
## ggsave(file = "filename.pdf")

## ----ggsave-2, eval = FALSE----------------------------------------------
## ggsave(p2, file = "filename.pdf")

## ----ggsave-3, eval = FALSE----------------------------------------------
## ggsave(file = "filename.pdf", width = 6, height = 4)

## ----ggsave-4, eval = FALSE----------------------------------------------
## ggsave(file = "filename.png")

