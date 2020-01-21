# MoviesTestApp
Aplicacion demo de la integraciona la The Movie Database api peliculas y series


## Capas de la aplicacion ##

### Service ### 
  <p>Capa exclusiva para los servicios</p>
 <details>
           <summary>MoviesApi</summary>
           <p>esta clase se encarga unicamente de las tareas asyncronas con los servicios, mapeo de las respuestas del servidor</p>
 </details>


### Model ### 
 <p>Capa exclusiva para los Datos</p>
 <details>
           <summary>Movie</summary>
           <p>struct movie, mapeo de json</p>
 </details>
 
  <details>
           <summary>MoviesServiceResponse</summary>
           <p>struct movieserviceresponse, mapeo de json</p>
 </details>


 <details>
           <summary>Trailer</summary>
           <p>struct trailer, mapeo de json</p>
 </details>


 <details>
           <summary>TrailersServiceResponse</summary>
           <p>struct trailersServiceResponse, mapeo de json</p>
 </details>


 <details>
           <summary>TvSerie</summary>
           <p>struct tvSerie, mapeo de json</p>
 </details>


 <details>
           <summary>TvServiceResponse</summary>
           <p>struct TvServiceResponse, mapeo de json</p>
 </details>



### DataManager ### 

Capa exclusiva para el manejo de los datos ya sean locales o remotos
 
 <details>
           <summary>DataManager</summary>
           <p>todos los servicios de manejo datos, la responsabilidad de interactuar con los servicios y devolver los datos</p>
 </details>

### UI ### 

capa exclusiva par todos los componentes de UI/ViewControllers/Cells


## Preguntas ##

### En qué consiste el principio de responsabilidad única? Cuál es su propósito? ###

_Consiste en que una clase tiene una unica responsabilidad , el proposito es de reducir al maximo el grado de relacion de una clase con el resto y asi una clase deberia tener una unica razon para cambiar._

### Qué características tiene, según su opinión, un “buen” código o código limpio ###

_Un codigo limpio debe ser enfocado, cada clase, metodo o entidad debe permanecer sin cambiar, tambien debe ser leible con nombres de variables claras y no debe ser redundate._

