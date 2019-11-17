#!/bin/bash

case $@ in
	-a )
		echo "un"
		nb=1
		;;
	-b )
		echo "deux"
		nb=2
		;;
	 * )
		echo "erreur"
		nb=3
		;;
esac

case $nb in
	1 )
		echo "1€"
		;;
	2 )
		echo "2€"
		;;
	3 )
		echo "3€ erreur"
		;;
	* )
		echo "erreur"
		;;
esac
