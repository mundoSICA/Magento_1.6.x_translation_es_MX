#!/bin/bash
# @autor:        fitorec <programacion@mundosica.com>
# @descripcion:	 Auxiliar en el manejo de los archivos de traducción.
# @copyright:    2011 SICÁ (tm)
# @package:      Magento_1.6.x_translation_es_MX
# @license:      MIT
# @url:          http://mundosica.github.com/Magento_1.6.x_translation_es_MX/
# @version:      0.0.1
#  _   _   _   _   _   _   _   _   _   _   _   _   _  
# / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ 
#( m | u | n | d | o | s | i | c | a | . | c | o | m )
# \_/ \_/ \_/ \_/ \_/ \_/ \_/ \_/ \_/ \_/ \_/ \_/ \_/ 
#
#             . --- .
#           /        \
#          |  O  _  O |
#          |  ./   \. |
#          /  `-._.-'  \
#        .' /         \ `.
#    .-~.-~/           \~-.~-.
#.-~ ~    |             |    ~ ~-.
#`- .     |             |     . -'
#     ~ - |             | - ~
#         \             /
#       ___\           /___
#      ~;_  >- . . -<  _i~
#          `'         `'
##########################################################################################


function manual()
{
	echo -e "NOMBRE
       auxiliar - Auxiliar en el manejo de los archivos de traducción.

SINOPSIS
       auxiliar  [-ordenar] [-instalar \"ruta de instalación\"]  [-buscar \"cadena buscada\"]

DESCRIPCIÓN
	  Auxiliar en el manejo de los archivos de traducción.
	  
	  Las opciones que este script acepta son las siguientes:
	  
	  -ordenar 
               Ordena por orden alfabetico al tiempo que elimina las lineas repetidas.
	  
	  -instalar  \"ruta de instalación\"
               copia archivo por archivo en la ruta de instalación los archivos csv.
	  
	  -buscar  \"Cadena buscada\"
               Busca en los archivos csv la cadena buscada mostrando archivo/linea donde fue localizada.
Ejemplos
	  ./auxiliar.sh -ordenar
	          Ordena las lineas de los archivos en la ruta donde nos localicemos.

	  ./auxiliar.sh -instalar /var/www/mi_directorio_magento/
	          Instala los archivos de traduccion en la carpeta /var/www/mi_directorio_magento/

	  ./auxiliar.sh -buscar \"cadena buscada\"
	          Busca  \"cadena buscada\" en los archivos csv.
";
}

function ordenar()
{
	light='\e[1;36m'
	yellow="\e[0;33m"
	NC='\e[0m'
	export num=0;
	for file in $(find . -iregex '.*\.csv$' | sort)
        do
			echo -e ${num}.-${light}Ord Archivo:${NC}  ${yellow}${file}${NC};
			sort -u $file -o $file;
			export num=`expr $num '+' 1`
	done
}

function instalar()
{
	if [ -d "${1}/app/" ];
	then
		echo "Instalando en el directorio ${1}";
		cp -r -f app ${1}
	else
		echo -e "Error Directorio inexistente y/o invalido(no contiene la estructura de Magento):\n\t${1}\nfavor de revisar!";
	fi
}

function buscar()
{
	grep --color -RHns "^\"${1}" app
}

if [ $# -lt 1 ]
then
	manual
	echo 'numero de argumentos invalidos';
	exit
fi

case "${1}" in
	"-ordenar") 
		ordenar;
		exit 0
		;;
	"-instalar")
		if [ $# -lt 2 ]
		then
			manual
			echo 'por favor ingrese la ruta de instalación';
			echo 'USE:';
			echo "     ./$0 -instalar \"ruta de instalación\"";
			exit
		fi
		instalar $2
		exit 0
		;;
	"-buscar")
		if [ $# -lt 2 ]
		then
			manual
			echo 'por favor ingrese la cadena buscada';
			echo 'USE:';
			echo "     ./$0 -buscar \"cadena buscada\"";
			
			exit
		fi
		#export cadena='${2}'
		#for (( i=3; i<=$#; i++ )); do
		#  export cadena+=' ${'$i'}'
		#done
		# echo `eval $cadena`
		#exit;
		buscar "${2}"
		exit 0
		;;
	*)
		manual
		echo $1
		exit 1
	   ;;
esac
