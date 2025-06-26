#!/bin/bash


dir_path=$1

# Проверяем, что директория существует и аргумент не пустой
if [[ ! -d $dir_path ]]; then
  echo "Usage: $0 <directory_path>"
  exit 1
fi

# Функция форматирования размера (целочисленное деление)
format_size() {
    local bytes=$1
    local units=("B" "K" "M" "G" "T")
    local index=0
    local size=$bytes

    while (( size >= 1024 && index < 4 )); do
        size=$(( size / 1024 ))
        ((index++))
    done

    echo "${size}${units[$index]}"
}

# Проходим по всем директориям и выводим размер файлов в каждой
find "$dir_path" -type d | while read -r dir; do
  size=$(find "$dir" -type f -printf "%s\n" | awk '{sum += $1} END {print sum+0}')
  hr_size=$(format_size "$size")
  echo "$dir: $hr_size"
done