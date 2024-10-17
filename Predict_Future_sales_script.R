
#Installing required Lib 
install.packages("readr")
library(readr)

install.packages("dplyr") #Data Manipualtion
library(dplyr)

install.packages("ggplot2") #Data Visualization
library(ggplot2)

#-----------------------------------------------------------------------------------------------------------------

#Loading data into Global Environment 
item_categories <- read.csv("competitive-data-science-predict-future-sales/item_categories.csv")
View(item_categories)

items <- read.csv("competitive-data-science-predict-future-sales/items.csv")
View(items)

sales_data <- read.csv("competitive-data-science-predict-future-sales/sales_train.csv")
View(sales_data)

sample_submission <- read.csv("competitive-data-science-predict-future-sales/sample_submission.csv")
View(sample_submission)

shops <- read.csv("competitive-data-science-predict-future-sales/shops.csv")
View(shops)

test <- read.csv("competitive-data-science-predict-future-sales/test.csv")
View(test)

#-----------------------------------------------------------------------------------------------------------------

# Data Cleaning and Understanding 

str(sales_data) #it returns the datatype and few values from that dataset.

head(sales_data)
tail(sales_data)

summary(sales_data) #Returns the statistical analysis of Data. 

#-----------------------------------------------------------------------------------------------------------------

#Check for Null values 

sum(is.na(sales_data))
sum(is.na(item_categories))
sum(is.na(items))
sum(is.na(sample_submission))
sum(is.na(shops))

#Handling Missing values ( in case available: )
### na.omit() & is.na() removes missing values from dataset. 

### To convert data types : as.numeric(), as.character()

#-----------------------------------------------------------------------------------------------------------------
#Data Manipulation 
item_cnt_days <- abs(sales_data) 
item_cnt_days[2935849]

sales_data$item_price <- abs(sales_data$item_price) 

dates_as_date <- as.Date(date_month, format = "%d.%m.%Y")
months <- format(dates_as_date, format = "%m")

#-----------------------------------------------------------------------------------------------------------------
#Summary Statistics 
mode <- function(x) {
  ux <- unique(x)
  ux[which.max(tabulate(match(x, ux)))]
}

mode(sales_data$item_price)
mode(item_cnt_days)
#-----------------------------------------------------------------------------------------------------------------
#Outlier Analysis 
Q1 <- quantile(sales_data$item_price,0.25)
Q3 <- quantile(sales_data$item_price,0.75)

IQR <- Q3 - Q1

Outliers <- sales_data[sales_data$item_price < Q1 - 1.5*IQR | sales_data$item_price > Q3 + 1.5*IQR,]

cleaned_sales_data <- sales_data[!sales_data$item_price %in% Outliers$item_price,]
#------------------------------------------------------------------------------------------------------------------
#Data Visualizations

ggplot(cleaned_sales_data, aes(x=item_price)) + geom_histogram(binwidth = 75,color = "black", fill = "lightblue" ) + 
  labs(title = "Histogram of Sales",x="Item Price",y="Frequency")

ggplot(cleaned_sales_data, aes(x = factor(item_price), y = item_cnt_day)) + 
  geom_boxplot() + 
  labs(title = "Boxplot of Item Distribution",x="Items Price",y="No.of Items Sold")

#------------------------------------------------------------------------------------------------------------------
