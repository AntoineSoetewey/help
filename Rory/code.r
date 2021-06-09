# import and transform data
dat <- read.csv("SampleAntoine.csv",
                header = TRUE,
                sep = ",",
                dec = ".",
                row.names = 1)
View(dat)

dat$signatory <- as.factor(dat$signatory)
str(dat)

# plot totalUSD for each group
library(ggplot2)

ggplot(dat) +
  aes(x = signatory, y = totalUSD) +
  geom_boxplot() +
  theme_minimal()

# t-test
test <- t.test(totalUSD ~ signatory,
               data = dat)
test
