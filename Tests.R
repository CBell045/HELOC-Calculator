source("./HELOC.R")
start_time <- Sys.time()


mortgage(loan_amount = 1000000, principal = 0, rate = .05, years = 30, start_date = today())




end_time <- Sys.time()
print(start_time - end_time)
