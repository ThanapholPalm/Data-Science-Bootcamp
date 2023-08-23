library(readxl)
library(caret)
library(dplyr)

rmse_metric <- function(actual, prediction) {
  sq_error <- (actual - prediction) **2
  mean(sq_error)
  sqrt(mean(sq_error)) ## why we need this one bc we **2 error we 'd like to return normal
}

train_test_split <- function(data, trainRatio=0.7){
  set.seed(42)
  (n <- nrow(data))
  #if u put syntax () on informed data it will show on console
  (id <- sample(1:n, size=trainRatio*n))
  train_data <- data[id, ]
  test_data <- data[-id, ]
  return( list(train=train_data, test=test_data))
}

#0. Data Manipullation 
HID <- read_excel("House Price India.xlsx")


#1 . Split data

splitdata <- train_test_split(HID,0.7)
train_data <- splitdata[[1]]
test_data <- splitdata[[2]]

#1.1 Normalized data 
train_data$Price_log <- log(train_data$Price)
test_data$Price_log<- log(test_data$Price)


#2. Train Model

set.seed(42)
ctrl <- trainControl(
  method = "cv",
  number =5
)

knn_model <- train(Price_log ~ `Distance from the airport` + 
                          `Number of schools nearby` + 
                           lot_area_renov + 
                    `condition of the house`+
                    `number of bedrooms` +
                    `number of bathrooms` +
                     living_area_renov +
                     `Area of the house(excluding basement)` +
                     `Area of the basement`,
          data = train_data,
          method = "knn",
          trControl = ctrl)

#3. score model

priced_prediction <- predict(knn_model, newdata = test_data)

#4. evalute Model

rmse_evaluate <- rmse_metric(test_data$Price_log,priced_prediction)

#5. Save Model
