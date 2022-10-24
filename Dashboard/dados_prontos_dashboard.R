# Dados já prontos para o dashboard

library(tidyverse)
library(sf)

# dps_id

dps_id <- readRDS("C:\\Users\\Caio\\Desktop\\Dados Dashboard\\dps_id.rds")



# ROUBOS DE CELULARES--------------------------------------------------------------------------------

# Mapa

roubos <- read_csv("C:\\Users\\Caio\\Desktop\\Dados Dashboard\\roubos_celular.csv")


zonas_elec_sp <- read_sf("C:\\Users\\Caio\\Desktop\\Furtos - Dados\\Furtos por bairro\\arquivo shape\\DISTPOL2021_MSP_CEM_V1.shp")


roubos <- zonas_elec_sp %>% left_join(roubos, by = 'DP_COD') 


roubos <- roubos %>% mutate(tooltip = paste("Delegacia:",DP_NOM_C,"\nDP_Num:",DP_COD,"\nN de Roubos:",n))



roubos$Numero <- cut(roubos$n, 
                     breaks=c(100,400, 700, 1000, 1300,1600,2000,2500,3500,4200), 
                     labels=c("100-400","401-700", "701-1000", "1001-1300","1301-1600","1601-2000","2001-2500",
                              "2501-3500","3501-4200"), right = FALSE)


# Tabela 


dados_tabela <- read_csv("C:\\Users\\Caio\\Desktop\\Dados Dashboard\\dados_tabela.csv")



# Grafico de Barras

dados_linhatempo <- read_csv("C:\\Users\\Caio\\Desktop\\Dados Dashboard\\dados_linhatempo.csv")




# Homicidio --------------------------------------------------------------------------------

# MAPA


homicidio <- read_csv("C:\\Users\\Caio\\Desktop\\Dados Dashboard\\homicidio.csv")



homicidio <- zonas_elec_sp %>% left_join(homicidio, by = 'DP_COD') 


homicidio <- homicidio %>% mutate(tooltip = paste("Delegacia:",DP_NOM_C,"\nDP_Num:",DP_COD,"\nN de Vítimas:",vitimas))


# Nova mudança que fiz 18/10

homicidio$homicidios <-  cut(homicidio$vitimas, 
                             breaks=c(-1, 4, 10, 20, 30,40), 
                             labels=c("0 - 4", "5 - 10", "11 - 20", 
                                      "21 - 30", "31 - 40"), right = TRUE) 


# TABELA



homicidios_tab <- read_csv("C:\\Users\\Caio\\Desktop\\Dados Dashboard\\homicidio_tab.csv")




# gráfico de barras


homicidio_linhatempo <- read_csv("C:\\Users\\Caio\\Desktop\\Dados Dashboard\\homicidio_linhatempo.csv")






# Roubos de Veiculos --------------------------------------------------------------------------------


# MAPA

roubos_veiculos_mapa <- read_csv("C:\\Users\\Caio\\Desktop\\Dados Dashboard\\roubos_veiculos_mapa.csv")


roubos_veiculos_mapa <- zonas_elec_sp %>% left_join(roubos_veiculos_mapa, by = 'DP_COD') 



roubos_veiculos_mapa <- roubos_veiculos_mapa %>% mutate(tooltip = paste("Delegacia:",DP_NOM_C,"\nDP_Num:",DP_COD,"\nN de Roubos:",n))


roubos_veiculos_mapa$roubos <- cut(roubos_veiculos_mapa$n, 
                                   breaks=c(-1,100,200, 400, 600, 800,1000,1200, Inf), 
                                   labels=c("0 - 100","101-200"," 201 - 400", "401 - 600", "601 - 800","801 - 1000", "1001 - 1200", "Acima 1200"), right = FALSE)



# TABELA


roubos_veiculos_tabela <- read_csv("C:\\Users\\Caio\\Desktop\\Dados Dashboard\\roubos_veiculos_tabela.csv")


# gráfico de barras


roubos_veiculoslinhatempo <- read_csv("C:\\Users\\Caio\\Desktop\\Dados Dashboard\\roubos_veiculoslinhatempo.csv")





# Latrocinios --------------------------------------------------------------------------------


# MAPA

latrocinio <- read_csv("C:\\Users\\Caio\\Desktop\\Dados Dashboard\\latrocinio.csv")

latrocinio <- latrocinio %>% mutate(tooltip = paste("Delegacia:",DP_NOM_C,"\nDP_Num:",DP_COD,"\nN de Vítimas:",vitimas))


latrocinio$latrocinios <- cut(latrocinio$vitimas, 
                              breaks=c(-1,1, 2, 3, 4,5,6), 
                              labels=c("0","1", "2", "3","4", "5"), right = FALSE)



# Tabela


latrocinio_tabela <- read_csv("C:\\Users\\Caio\\Desktop\\Dados Dashboard\\latrocinio_tabela.csv")


# gráfico de barras


latrocinio_linhatempo <- read_csv("C:\\Users\\Caio\\Desktop\\Dados Dashboard\\latrocinio_linhatempo.csv")


