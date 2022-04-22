# 导入包
library(sparklyr)
library(DBI)
library(dplyr)

# 设置环境变量
JAVA_HOME <- "/opt/homebrew/opt/openjdk@11"
Sys.setenv(JAVA_HOME=JAVA_HOME)
Sys.getenv("JAVA_HOME")

sc <- spark_connect(master = "local", version = "3.2.1")

cars <- copy_to(sc, mtcars)

cars

spark_web(sc)

dbGetQuery(sc, "SELECT count(*) FROM mtcars")

count(cars)

select(cars, hp, mpg) %>% 
  sample_n(100) %>%
  collect() %>%
  plot()

model <- ml_linear_regression(cars, mpg ~ hp)

model %>% ml_predict(copy_to(sc, data.frame(hp = 250 + 10 * 1:10))) %>%
  transmute(hp = hp, mpg = prediction) %>%
  full_join(select(cars, hp, mpg)) %>%
  collect() %>%
  plot()

spark_write_csv(cars, "cars.csv")
