# 导入包
library(nycflights13)
library(tidyverse)

# flights数据集变量含义
# year, month, day: 起飞日期
# dep_time, arr_time: 起飞时间和到达时间。格式: HHMM，当地时间。
# sched_dep_time, sched_arr_time: 计划起飞时间、计划到达时间
# dep_delay, arr_delay: 起飞延误、到达延误
# hour, minute: 计划起飞时间拆分为hour和minute
# carrier: 承运商缩写
# tailnum: 飞机尾号
# origin, dest: 始发地、目的地
# airtime: 空中时间
# distance: 机场间距

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


# mutate函数添加新变量
flights_sml <- select(flights, 
                      year:day,
                      ends_with("delay"),
                      distance,
                      air_time)
mutate(flights_sml, gain = dep_delay - arr_delay,
       speed = distance / air_time * 60)

mutate(flights_sml, gain = dep_delay - arr_delay,
       hours = air_time / 60,
       gain_per_hour = gain / hours)

transmute(flights, gain = dep_delay - arr_delay,
          hours = air_time / 60,
          gain_per_hour = gain / hours)

transmute(flights, dep_time, hour = dep_time %/% 100,
          minute = dep_time %% 100)

(x <- 1:10)

lag(x)

lead(x)

cumsum(x)

cummean(x)

y <- c(1, 2, 2, NA, 3, 4)

min_rank(y)

# 5.5.2 Exercises
# 1
time2mins <- function(x){
  (x %/% 100 * 60 + x %% 100) %% 1440
}

flights_times <- mutate(flights,
                        dep_time_mins=time2mins(dep_time),
                        sched_dep_time_mins=time2mins(sched_dep_time))

select(flights_times, dep_time, dep_time_mins, sched_dep_time,
       sched_dep_time_mins)
# 2
flights_air_time <- mutate(flights, 
                           dep_time = time2mins(dep_time),
                           arr_time = time2mins(arr_time),
                           air_diff=air_time - arr_time + dep_time)
nrow(filter(flights_air_time, air_diff != 0))
dim(flights_air_time)

# 3
select(flights, dep_time, sched_dep_time, dep_delay)
# dep_time = sched_dep_time + dep_delay

# 4
flights_delayed <- mutate(flights, 
                          dep_delay_min_rank = min_rank(desc(dep_delay)),
                          dep_delay_row_number = row_number(desc(dep_delay)),
                          dep_delay_dense_rank = dense_rank(desc(dep_delay))
)
flights_delayed <- filter(flights_delayed, 
                          !(dep_delay_min_rank > 10 | dep_delay_row_number > 10 |
                              dep_delay_dense_rank > 10))

flights_delayed <- arrange(flights_delayed, dep_delay_min_rank)
# 5
1:3 + 1:10
# 报错, 两个向量的长度不匹配

# 6
sin(1:3)

cos(1:3)

tan(1:3)

# 使用summarize函数进行分组摘要
summarize(flights, delay=mean(dep_delay, na.rm=TRUE))

by_day <- group_by(flights, year, month, day)
summarize(by_day, delay = mean(dep_delay, na.rm=TRUE))

## 使用管道组合多种操作
delays <- flights %>% 
  group_by(dest) %>%
  summarize(
    count = n(),
    dist=mean(distance, na.rm=TRUE),
    delay=mean(arr_delay, na.rm=TRUE)
  ) %>% filter(count > 20, dest != "HNL")

delays

## 缺失值
flights %>%
  group_by(year, month, day) %>%
  summarize(mean=mean(dep_delay, na.rm=TRUE))

flights %>% filter(!is.na(dep_delay), !is.na(arr_delay)) %>%
  group_by(year, month, day) %>%
  summarize(mean=mean(dep_delay))

batting <- as_tibble(Lahman::Batting)

batters <- batting %>%
  group_by(playerID) %>%
  summarize(ba=sum(H, na.rm = TRUE) / sum(AB, na.rm = TRUE),
            ab=sum(AB, na.rm = TRUE)
            )
batters %>% filter(ab > 100) %>%
  ggplot(mapping = aes(x = ab, y = ba)) +
  geom_point() +
  geom_smooth(se = FALSE)

batters %>% 
  arrange(desc(ba))
