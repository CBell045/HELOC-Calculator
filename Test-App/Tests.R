start_time <- Sys.time()

HELOC = function(loan_amount = 100000, principal = 0, rate = .05, income = 5000, expenses = 2000, start_date = today(), interest_pay_day = 1, income_pay_day = 1, expenses_pay_day = 1) {
  # Outstanding principal of loan 
  outstanding_principal = loan_amount - principal
  # Monthly rate (convert rate to percentage and divide by 12)
  daily_rate = rate / 365.25
  next_month <- start_date
  monthly_table <- matrix(0L, nrow = 360, ncol = 7)
  colnames(monthly_table) <- c("Month", "Income", "Expenses", "Interest", "Balance", "Total Interest", "Total Cost")
  month_count = 1
  

  # While loan is outstanding
  while (outstanding_principal > 0) {
  num_days_in_month <- days_in_month(next_month)[[1]]
  
  daily_table <- matrix(0L, nrow = num_days_in_month, ncol = 4)
  colnames(daily_table) <- c("Income", "Expenses", "Interest", "Balance")
  daily_table[income_pay_day,1] <- income
  daily_table[expenses_pay_day,2] <- expenses
  daily_table[1, 4] <- outstanding_principal
  # return(daily_table)
  for (row in 1:num_days_in_month) {
    daily_table[row,4][[1]] <- daily_table[row,4][[1]] + daily_table[row,2][[1]] - daily_table[row,1][[1]]
    daily_table[row,3][[1]] <- daily_table[row,4][[1]] * daily_rate
  }
  
  monthly_income <- sum(daily_table[,1])
  monthly_expenses <- sum(daily_table[,2])
  monthly_interest <- sum(daily_table[,3])
  outstanding_principal <- daily_table[num_days_in_month,4][[1]] + monthly_interest
  monthly_table[month_count, ] <- c(0, monthly_income, monthly_expenses, monthly_interest, outstanding_principal, 0, 0)
  
  
  month_count = month_count + 1
  next_month = next_month + months(1, abbreviate = FALSE)
  }

  
  View(data.frame(monthly_table))
}
  # 
  # 
  # 
  # # Create a data frame for the HELOC schedule
  # HELOC_table <- data.frame("date" = 0,
  #                           "income" = 0,
  #                           "expenses" = 0,
  #                           "daily_interest" = 0,
  #                           "monthly_interest" = 0,
  #                           "balance" = 0)
  # # Counter variables
  # i = 1
  # last_interest_pay_day = 1
  # 
  # # Run until the loan has been paid off
  # while (outstanding_principal >= 0) {
  #   # Calculate the current date and day of the month
  #   curr_date = start_date + days(i - 1)
  #   curr_day = day(curr_date)
  #   
  #   # Calculate daily amounts and interest
  #   daily_income = ifelse(curr_day == income_pay_day, income, 0)
  #   daily_expenses = ifelse(curr_day == expenses_pay_day, expenses, 0)
  #   outstanding_principal = outstanding_principal - daily_income + daily_expenses
  #   daily_interest = outstanding_principal * daily_rate
  #   
  #   # If the current day is the interest pay day, sum monthly interest and add to loan. 
  #   if (curr_day == interest_pay_day) {
  #     monthly_interest = sum(HELOC_table$daily_interest[last_interest_pay_day:i - 1])
  #     last_interest_pay_day = i
  #     outstanding_principal = outstanding_principal + monthly_interest
  #   }
  #   else {
  #     monthly_interest = 0
  #   }
  #   # Add the current day to the table
  #   HELOC_table[i,] <- c(curr_date, daily_income, daily_expenses, daily_interest, monthly_interest, outstanding_principal)
  #   i = i + 1
  # }
  # # Format date column correctly
  # class(HELOC_table$date) <- "Date"
  # 
  # # View tables
  # # View(HELOC_table)
  # return(filter(HELOC_table, day(HELOC_table$date) == 1))
# }


HELOC()



end_time <- Sys.time()
print(end_time - start_time)
