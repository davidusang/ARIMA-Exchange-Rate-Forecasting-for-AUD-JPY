# ARIMA Exchange Rate Forecasting for AUD/JPY

This repository contains an R script that demonstrates how to use the ARIMA (AutoRegressive Integrated Moving Average) model for time series forecasting of the AUD/JPY (Australian Dollar to Japanese Yen) exchange rate. The ARIMA model is widely used for time series analysis and forecasting, and it can help predict future values based on historical data patterns. This Readme file provides an overview of the script and explains the steps involved in the forecasting process.

## Table of Contents

- [Dependencies](#dependencies)
- [Usage](#usage)
- [Results](#results)
- [License](#license)

## Dependencies

To run the script, you need to have the following R packages installed:

- forecast
- quantmod
- ggplot2
- dplyr
- tseries

You can install these packages using the `install.packages()` function in R.

## Usage

  1 Clone the repository or download the script file.

  2 Open the R environment or an R script editor.

  3 Install the required packages if they are not already installed:

  install.packages(c("forecast", "quantmod", "ggplot2", "dplyr", "tseries"))

## Results

The script provides the following functionality:

    Retrieving historical data for the AUD/JPY exchange rate from Yahoo Finance.
    Preprocessing the data and handling missing values using last observation carried forward (LOCF).
    Decomposition of the time series into trend, seasonal, and random components.
    Checking for stationarity using the Augmented Dickey-Fuller (ADF) test.
    Identifying potential autoregressive (AR) and moving average (MA) terms using the autocorrelation function (ACF) and partial autocorrelation function (PACF) plots.
    Automatically selecting the best ARIMA model using the auto.arima() function.
    Forecasting the next 300 periods using the selected ARIMA model.
    Visualizing the forecasted data along with the original series and confidence interval using ggplot2.
    Plotting a histogram of the residuals to assess the model fit.

Execute the code step by step or run the entire script:

    The script uses the quantmod package to fetch historical data for the AUD/JPY exchange rate from Yahoo Finance.

    The data is preprocessed and missing values are handled using the na.locf() function.

    Descriptive analysis is performed on the time series data, including decomposition into trend, seasonal, and random components.

    The data is prepared and an ARIMA model is fitted to the data using the auto.arima() function.

    Forecasts are generated using the forecast() function.

    The model estimates and forecasted values are visualized using ggplot2.

    A histogram of the residuals is plotted to assess the model fit.

The script produces various plots and outputs to help analyze and understand the AUD/JPY exchange rate time series data.

## License

This script is released under the MIT License.

Feel free to copy the entire content and use it as a README file in your GitHub repository.
