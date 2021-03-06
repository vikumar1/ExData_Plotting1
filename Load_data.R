library(httr) 

direccion <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
datos <- "datos"
if(!file.exists(datos)){
        dir.create(datos)
} 
graficos <- "graficos" 
if(!file.exists(graficos)){
        dir.create(graficos)
}
archivo <- paste(getwd(), "/datos/household_power_consumption.zip", sep = "")
if(!file.exists(archivo)){
        download.file(direccion, archivo, mode="wb")
}
archiv <- paste(getwd(), "/datos/household_power_consumption.txt", sep = "")
if(!file.exists(archivo)){
        unzip("datos/household_power_consumption.zip", list = FALSE, overwrite = TRUE, exdir = datos)
}

datosresumidos <- paste(getwd(), "/datos/datosresumidos.rds", sep = "")
if(!file.exists(datosresumidos)){
        datos <- "datos/household_power_consumption.txt"
        cargardatos <- read.table(datos, header=TRUE, sep=";", colClasses=c("character", "character", rep("numeric",7)), na="?")
        cargardatos$Time <- strptime(paste(cargardatos$Date, cargardatos$Time), "%d/%m/%Y %H:%M:%S")
        cargardatos$Date <- as.Date(cargardatos$Date, "%d/%m/%Y")
        fechas <- as.Date(c("2007-02-01", "2007-02-02"), "%Y-%m-%d")
        cargardatos <- subset(cargardatos, Date %in% fechas)
        datosresumidos <- paste(getwd(), "/", "datos", "/", "datosresumidos", ".rds", sep="")
        saveRDS(cargardatos, datosresumidos)
} else {
        datos <- "datos/datosresumidos.rds"
        cargardatos <- readRDS(datos)
}
