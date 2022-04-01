# CREACIÓN DE MI BASE DE DATOS DEL COVID-19

# DATOS
library(readxl)
# Datos Covid-19 hasta el 7 de junio
Covid<-read_excel("datos_covid_7JUNIO.xlsx")

# Proporción de personas mayores de 65 años, en 2018
edad65<-read_excel("Proportion of population aged 65 and over.xlsx",
                   sheet=3,range="A9:B55")
colnames(edad65)<-c("Pais","prop_edad65")
edad65$Pais[which(edad65$Pais==
                    "Germany (until 1990 former territory of the FRG)")]<-"Germany"
edad65$Pais[which(edad65$Pais==
                    "Kosovo (under United Nations Security Council Resolution 1244/99)")]<-"Kosovo"
# Camas de hospital por cien mil habitantes, en 2017
camas<-read_excel("Hospital beds.xlsx",
                  sheet=3,range="A10:B47")
colnames(camas)<-c("Pais","camas_hosp")
camas$Pais[which(camas$Pais==
                   "Germany (until 1990 former territory of the FRG)")]<-"Germany"
camas$camas_hosp[which(camas$camas_hosp==":")]<-NA
# Densidad de población. Nº de personas por km^2, en 2018
densidad<-read_excel("Population density.xlsx",
                     sheet=3,range="A9:B46")
colnames(densidad)<-c("Pais","densidad_pob")
densidad$Pais[which(densidad$Pais==
                      "Germany (until 1990 former territory of the FRG)")]<-"Germany"
# Gasto total en salud en 2017. En € por habitante
salud<-read_excel("Total health care expenditure.xlsx",
                  sheet=3,range="A10:B48")
colnames(salud)<-c("Pais","gasto_salud")
salud$Pais[which(salud$Pais==
                   "Germany (until 1990 former territory of the FRG)")]<-"Germany"
salud$gasto_salud[which(salud$gasto_salud==":")]<-NA
# % de personas en riesgo de pobreza o exclusión social
pobreza<-read_excel("People at risk of poverty or social exclusion.xlsx",
                    sheet=3,range="A11:B46")
colnames(pobreza)<-c("Pais","riesgo_pobreza")
pobreza$Pais[which(pobreza$Pais==
                     "Germany (until 1990 former territory of the FRG)")]<-"Germany"
pobreza$riesgo_pobreza[which(pobreza$riesgo_pobreza==":")]<-NA
# Coordenadas
coordenadas<-read_excel("coordenadas europa.xlsx")

# Creamos nuestra base de datos con todas las variables incluidas
datos_Covid<-Covid
datos_Covid$`EU/EEA and the UK`[which(datos_Covid$`EU/EEA and the UK`==
                                        "United_Kingdom")]<-"United Kingdom"
# Añadimos la variable prop_edad65
datos_Covid$prop_edad65<-rep(NA,dim(datos_Covid)[1])
for (i in 1:dim(datos_Covid)[1]) {
  for (j in 1:dim(edad65)[1]) {
    if (datos_Covid$`EU/EEA and the UK`[i]==edad65$Pais[j])
      datos_Covid$prop_edad65[i]<-edad65$prop_edad65[j]
  }
}
# Añadimos la variable camas_hosp
datos_Covid$camas_hosp<-rep(NA,dim(datos_Covid)[1])
for (i in 1:dim(datos_Covid)[1]) {
  for (j in 1:dim(camas)[1]) {
    if (datos_Covid$`EU/EEA and the UK`[i]==camas$Pais[j])
      datos_Covid$camas_hosp[i]<-camas$camas_hosp[j]
  }
}
# Añadimos la variable densidad_pob
datos_Covid$densidad_pob<-rep(NA,dim(datos_Covid)[1])
for (i in 1:dim(datos_Covid)[1]) {
  for (j in 1:dim(densidad)[1]) {
    if (datos_Covid$`EU/EEA and the UK`[i]==densidad$Pais[j])
      datos_Covid$densidad_pob[i]<-densidad$densidad_pob[j]
  }
}
# Añadimos la variable gasto_salud
datos_Covid$gasto_salud<-rep(NA,dim(datos_Covid)[1])
for (i in 1:dim(datos_Covid)[1]) {
  for (j in 1:dim(salud)[1]) {
    if (datos_Covid$`EU/EEA and the UK`[i]==salud$Pais[j])
      datos_Covid$gasto_salud[i]<-salud$gasto_salud[j]
  }
}
# Añadimos la variable riesgo_pobreza
datos_Covid$riesgo_pobreza<-rep(NA,dim(datos_Covid)[1])
for (i in 1:dim(datos_Covid)[1]) {
  for (j in 1:dim(pobreza)[1]) {
    if (datos_Covid$`EU/EEA and the UK`[i]==pobreza$Pais[j])
      datos_Covid$riesgo_pobreza[i]<-pobreza$riesgo_pobreza[j]
  }
}
# Añadimos las coordenadas
datos_Covid$latitud<-coordenadas$latitud
datos_Covid$longitud<-coordenadas$longitud

# Imputación múltiple de datos
library(VIM)
COVID_bbdd<-hotdeck(datos_Covid)[,1:dim(datos_Covid)[2]]

rownames(COVID_bbdd)<-COVID_bbdd[,1] # Nombramos cada fila con el nombre del país
COVID_bbdd<-COVID_bbdd[,-1] # Eliminamos la primera columna

# Guardamos las bases de datos
save(datos_Covid,file="datos_Covid.RData") # original
save(COVID_bbdd,file="COVID_bbdd.RData") # con datos imputados