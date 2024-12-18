
# Chargement des packages nécessaires -------------------------------------
library(shiny)
library(shinydashboard)
library(tidyverse)
library(bslib)
library(DT)
library(shinyjs)
library(fmsb)
library(scales)

# Source le module
source("R/slide_module.R")

#read csv
library(readr)
pokeData <- read_csv("Pokemon.csv")
pokeData <- pokeData %>% mutate(`Type 2` = replace_na(`Type 2`, "None"))


# Definition de l'UI ------------------------------------------------------

ui <- dashboardPage(
  skin = "yellow",
  
  # En-tête du dashboard
  dashboardHeader(
    title = "Human Talks"
  ),
  

## Definition de la Sidebar ------------------------------------------------

  dashboardSidebar(
    sidebarMenu(
      id = "sidebar",
      menuItem("Présentation", tabName = "presentation", icon = icon("file-powerpoint")),
      

### Définition du menu de l'Exemple Pokemon ---------------------------------

      h4("Exemple"),
      # Onglet Exemple avec des sous-items
      menuItem("Filtrage & Tableau", tabName = "filter_table", icon = icon("filter")),
      menuItem("Visualisation", tabName = "visualization", icon = icon("chart-bar")),
      menuItem("Comparaison", tabName = "comparison", icon = icon("columns"))
    )
  ),
  
## Definition du corps de l'application  ------------------------------------------------
  dashboardBody(
    tabItems(
      # Onglet Présentation
      tabItem(
        tabName = "presentation",
        slideModuleUI("presentation")  # Module de présentation existant
      ),
      

### Définition des pages de l'Exemple Pokemon -------------------------------

#### Sous-onglet Filtrage & Tableau -------------------------------------------------
      tabItem(
        tabName = "filter_table",
        fluidRow(
          box(
            title = "Filtres",
            width = 4,
            selectInput("type1", "Select Type 1:", 
                        choices = c("All","None",setdiff(unique(pokeData$`Type 1`), "None"))),
            selectInput("type2", "Select Type 2:", 
                        choices = c("All","None",setdiff(unique(pokeData$`Type 2`), "None"))),
            checkboxInput("legendary", "Include Legendary Pokémon", TRUE),
            sliderInput("total", "Total Stats Range:", 
                        min = min(pokeData$Total), 
                        max = max(pokeData$Total), 
                        value = c(min(pokeData$Total), max(pokeData$Total))),
          ),
          box(
            title = "Tableau",
            width = 8,
            dataTableOutput("pokeTable")
          )
        )
      ),
      
##### Sous-onglet Visualisation -------------------------------------------------
      tabItem(
        tabName = "visualization",
        fluidRow(
          box(
            title = "Graphique",
            width = 12,
            plotOutput("statsPlot")
          )
        )
      ),
      
##### Sous-onglet Comparaison -------------------------------------------------
      tabItem(
        tabName = "comparison",
        fluidRow(
          box(
            title = "Sélection des Pokémon",
            width = 4,
            selectInput("comparePokemon1", "Sélectionner le premier Pokémon:",
                        choices = pokeData$Name, selected = pokeData$Name[1]),
            selectInput("comparePokemon2", "Sélectionner le deuxième Pokémon:",
                        choices = pokeData$Name, selected = pokeData$Name[2])
          ),
            plotOutput("radarPlot")
        )
      )
    )
  )
)



# Definition de la Parie Server ------------------------------------------------

server <- function(input, output, session) {
  slideModule("presentation")
  #output$poketable <- renderDataTable(pokeData)

## Definition de la partie Server pour les "calculs" de l'exemple Pokemon ------------------------------------------------  
  
### Filtrage du dataset -------------------------------------------------
  filteredData <- reactive({
    data <- pokeData
    if (input$type1 != "All") {
      data <- subset(data, `Type 1` == input$type1)
    }
    if (input$type2 != "All") {
      data <- subset(data, `Type 2` == input$type2)
    }
    if (!input$legendary) {
      data <- subset(data, Legendary == FALSE)
    }
    data <- subset(data, Total >= input$total[1] & Total <= input$total[2])
    data
  })
  
### Affichage du tableau -------------------------------------------------
  output$pokeTable <- renderDataTable({
    datatable(filteredData(),
              options = list(pageLength = 10, scrollX = TRUE))
  })
  
### Graphique : Distribution des Totals -------------------------------------------------
  output$statsPlot <- renderPlot({
    hist(filteredData()$Total,
         breaks = 20, col = "steelblue", border = "white",
         main = "Distribution des Totals",
         xlab = "Total",
         ylab = "Fréquence")
  })
  
### Graphique Comparaison : RadarPlot -------------------------------------------------
  output$radarPlot <- renderPlot({
    selected <- c(input$comparePokemon1, input$comparePokemon2)  # Sélectionner les deux Pokémon
    
    # Vérifier que deux Pokémon sont sélectionnés
    if (length(selected) == 2) {
      # Filtrer les données des Pokémon sélectionnés
      compareData <- pokeData[pokeData$Name %in% selected, c("Name", "HP", "Attack", "Defense", "Sp. Atk", "Sp. Def", "Speed")]
      
      # Vérification : Les données doivent contenir deux lignes
      if (nrow(compareData) != 2) {
        showNotification("Erreur : les Pokémon sélectionnés n'ont pas été trouvés.", type = "error")
        return(NULL)
      }
      
      # Nommer les lignes par les noms des Pokémon
      rownames(compareData) <- compareData$Name
      compareData <- compareData[, -1]  # Supprimer la colonne 'Name'

      # Normalisation des données pour le radar
      maxStats <- rep(255,ncol(compareData))  # Plage max fixe
      minStats <- rep(1,ncol(compareData))    # Plage min fixe
      
      # Vérification : maxStats et minStats ne doivent pas être égaux à zéro
      if (any(maxStats == 0) || any(minStats == 0)) {
        showNotification("Erreur : Problème dans la normalisation des données.", type = "error")
        return(NULL)
      }
      
      radarData <- rbind(maxStats, minStats, compareData)
      
      # Graphique radar
      radarchart(
        radarData,
        axistype = 1,
        pcol = rainbow(nrow(compareData)),
        pfcol = alpha(rainbow(nrow(compareData)), 0.5),
        plwd = 2,
        cglcol = "grey", cglty = 1,
        axislabcol = "black",
        caxislabels = seq(0, 255, by = 51),  # L'échelle de 0 à 255
        cglwd = 1,  # Opacité des lignes de l'axe
        vlcex = 1.5  # Taille des labels des variables
      )
      
      # Légende avec les noms des Pokémon
      legend(
        "topright", legend = selected,
        col = rainbow(nrow(compareData)), lty = 1, lwd = 2, bty = "n"
      )
    } else {
      showNotification("Veuillez sélectionner deux Pokémon pour la comparaison.", type = "warning")
    }
  }, height = 700, width = 700)  # Ajuster la taille du plot
}


# Combinaison UI + Server -------------------------------------------------

# Création de l'application
shinyApp(ui = ui, server = server)
