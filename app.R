library(shiny)
library(MASS)
library(plotly)

source('https://raw.githubusercontent.com/ale-ch/binorm_plot/main/plot_binorm.R')


ui <- fluidPage(

    titlePanel("Bivariate Normal Distribution"),
    
    sidebarLayout(
        sidebarPanel(
            fluidRow(
                column(6, 
                       sliderInput("rho", "Correlation coefficient:", value = 0, 
                                   min = -1, max = 1, step = 0.01)
                ),
                
                column(6,
                       sliderInput("n", "Sample size:", value = 1000, 
                                   min = 100, max = 50000)
                )
            ),
            
            fluidRow(
                
                column(6,
                       sliderInput("var_x", "Variance of X variable:", value = 1, 
                                   min = 0.1, max = 1000, step = 0.1)
                ),
                
                column(6, 
                       sliderInput("var_y", "Variance of Y variable:", value = 1, 
                                   min = 0.1, max = 1000, step = 0.1)
                )
            ),
            
            fluidRow(
                
                column(6, 
                       sliderInput("mu_x", "Mean of X variable:", value = 0, 
                                   min = 0, max = 1000, step = 0.1)
                ),
                column(6, 
                       sliderInput("mu_y", "Mean of Y variable:", value = 0, 
                                   min = 0, max = 1000, step = 0.1)
                )
            )
        ),
        
        mainPanel = 
            mainPanel(
                plotlyOutput("plot1", width = "100%", height = "100%"),
                plotlyOutput("plot2", width = "100%", height = "100%")
            )
            
    )
    
)

server <- function(input, output, session) {
    
    output$plot1 <- renderPlotly({
        
        Sigma <- make_Sigma(input$var_x, input$var_y, input$rho)
        mu <- c(input$mu_x, input$mu_y)
        
        plot_binorm(n = input$n, mu, Sigma)[[1]]
    })
    
    output$plot2 <- renderPlotly({
        
        Sigma <- make_Sigma(input$var_x, input$var_y, input$rho)
        mu <- c(input$mu_x, input$mu_y)
        
        plot_binorm(n = input$n, mu, Sigma)[[2]]
    })
    
}

shinyApp(ui = ui, server = server)
