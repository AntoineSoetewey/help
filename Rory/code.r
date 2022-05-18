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
# totalUSD is significantly different between groups

# outliers are present, specially in signatory == 1
# see wilcoxon test:

test <- wilcox.test(totalUSD ~ signatory,
               data = dat)
test
# totalUSD is NOT significantly different between groups

# or eventually remove outliers (be careful)
subdat <- subset(dat, totalUSD < 100)

t.test(totalUSD ~ signatory,
       data = subdat)
wilcox.test(totalUSD ~ signatory,
            data = subdat)
# t-test and wilcoxon test indicate that totalUSD is NOT significantly different between groups
