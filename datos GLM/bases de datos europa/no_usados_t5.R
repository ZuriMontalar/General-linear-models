## no utilizados en tarea 5 glm


```{r}
# ESTO QUITARLO TODO
library(R.utils)
# gunzip("hlth_rs_bds2.tsv.gz")
# gunzip("edat_lfse_03.tsv.gz")
# gunzip("tps00010.tsv.gz")
# gunzip("isoc_iw_ap.tsv.gz")
# gunzip("tps00046.tsv.gz")

#camas<-read.table("hlth_rs_bds2.tsv",sep="\t",header=T)
camas<-read.table("tps00046.tsv",sep="\t",header=T)
educacion<-read.table("edat_lfse_03.tsv",sep="\t",header=T)
pob.edad<-read.table("tps00010.tsv",sep="\t",header=T)
TIC<-read.table("isoc_iw_ap.tsv",sep="\t",header=T)
```

```{r}

edades<-read_excel("prop_edad.xlsx") #usar solo tal vez prop. gente mayor de 65 años?

```



tps00046.tsv: camas de hospitales. hospital beds

edat_lfse_03.tsv.gz: Population by educational attainment level, sex and age (%) 

tps00010.tsv: Population by age group 

isoc_iw_ap.tsv: Use of ICT at work and activities performed 