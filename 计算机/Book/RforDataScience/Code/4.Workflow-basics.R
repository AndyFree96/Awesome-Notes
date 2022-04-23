library(dplyr)
library(nycflights13)

# 运行命令：Command + Enter
# 运行整个脚本：Command + Shift + 

not_cancelled <- flights %>% 
  filter(!is.na(dep_delay), !is.na(arr_delay))

not_cancelled %>%
  group_by(year, month, day) %>%
  summarise(mean = mean(dep_delay))
