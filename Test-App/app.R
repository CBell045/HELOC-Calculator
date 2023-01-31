library(shiny)
library(shinyWidgets)
library(DT)
source("./HELOC.R")

# UI
ui <- navbarPage("HELOC vs. Mortgage Calculator",
                 tabPanel("Calculator",
                          sidebarLayout(
                            sidebarPanel(width = 2, 
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
                                                 fluidRow(
                                                   column(width = 6, DT::dataTableOutput("mortgage_table")),
                                                   column(width = 6, DT::dataTableOutput("HELOC_table"))
                                                 )
                                              
                                                 ),
                                        tabPanel("Graph View"))
                                      
                          )
                 )),
                 tabPanel("About",
                            mainPanel(img(src = "HELOC-vs-mortgage.png", style = "width: 100%"),
                                      h3("What is a HELOC?"),
                                      p("A Heloc is simply a lending product with typically a variable interest rate and a mid-length term (approx. 10 yrs), secured by the equity in a home.
Traditionally, Helocs are employed in the second lien position, for purposes of accessing additional equity in a home, above and beyond what is borrowed for a mortgage.", style = "font-size:20px;"),
                                      h3("HELOC vs. Mortgage"),
                                      p("For our purposes, we teach a strategy using a HELOC in the first lien position, and essentially replace a traditional mortgage. By implementing the strategy and utilizing a very specific HELOC product, we help people payoff a residential loan in 5-7 years, without changing their budget at all!", style = "font-size:20px;"),
                                      h3("What is Prevail? "),
                                      p("Prevail LLC. helps to educate clients about the potential benefits of HELOC's and their place in a successful financial plan. Contact to see how you can break the mold of traditional financial planning and Prevail!", style = "font-size:20px;"),
                                      a("Schedule an appointment!", href = "https://calendly.com/tsbell004", style = "font-size:18px;")
                                      
                            )
                          ),
                 tabPanel("Prevail",
                            mainPanel(
                              img(src = "Prevail-Logo-White.png", style = "width: 100%"),
                              h3("The traditional method of preparing for retirement is broken. "),
                              p("Putting away a little money into a volitile stock market or 401k just isn't going to cut it. You need a reliable way to both save for retirement and enjoy the present. You need to Prevail.", style = "font-size:18px;"),
                              h3("We're not in the sales business; we're in the solutions business. "),
                              p("Prevail helps clients to realize the potential of their funds and use out-of-the-box thinking to get their money working for them. Contact us today to see how you can break the mold of traditional financial planning and Prevail!", style = "font-size:18px;"),
                              h3("Interested in Learning More?"),
                              p("Schedule your free financial consultation today. Learn about HELOC's and how you can leverage the equity in your home. ", style = "font-size:18px;"),
                              a("Schedule an appointment!", href = "https://calendly.com/tsbell004", style = "font-size:18px;"))
                          )
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
      formatCurrency(columns = 2:6)})
}

# Run app
shinyApp(ui = ui, server = server)



# TODO
# Change date format to mm/dd/yyyy
# Add accumulated interest and principal columns
# Refactor HELOC Calc
# - add exit statement if it is over 40 years, with an error message to the client. 
# - create a monthly display table that sums the monthly amounts