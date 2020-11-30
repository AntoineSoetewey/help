dat <- matrix(c(63,78,94,65), ncol=2)

# 1st method:
test1 <- chisq.test(dat,
           correct = FALSE)
test1$p.value

# 2nd method:
test2 <- summary(as.table(dat))
test2$p.value

# both p-values are equal