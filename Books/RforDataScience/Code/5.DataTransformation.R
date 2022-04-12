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

# 5.2.4 Exercise
# 1.1
filter(flights,arr_delay >= 120)

# 1.2
filter(flights, dest %in% c("IAH", "HOU"))

# 1.3
filter(flights, carrier %in% c("AA", "UA", "DL")) 

# 1.4
filter(flights, month %in% c(7, 8, 9))

# 1.5
filter(flights, (arr_time - sched_arr_time) > 120 & (dep_time == sched_dep_time))

# 1.6
filter(flights, arr_delay > 120 & dep_delay <= 0)
       
# 1.7
filter(flights, dep_time <= 600 | dep_time == 2400)

# 2
filter(flights, between(month, 7, 9))

# 3
filter(flights, is.na(dep_time))

summary(flights)

# 4
NA ^ 0

NA | TRUE

FALSE & NA

NA * 0





