library(shiny)
library(bslib)
library(shinyjs)

# Source le module
source("R/slide_module.R")

# Chargement des packages nécessaires
library(shinydashboard)

# UI principal
ui <- dashboardPage(
  skin = "yellow",
  
  # En-tête du dashboard
  dashboardHeader(
    title = "Human Talks"
  ),
  
  # Barre latérale avec menu
  dashboardSidebar(
    sidebarMenu(
      id = "sidebar",
      menuItem("Présentation", tabName = "presentation", icon = icon("file-powerpoint")),
      menuItem("Exemple", tabName = "exemple", icon = icon("th"))
     
    )
  ),
  
  # Corps du dashboard
  dashboardBody(
    tabItems(
      # Onglet Présentation
      tabItem(
        tabName = "presentation",
        slideModuleUI("presentation")
      ),
      
      # Onglet Exemple
      tabItem(
        tabName = "exemple",
        box(
          title = "Exemple de contenu",
          width = 12,
          "Contenu de l'exemple à venir"
        )
      )
    )
  )
)

# Server principal
server <- function(input, output, session) {
  slideModule("presentation")
}

# Création de l'application
shinyApp(ui = ui, server = server)
