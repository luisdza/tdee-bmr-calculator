library(shiny)
library(bslib)

# Define the UI theme
my_theme <- bs_theme(
  version = 5,
  bootswatch = "minty",
  primary = "#007bff",
  secondary = "#6c757d"
)

ui <- fluidPage(
  theme = my_theme,
  titlePanel("Energy Expenditure Calculator"),
  
  sidebarLayout(
    sidebarPanel(
      h4("Input Data"),
      numericInput("weight", "Weight (kg):", value = 70, min = 30, max = 200),
      numericInput("height", "Height (cm):", value = 170, min = 100, max = 250),
      numericInput("age", "Age (years):", value = 30, min = 10, max = 100),
      selectInput("gender", "Gender:", choices = c("Male", "Female")),
      selectInput("activity", "Activity Level:",
                  choices = list("Sedentary (no exercise)" = 1.2, 
                                  "Light activity (1-2x/week)" = 1.375, 
                                  "Moderate activity (3-4x/week)" = 1.55, 
                                  "High activity (4-5x/week)" = 1.725, 
                                  "Very high activity (6-7x/week or physical job)" = 1.9,
                                  "Athlete (10+ hours/week)" = 2.0)),
      actionButton("calculate", "Calculate", class = "btn-primary")
    ),
    
    mainPanel(
      h4("Results"),
      fluidRow(
        column(6,
               tags$div(style = "padding: 15px; border: 1px solid #ddd; border-radius: 5px; margin-top: 20px;",
                 h4("Average"),
                 tags$b("Total Daily Energy Expenditure (TDEE):"),
                 verbatimTextOutput("average_tdee"),
                 tags$b("Basal Metabolic Rate (BMR):"),
                 verbatimTextOutput("average_bmr")
               )
        ),
        column(6,
               tags$div(style = "padding: 15px; border: 1px solid #ddd; border-radius: 5px; margin-top: 20px;",
                 h4("Macros"),
                 tags$b("Protein"), verbatimTextOutput("protein"), span("28%"),
                 br(),
                 tags$b("Fat"), verbatimTextOutput("fat"), span("14%"),
                 br(),
                 tags$b("Carbs"), verbatimTextOutput("carbs"), span("57%")
               )
        )
      ),
      br(),
      fluidRow(
        column(6, 
               tags$div(style = "padding: 15px; border: 1px solid #ddd; border-radius: 5px; margin-top: 20px;",
                 h4("Harris-Benedict Formula"),
                 tags$b("TDEE:"), verbatimTextOutput("hb_tdee"),
                 br(),
                 tags$b("BMR:"), verbatimTextOutput("hb_bmr")
               )
        ),
        column(6, 
               tags$div(style = "padding: 15px; border: 1px solid #ddd; border-radius: 5px; margin-top: 20px;",
                 h4("Roza Shizgal Formula"),
                 tags$b("TDEE:"), verbatimTextOutput("rs_tdee"),
                 br(),
                 tags$b("BMR:"), verbatimTextOutput("rs_bmr")
               )
        )
      ),
      fluidRow(
        column(6, 
               tags$div(style = "padding: 15px; border: 1px solid #ddd; border-radius: 5px; margin-top: 20px;",
                 h4("Mifflin-St Jeor Formula"),
                 tags$b("TDEE:"), verbatimTextOutput("msj_tdee"),
                 br(),
                 tags$b("BMR:"), verbatimTextOutput("msj_bmr")
               )
        ),
        column(6, 
               tags$div(style = "padding: 15px; border: 1px solid #ddd; border-radius: 5px; margin-top: 20px;",
                 h4("Katch-McArdle Formula"),
                 tags$b("TDEE:"), verbatimTextOutput("kma_tdee"),
                 br(),
                 tags$b("BMR:"), verbatimTextOutput("kma_bmr")
               )
        )
      ),
      fluidRow(
        column(12, 
               tags$div(style = "padding: 15px; border: 1px solid #ddd; border-radius: 5px; margin-top: 20px;",
                 h4("Cunningham Formula"),
                 tags$b("TDEE:"), verbatimTextOutput("cunningham_tdee"),
                 br(),
                 tags$b("BMR:"), verbatimTextOutput("cunningham_bmr")
               )
        )
      )
    )
  )
)

server <- function(input, output) {
  observeEvent(input$calculate, {
    # Ensure all input values are available and numeric
    req(input$weight, input$height, input$age, input$activity)

    weight <- as.numeric(input$weight)
    height <- as.numeric(input$height)
    age <- as.numeric(input$age)
    gender <- input$gender
    activity <- as.numeric(input$activity)

    # Check for NULL or non-numeric values
    if (is.na(weight) || is.na(height) || is.na(age) || is.na(activity)) {
      return()  # Do nothing if any value is missing or not numeric
    }

    # Example calculation for BMR and TDEE using Harris-Benedict formula
    if (gender == "Male") {
      bmr_hb <- 88.362 + (13.397 * weight) + (4.799 * height) - (5.677 * age)
    } else {
      bmr_hb <- 447.593 + (9.247 * weight) + (3.098 * height) - (4.330 * age)
    }
    tdee_hb <- bmr_hb * activity

    # Outputting values
    output$hb_bmr <- renderText({ round(bmr_hb, 2) })
    output$hb_tdee <- renderText({ round(tdee_hb, 2) })

    # Placeholder values for other formulas (implement as needed)
    output$rs_bmr <- renderText({ round(bmr_hb * 0.98, 2) })
    output$rs_tdee <- renderText({ round(tdee_hb * 0.98, 2) })
    output$msj_bmr <- renderText({ round(bmr_hb * 0.95, 2) })
    output$msj_tdee <- renderText({ round(tdee_hb * 0.95, 2) })
    output$kma_bmr <- renderText({ round(bmr_hb * 1.02, 2) })
    output$kma_tdee <- renderText({ round(tdee_hb * 1.02, 2) })
    output$cunningham_bmr <- renderText({ round(bmr_hb * 1.05, 2) })
    output$cunningham_tdee <- renderText({ round(tdee_hb * 1.05, 2) })

    # Average values
    output$average_bmr <- renderText({ round(mean(c(bmr_hb, bmr_hb * 0.98, bmr_hb * 0.95, bmr_hb * 1.02, bmr_hb * 1.05)), 2) })
    output$average_tdee <- renderText({ round(mean(c(tdee_hb, tdee_hb * 0.98, tdee_hb * 0.95, tdee_hb * 1.02, tdee_hb * 1.05)), 2) })

    # Macros calculation (example based on average TDEE)
    average_tdee <- mean(c(tdee_hb, tdee_hb * 0.98, tdee_hb * 0.95, tdee_hb * 1.02, tdee_hb * 1.05))
    output$protein <- renderText({ round(average_tdee * 0.28 / 4, 2) })
    output$fat <- renderText({ round(average_tdee * 0.14 / 9, 2) })
    output$carbs <- renderText({ round(average_tdee * 0.57 / 4, 2) })
  })
}

shinyApp(ui = ui, server = server)
