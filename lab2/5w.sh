#!/bin/bash


if [ ! -d "$1" ]; then
  echo "'$1' не является директорией"
  exit 1
fi

if ! [[ "$3" =~ ^[1-9][0-9]*$ ]]; then
  echo "Введите положительное целое в третьем аргументе"
  exit 1
fi


STOPWORDS_FILE="$4"

# устанавливает 
declare -A word_count  
declare -A stopwords  

# Если задан файл со стоп-словами и он существует — считываем его построчно
if [[ -n "$STOPWORDS_FILE" && -f "$STOPWORDS_FILE" ]]; then
  while IFS= read -r word; do 
    stopwords["$word"]=1  
  done < "$STOPWORDS_FILE"
fi
# изв тс  бим ррв  и одно и более б-ц з
words=$(find "$1" -type f -name "*.$2" -exec grep -ohE "\w+" {} + | tr '[:upper:]' '[:lower:]')


if [[ -z "$words" ]]; then
  echo "Нет слов для анализа."
  exit 0
fi


# читаем каждое слово, если оно не входит в список стоп-слов — увеличиваем счётчик
while IFS= read -r word; do
  [[ -z "${stopwords[$word]}" ]] && ((word_count["$word"]++))
done <<< "$words"

# cпвп   чсо
for word in "${!word_count[@]}"; do
  echo "$word: ${word_count[$word]}"
done | sort -k2nr | head -n "$3"
