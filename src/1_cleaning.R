#### ---- packages
library(here)
library(readxl)
library(tidyverse)
library(stringr)
library(viridis)
library(lubridate)

#### ---- readdata
data_raw <- readxl::read_xlsx(here("data/TimeTableTentative_2022_04_10.xlsx"))

#### ---- overview
head(data_raw)
colnames(data_raw)

#### ---- save cleaned data
data_raw$subject_code <- substr(data_raw$`Unit No.`, 1, 3)
data_raw$time_st <- substr(data_raw$Time, 1, 5)
data_raw$time_am_pm <- substr(data_raw$Time, 15, 16)

#### ---- adjusting time column



#### ---- draw heatmap
data_count <- data_raw %>%
              group_by(Day, Time) %>%
              mutate(count = n())
as.data.frame(head(data_count))

p1 <- ggplot(data_count, aes(x=Day, y=Time, fill=count)) +                           # Create heatmap with ggplot2
  geom_tile(colour="white", lwd = 1.5, linetype = 1) + 
  #geom_text(aes(label = subject_code), col="white",
  #          position=position_jitter(width=0.5,height=0.5)) + 
  scale_fill_viridis(discrete=FALSE, direction=1)  + 
  theme_minimal()
p1

p2 <- ggplot(data_count, aes(x=Day, y=Time)) +                           # Create heatmap with ggplot2
  geom_tile(aes(fill = subject_code)) + 
  theme_minimal()
p2
