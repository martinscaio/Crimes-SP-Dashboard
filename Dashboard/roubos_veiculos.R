library(tidyverse)
library(sf)
library(ggiraph)
library(readxl)


# Dados-------------------------------------------------------------------------------------

# dados 2021

C:\\Users\\Caio\\Desktop\\Dados Dashboard\\Dados Brutos\\Roubos de Veiculos\\

jan_veiculo21 <- read_delim("C:\\Users\\Caio\\Desktop\\Dados Dashboard\\Dados Brutos\\Roubos de Veiculos\\DadosBO_2021_1(ROUBO DE VEÍCULOS).csv",locale = locale(encoding = 'Latin1'))
fev_veiculo21 <- read_delim("C:\\Users\\Caio\\Desktop\\Dados Dashboard\\Dados Brutos\\Roubos de Veiculos\\DadosBO_2021_2(ROUBO DE VEÍCULOS).csv",locale = locale(encoding = 'Latin1'))
mar_veiculo21 <- read_delim("C:\\Users\\Caio\\Desktop\\Dados Dashboard\\Dados Brutos\\Roubos de Veiculos\\DadosBO_2021_3(ROUBO DE VEÍCULOS).csv",locale = locale(encoding = 'Latin1'))
abr_veiculo21 <- read_delim("C:\\Users\\Caio\\Desktop\\Dados Dashboard\\Dados Brutos\\Roubos de Veiculos\\DadosBO_2021_4(ROUBO DE VEÍCULOS).csv",locale = locale(encoding = 'Latin1'))
mai_veiculo21 <- read_delim("C:\\Users\\Caio\\Desktop\\Dados Dashboard\\Dados Brutos\\Roubos de Veiculos\\DadosBO_2021_5(ROUBO DE VEÍCULOS).csv",locale = locale(encoding = 'Latin1'))
jun_veiculo21 <- read_delim("C:\\Users\\Caio\\Desktop\\Dados Dashboard\\Dados Brutos\\Roubos de Veiculos\\DadosBO_2021_6(ROUBO DE VEÍCULOS).csv",locale = locale(encoding = 'Latin1'))
jul_veiculo21 <- read_delim("C:\\Users\\Caio\\Desktop\\Dados Dashboard\\Dados Brutos\\Roubos de Veiculos\\DadosBO_2021_7(ROUBO DE VEÍCULOS).csv",locale = locale(encoding = 'Latin1'))
ago_veiculo21 <- read_delim("C:\\Users\\Caio\\Desktop\\Dados Dashboard\\Dados Brutos\\Roubos de Veiculos\\DadosBO_2021_8(ROUBO DE VEÍCULOS).csv",locale = locale(encoding = 'Latin1'))
set_veiculo21 <- read_delim("C:\\Users\\Caio\\Desktop\\Dados Dashboard\\Dados Brutos\\Roubos de Veiculos\\DadosBO_2021_9(ROUBO DE VEÍCULOS).csv",locale = locale(encoding = 'Latin1'))
out_veiculo21 <- read_delim("C:\\Users\\Caio\\Desktop\\Dados Dashboard\\Dados Brutos\\Roubos de Veiculos\\DadosBO_2021_10(ROUBO DE VEÍCULOS).csv",locale = locale(encoding = 'Latin1'))
nov_veiculo21 <- read_delim("C:\\Users\\Caio\\Desktop\\Dados Dashboard\\Dados Brutos\\Roubos de Veiculos\\DadosBO_2021_11(ROUBO DE VEÍCULOS).csv",locale = locale(encoding = 'Latin1'))
dez_veiculo21 <- read_delim("C:\\Users\\Caio\\Desktop\\Dados Dashboard\\Dados Brutos\\Roubos de Veiculos\\DadosBO_2021_12(ROUBO DE VEÍCULOS).csv",locale = locale(encoding = 'Latin1'))

jan_veiculo21 %>% view()
# dados 2020


jan_veiculo20 <- read_delim("C:\\Users\\Caio\\Desktop\\Dados Dashboard\\Dados Brutos\\Roubos de Veiculos\\DadosBO_2020_1(ROUBO DE VEÍCULOS).csv",locale = locale(encoding = 'Latin1'))
fev_veiculo20 <- read_delim("C:\\Users\\Caio\\Desktop\\Dados Dashboard\\Dados Brutos\\Roubos de Veiculos\\DadosBO_2020_2(ROUBO DE VEÍCULOS).csv",locale = locale(encoding = 'Latin1'))
mar_veiculo20 <- read_delim("C:\\Users\\Caio\\Desktop\\Dados Dashboard\\Dados Brutos\\Roubos de Veiculos\\DadosBO_2020_3(ROUBO DE VEÍCULOS).csv",locale = locale(encoding = 'Latin1'))
abr_veiculo20 <- read_delim("C:\\Users\\Caio\\Desktop\\Dados Dashboard\\Dados Brutos\\Roubos de Veiculos\\DadosBO_2020_4(ROUBO DE VEÍCULOS).csv",locale = locale(encoding = 'Latin1'))
mai_veiculo20 <- read_delim("C:\\Users\\Caio\\Desktop\\Dados Dashboard\\Dados Brutos\\Roubos de Veiculos\\DadosBO_2020_5(ROUBO DE VEÍCULOS).csv",locale = locale(encoding = 'Latin1'))
jun_veiculo20 <- read_delim("C:\\Users\\Caio\\Desktop\\Dados Dashboard\\Dados Brutos\\Roubos de Veiculos\\DadosBO_2020_6(ROUBO DE VEÍCULOS).csv",locale = locale(encoding = 'Latin1'))
jul_veiculo20 <- read_delim("C:\\Users\\Caio\\Desktop\\Dados Dashboard\\Dados Brutos\\Roubos de Veiculos\\DadosBO_2020_7(ROUBO DE VEÍCULOS).csv",locale = locale(encoding = 'Latin1'))
ago_veiculo20 <- read_delim("C:\\Users\\Caio\\Desktop\\Dados Dashboard\\Dados Brutos\\Roubos de Veiculos\\DadosBO_2020_8(ROUBO DE VEÍCULOS).csv",locale = locale(encoding = 'Latin1'))
set_veiculo20 <- read_delim("C:\\Users\\Caio\\Desktop\\Dados Dashboard\\Dados Brutos\\Roubos de Veiculos\\DadosBO_2020_9(ROUBO DE VEÍCULOS).csv",locale = locale(encoding = 'Latin1'))
out_veiculo20 <- read_delim("C:\\Users\\Caio\\Desktop\\Dados Dashboard\\Dados Brutos\\Roubos de Veiculos\\DadosBO_2020_10(ROUBO DE VEÍCULOS).csv",locale = locale(encoding = 'Latin1'))
nov_veiculo20 <- read_delim("C:\\Users\\Caio\\Desktop\\Dados Dashboard\\Dados Brutos\\Roubos de Veiculos\\DadosBO_2020_11(ROUBO DE VEÍCULOS).csv",locale = locale(encoding = 'Latin1'))
dez_veiculo20 <- read_delim("C:\\Users\\Caio\\Desktop\\Dados Dashboard\\Dados Brutos\\Roubos de Veiculos\\DadosBO_2020_12(ROUBO DE VEÍCULOS).csv",locale = locale(encoding = 'Latin1'))

# dados 2019



jan_veiculo19 <- read_delim("C:\\Users\\Caio\\Desktop\\Dados Dashboard\\Dados Brutos\\Roubos de Veiculos\\DadosBO_2019_1(ROUBO DE VEÍCULOS).csv",locale = locale(encoding = 'Latin1'))
fev_veiculo19 <- read_delim("C:\\Users\\Caio\\Desktop\\Dados Dashboard\\Dados Brutos\\Roubos de Veiculos\\DadosBO_2019_2(ROUBO DE VEÍCULOS).csv",locale = locale(encoding = 'Latin1'))
mar_veiculo19 <- read_delim("C:\\Users\\Caio\\Desktop\\Dados Dashboard\\Dados Brutos\\Roubos de Veiculos\\DadosBO_2019_3(ROUBO DE VEÍCULOS).csv",locale = locale(encoding = 'Latin1'))
abr_veiculo19 <- read_delim("C:\\Users\\Caio\\Desktop\\Dados Dashboard\\Dados Brutos\\Roubos de Veiculos\\DadosBO_2019_4(ROUBO DE VEÍCULOS).csv",locale = locale(encoding = 'Latin1'))
mai_veiculo19 <- read_delim("C:\\Users\\Caio\\Desktop\\Dados Dashboard\\Dados Brutos\\Roubos de Veiculos\\DadosBO_2019_5(ROUBO DE VEÍCULOS).csv",locale = locale(encoding = 'Latin1'))
jun_veiculo19 <- read_delim("C:\\Users\\Caio\\Desktop\\Dados Dashboard\\Dados Brutos\\Roubos de Veiculos\\DadosBO_2019_6(ROUBO DE VEÍCULOS).csv",locale = locale(encoding = 'Latin1'))
jul_veiculo19 <- read_delim("C:\\Users\\Caio\\Desktop\\Dados Dashboard\\Dados Brutos\\Roubos de Veiculos\\DadosBO_2019_7(ROUBO DE VEÍCULOS).csv",locale = locale(encoding = 'Latin1'))
ago_veiculo19 <- read_delim("C:\\Users\\Caio\\Desktop\\Dados Dashboard\\Dados Brutos\\Roubos de Veiculos\\DadosBO_2019_8(ROUBO DE VEÍCULOS).csv",locale = locale(encoding = 'Latin1'))
set_veiculo19 <- read_delim("C:\\Users\\Caio\\Desktop\\Dados Dashboard\\Dados Brutos\\Roubos de Veiculos\\DadosBO_2019_9(ROUBO DE VEÍCULOS).csv",locale = locale(encoding = 'Latin1'))
out_veiculo19 <- read_delim("C:\\Users\\Caio\\Desktop\\Dados Dashboard\\Dados Brutos\\Roubos de Veiculos\\DadosBO_2019_10(ROUBO DE VEÍCULOS).csv",locale = locale(encoding = 'Latin1'))
nov_veiculo19 <- read_delim("C:\\Users\\Caio\\Desktop\\Dados Dashboard\\Dados Brutos\\Roubos de Veiculos\\DadosBO_2019_11(ROUBO DE VEÍCULOS).csv",locale = locale(encoding = 'Latin1'))
dez_veiculo19 <- read_delim("C:\\Users\\Caio\\Desktop\\Dados Dashboard\\Dados Brutos\\Roubos de Veiculos\\DadosBO_2019_12(ROUBO DE VEÍCULOS).csv",locale = locale(encoding = 'Latin1'))


# dados 2018


jan_veiculo18 <- read_delim("C:\\Users\\Caio\\Desktop\\Dados Dashboard\\Dados Brutos\\Roubos de Veiculos\\DadosBO_2018_1(ROUBO DE VEÍCULOS).csv",locale = locale(encoding = 'Latin1'))
fev_veiculo18 <- read_delim("C:\\Users\\Caio\\Desktop\\Dados Dashboard\\Dados Brutos\\Roubos de Veiculos\\DadosBO_2018_2(ROUBO DE VEÍCULOS).csv",locale = locale(encoding = 'Latin1'))
mar_veiculo18 <- read_delim("C:\\Users\\Caio\\Desktop\\Dados Dashboard\\Dados Brutos\\Roubos de Veiculos\\DadosBO_2018_3(ROUBO DE VEÍCULOS).csv",locale = locale(encoding = 'Latin1'))
abr_veiculo18 <- read_delim("C:\\Users\\Caio\\Desktop\\Dados Dashboard\\Dados Brutos\\Roubos de Veiculos\\DadosBO_2018_4(ROUBO DE VEÍCULOS).csv",locale = locale(encoding = 'Latin1'))
mai_veiculo18 <- read_delim("C:\\Users\\Caio\\Desktop\\Dados Dashboard\\Dados Brutos\\Roubos de Veiculos\\DadosBO_2018_5(ROUBO DE VEÍCULOS).csv",locale = locale(encoding = 'Latin1'))
jun_veiculo18 <- read_delim("C:\\Users\\Caio\\Desktop\\Dados Dashboard\\Dados Brutos\\Roubos de Veiculos\\DadosBO_2018_6(ROUBO DE VEÍCULOS).csv",locale = locale(encoding = 'Latin1'))
jul_veiculo18 <- read_delim("C:\\Users\\Caio\\Desktop\\Dados Dashboard\\Dados Brutos\\Roubos de Veiculos\\DadosBO_2018_7(ROUBO DE VEÍCULOS).csv",locale = locale(encoding = 'Latin1'))
ago_veiculo18 <- read_delim("C:\\Users\\Caio\\Desktop\\Dados Dashboard\\Dados Brutos\\Roubos de Veiculos\\DadosBO_2018_8(ROUBO DE VEÍCULOS).csv",locale = locale(encoding = 'Latin1'))
set_veiculo18 <- read_delim("C:\\Users\\Caio\\Desktop\\Dados Dashboard\\Dados Brutos\\Roubos de Veiculos\\DadosBO_2018_9(ROUBO DE VEÍCULOS).csv",locale = locale(encoding = 'Latin1'))
out_veiculo18 <- read_delim("C:\\Users\\Caio\\Desktop\\Dados Dashboard\\Dados Brutos\\Roubos de Veiculos\\DadosBO_2018_10(ROUBO DE VEÍCULOS).csv",locale = locale(encoding = 'Latin1'))
nov_veiculo18 <- read_delim("C:\\Users\\Caio\\Desktop\\Dados Dashboard\\Dados Brutos\\Roubos de Veiculos\\DadosBO_2018_11(ROUBO DE VEÍCULOS).csv",locale = locale(encoding = 'Latin1'))
dez_veiculo18 <- read_delim("C:\\Users\\Caio\\Desktop\\Dados Dashboard\\Dados Brutos\\Roubos de Veiculos\\DadosBO_2018_12(ROUBO DE VEÍCULOS).csv",locale = locale(encoding = 'Latin1'))






# Funções------------------------------------------------------------------------------------------------------


limpeza_rouboveiculos <- function(dado){
  
  provisorio <- dado %>% 
    dplyr::distinct(DELEGACIA_NOME,ANO_BO,NUM_BO, .keep_all = TRUE) %>% 
    tidyr::separate(BO_EMITIDO, into = c('BO_EMITIDO', 'horario'), sep = ' ') %>% 
    dplyr::mutate(#DELEGACIA_CIRCUNSCRICAO = case_when(DELEGACIA_CIRCUNSCRICAO == 'DEL.SEC.1ª CENTRO' ~ '03º D.P. CAMPOS ELISEOS',
                  #                                    DELEGACIA_CIRCUNSCRICAO == 'DEL.SEC.7ª ITAQUERA' ~ '32º D.P. ITAQUERA',
                  #                                    DELEGACIA_CIRCUNSCRICAO == 'DEL.SEC.3ª OESTE' ~ '14º D.P. PINHEIROS',
                  #                                    DELEGACIA_CIRCUNSCRICAO == 'DEL.SEC.8ª SÃO MATEUS' ~ '49º D.P. SAO MATEUS',
                  #                                    DELEGACIA_CIRCUNSCRICAO == 'DEL.SEC.2ª SUL' ~ '96º D.P. MONÇÕES',
                  #                                    DELEGACIA_CIRCUNSCRICAO == 'DEL.SEC.5ª LESTE' ~ '81º D.P. BELEM',
                  #                                    DELEGACIA_CIRCUNSCRICAO == 'DEL.SEC.6ª SANTO AMARO' ~ '11º D.P. SANTO AMARO',
                  #                                    DELEGACIA_CIRCUNSCRICAO == 'DEL.SEC.4ª NORTE' ~ '13º D.P. CASA VERDE',
                  #                                    TRUE ~ DELEGACIA_CIRCUNSCRICAO),
                  DP_COD = str_extract(DELEGACIA_CIRCUNSCRICAO, "[0-9]+"),
                  DP_COD = as.integer(DP_COD),
                  ocorrencia = lubridate::dmy(DATAOCORRENCIA),
                  BO_EMITIDO = lubridate::dmy(BO_EMITIDO),
                  diferenca_tempo = difftime(BO_EMITIDO, ocorrencia, units = 'days'))
  
  
  
}




arrumar_rouboveiculos <- function(dado){
  
  data_errada <- dado %>% 
    dplyr::filter(diferenca_tempo > 180)
  
  
  data_certa <- data_errada %>% 
    dplyr::mutate(ocorrencia = BO_EMITIDO)
  
  
  dados_arrumados <- data.table::setDT(dado)[data.table::setDT(data_certa), on = "NUM_BO", ocorrencia := i.ocorrencia]
  
  
  arrumar_na <- dado %>% filter(is.na(ocorrencia)) %>% mutate(ocorrencia = BO_EMITIDO)
  
  
  dados_arrumados <- data.table::setDT(dados_arrumados)[data.table::setDT(arrumar_na), on = "NUM_BO", ocorrencia := i.ocorrencia]
  
  
  dados_arrumados <- dados_arrumados %>% 
    dplyr::mutate(mes_ocorrencia = lubridate::month(ocorrencia),
                  ano_ocorrencia = lubridate::year(ocorrencia),
                  dia_ocorrencia = lubridate::day(ocorrencia),
                  mes_boletim = lubridate::month(BO_EMITIDO),
                  ano_boletim = lubridate::year(BO_EMITIDO),
                  dia_boletim = lubridate::day(BO_EMITIDO))
  
  
  
}





# Aplicação ------------------------------------------------------------------------------------------------------


roubos_veiculos <- list(jan_veiculo21, fev_veiculo21, mar_veiculo21, abr_veiculo21, mai_veiculo21, jun_veiculo21,
                        jul_veiculo21,ago_veiculo21,set_veiculo21, out_veiculo21, nov_veiculo21, dez_veiculo21,
                        jan_veiculo20,fev_veiculo20, mar_veiculo20,abr_veiculo20, mai_veiculo20, jun_veiculo20,
                        jul_veiculo20, ago_veiculo20, set_veiculo20, out_veiculo20,nov_veiculo20, dez_veiculo20,
                        jan_veiculo19,fev_veiculo19, mar_veiculo19,abr_veiculo19, mai_veiculo19, jun_veiculo19,
                        jul_veiculo19, ago_veiculo19, set_veiculo19, out_veiculo19,nov_veiculo19, dez_veiculo19,
                        jan_veiculo18,fev_veiculo18, mar_veiculo18,abr_veiculo18, mai_veiculo18, jun_veiculo18,
                        jul_veiculo18, ago_veiculo18, set_veiculo18, out_veiculo18,nov_veiculo18, dez_veiculo18) %>% 
  map(limpeza_rouboveiculos) %>% 
  map(arrumar_rouboveiculos) %>%
  reduce(full_join)


roubos_veiculos %>% filter(ano_ocorrencia == 2020) %>% group_by(mes_ocorrencia) %>% count()


roubos_veiculos_mapa <- roubos_veiculos %>% filter(!str_detect(DELEGACIA_CIRCUNSCRICAO, '^DEL.SEC'))



roubos_veiculos_mapa <- roubos_veiculos_mapa %>% group_by(DP_COD, ano_ocorrencia) %>% count()






# IMPORTANDO ARQUIVO SHAPE-------------------------------------------------

zonas_elec_sp <- read_sf("C:\\Users\\Caio\\Desktop\\Furtos - Dados\\Furtos por bairro\\arquivo shape\\DISTPOL2021_MSP_CEM_V1.shp")


# -----------------------


# MAPA


roubos_veiculos_mapa <- zonas_elec_sp %>% left_join(roubos_veiculos_mapa, by = 'DP_COD') 



roubos_veiculos_mapa <- roubos_veiculos_mapa %>% mutate(tooltip = paste("Delegacia:",DP_NOM_C,"\nDP_Num:",DP_COD,"\nN de Roubos:",n))



roubos_veiculos_mapa$roubos <- cut(roubos_veiculos_mapa$n, 
                              breaks=c(-1,100,200, 400, 600, 800,1000,1200, Inf), 
                              labels=c("0 - 100","101-200"," 201 - 400", "401 - 600", "601 - 800","801 - 1000", "1001 - 1200", "Acima 1200"), right = FALSE)







t = roubos_veiculos_mapa %>%
  filter(ano_ocorrencia == 2019) %>% 
  ggplot(aes()) + 
  geom_sf_interactive(color = 'gray50', size = 0.2, data_id = dps_id,
                      aes(fill = roubos,tooltip = tooltip))+
  #scale_fill_manual(values = c("#770404", "#D90505","#DC5700" ,"#DBB139", '#D9A862', '#D6CEC2'), name = '')+
  scale_fill_manual(values = c("#F8F3B4", "#F9B31D","#F9841D","#F9521D","#B60F01", "yellow", "green"))+
  labs(title = "Criminalidade Bairro a Bairro",
       subtitle = "Roubos de Celulares por Distrito Policial no ano de 2021",
       caption = 'Fonte: Secretaria de Estado da Segurança Pública de São Paulo')+
  theme_void() + 
  theme(panel.grid.minor = element_blank(), 
        panel.grid.major = element_blank(),
        plot.background = element_rect(fill = "transparent", colour = NA),
        plot.title = element_text(hjust = 0.5),
        plot.caption = element_text(size = 7))


tooltip_css = paste0("border-radius: 4px;",
                     "border: 1px solid gray;",
                     "background: white;",
                     "padding: 5px;",
                     "text-align: center;",
                     "opactiy: 0.5")
g = girafe(ggobj =  t, 
           options = list(
             opts_tooltip(css = tooltip_css),
             opts_zoom(max = 5),
             opts_hover_inv(css = "opacity:0.5;"),
             opts_hover(css = "stroke:red;stroke-width:1.0;")
           ) )






g






# Tabela



roubos_veiculos_tabela <- roubos_veiculos %>% 
  group_by(DELEGACIA_CIRCUNSCRICAO, ano_ocorrencia) %>% 
  count() %>% 
  arrange(desc(n)) %>% 
  rename(DELEGACIA = DELEGACIA_CIRCUNSCRICAO,
         'NÚMERO DE ROUBOS' = n)


roubos_veiculos_tabela %>% DT::datatable()



# Gráfico de barras





roubos_veiculoslinhatempo <- roubos_veiculos %>% 
  mutate(mes = lubridate::month(mes_ocorrencia, label = TRUE)) %>% 
  group_by(mes, ano_ocorrencia) %>% 
  count() %>% 
  arrange()


roubos_veiculoslinhatempo


roubos_veiculoslinhatempo %>% filter(ano_ocorrencia == 2021) %>% ungroup() %>% 
  plot_ly(x = ~mes, y = ~n, type = 'bar') %>% 
  layout(yaxis = list(title = '', showgrid = F),
         xaxis = list(title = '', showgrid = F)) %>% 
  layout(xaxis = list(titlefont = list(size = 16), tickfont = list(size = 16)))


