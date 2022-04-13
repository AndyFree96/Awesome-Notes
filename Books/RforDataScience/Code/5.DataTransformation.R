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

# 5.2.4 Exercises
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

# arrange函数给行排序
arrange(flights, year, month, day)

arrange(flights, desc(dep_delay))

df <- tibble(x = c(5, 2, NA))

df

arrange(df, x)

arrange(df, desc(x))

# 5.3.1 Exercises
# 1
arrange(df, !is.na(x))

# 2
arrange(flights, desc(dep_delay))

arrange(flights, dep_delay)

# 3
arrange(flights, desc(distance / air_time))

# 4
arrange(flights, desc(distance))

arrange(flights, distance)

arrange(flights, desc(air_time))

arrange(flights, air_time)

# select函数选择列
select(flights, year, month, day)

select(flights, year:day)

select(flights, -(year:day))

rename(flights, tail_num=tailnum)

select(flights, starts_with("t"))

select(flights, ends_with("r"))

select(flights, time_hour, air_time, everything())

# 5.4.1 Exercises
# 1
select(flights, dep_time, dep_delay, arr_time, arr_delay)

# 2
select(flights, dep_time, dep_time)

# 3
vars <- c("year", "month", "day","dep_delay", "arr_delay")
select(flights, any_of(vars))

# 4
select(flights, contains("TIME"))

select(flights, contains("TIME", ignore.case = FALSE))

