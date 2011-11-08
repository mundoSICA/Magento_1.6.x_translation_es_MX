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

export LANG=es_MX.utf8
cyan='\e[0;36m'
light='\e[1;36m'
red="\e[0;31m"
yellow="\e[0;33m"
white="\e[0;37m"
NC='\e[0m'
	
function manual()
{
	echo -e "${light}NOMBRE${NC}
       auxiliar - Auxiliar en el manejo de los archivos de traducción.

${light}SINOPSIS${NC}
       auxiliar  [-ordenar] [-instalar \"ruta de instalación\"]  [-buscar \"cadena buscada\"] [-sin_traduccion]

${light}DESCRIPCIÓN${NC}
	  Auxiliar en el manejo de los archivos de traducción.
	  
	  Las opciones que este script acepta son las siguientes:
	  
	  ${yellow}-ordenar${NC}
               Ordena por orden alfabetico al tiempo que elimina las lineas repetidas.
	  
	  ${yellow}-instalar  \"ruta de instalación\"${NC}
               Copia los archivos(csv) en la carpeta app de la ruta instalación.
	  
	  ${yellow}-buscar  \"Cadena buscada\"${NC}
              Busca en los archivos .csv la cadena pasada como argumento mostrando archivo/linea donde fue localizada.
              
          ${yellow}-sin_traduccion${NC}
              Muestra los archivos en donde existan cadenas que no han sido traducidas,
              Asi como dichas cadenas y el numero de linea en donde se encuentran.
              Esto lo realiza cachando la repetición de la cadena p.e.
                   \"alguna cadena\",\"alguna cadena\"

${light}Ejemplos${NC}
	  ${cyan}./auxiliar.sh -ordenar${NC}
	          Ordena las lineas de los archivos en la ruta donde nos localicemos.

	  ${cyan}./auxiliar.sh -instalar /var/www/mi_directorio_magento/${NC}
	          Instala los archivos de traduccion en la carpeta /var/www/mi_directorio_magento/

	  ${cyan}./auxiliar.sh -buscar \"cadena buscada\"${NC}
	          Busca  \"cadena buscada\" en los archivos csv.

	  ${cyan}./auxiliar.sh -sin_traduccion${NC}
	          Mostrando los archivos y sus cadenas que no han sido traducidas.
";
}

function ordenar()
{
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

function sin_traduccion()
{
	export num=0;
	for file in $(find . -iregex '.*\.csv$' | sort)
        do
			grep -Eq '"(.*)","(\1)"' ${file};
			if [ $? -eq 0 ]
			then
				echo -e ${light}Archivo ${num}${NC}  ${yellow}${file}${NC};
				grep --color -Ehn '"(.*)","(\1)"' ${file};
				export num=`expr $num '+' 1`;
			fi
	done
}

if [ $# -lt 1 ]
then
	manual
	echo -e ${red}numero de argumentos invalidos${NC};
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
	"-sin_traduccion")
		sin_traduccion
		;;
	*)
		manual
		echo $1
		exit 1
	   ;;
esac
