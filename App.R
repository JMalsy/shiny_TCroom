library(shiny)
library(shinyWidgets)
library(shiny)
library(shinydashboard)

library(shiny)
library(shinydashboard)

ui <- dashboardPage(
  dashboardHeader(title = "Notification Pane"),
  dashboardSidebar(
    h4("Notifications"),
    textInput("new_notification", "New Notification:"),
    actionButton("add_notification", "Add"),
    br(),
    h4("Delete Notifications"),
    selectInput("delete_notification", "Select Notification to Delete:", choices = NULL),
    actionButton("delete_button", "Delete"),
    h4("Notifications:"),
    verbatimTextOutput("notification_text")
  ),
  dashboardBody(
    fluidRow(
      box(title = "Water Bath", status = "danger", solidHeader = TRUE,
          dateInput("waterbath_date", label = "Last Cleaned Date"),
          actionButton("waterbath_button", "Update")),
      box(title = "Sink", status = "warning", solidHeader = TRUE,
          dateInput("sink_date", label = "Last Cleaned Date"),
          actionButton("sink_button", "Update")),
      box(title = "Incubator", status = "success", solidHeader = TRUE,
          dateInput("incubator_date", label = "Last Cleaned Date"),
          actionButton("incubator_button", "Update")),
      box(title = "Centrifuge", status = "primary", solidHeader = TRUE,
          dateInput("centrifuge_date", label = "Last Cleaned Date"),
          actionButton("centrifuge_button", "Update"))
    )
  )
)

server <- function(input, output, session) {
  
  # Initialize notifications list
  notifications <- reactiveValues(list = c())
  
  # Add new notification
  observeEvent(input$add_notification, {
    if (nchar(input$new_notification) > 0) {
      notifications$list <- c(notifications$list, input$new_notification)
      updateSelectInput(session, "delete_notification", choices = notifications$list)
    }
  })
  
  # Delete selected notification
  observeEvent(input$delete_button, {
    notifications$list <- notifications$list[-which(notifications$list == input$delete_notification)]
    updateSelectInput(session, "delete_notification", choices = notifications$list)
  })
  
  # Update water bath date
  observeEvent(input$waterbath_button, {
    updateDateInput(session, "waterbath_date", value = Sys.Date())
  })
  
  # Update sink date
  observeEvent(input$sink_button, {
    updateDateInput(session, "sink_date", value = Sys.Date())
  })
  
  # Update incubator date
  observeEvent(input$incubator_button, {
    updateDateInput(session, "incubator_date", value = Sys.Date())
  })
  
  # Update centrifuge date
  observeEvent(input$centrifuge_button, {
    updateDateInput(session, "centrifuge_date", value = Sys.Date())
  })
  
  # Concatenate notifications into a single string
  notification_text <- reactive({
    paste(notifications$list, collapse = "\n")
  })
  
  output$notification_text <- renderText({
    notification_text()
  })
  
}

shinyApp(ui, server)



# Run the app
shinyApp(ui=ui, server=server)