Traducción de magento al Español Mexicano.
================================================================================

Esta es una traducción de magento al **Español Mexicano**, el cual lo puedes utilizar para trasformar tu tienda virtual a dicha idioma.

Para esto hemos tomado los archivos base de:

> <http://www.magentocommerce.com/translations/list/50>

Instrucciones Como utilizar.
================================================================================

1.- Descargar el paquete.
---------------------------------------------------------------------------------

Usted puede descargar la versión mas reciente de esta traduccion desde la siguientes URLs:

<a href="https://github.com/mundoSICA/Magento_1.6.x_translation_es_MX/tarball/master" class="button icon arrowdown">Download as <b>.tar.gz</b></a>
<a href="https://github.com/mundoSICA/Magento_1.6.x_translation_es_MX/zipball/master" class="button icon arrowdown">Download as <b>.zip</b></a>

2.- Agregando los archivos a nuestro Magento.
---------------------------------------------------------------------------------

tendrás que combinar los archivos manteniendo la misma estructura de directorios en `app/locale/` y `app/design/frontend/default/default/es_MX`, para esto usted puede utilizar el script `auxiliar.sh`:

	./auxiliar.sh -instalar /var/www/mi_directorio_magento/

> Donde `/var/www/mi_directorio_magento/` es la ruta de nuestro directorio donde tenemos instalado magento.


3.- Configurando mi Magento para usar la nueva idioma.
---------------------------------------------------------------------------------

Para esto tienes que ir al **Admin, System (sistema) -> Configuration (configuración) -> General tab (general) -> Locale options** el idioma es\_MX. Y le damos de grabar ‘Save Config’.

###4.- Desactiva el Cache.

Para para desabilitar el _cache_ **Admin, System (sistema) -> Cache Management (Gestión de Cache)** desactivamos `Translation files`.


-----------------------------------------------------------------------------------------

#Documentación para desarrolladores.

La siguiente sección esta orientada a desarrolladores, si gustas contribuir en la traducción de magento al **Español Mexicano** este es el espacio ideal para tí.

##¿Como contribuir?

Para contribuir no es necesario que sepas programar o que conozcas del todo la estructura de los archivos que estamos manejando(_aunque resulta ideal_), usted puede contribuir de 2 formas:

- **Incurrencias ó errores:** en caso que observes que alguna traducción se ha realizado incorrectamente(ó faltante) favor de dejar una nota en la siguiente _URL_:

> <https://github.com/mundoSICA/Magento_1.6.x_translation_es_MX/issues>

- **Solicitud para agregar de tus cambios:** Si realizaste alguna mejora (p.e la traducción ó corrección de ciertas etiquetas), por favor avisanos para incluir tus cambios, para esto puedes acudir a la siguiente _URL_:

> <https://github.com/mundoSICA/Magento_1.6.x_translation_es_MX/pulls>

Nosotros nos encargamos de revisar y mantener estos cambios, 


##Generando bifurcación de este proyecto.

En la segunda opción de como contribuir es necesario que usted obtenga una copia _canonica_ del repositorio (_sientase libre de hacerlo_). Para esto se recomienda seguir las instrucciones documentadas en el siguiente enlace:

- <http://help.github.com/fork-a-repo/>

Una vez que tengas una copia de este repositorio usted puede _jugar_ con su copia como considere conveniente.


##Uso del script `auxiliar.sh`.

Para facilitar el desarrollo de la tradducción hemos desarrollado un guión(_script_) en bash nombrado como `auxiliar.sh`, que le facilita las siguientes tareas:

 - **Ordenar**: Ordena por orden alfabetico al tiempo que elimina las lineas repetidas.

		./auxiliar.sh -ordenar

 - **Instalación**: Copia los archivos(csv) en la carpeta app de la ruta instalación.

		./auxiliar.sh -instalar /var/www/mi_directorio_magento/
	 
 - **Buscar**: Busca en los archivos `.csv` la cadena pasada como argumento mostrando archivo/linea donde fue localizada.

		./auxiliar.sh -buscar "cadena buscada"

 - **Sin traducción**: Muestra los archivos en donde existan cadenas que no han sido traducidas,Asi como dichas cadenas y el numero de linea en donde se encuentran. Esto lo realiza cachando la repetición de la cadena p.e.
> "alguna cadena","alguna cadena"

		./auxiliar.sh -sin_traduccion
     
**Nota**: El script esta desarrollado para _Linux_ sin embargo usted lo puede correr sobre Windows instalando una shell p.e. **Cygwin** (mayor información <http://www.cygwin.com/> ).


