library(bs4Dash)
library(shiny)
library(shinyjs)

# Module UI
slideModuleUI <- function(id) {
  ns <- NS(id)
  
  tagList(
    useShinyjs(),
    
    tags$head(
      tags$style(HTML("
                      /* Styles de base pour la box et les conteneurs */
.box {
  overflow: hidden;
  position: relative;
}

#slides_container {
  height: 100%;
  overflow: hidden;
}

/* Styles des cartes */
.slide-card {
  height: calc(100vh - 200px) !important;
  min-height: 500px;
  margin-bottom: 0 !important;
  overflow: hidden;
}

.bs4Card {
  overflow: hidden;
  height: 100%;
  display: flex;
  flex-direction: column;
}

.bs4Card .card-body {
  flex: 1;
  overflow-y: auto;
  padding: 15px;
  display: flex;
  flex-direction: column;
}

.card-content {
  height: 100%;
  overflow-y: auto;
  padding: 10px;
  position: relative;
  display: flex;
  flex-direction: column;
}

/* Styles de typographie */
.presentation-title {
  font-size: 4.5rem !important;
  font-weight: bold;
  color: #2c3e50;
}

.presentation-subtitle {
  font-size: 3.8rem !important;
}

.context-list li {
  font-size: 2.5rem !important;
}

/* Styles de navigation */
.navigation-container {
  display: flex;
  justify-content: center;
  align-items: center;
  gap: 30px;
  padding: 20px;
  background: #f8f9fa;
  border-radius: 15px;
  width: fit-content;
  margin: 20px auto 0;
  position: sticky;
  bottom: 20px;
  z-index: 1000;
}

.nav-button {
  width: 50px;
  height: 50px;
  border-radius: 50%;
  font-size: 16px;
  background-color: #ffc107;
  border: none;
  box-shadow: 0 2px 5px rgba(0,0,0,0.2);
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 0;
}

.slide-counter {
  font-size: 18px;
  font-weight: 600;
  padding: 10px 25px;
  background: #fff;
  border-radius: 25px;
  box-shadow: 0 2px 5px rgba(0,0,0,0.1);
  color: #666;
}

/* Styles responsifs */
@media (max-width: 768px) {
  .slide-card {
    height: auto !important;
    min-height: 400px;
    max-height: calc(100vh - 150px);
  }

  .bs4Card {
    height: 100%;
    max-height: calc(100vh - 150px);
  }

  .card-content {
    overflow-y: auto;
    max-height: 100%;
    padding: 10px;
  }

  .bs4Card .card-body {
    padding: 10px;
    overflow-y: auto;
  }

  /* Conteneurs flex en responsive */
  div[style*='display: flex'] {
    flex-wrap: wrap;
    justify-content: center;
  }

  /* Typographie responsive */
  .presentation-title {
    font-size: 2.5rem !important;
  }
  
  .presentation-subtitle {
    font-size: 2rem !important;
  }
  
  .context-list li {
    font-size: 1.5rem !important;
  }

  /* Images responsives */
  img {
    max-height: 75px !important;
    width: auto;
    margin: 10px auto;
  }

  .image-flex-container img {
    max-width: 100%;
    height: auto;
  }

  /* Ajustements pour les colonnes responsive */
  .responsive-column {
    flex: 0 0 100%;
    max-width: 100%;
    margin-bottom: 15px;
  }
}
    "))
    ),

    
    # Container pour les slides
    box(
         width = 12,
         height = "75%",
         style = "overflow: hidden; position: relative;",
    div(
      id = ns("slides_container"),
      
      # Slide 1
      div(
        id = ns("slide1"),
        bs4Card(
          width = 12,
          title = NULL,
          status = "warning",
          solidHeader = TRUE,
          collapsible = FALSE,
          height = "500px",
          div(
            class = "card-content text-center",
            h1(class = "presentation-title", "Introduction à R Shiny"),
            h2(class = "presentation-subtitle", "d'un Tableur à une Application Web Dynamique"),
            div(
              style = "margin-top: 40px;",
              img(src = "Shiny_hex_logo.png", 
                  style = "max-height: 200px; width: auto; max-width: 100%;")
            )
          )
        )
      ),
      
      # Slide 2
      div(
        id = ns("slide2"),
        style = "display: none;",
        bs4Card(
          width = 12,
          title = NULL,
          status = "warning",
          solidHeader = TRUE,
          collapsible = FALSE,
          height = "500px",
          div(
            class = "card-content",
            h2(class = "presentation-title", "Le Contexte"),
            tags$ul(
              class = "context-list",
              tags$li(" Les tableurs sont statiques et limitent les possibilités d'analyse interactive"),
              tags$li(" Besoin d'une solution moderne pour explorer et visualiser les données"),
              tags$li(" Objectif : Créer une application interactive et professionnelle")
            ),
            div(
              class = "flex-image-container",
              style = "margin-top: 40px; display: flex; justify-content: center; align-items: center; gap: 20px;",
              img(src = "table.png", 
                  style = "max-height: 200px; width: auto; max-width: 100%;"),
              img(src = "right-arrow.png", 
                  style = "max-height: 200px; width: auto; max-width: 100%;"),
              img(src = "dashboard.png", 
                  style = "max-height: 200px; width: auto; max-width: 100%;")
            )
          )
        )
      ),
      
      # Slide 3 (Nouveau)
      div(
        id = ns("slide3"),
        style = "display: none;",
        bs4Card(
          width = 12,
          title = NULL,
          status = "warning",
          solidHeader = TRUE,
          collapsible = FALSE,
          height = "500px",
          div(
            class = "card-content",
            h2(class = "presentation-title", "Pourquoi R Shiny ?"),
            tags$ul(
              class = "context-list",
              tags$li(" Interactivité immédiate pour vos analyses"),
              tags$li(" Accessibilité via un navigateur web : partage facile avec les collaborateurs"),
              tags$li(" Pas besoin de compétences avancées en développement web")
            ),
            div(
              style = "margin-top: 40px; display: flex; justify-content: center; align-items: center; gap: 20px;",
              img(src = "interactive.png", 
                  style = "max-height: 150px; width: auto; max-width: 100%;"),
              img(src = "internet.png", 
                  style = "max-height: 150px; width: auto; max-width: 100%;"),
              img(src = "no-code.png", 
                  style = "max-height: 150px; width: auto; max-width: 100%;")
            )
          )
        )
      ),
      
      #slide4
      div(
        id = ns("slide4"),
        style = "display: none;",
        bs4Card(
          width = 12,
          title = NULL,
          status = "warning",
          solidHeader = TRUE,
          collapsible = FALSE,
          height = "500px",
          div(
            class = "card-content",
            h2(class = "presentation-title", "Démonstration Interactive"),
            fluidRow(
              column(
                class = "responsive-column",
                width = 6,
                div(
                  style = "padding: 20px;",
                  h4("Contrôles Interactifs", style = "color: #666;"),
                  sliderInput(
                    ns("demo_slider"),
                    "Ajustez la valeur:",
                    min = 0, max = 100, value = 50
                  ),
                  selectInput(
                    ns("demo_color"),
                    "Choisissez une couleur:",
                    choices = c("Rouge" = "red", 
                                "Bleu" = "blue", 
                                "Vert" = "green")
                  )
                )
              ),
              column(
                class = "responsive-column",
                width = 6,
                div(
                  style = "padding: 20px; text-align: center;",
                  h4("Résultats en Temps Réel", style = "color: #666;"),
                  plotOutput(ns("demo_plot"), height = "200px"),
                  textOutput(ns("demo_text"))
                )
              )
            )
          )
        )
      ),
      
      
      div(
        id = ns("slide5"),
        style = "display: none;",
        bs4Card(
          width = 12,
          title = NULL,
          status = "warning",
          solidHeader = TRUE,
          collapsible = FALSE,
          height = "500px",  # Augmenté la hauteur
          div(
            class = "card-content",
            style = "height: 100%; overflow-y: auto;",  # Ajout du scroll
            h2(class = "presentation-title", "Les Widgets Shiny"),
            
            fluidRow(
              style = "margin: 0;",
              # Première colonne
              column(
                class = "responsive-column",
                width = 3,
                #class = "column",  #
                div(
                  style = "background: #f8f9fa; padding: 10px; border-radius: 10px; margin-bottom: 10px;",
                  h4("Entrées Basiques", style = "color: #666; font-size: 1rem;"),
                  textInput(ns("demo_text"), "Text Input:", width = "100%"),
                  numericInput(ns("demo_num"), "Numeric Input:", value = 0, width = "100%"),
                  dateInput(ns("demo_date"), "Date Input:", width = "100%")
                )
              ),
              
              # Deuxième colonne
              column(
                width = 3,
                class = "responsive-column",
                #class = "column", 
                div(
                  style = "background: #f8f9fa; padding: 10px; border-radius: 10px; margin-bottom: 10px;",
                  h4("Sélections", style = "color: #666; font-size: 1rem;"),
                  selectInput(ns("demo_select"), "Select Input:",
                              choices = c("Option 1", "Option 2", "Option 3"),
                              width = "100%"),
                  radioButtons(ns("demo_radio"), "Radio Buttons:",
                               choices = c("Choix 1", "Choix 2"),  # Réduit le nombre de choix
                               width = "100%"),
                  checkboxGroupInput(ns("demo_checkbox"), "Checkbox Group:",
                                     choices = c("A", "B"),  # Réduit le nombre de choix
                                     width = "100%")
                )
              ),
              
              # Troisième colonne
              column(
                width = 3,
                class = "responsive-column",
                #class = "column",  #
                div(
                  style = "background: #f8f9fa; padding: 10px; border-radius: 10px; margin-bottom: 10px;",
                  h4("Contrôles Avancés", style = "color: #666; font-size: 1rem;"),
                  sliderInput(ns("demo_slider"), "Slider:",
                              min = 0, max = 100, value = 50,
                              width = "100%"),
                  dateRangeInput(ns("demo_daterange"), "Date Range:",
                                 width = "100%"),
                  actionButton(ns("demo_action"), "Action Button",
                               class = "btn-primary btn-sm",
                               width = "100%")
                )
              ),
              
              # Quatrième colonne
              column(
                width = 3,
                class = "responsive-column",
                #class = "column",  #
                div(
                  style = "background: #f8f9fa; padding: 10px; border-radius: 10px; margin-bottom: 10px;",
                  h4("Valeurs Sélectionnées", style = "color: #666; font-size: 1rem;"),
                  verbatimTextOutput(ns("widget_values"))
                )
              )
            )
          )
        )
      ),
      
      
      #Slide 6
      div(
        id = ns("slide6"),
        style = "display: none;",
        bs4Card(
          width = 12,
          title = NULL,
          status = "warning",
          solidHeader = TRUE,
          collapsible = FALSE,
          height = "500px", # Augmenté pour plus d'espace
          div(
            class = "card-content",
            h2(class = "presentation-title", "Structure d'une Application Shiny"),
            div(
              style = "display: flex; justify-content: space-around; align-items: center; padding: 20px;",
              # UI Section
              div(
                style = "text-align: center;",
                img(src = "cosmetics.png", style = "max-height: 150px; width: auto; max-width: 100%;", alt = "UI Image"),
                h4("UI : Interface utilisateur"),
                p("Les inputs et outputs permettent à l'utilisateur d'interagir avec les données.")
              ),
              # Server Section
              div(
                style = "text-align: center;",
                img(src = "brain.png", style = "max-height: 150px; width: auto; max-width: 100%;", alt = "Server Image"),
                h4("Server : Logique métier"),
                p("Les calculs réactifs et traitements définissent la logique de l'application.")
              )
            ),
            # Accolade for App
            div(
              style = "text-align: center; margin-top: 20px; position: relative;",
              div(
                style = "
          display: inline-block; 
          border-left: 3px solid #000; 
          border-bottom: 3px solid #000; 
          border-right: 3px solid #000; 
          height: 50px; 
          width: 200px; 
          border-radius: 0 0 100px 100px; 
          margin-bottom: -10px;",
          NULL
              ),
          h4("App : Combine UI + Server"),
          p("Une application complète et dynamique résultant de la fusion des deux composants.")
            )
          )
        )
        
      ),
      
      
      
      div(
        id = ns("slide7"),
        style = "display: none;",
        bs4Card(
          width = 12,
          title = NULL,
          status = "warning",
          solidHeader = TRUE,
          collapsible = FALSE,
          height = "500px",
          div(
            class = "card-content",
            h2(
              class = "presentation-title",
              style = "text-align: left; font-size: 1.5rem;",
              "Exemple d'utilisation"
            ),
            div(
              style = "display: flex; justify-content: space-around; align-items: center; margin-top: 40px;",
              
              # Partie "Avant"
              div(
                style = "text-align: center; font-size: 1.6rem;",
                h2("Avant"),
                tags$p("Un tableur Excel"),
                tags$p("avec des données fixes"),
                img(src = "table.png", alt = "table", style = "max-height: 150px; width: auto; max-width: 100%;")
              ),
              
              # Image Team Rocket
              div(
                class = "card-content",
                div(
                  style = "text-align: center;",
                  img(src = "teamrocketpokemon.png", alt = "Team Rocket", style = "max-height: 250px; width: auto; max-width: 100%;")
                )
              ),
              
              # Partie "Après"
              div(
                style = "text-align: center; font-size: 1.6rem;",
                h2("Après"),
                tags$p("Une interface web interactive"),
                tags$p("permettant de filtrer et visualiser les données en direct"),
                img(src = "dashboard.png", alt = "dashboard", style = "max-height: 150px; width: auto; max-width: 100%;")
              )
            )
          )
        )
      ),

      
      # Slide 8
      div(
        id = ns("slide8"),
        style = "display: none;",
        bs4Card(
          width = 12,
          title = NULL,
          status = "warning",
          solidHeader = TRUE,
          collapsible = FALSE,
          height = "500px",
          div(
            class = "card-content",
            h2(class = "presentation-title", "Conclusion"),
            tags$ul(
              class = "context-list",
              tags$li(" R Shiny transforme vos analyses statiques en expériences interactives"),
              tags$li(" Une solution accessible pour démocratiser la data au sein des équipes"),
              tags$li(" Pourquoi ne pas essayer aujourd'hui ?")
            )
          )
        )
      ),
      
      div(
        id = ns("slide9"),
        style = "display: none;",
        bs4Card(
          width = 12,
          title = NULL,
          status = "success",
          solidHeader = TRUE,
          collapsible = FALSE,
          height = "500px",
          div(
            class = "card-content",
            style = "text-align: center; padding-top: 50px;",
            h1(class = "presentation-title", "Merci !"),
            div(
            img(
              src = "Rcestchouette.jpg", # Remplacez par le chemin de votre photo
              style = "width: 200px; height: 200px; border-radius: 50%; margin-top: 20px;"
            ),
            img(
              src = "QRCODE.png", # Remplacez par le chemin de votre photo
              style = "width: 200px; height: 200px; border-radius: 50%; margin-top: 20px;"
            )
            ),
            div(
              style = "margin-top: 30px;",
              h4("Connectez-vous avec moi :"),
              div(
                style = "margin-top: 20px; display: flex; justify-content: center; gap: 20px;",
                tags$a(
                  href = "https://www.linkedin.com/in/luciecamanez/",
                  target = "_blank",
                  icon("linkedin", "fa-2x", style = "color: #0077b5;")
                ),
                tags$a(
                  href = "https://web-cdn.bsky.app/profile/ladatatata.bsky.social",
                  target = "_blank",
                  img(
                    src = "bs_logo.png", # Ajoutez l'icône papillon dans le dossier www
                    style = "width: 32px; height: 32px; margin-top: -4px;"
                  )
                ),
                tags$a(
                  href = "https://github.com/TrueCactus",
                  target = "_blank",
                  icon("github", "fa-2x", style = "color: black;")
                )
              )
            )
          )
        )
      )
      
      
    )) ,
    
    # Navigation
    div(
      class = "navigation-container",
      actionButton(
        ns("prev_slide"), 
        "",
        class = "nav-button",
        icon = icon("chevron-left")
      ),
      div(
        class = "slide-counter",
        textOutput(ns("slide_counter"))
      ),
      actionButton(
        ns("next_slide"), 
        "",
        class = "nav-button",
        icon = icon("chevron-right")
      )
    )
  )
}

# Module Server
slideModule <- function(id) {
  moduleServer(id, function(input, output, session) {
    current_slide <- reactiveVal(1)
    total_slides <- 9
    
    # Ajouter les rendus pour le slide démonstratif
    output$demo_plot <- renderPlot({
      plot(1:100, 
           rep(input$demo_slider, 100), 
           col = input$demo_color,
           type = "l",
           main = "Visualisation Interactive",
           xlab = "X",
           ylab = "Y")
    })
    
    output$demo_text <- renderText({
      paste("Valeur sélectionnée:", input$demo_slider,
            "\nCouleur choisie:", input$demo_color)
    })
    
    # Output pour afficher les valeurs des widgets
    output$widget_values <- renderText({
      paste(
        "Text Input:", input$demo_text, "\n",
        "Numeric Input:", input$demo_num, "\n",
        "Select Input:", input$demo_select, "\n",
        "Radio Selection:", input$demo_radio, "\n",
        "Checkbox Group:", paste(input$demo_checkbox, collapse = ", "), "\n",
        "Slider Value:", input$demo_slider
      )
    })
    
    observeEvent(input$demo_action, {
      showModal(modalDialog(
        title = "R Shiny c'est super chouette !",
        div(
          style = "text-align: center;",
          img(
            src = "Rcestchouette.jpg", # Remplacez par le chemin de votre photo
            style = "width: 250px; height:250px; border-radius: 50%; margin-top: 20px;"
          ),
          h3("R Shiny c'est sup'R chouette !",
             style = "color: #2c3e50; margin-top: 20px;")
        ),
        footer = modalButton("Fermer"),
        size = "m",
        easyClose = TRUE
      ))
    })
    
    observeEvent(input$next_slide, {
      if (current_slide() < total_slides) {
        shinyjs::hide(paste0("slide", current_slide()))
        current_slide(current_slide() + 1)
        shinyjs::show(paste0("slide", current_slide()))
      }
    })
    
    observeEvent(input$prev_slide, {
      if (current_slide() > 1) {
        shinyjs::hide(paste0("slide", current_slide()))
        current_slide(current_slide() - 1)
        shinyjs::show(paste0("slide", current_slide()))
      }
    })
    
    output$slide_counter <- renderText({
      paste(current_slide(), "/", total_slides)
    })
  })
}
