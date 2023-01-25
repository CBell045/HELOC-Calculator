library(shiny)

# UI
ui <- navbarPage("HELOC vs. Mortgage Calculator",
                 tabPanel("Calculator",
                          sidebarLayout(
                            sidebarPanel(
                              h3("Loan Details"),
                              numericInput("loan_amount", h4("Loan Amount"), value = 350000, step = 10000),
                              numericInput("interest_rate", h4("Interest Rate"), value = 6.0, step = .1),
                              dateInput("start_date", h4("Start Date"), value = Sys.Date())
                              ),
                            mainPanel(h3("Pay-off Schedule"),
                                      tabsetPanel(
                                        tabPanel("Table View"),
                                        tabPanel("Graph View"))
                                      
                          )
                 )),
                 tabPanel("About"),
                 tabPanel("Contact")
)

# Server
server <- function(input, output) {

}

# Run app
shinyApp(ui = ui, server = server)



# TODO
# Research shinyWidgets

