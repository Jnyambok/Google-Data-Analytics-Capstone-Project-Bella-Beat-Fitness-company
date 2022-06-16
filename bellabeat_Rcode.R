install.packages("dplyr")         #Data manipulation 
install.packages("ggplot2")       #creating data viz
install.packages("tidyverse")     #Data cleaning/Data tidying
install.packages("lubridate")     #Formatting dates
install.packages("janitor")       #Examining dirty data
install.packages("readr")         #Importing data
install.packages("data.table")    #Working with tabular data.


library(dplyr)
library(ggplot2)
library(tidyverse)
library(lubridate)
library(janitor)
library(readr)
library(data.table)

##Loading the selected data set
library(readxl)
dailyActivity_2016 <- read_excel("C:/Users/hp/Desktop/Machine learning/BELLABEAT Capstone Project/fitbit_data/Fitabase Data 4.12.16-5.12.16/dailyActivity_merged.xlsx")
View(dailyActivity_2016)


##Lets take a quick look at the data's integrity
skimr::skim_without_charts(dailyActivity_2016)
str(dailyActivity_2016)

#Converting the dates to days of the week,
dailyActivity_2016$Activity_weekday <- weekdays(dailyActivity_2016$ActivityDate)
dailyActivity_2016 <- dailyActivity_2016 %>% 
  relocate(Activity_weekday, .before = TotalSteps)
View(dailyActivity_2016)



#Plotting the logged in activity by day of the week
ggplot(dailyActivity_2016) +
  geom_bar(aes(x = Activity_weekday, fill="#FF9999", colour="black")) +
  labs(title = 'Distribution of Logged Activity by Day')


#Plotting the Active minutes vs Sedentary Minutes
active_minutes <- sum(light_minutes,moderate_minutes,veryActyive_minutes) 
sedentary_minutes <- sum(dailyActivity_2016$SedentaryMinutes)
activity_df <- data.frame("category" = c('Active Minutes','Sedentary Minutes'),
                          "sum" = c(active_minutes,sedentary_minutes))
ggplot(activity_df, aes(x="", y=sum, fill=category)) +
  geom_bar(stat="identity", width=1) +
  coord_polar("y", start=0)  +
  labs(title = " Active minutes vs Sedentary minutes")


#Plotting the Activity by their category
dailyActivity_2016 <- data.frame(dailyActivity_2016)
moderate_minutes <- sum(dailyActivity_2016$FairlyActiveMinutes)
light_minutes <- sum(dailyActivity_2016$LightlyActiveMinutes)
veryActyive_minutes <- sum(dailyActivity_2016$VeryActiveMinutes)

typeof(moderate_distance)
sum_data <- data.frame("category" = c('Light Active', 'Moderately Active', 'Very Active'),
                   "sum" = c(light_minutes, moderate_minutes, veryActyive_minutes))

ggplot(sum_data, aes(x="", y=sum, fill=category)) +
  geom_bar(stat="identity", width=1) +
  coord_polar("y", start=0) +
  labs(title = " Distribution of Active minutes logged in")


