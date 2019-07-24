#!/bin/bash
trglk_is(){ # треугольник или не треугольник
local a=$1
local b=$2
local c=$3   
 if [[ $(($a + $b)) -gt $c &&  $(($b + $c)) -gt $a && $(($c + $a)) -gt $b ]]; then  trglk "$a" "$b" "$c" >&2
     else echo "такого треугольника нет"
fi
}

trglk(){ #какой именно треугольник
local a=$1
local b=$2
local c=$3

 if [ $a -eq $b ] && [ $a -eq $c ] && [ $b -eq $c ]; then
    echo "равносторонний" 
   elif [ $a -eq $b -o $a -eq $c -o $b -eq $c ]; then
    echo "равнобедренный"
      else echo "просто треугольник"
fi
}

input(){ #проверяем входящие символы

local a=$2
local b=$3
local c=$4
if [ -z "${a//[0-9]}" ] && [ -n "$a" ] && [ -z "${b//[0-9]}" ] && [ -n "$b" ] && [ -z "${c//[0-9]}" ] && [ -n "$c" ]; then trglk_is "$a" "$b" "$c" >&2
else echo "не верные вводные" 
fi


}

run_tests() { 
  set -x -e

    [ "$(trglk 10 10 10)" = "равносторонний" ]
    [ "$(trglk 7 8 7)" = "равнобедренный" ]
    [ "$(trglk 8 7 7)" = "равнобедренный" ]
    [ "$(trglk 7 7 8)" = "равнобедренный" ]
    [ "$(input h y i)" = "не верные вводные" ]
    [ "$(input 7 о 10)" = "не верные вводные" ]
    [ "$(input \* 8 19)" = "не верные вводные" ]
    [ "$(trglk_is 0 7 9 )" = "такого треугольника нет" ]
    [ "$(input \& 0 u )" = "не верные вводные" ]

}

main(){
        echo -n "Введите целочисленное положительное значение a b c через пробел или табуляцию: "
        read  a b c
        input $a $b $c  #функция проверки введенных значений
}
if [ "$1" = "--test" ]; then 
 run_tests
#a=$2
#b=$3
#c=$4
#input  $a $b $c
#trglk $a $b $c
#trglk_is $a $b $c

else  main

fi
