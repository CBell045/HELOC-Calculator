library(shiny)
library(shinyWidgets)
library(DT)
source("./HELOC.R")

# UI
ui <- navbarPage("HELOC vs. Mortgage Calculator",
                 tabPanel("Calculator",
                          sidebarLayout(
                            sidebarPanel(
                              h3("Loan Details"),
                              # Loan Balance Input
                              currencyInput("loan_balance", 
                                            h4("Loan Balance"), 
                                            format = "dollar", 
                                            value = 350000, 
                                            align = "left"),
                              # Interest Rate Input
                              formatNumericInput("interest_rate", 
                                                 h4("Interest Rate"), 
                                                 format = "percentageUS2dec", 
                                                 value = .06, 
                                                 align = "left"),
                              # Monthly Income Input
                              currencyInput("income", 
                                           h4("Monthly Income"), 
                                           format = "dollar",
                                           value = 5000, 
                                           align = "left"),
                              # Monthly Expenses Input
                              currencyInput("expenses", 
                                           h4("Monthly Expenses"), 
                                           format = "dollar",
                                           value = 2000, 
                                           align = "left"),
                              # Start Date Input
                              dateInput("start_date", 
                                        h4("Start Date"), 
                                        value = Sys.Date())
                              ),
                            
                            
                            mainPanel(h3("Pay-off Schedule"),
                                      tabsetPanel(
                                        tabPanel("Table View", 
                                                 DT::dataTableOutput("mortgage_table"),
                                                 DT::dataTableOutput("HELOC_table")
                                                 ),
                                        tabPanel("Graph View"))
                                      
                          )
                 )),
                 tabPanel("About"),
                 tabPanel("Contact")
)

server <- function(input, output) {
  
  options(DT.options = list(
    lengthMenu = list(c(-1, 5, 10, 15, 30), c('All', '5', '10', '15', '30')),
    pageLength = -1))
  
  output$mortgage_table <- DT::renderDataTable({
    mortgage(loan_amount = input$loan_balance, rate = input$interest_rate, start_date = input$start_date) %>%
      datatable() %>% 
      formatCurrency(columns = 2:5)})
  
  output$HELOC_table <- DT::renderDataTable({
    HELOC(loan_amount = input$loan_balance, rate = input$interest_rate, start_date = input$start_date, income = input$income, expenses = input$expenses) %>%
      datatable() %>%
      formatCurrency(columns = 2:5)})
}

# Run app
shinyApp(ui = ui, server = server)



# TODO
# Change date format to mm/dd/yyyy
# Refactor HELOC Calc
# - add exit statement if it takes too long, with an error message to the client. 