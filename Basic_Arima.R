# Load the required packages
library(quantmod)    # For financial data retrieval
library(forecast)    # For time series forecasting
library(dplyr)       # For data manipulation
library(tseries)     # For time series analysis
library(ggplot2)     # For creating detailed graphs

# Retrieve exchange rate data from Yahoo Finance
getSymbols("AUDJPY=X", src = "yahoo", from = "2011-05-30", to = "2021-06-05")

# Extract the 'Close' price series from the data
df <- `AUDJPY=X`[, 4]

# Check for missing values
sum(is.na(df))

# Fill missing values using last observation carried forward (LOCF)
df <- na.locf(df, fromLast = TRUE)

# Remove any remaining NA values
df <- na.omit(df)

# Confrim missing values
sum(is.na(df))

# Convert the dataset to a time series object with daily frequency
df <- ts(df, frequency = 365)

# Perform decomposition of the time series into trend, seasonal, and random components
decomp <- decompose(df, "multiplicative")

# Plot the decomposed time series to visualize its components
plot(decomp)

# Perform Augmented Dickey-Fuller (ADF) test to check for stationarity
adf_result <- adf.test(df)
print(adf_result)

# Plot the autocorrelation function (ACF) to identify potential autoregressive (AR) terms
acf_result <- Acf(df)

# Plot the partial autocorrelation function (PACF) to identify potential moving average (MA) terms
pacf_result <- pacf(df)

# Apply the auto.arima function to automatically select the best ARIMA model
modelfit <- auto.arima(df, seasonal = FALSE, lambda = "auto")
print(modelfit)

# Forecast the next 300 periods using the selected ARIMA model
forecast_data <- forecast(modelfit, h = 300)

# Convert time series object to data frame for plotting
df_df <- data.frame(Date = as.Date(index(df)), Exchange_Rate = as.numeric(df))
forecast_df <- data.frame(Date = as.Date(index(forecast_data$mean)), Forecast = as.numeric(forecast_data$mean))
confidence_interval_df <- data.frame(Date = as.Date(index(forecast_data$mean)), Lower = as.numeric(forecast_data$lower[, 1]), Upper = as.numeric(forecast_data$upper[, 1]))

# Plot the forecasted data along with the original series and confidence interval
ggplot() +
  geom_line(data = df_df, aes(x = Date, y = Exchange_Rate), color = "blue", linetype = "solid") +
  geom_line(data = forecast_df, aes(x = Date, y = Forecast), color = "red", linetype = "dashed") +
  geom_ribbon(data = confidence_interval_df, aes(x = Date, ymin = Lower, ymax = Upper), fill = "lightblue", alpha = 0.5) +
  labs(x = "Date", y = "Exchange Rate", title = "AUD/JPY Exchange Rate Forecast") +
  theme_minimal()

# Convert residuals to data frame for plotting
residuals_df <- data.frame(Residuals = as.numeric(residuals(modelfit)))

# Plot a histogram of the residuals from the ARIMA model to assess model fit
ggplot(residuals_df) +
  geom_histogram(aes(x = Residuals), fill = "lightgray", color = "black", bins = 20) +
  labs(x = "Residuals", y = "Frequency", title = "Residuals of ARIMA Model") +
  theme_minimal()

