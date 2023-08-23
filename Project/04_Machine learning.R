# Intorduce new Library MLbench rpart randomForest class glmnet 

##load library
library(caret)
library(tidyverse)
library(mlbench)
library(MLmetrics)
library(forcats)
library(rpart)
library(rpart.plot)

##see avalible data 
data()## call data set build in data

## glimpse data
df <- BostonHousing
glimpse(df)

## Classification category or clusering <= segmentation crim age lstat, medv

subset_df <- df %>%
  select(crim, rm, age, lstat, medv) %>%
  as_tibble()


## test different K (K=2-5) managine inside 
result <- kmeans(x = subset_df, centers = 3)

## membership [1,2,3]
subset_df$cluster <- result$cluster

## lm, KNN

df <- as_tibble(df)

#1. split data 

set.seed(42)
n <- nrow(df)
id <- sample(1:n, size=0.8*n)
train_data <- df[id, ]
test_data <- df[-id, ]

#2. train model Want to predict medv 
lm_model <- train(medv ~ crim + rm + age,
                   data = train_data,
                   method = "lm",
                   preProcess = c("center", "scale"))

set.seed(42)

ctrl <- trainControl(method = "cv",
                     number = 5,
                     verboseIter = TRUE)
#grid search must before train model name of column k must same as hyper parameter
k_grid <- data.frame(k = c(3,5,7,9,11))

knn_model <- train(medv ~ crim + rm + age,
                   data = train_data,
                   method = "knn",
                   metric = "Rsquared",
                   tuneGrid = k_grid,
                   preProcess = c("center", "scale"),
                   trControl = ctrl)

## which was the most suitable -> lm KNN value was diff 100 time , we should use Std-z to be same scale 
## Standardization or we call center and scale , (x-mean_x) / sd_x
## after scale KNN better 

# tune length random search 
knn_model <- train(medv ~ crim + rm + age,
                   data = train_data,
                   method = "knn",
                   metric = "Rsquared",
                   tuneLength = 5,
                   preProcess = c("center", "scale"),
                   trControl = ctrl)

#3. score

p <- predict(knn_model, newdata = test_data)

#4. evalute

RMSE(p, test_data$medv)

##----------------------------

## classification problem
data("PimaIndiansDiabetes")

df <- PimaIndiansDiabetes

df$diabetes <- fct_relevel(df$diabetes, "pos")




#1. split data 
set.seed(42)
n <- nrow(df)
id <- sample(1:n, size=0.8*n)
train_data <- df[id, ]
test_data <- df[-id, ]

#2. train model
## Knn model can do both class and regress
set.seed(42)
ctrl <- trainControl(method = "cv",
                     number = 5,
                     verboseIter = TRUE
                    )
## Class prob -> calculate pos and neg 

(knn_model <- train(diabetes ~ .,
                   data = train_data,
                   method = "knn",
                   metric = "Accuracy", # Recall
                   trControl = ctrl))

#3. score
p <- predict(knn_model,newdata = test_data)

#4. evalute 
##Default confusion matrix dnn -> Create matrix 
table(test_data$diabetes, p, dnn = c( "Actual","Prediction"))

confusionMatrix(p, test_data$diabetes, 
                positive = "pos",
                mode = "prec_recall")

#----------------------------------------------------------------------
## Logistic Regression

set.seed(42)
ctrl <- trainControl(method = "cv",
                     number = 5,
                     verboseIter = TRUE)


(logit_model <- train(diabetes ~ .,
                    data = train_data,
                    method = "glm",
                    metric = "Accuracy",
                    trControl = ctrl))

#------------------------------------------------------------
## Decision Tree ( Library rpart )

(tree_model <- train(diabetes ~ .,
                    data = train_data,
                    method = "rpart",
                    metric = "Accuracy",
                    trControl = ctrl))
## Install nore about rpart plot 
library(rpart.plot)
rpart.plot(tree_model$finalModel)
## Best point no need normalized data 
## rpart.plot can optimized color please searach in google 


# ----------------------------------------------
## Random Forest 
## Model Accuracy the highest >= 76%
## lets unleash to used all factor 
## mtry = numberof features used to train model 
## bootstrap sampling

## bagging technique 
mtry_grid <- data.frame(mtry = 2:8)

(rf_model <- train(diabetes ~ .,
                     data = train_data,
                     method = "rf",
                     metric = "Accuracy",
                   tuneGrid = mtry_grid,
                     trControl = ctrl))


# -----------------------------------------------------
## compare models

list_models <- list(knn = knn_model,
                    logistics = logit_model,
                    decisionTree = tree_model,
                    randomForest = rf_model)

result <- resamples(list_models)

summary(result)

#-------------------------------------------------
## ridge vs. lasso regression 
library(glmnet)

# 0=Ridge, 1=Lasso
glmnet_grid <- expand.grid(alpha = 0:1,
                          lambda = c(0.1, 0.2, 0.3))
## Exapnd grid จะ expand ออกมาทุก vlue 

(glmnet_model <- train(diabetes ~ .,
                   data = train_data,
                   method = "glmnet",
                   metric = "Accuracy",
                   tuneGrid = glmnet_grid,
                   trControl = ctrl))
