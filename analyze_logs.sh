
report="report.txt"
{
echo "Отчет о логе веб-сервера" 
echo -e "========================\n"


count_all=$(cat access.log | wc -l) 
echo "Общее количество запросов: $count_all" 

echo "---------------------------------------" 

count_unique=$(awk '{ count[$1]++ } END { print length(count) }' access.log)
echo "Количество уникальных IP-адресов: $count_unique" 

echo "---------------------------------------" 

echo "Количество запросов по методам:" 
awk -F'[ "]+' '{print $6}' access.log | sort | uniq -c 

echo "---------------------------------------" 

echo "Самый популярный URL: "$(awk -F'[ "]+' '{print $7}' access.log | sort | uniq -c | sort -nr | head -n 1)
echo "---------------------------------------" 

} > "$report"
echo "Файл сохранен: $report"
