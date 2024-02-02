# Shop-App
Es una app que permite la búsqueda de distintos productos actualmente a la venta. Consta de tres pantallas: 

# Pantalla de Búsqueda:
  · Contiene una imagen con el logo de la empresa y un Textfield que permite el ingreso de inputs en formato string.

  · Casos de errores: 
   No permite inputs vacios, en tal caso el usuario recibiría un mensaje de error que le indicaría ingresar un texto válido. 
   En caso de que ocurra un error en la búsqueda, ya sea errores al conectarse con la API, al recibir la respuesta, o decodificarla. El usuario podrá observar un mensaje de error que le indicará que intente más tarde. 
   
# Pantalla de Resultados de Búsqueda:
  · Contiene un Textfield para realizar una nueva búsqueda desde esa pantalla, sin necesidad de volver a la pantalla principal, y se visualizan los resultados de la búsuqeda realizada en la primera pantalla en una TableView, 
  configurada dentro de un ScrollView, que le permite al usuario navegar en la misma tabla. 
  
# Pantalla de Detalle del Producto:
  · Al seleccionar un producto desde la TableView, el usuario navega hacia la pantalla de detalle que contiene, también dentro de un ScrollView, un label con el título del producto, su imagen y su descripción.

En todo el proyecto se puede regresar hacia la pantalla anterior utilizando la barra de navegación superior. 

# Instalación y Uso
  · Clonar el repositorio copiando la dirección HTTPS o SSH
  · Una vez clonado el repositorio, entrar en la carpeta del proyecto desde la terminal y correr el comando _pod install_ para poder instalar las dependencias de Alamofire, AlamofireImage y PromiseKit.
  · Una vez instalado, correr la app desde el XCODE para poder visualizar la app. 
  
# Estructura del Proyecto:
  · El Proyecto está desarrollado con arquitectura VIPER. 
  · Contiene tres carpetas referidas a las pantallas las cuales son Home, SearchResult y ProductDetail. Además de la carpeta Model, donde se encuentran los Structs de los datos que se recibirán en la API, y la carpeta Assets, donde está la imagen del logo 
  y dos archivos que tienen la configuración global del loading y el alerta para los mensajes de error. 
  · Se encuentra configurado desde el AppDelegate y el SceneDelegate para que la pantalla inicial sea la pantalla de home, por lo cual es el único módulo que no tiene un archivo _Module_ para buildearlo. 
  · Por otro lado se agregaron UnitTests para las búsquedas, los cuales se encuentran en la carpeta ShopAppTests, los cuales están dentro de la carpeta de cada módulo respectivamente. 
  
# Dependencias
  · Alamofire
  · AlamofireImage
  · PromiseKit

https://github.com/agostinacorcuera/shop-app/assets/70046224/d6f1c79c-13a5-4394-9c63-e02bb12d2af1

