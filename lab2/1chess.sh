#!/bin/bash

validate_input() {
  if [[ ! $1 =~ ^[1-9][0-9]*$ ]]; then
    echo "Ошибка: введите положительное число"
    exit 1
fi
}

print_chessboard() {
    local size=$1
    local white="\033[47m  \033[0m"
    local black="\033[40m  \033[0m"

    for ((i=0; i<size; i++)); do
        for ((j=0; j<size; j++)); do

            if [ $(( (i + j) % 2 )) -eq 0 ]; then
                echo -ne "$white"
            else
                echo -ne "$black"
            fi
        done
        echo
    done
}

echo "Введите размер шахматной доски:"
read size
validate_input "$size"
print_chessboard "$size"
