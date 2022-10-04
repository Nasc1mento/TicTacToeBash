_PRINT(){
	while IFS= read -r read_while_line
	do
		echo "$read_while_line"
	done < ./components/"$1"
}
