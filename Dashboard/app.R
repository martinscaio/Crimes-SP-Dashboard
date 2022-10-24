library(fresh)
library(shiny)
library(ggiraph)
library(tidyverse)
library(shinydashboard)
library(rmarkdown)
library(markdown)
library(DT)
library(plotly)
library(sf)


# Dados 


tooltip_css = paste0("border-radius: 4px;",
                     "border: 1px solid gray;",
                     "background: white;",
                     "padding: 5px;",
                     "text-align: center;",
                     "opactiy: 0.5")



# dps_id



dps_id <- readRDS('dps_id.rds')

#dps_id <- read.csv("C:\\Users\\Caio\\Desktop\\Shiny - Criminalidade\\Shiny - Criminalidade\\dps.csv", header = FALSE)

#dps_id <- read.csv("dps.csv", header = FALSE)


#dps_id <- as.vector(dps_id[[1]])



# ROUBOS DE CELULARES--------------------------------------------------------------------------------

# Mapa

#roubos <- read_csv("C:\\Users\\Caio\\Desktop\\Shiny - Criminalidade\\Shiny - Criminalidade\\roubos_celular.csv")

roubos <- read_csv("roubos_celular.csv")


#zonas_elec_sp <- read_sf("C:\\Users\\Caio\\Desktop\\Furtos - Dados\\Furtos por bairro\\arquivo shape\\DISTPOL2021_MSP_CEM_V1.shp")

zonas_elec_sp <- read_sf("DISTPOL2021_MSP_CEM_V1.shp")



roubos <- zonas_elec_sp %>% left_join(roubos, by = 'DP_COD') 


roubos <- roubos %>% mutate(tooltip = paste("Delegacia:",DP_NOM_C,"\nDP_Num:",DP_COD,"\nN de Roubos:",n))



roubos$Numero <- cut(roubos$n, 
                     breaks=c(100,400, 700, 1000, 1300,1600,2000,2500,3500,4200), 
                     labels=c("100-400","401-700", "701-1000", "1001-1300","1301-1600","1601-2000","2001-2500",
                              "2501-3500","3501-4200"), right = FALSE)


# Tabela 


#dados_tabela <- read_csv("C:\\Users\\Caio\\Desktop\\Shiny - Criminalidade\\Shiny - Criminalidade\\dados_tabela.csv")

dados_tabela <- read_csv("dados_tabela.csv")


# Grafico de Barras

#dados_linhatempo <- read_csv("C:\\Users\\Caio\\Desktop\\Shiny - Criminalidade\\Shiny - Criminalidade\\dados_linhatempo.csv")

dados_linhatempo <- read_csv("dados_linhatempo.csv")



# Homicidio --------------------------------------------------------------------------------

# MAPA


#homicidio <- read_csv("C:\\Users\\Caio\\Desktop\\Shiny - Criminalidade\\Shiny - Criminalidade\\homicidio.csv")

homicidio <- read_csv("homicidio.csv")



homicidio <- zonas_elec_sp %>% left_join(homicidio, by = 'DP_COD') 


homicidio <- homicidio %>% mutate(tooltip = paste("Delegacia:",DP_NOM_C,"\nDP_Num:",DP_COD,"\nN de Vítimas:",vitimas))


# Nova mudança que fiz 18/10

homicidio$homicidios <-  cut(homicidio$vitimas, 
                             breaks=c(-1, 4, 10, 20, 30,40), 
                             labels=c("0 - 4", "5 - 10", "11 - 20", 
                                      "21 - 30", "31 - 40"), right = TRUE) 


# TABELA



#homicidios_tab <- read_csv("C:\\Users\\Caio\\Desktop\\Shiny - Criminalidade\\Shiny - Criminalidade\\homicidio_tab.csv")

homicidios_tab <- read_delim("homicidio_tab.csv", delim = ",")



# gráfico de barras


#homicidio_linhatempo <- read_csv("C:\\Users\\Caio\\Desktop\\Shiny - Criminalidade\\Shiny - Criminalidade\\homicidio_linhatempo.csv")



homicidio_linhatempo <- read_delim("homicidio_linhatempo.csv")




# Roubos de Veiculos --------------------------------------------------------------------------------


# MAPA

#roubos_veiculos_mapa <- read_csv("C:\\Users\\Caio\\Desktop\\Shiny - Criminalidade\\Shiny - Criminalidade\\roubos_veiculos_mapa.csv")

roubos_veiculos_mapa <- read_delim("roubos_veiculos_mapa.csv", locale = locale(encoding = 'UTF-8'))


roubos_veiculos_mapa <- zonas_elec_sp %>% left_join(roubos_veiculos_mapa, by = 'DP_COD') 



roubos_veiculos_mapa <- roubos_veiculos_mapa %>% mutate(tooltip = paste("Delegacia:",DP_NOM_C,"\nDP_Num:",DP_COD,"\nN de Roubos:",n))


roubos_veiculos_mapa$roubos <- cut(roubos_veiculos_mapa$n, 
                                   breaks=c(-1,100,200, 400, 600, 800,1000,1200, Inf), 
                                   labels=c("0 - 100","101-200"," 201 - 400", "401 - 600", "601 - 800","801 - 1000", "1001 - 1200", "Acima 1200"), right = FALSE)



# TABELA


#roubos_veiculos_tabela <- read_csv("C:\\Users\\Caio\\Desktop\\Shiny - Criminalidade\\Shiny - Criminalidade\\roubos_veiculos_tabela.csv")

roubos_veiculos_tabela <- read_delim("roubos_veiculos_tabela.csv", locale = locale(encoding = 'UTF-8'))


# gráfico de barras


#roubos_veiculoslinhatempo <- read_csv("C:\\Users\\Caio\\Desktop\\Shiny - Criminalidade\\Shiny - Criminalidade\\roubos_veiculoslinhatempo.csv")


roubos_veiculoslinhatempo <- read_delim("roubos_veiculoslinhatempo.csv",locale = locale(encoding = 'UTF-8') )



# Latrocinios --------------------------------------------------------------------------------


# MAPA

#latrocinio <- read_csv("C:\\Users\\Caio\\Desktop\\Shiny - Criminalidade\\Shiny - Criminalidade\\latrocinio.csv")


latrocinio <- read_csv("latrocinio.csv")



latrocinio <- zonas_elec_sp %>% left_join(latrocinio, by = 'DP_COD') 


latrocinio <- latrocinio %>% mutate(tooltip = paste("Delegacia:",DP_NOM_C,"\nDP_Num:",DP_COD,"\nN de Vítimas:",vitimas))


latrocinio$latrocinios <- cut(latrocinio$vitimas, 
                              breaks=c(-1,1, 2, 3, 4,5,6), 
                              labels=c("0","1", "2", "3","4", "5"), right = FALSE)



# Tabela


#latrocinio_tabela <- read_csv("C:\\Users\\Caio\\Desktop\\Shiny - Criminalidade\\Shiny - Criminalidade\\latrocinio_tabela.csv")

latrocinio_tabela <- read_csv("latrocinio_tabela.csv")


# gráfico de barras


#latrocinio_linhatempo <- read_csv("C:\\Users\\Caio\\Desktop\\Shiny - Criminalidade\\Shiny - Criminalidade\\latrocinio_linhatempo.csv")


latrocinio_linhatempo <- read_csv("latrocinio_linhatempo.csv")










# APLICATIVO SHINY--------------------------------------------------------------------------------------------

data <- c(2018,2019,2020,2021)

data2 <- c(2021)


ui <- shinyUI(fluidPage(
  
  # load custom stylesheet
  #includeCSS("C:/Users/Caio/Desktop/Learning Shiny/aprendendo_shiny/teste/style.css"),
  
  
  # remove shiny "red" warning messages on GUI
  #tags$style(type="text/css",
  #          ".shiny-output-error { visibility: hidden; }",
  #         ".shiny-output-error:before { visibility: hidden; }"
  #),
  
  
  
  
  
  dashboardPage(
    
    skin = "blue",
    
    
    dashboardHeader(title = "Criminalidade Bairro a Bairro", titleWidth = 300),
    
    dashboardSidebar(width = 300,
                     
                     
                     sidebarMenu(
                       
                       menuItem("Inicio", tabName = "Inicio",icon = icon("home")),
                       menuItem("Roubos de Celulares", tabName = "Roubos",icon = icon("mobile")),
                       menuItem("Homicidios", tabName = "Homicidios",icon = icon("gun")),
                       menuItem("Roubos de Veículos", tabName = "veiculos",icon = icon("car")),
                       menuItem("Latrocinios", tabName = "Latrocinios",icon = icon("gun"))
                       
                       
                       
                       
                     ),
                     
                     
                     
                     HTML(paste0(
                       "<br><br><br><br><br><br><br><br><br>",
                       "<table style='margin-left:auto; margin-right:auto;'>",
                       "<tr>",
                       "<td style='padding: 5px;'><a href='https://https://twitter.com/Mcaio3' target='_blank'><i class='fab fa-twitter fa-lg'></i></a></td>",
                       "<td style='padding: 5px;'><a href='https://https://www.instagram.com/martinsv_caio/' target='_blank'><i class='fab fa-instagram fa-lg'></i></a></td>",
                       "<td style='padding: 5px;'><a href='https://github.com/martinscaio' target='_blank'><i class='fab fa-github fa-lg'></i></a></td>",
                       "</tr>",
                       "</table>",
                       "<br>"),
                       HTML(paste0(
                         "<script>",
                         "var today = new Date();",
                         "var yyyy = today.getFullYear();",
                         "</script>",
                         "<p style = 'text-align: center;'><small>&copy; - <a href='Caio Martins' target='_blank'>Caio Martins</a> - <script>document.write(yyyy);</script></small></p>")
                       ))
    ),
    
    
    
    
    
    
    
    
    
    dashboardBody(
      
      
      tabItems(
        
        
        tabItem(tabName = 'Inicio',
                
                includeMarkdown("sobre.md")),
        
        
        tabItem(tabName = 'Roubos',
                
                
                titlePanel(h1('Roubos de Celulares na Cidade de São Paulo', align = 'center')),
                
                selectInput(inputId = 'Ano',
                            label = 'Ano',
                            choices = data2,
                            selected = data2[1]),
                
                
                
                
                fluidRow(box(title = h3('Mapa de SP com o Nº de Roubos por Distrito Policial',align = 'center'),
                             solidHeader = T,
                             collapsible = T,
                             status = 'primary',
                             width = 6,column(6,ggiraphOutput(outputId = "mapa",
                                                              width = '180%',
                                                              height = "70%"))),
                         box(title = h3('Delegacias com o maior número de Roubos', align = 'center'),
                             solidHeader = T,
                             collapsible = T,
                             status = 'primary',
                             column(width = 12,DT::dataTableOutput("tabela")))),
                
                fluidRow(
                  box(title = h3('Evolução do Nº de Roubos ao longo do Ano',align = 'center'),
                      solidHeader = T,
                      collapsible = T,
                      status = 'primary',
                      width = 12,column(7,plotly::plotlyOutput("grafico", width = '170%'))))
                
                
                
        ),
        
        
        
        tabItem(tabName = 'Homicidios',
                
                titlePanel(h1('Homicídios Dolosos na Cidade de São Paulo', align = 'center')),
                
                selectInput(inputId = 'tempo',
                            label = 'Ano',
                            choices = data,
                            selected = data[1]),
                
                
                
                
                fluidRow(box(title = h3('Mapa de SP com o Nº de Homicídios Dolosos por Distrito Policial',align = 'center'),
                             solidHeader = T,
                             collapsible = T,
                             status = 'primary',
                             width = 6,column(6,ggiraphOutput(outputId = "homicidios",
                                                              width = '180%',
                                                              height = "70%"))),
                         box(title = h3('Delegacias com o maior número de Homicídios registrados', align = 'center'),
                             solidHeader = T,
                             collapsible = T,
                             status = 'primary',
                             column(width = 12,DT::dataTableOutput("tabela_homicidio")))),
                
                fluidRow(
                  box(title = h3('Evolução do Nº de Homicidios Dolosos ao longo do Ano',align = 'center'),
                      solidHeader = T,
                      collapsible = T,
                      status = 'primary',
                      width = 12,column(7,plotly::plotlyOutput("grafico_homicidio", width = '170%'))))
                
                
                
                
                
        ),
        
        
        tabItem(tabName = 'Latrocinios',
                
                titlePanel(h1('Latrocínios na Cidade de São Paulo', align = 'center')),
                
                selectInput(inputId = 'year',
                            label = 'Ano',
                            choices = data,
                            selected = data[1]),
                
                
                
                
                fluidRow(box(title = h3('Mapa de SP com o Nº de Latrocínios por Distrito Policial',align = 'center'),
                             solidHeader = T,
                             collapsible = T,
                             status = 'primary',
                             width = 6,column(6,ggiraphOutput(outputId = "latrocinios",
                                                              width = '180%',
                                                              height = "70%"))),
                         box(title = h3('Delegacias com o maior número de Latrocínios registrados', align = 'center'),
                             solidHeader = T,
                             collapsible = T,
                             status = 'primary',
                             column(width = 12,DT::dataTableOutput("tabela_latrocinio")))),
                
                fluidRow(
                  box(title = h3('Evolução do Nº de Latrocínios ao longo do Ano',align = 'center'),
                      solidHeader = T,
                      collapsible = T,
                      status = 'primary',
                      width = 12,column(7,plotly::plotlyOutput("grafico_latrocinio", width = '170%'))))
                
                
                
                
                
        ),
        
        
        
        
        tabItem(tabName = 'veiculos',
                
                titlePanel(h1('Roubos de Veículos na Cidade de São Paulo', align = 'center')),
                
                selectInput(inputId = 'periodo',
                            label = 'Ano',
                            choices = data,
                            selected = data[1]),
                
                
                
                
                fluidRow(box(title = h3('Mapa de SP com o Nº de Roubos de Veículos por Distrito Policial',align = 'center'),
                             solidHeader = T,
                             collapsible = T,
                             status = 'primary',
                             width = 6,column(6,ggiraphOutput(outputId = "veiculos",
                                                              width = '180%',
                                                              height = "70%"))),
                         box(title = h3('Delegacias com o maior número de Roubos de Veículos registrados', align = 'center'),
                             solidHeader = T,
                             collapsible = T,
                             status = 'primary',
                             column(width = 12,DT::dataTableOutput("tabela_veiculos")))),
                
                fluidRow(
                  box(title = h3('Evolução do Nº de Roubos de Veículos ao longo do Ano',align = 'center'),
                      solidHeader = T,
                      collapsible = T,
                      status = 'primary',
                      width = 12,column(7,plotly::plotlyOutput("grafico_veiculos", width = '170%'))))
                
                
                
                
                
        )
        
        
        
        
      )
      
    )
    
  )
  
)

)







# Define server logic required to draw a histogram
server <- function(input, output, session) {
  
  
  
  # Roubos de Celulares
  
  output$mapa <- renderggiraph({
    
    t = roubos %>% filter(ano_ocorrencia == input$Ano) %>% 
      ggplot(aes()) + 
      geom_sf_interactive(color = 'gray50', size = 0.2, data_id = dps_id, # preciso arrumar isso
                          aes(fill = Numero,tooltip = tooltip))+
      scale_fill_manual(values = c("#FCF7CC", "#F1E57E","#DFCE39","#DFAF2E","#DE9B14", "#DE7F14","#DC5B02","#DC4102","#C60F00"))+
      theme_void() + 
      theme(panel.grid.minor = element_blank(),
            rect = element_blank(),
            panel.background = element_blank(),
            panel.grid = element_blank(),
            panel.grid.major = element_blank(),
            plot.background = element_rect(fill = "transparent", colour = NA),
            plot.title = element_text(hjust = 0.5),
            plot.caption = element_text(size = 7))
    
    
    g = girafe(ggobj =  t, 
               options = list(
                 opts_tooltip(css = tooltip_css),
                 opts_zoom(max = 5),
                 opts_hover_inv(css = "opacity:0.5;"),
                 opts_hover(css = "stroke:red;stroke-width:1.0;")
               ) )
    
    
    
    
  })
  
  
  
  
  
  output$tabela <- DT::renderDataTable(
    
    
    dados_tabela %>% filter(ano_ocorrencia == input$Ano)
    
    
    
    
  )
  
  
  
  output$grafico <- plotly::renderPlotly({
    
    dados_linhatempo %>% filter(ano_ocorrencia == input$Ano) %>% ungroup() %>% 
      plot_ly(x = ~mes, y = ~n, type = 'bar') %>% 
      layout(yaxis = list(title = '', showgrid = F),
             xaxis = list(title = '', showgrid = F)) %>% 
      layout(xaxis = list(titlefont = list(size = 16), tickfont = list(size = 16))) %>% 
      layout(xaxis = list(categoryorder = "mes",
                          categoryarray = c("jan", "fev", "mar", "abr", "mai",
                                            "jun","jul","ago","set","out","nov","dez")))
    
    
    
    
    
  })
  
  
  # Homicidios
  
  
  output$homicidios <-  ggiraph::renderggiraph({
    
    a = homicidio %>% filter(ano_ocorrencia == input$tempo) %>% 
      ggplot(aes()) + 
      geom_sf_interactive(color = 'gray50', size = 0.2, data_id = dps_id, # preciso arrumar isso
                          aes(fill = homicidios,tooltip = tooltip))+
      scale_fill_manual(values = c("#F8F3B4", "#F9B31D","#F9841D","#F9521D","#B60F01"))+
      theme_void() + 
      theme(panel.grid.minor = element_blank(),
            rect = element_blank(),
            panel.background = element_blank(),
            panel.grid = element_blank(),
            panel.grid.major = element_blank(),
            plot.background = element_rect(fill = "transparent", colour = NA),
            plot.title = element_text(hjust = 0.5),
            plot.caption = element_text(size = 7))
    
    
    h = girafe(ggobj =  a, 
               options = list(
                 opts_tooltip(css = tooltip_css),
                 opts_zoom(max = 5),
                 opts_hover_inv(css = "opacity:0.5;"),
                 opts_hover(css = "stroke:red;stroke-width:1.0;")
               ) )
    
    
    
    
  })
  
  
  
  
  output$tabela_homicidio <- DT::renderDataTable(
    
    
    homicidios_tab %>% dplyr::filter(ANO == input$tempo)
    
    
    
    
  )
  
  
  output$grafico_homicidio <- plotly::renderPlotly({
    
    homicidio_linhatempo %>% filter(ano_ocorrencia == input$tempo) %>% ungroup() %>% 
      plot_ly(x = ~mes, y = ~n, type = 'bar') %>% 
      layout(yaxis = list(title = '', showgrid = F),
             xaxis = list(title = '', showgrid = F)) %>% 
      layout(xaxis = list(titlefont = list(size = 16), tickfont = list(size = 16))) %>% 
      layout(xaxis = list(categoryorder = "mes",
                          categoryarray = c("jan", "fev", "mar", "abr", "mai",
                                            "jun","jul","ago","set","out","nov","dez")))
    
    
    
    
    
  })
  
  
  
  # latrocinios
  
  
  output$latrocinios <-  ggiraph::renderggiraph({
    
    a = latrocinio %>% filter(ano == input$year) %>% 
      ggplot(aes()) + 
      geom_sf_interactive(color = 'gray50', size = 0.2, data_id = dps_id, # preciso arrumar isso
                          aes(fill = latrocinios,tooltip = tooltip))+
      scale_fill_manual(values = c("#F8F3B4", "#F9B31D","#F9841D","#F9521D","#B60F01", "#5B0D06"))+
      theme_void() + 
      theme(panel.grid.minor = element_blank(),
            rect = element_blank(),
            panel.background = element_blank(),
            panel.grid = element_blank(),
            panel.grid.major = element_blank(),
            plot.background = element_rect(fill = "transparent", colour = NA),
            plot.title = element_text(hjust = 0.5),
            plot.caption = element_text(size = 7))
    
    
    h = girafe(ggobj =  a, 
               options = list(
                 opts_tooltip(css = tooltip_css),
                 opts_zoom(max = 5),
                 opts_hover_inv(css = "opacity:0.5;"),
                 opts_hover(css = "stroke:red;stroke-width:1.0;")
               ) )
    
    
    
    
  })
  
  
  output$tabela_latrocinio <- DT::renderDataTable(
    
    
    latrocinio_tabela %>% filter(ano == input$year)
    
    
    
    
  )
  
  
  
  output$grafico_latrocinio <- plotly::renderPlotly({
    
    latrocinio_linhatempo %>% filter(ano == input$year) %>% ungroup() %>% 
      plot_ly(x = ~mes, y = ~n, type = 'bar') %>% 
      layout(yaxis = list(title = '', showgrid = F),
             xaxis = list(title = '', showgrid = F)) %>% 
      layout(xaxis = list(titlefont = list(size = 16), tickfont = list(size = 16))) %>% 
      layout(xaxis = list(categoryorder = "mes",
                          categoryarray = c("jan", "fev", "mar", "abr", "mai",
                                            "jun","jul","ago","set","out","nov","dez")))
    
    
    
    
    
  }) 
  
  
  
  # Roubos de Veiculos
  
  
  
  output$veiculos <-  ggiraph::renderggiraph({
    
    a = roubos_veiculos_mapa %>% filter(ano_ocorrencia == input$periodo) %>% 
      ggplot(aes()) + 
      geom_sf_interactive(color = 'gray50', size = 0.2, data_id = dps_id, # preciso arrumar isso
                          aes(fill = roubos,tooltip = tooltip))+
      scale_fill_manual(values = c("#F8F3B4", "#F9B31D","#F9841D","#F9521D","#B60F01", "yellow", "green"))+
      theme_void() + 
      theme(panel.grid.minor = element_blank(),
            rect = element_blank(),
            panel.background = element_blank(),
            panel.grid = element_blank(),
            panel.grid.major = element_blank(),
            plot.background = element_rect(fill = "transparent", colour = NA),
            plot.title = element_text(hjust = 0.5),
            plot.caption = element_text(size = 7))
    
    
    h = girafe(ggobj =  a, 
               options = list(
                 opts_tooltip(css = tooltip_css),
                 opts_zoom(max = 5),
                 opts_hover_inv(css = "opacity:0.5;"),
                 opts_hover(css = "stroke:red;stroke-width:1.0;")
               ) )
    
    
    
    
  })
  
  
  
  
  output$tabela_veiculos <- DT::renderDataTable(
    
    
    roubos_veiculos_tabela %>% filter(ANO == input$periodo)
    
    
    
    
  )
  
  
  
  output$grafico_veiculos <- plotly::renderPlotly({
    
    roubos_veiculoslinhatempo %>% filter(ano_ocorrencia == input$periodo) %>% ungroup() %>% 
      plot_ly(x = ~mes, y = ~n, type = 'bar') %>% 
      layout(yaxis = list(title = '', showgrid = F),
             xaxis = list(title = '', showgrid = F)) %>% 
      layout(xaxis = list(titlefont = list(size = 16), tickfont = list(size = 16))) %>% 
      layout(xaxis = list(categoryorder = "mes",
                          categoryarray = c("jan", "fev", "mar", "abr", "mai",
                                            "jun","jul","ago","set","out","nov","dez")))
    
    
    
    
    
  })
  
  
  
  
  
}


# Run the application 
shinyApp(ui = ui, server = server)
