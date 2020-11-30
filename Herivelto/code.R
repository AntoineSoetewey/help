dat <- matrix(c(63, 78, 94, 65),
  ncol = 2
)

# 1st method:
test1 <- chisq.test(dat,
  correct = FALSE
)
test1$p.value

# 2nd method:
test2 <- summary(as.table(dat))
test2$p.value

# 3rd method:
library(vcd)
test3 <- assocstats(dat)
test3

# all p-values are equal
