library(dslabs)
data(heights)

# data
dat <- heights
View(dat)

# create new height
dat$height2 <- ifelse(dat$height > 72,
                      dat$height,
                      0)

# compute mean
mean(dat$height2)