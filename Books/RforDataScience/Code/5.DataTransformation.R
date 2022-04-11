# 导入包
library(nycflights13)
library(tidyverse)

flights

jan1 <- filter(flights, month == 1, day == 1)

(dec25 <- filter(flights, month == 12, day == 25))

filter(flights, month == 1)

sqrt(2) ^ 2 == 2

1 / 49 * 49 == 1

near(sqrt(2) ^ 2, 2)

near(1 / 49 * 49, 1)

filter(flights, month == 11 | month == 12)

nov_dec <- filter(flights, month %in% c(11, 12))

filter(flights, !(arr_delay > 120 | dep_delay > 120))

filter(flights, arr_delay <= 120, dep_delay <= 120)

NA > 5

10 == NA

NA + 10

NA / 2

NA == NA

x <- NA

y <- NA

is.na(x)

df <- tibble(x = c(1, NA, 3))

filter(df, x > 1)

filter(df, is.na(x) | x > 1)


