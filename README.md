
# Human Talks - Introduction à Shiny

Cette application Shiny est utilisée dans le cadre de l'événement [Human Talks Nantes](https://humantalks.com/cities/nantes) pour introduire les concepts fondamentaux de Shiny. Elle présente un exemple interactif basé sur un dataset Pokémon, où les utilisateurs peuvent filtrer des données, afficher des tableaux, visualiser des graphiques, et comparer des statistiques de différents Pokémon à l'aide d'un radar plot.

## Description de l'application

L'application est structurée autour de plusieurs onglets, dont le premier est dédié à une présentation introductive et les suivants illustrent des fonctionnalités d'interaction avec les données Pokémon.

### Fonctionnalités principales :
- **Filtrage & Tableau** : Permet de filtrer les Pokémon selon différents critères (type, légendaire, stats totales) et d'afficher un tableau dynamique des résultats filtrés.
- **Visualisation** : Affiche un graphique de la distribution des statistiques totales des Pokémon.
- **Comparaison** : Permet de sélectionner deux Pokémon pour comparer leurs statistiques à l'aide d'un radar plot.

### Module de présentation :
Un module de présentation (slides) est intégré pour présenter l'introduction à Shiny avant d'entrer dans les fonctionnalités de l'application.
Cette partie utilise la notion de modularisation au sein d'une application Shiny ( Ce point n'a pas été approfondi pour la présentation)

## Structure de l'application

### UI (Interface Utilisateur)
L'interface est construite avec **shinydashboard** pour une navigation fluide entre les différentes sections.

- **Dashboard Header** : Le titre de l'application est **Human Talks**.
- **Sidebar** : Le menu latéral contient plusieurs sections, notamment l'onglet **Présentation** avec les slides et les autres sections pour l'exemple Pokémon.
- **Dashboard Body** : Le corps de l'application contient des onglets qui gèrent les interactions avec les données Pokémon.

Les onglets sont organisés comme suit :
1. **Présentation** : Un module pour afficher les slides de présentation.
2. **Filtrage & Tableau** : Interface permettant de filtrer les Pokémon et afficher un tableau des résultats.
3. **Visualisation** : Graphique de la distribution des statistiques des Pokémon.
4. **Comparaison** : Comparaison de deux Pokémon à l'aide d'un radar plot.

### Server
La partie **server** gère les différentes interactions des utilisateurs avec les données. Voici les principales fonctionnalités :
- **Filtrage des données** : En fonction des sélections faites par l'utilisateur (type, statut légendaire, stats totales), les données sont filtrées.
- **Tableau dynamique** : Affiche les Pokémon filtrés sous forme de tableau interactif avec pagination et possibilité de défiler horizontalement.
- **Graphique de distribution** : Un histogramme affichant la répartition des statistiques totales des Pokémon.
- **Radar Plot** : Permet de comparer les statistiques de deux Pokémon sélectionnés.

## Installation

Avant de lancer l'application, vous devez avoir installé les packages nécessaires.

### Dépendances

Voici les packages nécessaires à l'exécution de l'application :

```r
install.packages(c("shiny", "shinydashboard", "tidyverse", "bslib", "DT", "shinyjs", "fmsb", "scales"))
```

### Fichiers requis

1. **Pokemon.csv** : Le fichier CSV contenant les données des Pokémon. Ce fichier doit être situé dans le même répertoire que votre application.
2. **R/slide_module.R** : Le module des slides qui permet d'afficher une présentation.

### Lancer l'application

Une fois les dépendances installées et les fichiers nécessaires en place, lancez l'application avec le code suivant :

```r
shiny::runApp()
```

## Fonctionnement de l'application

### Onglet Présentation
Cet onglet utilise un module de slides pour présenter l'introduction à l'utilisation de Shiny. Le module est source dans le fichier `R/slide_module.R`.

### Onglet Filtrage & Tableau
Dans cet onglet, l'utilisateur peut filtrer les Pokémon par type, statut légendaire et plage de statistiques totales. Le tableau est affiché à l'aide du package **DT**, permettant une visualisation interactive des résultats.

### Onglet Visualisation
Ce sous-onglet affiche un histogramme représentant la distribution des statistiques totales des Pokémon filtrés.

### Onglet Comparaison
Cet onglet permet à l'utilisateur de sélectionner deux Pokémon pour comparer leurs statistiques via un graphique radar. Les statistiques de chaque Pokémon sont normalisées pour être comparées sur la même échelle.

## À propos de l'application

Cette application est utilisée dans le cadre du talk "Introduction à Shiny" lors de l'événement **Human Talks**. L'objectif est de familiariser les participants avec les bases de Shiny en créant une application simple mais interactive.

## Contributeurs

- **Lucie Camanez** : Développeur principal
  - [LinkedIN](https://www.linkedin.com/in/luciecamanez/)
  - Bluesky [ladatatata.bsky.social](https://web-cdn.bsky.app/profile/ladatatata.bsky.social)

## Remerciements

Merci aux [Human Talks Nantes](https://humantalks.com/cities/nantes) pour leur accueil 


