#!/bin/sh -xe

APP=${1-./tr.sh}

expect_success() {
    set -e
    res="$(echo $1 $2 $3 | $APP)"
    [ "$res" = "$4" ]
    res="$(echo $1 $3 $2 | $APP)"
    [ "$res" = "$4" ]
    res="$(echo $2 $1 $3 | $APP)"
    [ "$res" = "$4" ]
    res="$(echo $2 $3 $1 | $APP)"
    [ "$res" = "$4" ]
    res="$(echo $3 $1 $2 | $APP)"
    [ "$res" = "$4" ]
    res="$(echo $3 $2 $1 | $APP)"
    [ "$res" = "$4" ]
    set +e
}

expect_fail() {
    set -e
    ! res="$(echo $1 $2 $3 | $APP)"
    [ -z "$res" ]
    ! res="$(echo $1 $3 $2 | $APP)"
    [ -z "$res" ] || echo "'$res'"
    ! res="$(echo $2 $1 $3 | $APP)"
    [ -z "$res" ]
    ! res="$(echo $2 $3 $1 | $APP)"
    [ -z "$res" ]
    ! res="$(echo $3 $1 $2 | $APP)"
    [ -z "$res" ]
    ! res="$(echo $3 $2 $1 | $APP)"
    [ -z "$res" ]
}

R="просто треугольник"
I="равнобедренный"
E="равносторонний"
N="такого треугольника нет"

expect_success 1 1 1 "$E"
expect_success 1000 1000 1000 "$E"
#expect_success 18446744073709551616 18446744073709551616 18446744073709551616 "$E"

expect_success 2 2 1 "$I"
expect_success 1000 1000 100 "$I"
#expect_success 18446744073709551616 18446744073709551616 18446744073709551615 "$I"

expect_success 4 3 2 "$R"
expect_success 4000 3000 2000 "$R"
#expect_success 1844674407370955161600 1844674407370955161601 1844674407370955161602 "$R"


expect_fail 0 0 0 
expect_fail -1 -1 -1
expect_fail a a a

expect_fail 0 0 1
expect_fail 0 0 a
expect_fail 0 0 -1
expect_fail -1 -1 1
expect_fail -1 -1 0
expect_fail -1 -1 a 
expect_fail a a 1
expect_fail a a 0
expect_fail a a -1

expect_fail 0 1 2
expect_fail 1 2 3
expect_fail a b c
expect_fail -1 -2 -3
expect_fail -1 0 -2
expect_fail -1 a 0

expect_fail 1 2 '3 4'
expect_fail 1 2
expect_fail '4 3 2 1'
