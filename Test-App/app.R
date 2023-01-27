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
                                                 DT::dataTableOutput("mortgage_table")
                                                 ),
                                        tabPanel("Graph View"))
                                      
                          )
                 )),
                 tabPanel("About"),
                 tabPanel("Contact")
)

# Server
server <- function(input, output) {
  # output$mortgage_table <- renderTable({paste("Loan Balance: ", input$loan_balance)})
  output$mortgage_table <- DT::renderDataTable({mortgage(loan_amount = input$loan_balance, APR = input$interest_rate)})
}

# Run app
shinyApp(ui = ui, server = server)



# TODO

