### 3.2.4:

# 1. Run ggplot(data = mpg). What do you see?
# Nothing


# 2. How many rows are in mpg? How many columns?
ncol(mpg) # 11
nrow(mpg) # 234


# 3. What does the drv variable describe?
# f = front-wheel drive, r = rear wheel drive, 4 = 4wd


# 4. Make a scatterplot of hwy vs cyl.
plot(mpg$hwy, mpg$cyl)


# 5. What happens if you make a scatterplot of class vs drv?
plot(mpg$class, mpg$drv)
# These are two categorical variables that's why the plot is not useful
# This command doesn't even plot it, may be ggplot can do it but still
# it won't be helpful at all.



### 3.3.1

# 1. What's gone wrong with this code? Why are the points not blue?
# color should be out of the aes, when it's there, ggplot assumes it as
# a variable. It should be like this:
ggplot(data = mpg)+
geom_point(mapping=aes(x=displ, y=hwy), color="blue")


# 2. Cat: manufacturer, model, trans, fl, class
# The rest are contiuous.
# Although, as a mechanical eng I wouldn't count the number of cylinders as
# continuous but since it is a number let's say it is continuous


# 3. I am using ggplot for this one:
ggplot(data=mpg)+
geom_point(mapping=aes(x=cty, y=year, color=cyl))

ggplot(data=mpg)+
geom_point(mapping=aes(x=cty, y=year, size=displ))

ggplot(data=mpg)+
geom_point(mapping=aes(x=cty, y=year, shape=drv))

#The legend is different for con/cat vars


# 4. What happens if you map the same variable to multiple aesthetics?
# Nothing, it will be maped to all of them.


# 5. What does the stroke aesthetic do? What shapes does it work with?
# Use the stroke aesthetic to modify the width of the border
# For shapes that have a border.


# 6. Map an aesthetic to something other than a variable name?
# It depends on the variable. The aesthetic will be based on that variable.



### 3.5.1

# 1. It would be awful, it assigns one facet for every single value

# 2. Obviously it means there were no data points in that facet with that
# specification.
# in both of them we don't have: 4-r, 5-4 and 5-f

# 3. This question was answered before in mtcars

# 4. We can separately look at the distribution in each facet but w/ colors
# the data is all there. If we want to look at each of those facets 
# separately, facet is better. but if we would like to compare all the data
# together, color coded plots are better. Also, for large datasets, color
# coded plots get messy and faceted plots are much better.

# 5. Answered before

# 6. Probably because we usually have more space on the horizontal
# direction.



### 3.6.1

# 1. geom_line()
# geom_boxplot()
# geom_histogram()
# geom_area()


# 2. Answered before


# 3. It doesn't show the legend
# does otherwise
# Because the plot on the left already shows the colors assigned to vars,
# It was redundant to have the legend again. By the way it is for the next
# section!!


# 4. Do not display confidence interval around smooth line


# 5. No because we basically haven't changed anything! The austhetics are
# all ggplot defaults


# 6.
ggplot(data=mpg, mapping=aes(x=displ, y=hwy))+
geom_point()+
geom_smooth(se=FALSE)

ggplot(data=mpg, mapping=aes(x=displ, y=hwy))+ 
geom_point()+
geom_smooth(mapping=aes(group=drv), se=FALSE)

ggplot(data=mpg, mapping=aes(x=displ, y=hwy, color=drv))+
geom_point()+
geom_smooth(se=FALSE)

ggplot(data=mpg, mapping=aes(x=displ, y=hwy))+ 
geom_point(mapping=aes(color=drv))+
geom_smooth(se=FALSE)

ggplot(data=mpg, mapping=aes(x=displ, y=hwy))+ 
geom_point(mapping=aes(color=drv))+
geom_smooth(se=FALSE, mapping=aes(linetype=drv))

ggplot(data=mpg, mapping=aes(x=displ, y=hwy))+ 
geom_point(mapping=aes(color=drv))+ 
geom_point(shape=21, color="white", stroke=2)


### 3.7.1

# 1. Answered before

# 2. There are two types of bar charts: geom_bar() and geom_col().
# geom_bar() makes the height of the bar proportional to the number of
# cases in each group (or if the weight aesthetic is supplied, the sum of
# the weights). If you want the heights of the bars to represent values
# in the data, use geom_col() instead. geom_bar() uses stat_count() by
# default: it counts the number of cases at each x position. geom_col()
# uses stat_identity(): it leaves the data as is.


# 3. geom_bar()/stat_count(), geom_bin2d()/stat_bin_2d(), geom_boxplot()/
# stat_boxplot(), geom_contour()/stat_contour(), geom_count()/stat_sum(),
# geom_density()/stat_density(), geom_density_2d()/stat_density_2d(),
# geom_hex()/stat_hex(), geom_freqpoly()/stat_bin(), geom_histogram()/
# stat_bin(), geom_qq_line()/stat_qq_line(), geom_qq()/stat_qq(),
# geom_quantile()/stat_quantile(), geom_smooth()/stat_smooth(),
# geom_violin()/stat_violin(), geom_sf()/stat_sf() Their names probably!


# 4. y: predicted value, ymin: lower pointwise confidence interval around
# the mean, ymax: upper pointwise confidence interval around the mean,
# se: standard error

# position, method, formula, se, na.rm, show.legend, inherit.aes, ...


# 5. If we don't assign groups all of the bars will have the same height.



### 3.8.1

# 1. We have overlapping points because the datapoints are not really
# continuous.


# 2. width, height


# 3. Answered before


# 4. position = "dodge2"
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + 
geom_boxplot()



### 3.9.1

# 1.
bar <- ggplot(data=mpg)+ 
geom_bar(mapping=aes(x=cty, fill=hwy), show.legend=FALSE, width=1)+ 
theme(aspect.ratio=1)+
labs(x=NULL, y=NULL)
bar+coord_polar()


# 2. Modify axis, legend, and plot labels


# 3. coord_map projects a portion of the earth, which is approximately
# spherical, onto a flat 2D plane using any projection defined by the
# mapproj package. Map projections do not, in general, preserve straight
# lines, so this requires considerable computation. coord_quickmap is a
# quick approximation that does preserve straight lines. It works best for
# smaller areas closer to the equator.


# 4. Answered before
