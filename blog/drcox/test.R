# create dataset
data <- data.frame(
  "flu_detected" = c(12,7),
  "other_virus" = c(4,10),
  "none_detected" = c(8,4),
  row.names = c("Yes", "No"),
  stringsAsFactors = FALSE
)

# Print data
data

# expected frenquencies
chisq.test(data)$expected

# chi-square test of independence
chisq.test(data)
fisher.test(data)

dat <- read.csv("dat.csv",
                stringsAsFactors = TRUE)

table(dat)

library(vcd)

mosaic(~ History_fever + Virus,
       direction = c("v", "h"),
       data = dat,
       shade = TRUE
)

library(ggstatsplot)
library(ggplot2)
ggbarstats(
  data = dat,
  x = History_fever,
  y = Virus
) +
  labs(caption = NULL) # remove caption
