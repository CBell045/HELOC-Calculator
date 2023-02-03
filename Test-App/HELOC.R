# R Mortgage and HELOC Calculators
# Author: Chad Bell
# Date: 1/12/23
# Purpose: The purpose of these functions are to compare using a HELOC vs. a traditional mortgage to pay off your home. 

# Import Libraries
library(tidyverse)
library(lubridate)

#---------- Mortgage Calculator ----------
mortgage = function(loan_amount = 100000, principal = 0, rate = .05, years = 30, start_date = today()) {
  # Total Number of payments
  payments = years * 12
  # Outstanding principal of loan
  outstanding_principal = loan_amount - principal
  # Monthly rate (convert rate to percentage and divide by 12)
  monthly_rate = rate / 12
  # Monthly payment
  payment = (loan_amount * monthly_rate) /
    (1 - (1 + monthly_rate) ^ (-payments))
  # Create a vector of payment numbers
  payment_numbers = 1:payments
  # Pre-allocate the amortization schedule matrix
  amort_table = matrix(nrow = payments, ncol = 7)
  colnames(amort_table) <- c("Date", "Payment", "Principal", "Interest", "Balance", "Total Interest", "Total Cost")
  # Calculate the date for each payment using vectorized operations
  dates = start_date + months(payment_numbers - 1, abbreviate = FALSE)
  total_paid = payment * payment_numbers
  # Fill in the amortization table
  amort_table[, 1] <- dates
  amort_table[, 2] <- payment
  amort_table[, 7] <- total_paid
  for (i in 1:payments) {
    amort_table[i, 4] <- outstanding_principal * monthly_rate
    amort_table[i, 3] <- payment - amort_table[i, 4]
    outstanding_principal <- outstanding_principal - amort_table[i, 3]
    amort_table[i, 5] <- outstanding_principal
  }
  # Calculates the cumulative sum of interest
  amort_table[, 6] <- cumsum(amort_table[, 4])
  # Return data frame
  to_return <- data.frame(amort_table)
  class(to_return$Date) <- "Date"
  return(to_return)
}

#---------- End of Mortgage Calculator ----------


#---------- HELOC Calculator ----------
HELOC = function(loan_amount = 100000, principal = 0, rate = .05, income = 5000, expenses = 2000, start_date = today(), interest_pay_day = 1, income_pay_day = 1, expenses_pay_day = 1) {
  # Outstanding principal of loan 
  outstanding_principal = loan_amount - principal
  # Monthly rate (convert rate to percentage and divide by 12)
  daily_rate = rate / 365.25

  # Create a data frame for the HELOC schedule
  HELOC_table <- data.frame("date" = 0,
                            "income" = 0,
                            "expenses" = 0,
                            "daily_interest" = 0,
                            "monthly_interest" = 0,
                            "balance" = 0)
  # Counter variables
  i = 1
  last_interest_pay_day = 1
  
  # Run until the loan has been paid off
  while (outstanding_principal >= 0) {
    # Calculate the current date and day of the month
    curr_date = start_date + days(i-1)
    curr_day = day(curr_date)
  
    # Calculate daily amounts and interest
    daily_income = ifelse(curr_day == income_pay_day, income, 0)
    daily_expenses = ifelse(curr_day == expenses_pay_day, expenses, 0)
    outstanding_principal = outstanding_principal - daily_income + daily_expenses
    daily_interest = outstanding_principal * daily_rate
    
    # If the current day is the interest pay day, sum monthly interest and add to loan. 
    if (curr_day == interest_pay_day) {
      monthly_interest = sum(HELOC_table$daily_interest[last_interest_pay_day:i - 1])
      last_interest_pay_day = i
      outstanding_principal = outstanding_principal + monthly_interest
    }
    else {
      monthly_interest = 0
    }
    # Add the current day to the table
    HELOC_table[i,] <- c(curr_date, daily_income, daily_expenses, daily_interest, monthly_interest, outstanding_principal)
    i = i + 1
  }
  # Format date column correctly
  class(HELOC_table$date) <- "Date"
  
  # View tables
  # View(HELOC_table)
  return(filter(HELOC_table, day(HELOC_table$date) == 1))
}

# Test values
# mortgage(loan_amount = 200000, rate = 4.5, years = 10)
# HELOC(loan_amount = 350000, principal = 0, rate = .06, income = 50000)


# Thoughts:
# Keep a running total of interest vs principal. 
# Re-factor the code? You probably don't need a daily table. Make a better monthly table. That should speed it up. Use aggregate? 
# Add the other options to the calculator