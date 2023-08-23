from os import XATTR_SIZE_MAX
## ML 

from sklearn.linear_model import LinearRegression
from sklearn.neighbors import KNeighborsRegressor
from sklearn.ensemble import RandomForestRegressor
from sklearn.model_selection import train_test_split
from sklearn.metrics import mean_squared_error
import pandas as pd

mtcars = pd.read_csv("https://gist.githubusercontent.com/seankross/a412dfbd88b3db70b74b/raw/5f23f993cd87c283ce766e7ac6b329ee7cc2e1d1/mtcars.csv")

# mpg <- predicted by utilized hp / wt / am 

X = mtcars[["hp", "wt", "am"]]
y = mtcars["mpg"]

# train_test_split
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# train model
model_lm = LinearRegression().fit(X_train, y_train)
model_knn = KNeighborsRegressor().fit(X_train, y_train)
model_rf = RandomForestRegressor().fit(X_train, y_train)

# test model/scoring
pred_lm = model_lm.predict(X_test)

pred_knn = model_dt.predict(X_test)

pred_rf = model_rf.predict(X_test)

# evaluate model

# test rmse
lm_test_rmse = mean_squared_error(pred_lm, y_test, squared=False)

dt_test_rmse = mean_squared_error(pred_knn, y_test, squared=False)

rf_test_rmse = mean_squared_error(pred_rf, y_test, squared=False)

# train rmse
lm_train_rmse = mean_squared_error(model_lm.predict(X_train), y_train, squared=False)

dt_train_rmse = mean_squared_error(model_knn.predict(X_train), y_train , squared=False)

rf_train_rmse = mean_squared_error(model_rf.predict(X_train),y_train , squared=False)

print(f"train rmse: lm {lm_train_rmse}, knn {dt_train_rmse}, rf {rf_train_rmse}")
print(f"test rmse: lm {lm_test_rmse}, knn {dt_test_rmse}, rf {rf_test_rmse}")


