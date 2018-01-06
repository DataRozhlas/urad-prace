download.file("https://portal.mpsv.cz/portalssz/download/getfile.do?filename=vm20180105_xml.zip&_lang=cs_CZ", "data.zip")
unzip("data.zip")

library(xml2)


volnamista <- read_xml("vm20180105.xml")

volnamista <- as_list(volnamista)

nazev=character()
doplnek=character()
plnyuvazek=character()
minmzda=numeric()
maxmzda=numeric()
typmzdy=character()
obec=character()
id=character()

for (i in 1:length(volnamista)) {
  profese <- as.data.frame(attributes(volnamista[[i]]$PROFESE))
  nazev <- append(nazev, as.character(profese$nazev))
  ifelse(length(as.character(profese$doplnek))>0,
    doplnek <- append(doplnek, as.character(profese$doplnek)),
    doplnek <- append(doplnek, NA))
  pracovnivztah <- as.data.frame(attributes(volnamista[[i]]$PRACPRAVNI_VZTAH))
  plnyuvazek <- append(plnyuvazek, as.character(pracovnivztah$ppvztahPpPlny))
  mzda <- as.data.frame(attributes(volnamista[[i]]$MZDA))
  minmzda <- append(minmzda, as.numeric(as.character(mzda$min)))
  ifelse(length(as.character(mzda$max))>0,
    maxmzda <- append(maxmzda, as.numeric(as.character(mzda$max))),
    maxmzda <- append(maxmzda, NA)
  )
  typmzdy <- append(typmzdy, as.character(mzda$typMzdy))
  pracoviste <- as.data.frame(attributes(volnamista[[i]]$PRACOVISTE))
  ifelse(length(as.character(pracoviste$obec))>0,
    obec <- append(obec, as.character(pracoviste$obec)),
    obec <- append(obec, NA)
  )
  id <- append(id, attributes(volnamista[[i]])$uid) 
}

result <- data.frame(nazev, doplnek, minmzda, maxmzda, typmzdy, obec, paste0("https://portal.mpsv.cz/sz/obcane/vmjedno?ref=", result$id)) 




