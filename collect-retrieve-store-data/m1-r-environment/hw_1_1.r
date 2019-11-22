# install.packages("tidyverse")
library('ggplot2')


# 1. The gears variable:
# ANS: Number of forward gears
mtcars$gear


# 2. mpg vs. cycle scatter plot:
plot(mtcars$mpg, mtcars$cyl)


# 3. cat/continuous vars? ...
# Generally we can see the summary of the data using:
summary(mtcars)
# we can also see a specified number of first rows using:
head(mtcars)
# These are the columns in the data set:
colnames(mtcars)
# cyl, vs, am, gear, carb are categorical and the rest are continuous


# 4. What do the following codes do:
ggplot(data = mtcars) +
geom_point(mapping = aes(x = disp, y = mpg)) +
facet_grid(cyl~.)
# facet_grid() facets the plot on the combination of 2 vars. Here the plot has
# disp on x axis and mpg on y. The . means we didn't want to facet on the
# columns and only number of cylinders on the rows

ggplot(data = mtcars) +
geom_point(mapping = aes(x = disp, y = mpg)) +
facet_grid(. ~ am)
# Same as above for x and y axis but here we facetet on the columns based 
# on wether it was manual or automatic transmission


# 5. ?facet_wrap ...
# "facet_wrap" wraps a 1d sequence of panels into 2d. This is generally a
# better use of screen space than facet_grid() because most displays are
# roughly rectangular.

# "nrow, ncol": Number of rows and columns.

# other options: scales, shrink, as.table, switch, dir, strip.position

# Because there nrows and ncols are based on the categorical variable that
# we have chosen for the facet_grid() formula and is not based on what we
# decide to happen.


# 6. My prediction of the following code:
# It should make a scatter plot with mpg on y axis and disp on x axis
# The color of points are chosen based on cyl
# it also adds a smoothed conditional mean, by setting se as False, we
# tell it not to display confidence interval around smooth line
ggplot(data = mtcars, mapping = aes(x = disp, y = mpg, color = cyl)) +
geom_point() +
geom_smooth(se = FALSE)


# 7. default geom associated with stat_summary()?
# geom_pointrange

# Rewrite code below:
ggplot(data = mtcars) +
  stat_summary(
    mapping = aes(x = disp, y = mpg),
    fun.ymin = min,
    fun.ymax = max,
    fun.y = median
  )
# After rewriting:
ggplot(data=mtcars) +
geom_pointrange(aes(x=disp, y=mpg, ymin=min, ymax=max))


# 8. For the following code, compare geom_jitter() with geom_count()
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
geom_point()
# geom_count: This is a variant geom_point() that counts the number of
# observations at each location, then maps the count to point area. It
# useful when you have discrete data and overplotting.
# geom_jitter: The jitter geom is a convenient shortcut for
# geom_point(position = "jitter"). It adds a small amount of random
# variation to the location of each point, and is a useful way of
# handling overplotting caused by discreteness in smaller datasets.


# 9. relationship between cty and hwy in mpg?
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
  geom_point() +
  geom_abline() +
  coord_fixed()
# It tells us that they are linearly related. Cars w/ Higher Highway fuel
# economy have higher city fuel economy too.

# Why is coord_fixed() important?
# A fixed scale coordinate system forces a specified ratio between the
# physical representation of data units on the axes. The ratio represents
# the number of units on the y-axis equivalent to one unit on the x-axis.
# The default, ratio = 1, ensures that one unit on the x-axis is the same
# length as one unit on the y-axis. Ratios higher than one make units on
# the y axis longer than units on the x-axis, and vice versa.

# What does geom_abline() do?
# These geoms add reference lines (sometimes called rules) to a plot,
# either horizontal, vertical, or diagonal (specified by slope and
# intercept). These are useful for annotating plots.
