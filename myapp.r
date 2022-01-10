# Importation des fichiers et nettoyage

#1 Impoprtation
bloc <-  st_read("contour_geo.shp",layer="contour_geo")
courbe <- st_read("courbe_geo.shp",layer = "courbe_geo")
note <- st_read("point_geo.shp",layer = "point_geo")




#2 Nettoyage
note <- st_zm(note, drop = T, what = "ZM")
courbe <- st_zm(courbe, drop = T, what = "ZM")
bloc <- st_zm(bloc, drop = T, what = "ZM")


#Preparation des label avec le package HTML
note$label <- paste("<p>", note$TEXT_1,"</p>",
                   "<p>", note$TEXT_2,"</p>",
                   "<p>", note$TEXT_3,"</p>")



sn_map <- leaflet() %>% 
      addFullscreenControl() %>% 
      addProviderTiles(providers$Esri.WorldImagery) %>% 
      setView(lng = -17.244, lat = 14.706,zoom = 15.5) %>% 
      addPolygons(data = bloc,
                  color = "black",
                  weight =1,
                  smoothFactor = 1,
                  fillColor =  "blank",
                  fillOpacity = 0.5 )%>% 
      
      addPolylines(data = courbe,
                   color = "yellow",
                   weight =1,
                   smoothFactor = 1,
                   fillColor =  "blank",
                   fillOpacity = 0.5,
                   popup = ~leafpop::popupTable(courbe,
                                                zcol = "Elevation",
                                                row.numbers = FALSE, feature.id = FALSE))%>% 
      
      addCircleMarkers(data = note,
                       color = "red",
           
