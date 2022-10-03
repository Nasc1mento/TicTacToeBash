#read -p "Tamanho: " length
values=([1]=1 [2]=2 [3]=3 [4]=4 [5]=5 [6]=6 [7]=7 [8]=8 [9]=9 [10]=10 [11]=11 [12]=12 [13]=13 [14]=14 [15]=15 [16]=16)
#[10]=10 [11]=11 [12]=12 [13]=13 [14]=14 [15]=15 [16]=16
square_root_table=$(echo "${#values[@]}" | awk '{print sqrt($1)}') #key



show_table(){
	echo -e "\n"
	for (( i=1; i<=${#values[@]}; i+=$square_root_table ))
	do
		middle_top=""
		middle_core=""
		middle_bottom=""
		for (( j=$i; j<=$i+$square_root_table-1; j++ ))
		do
		#middle_top+="  ${values[j]}  |"
		if [ $j -ge 10 ]; then middle_top+="  ${values[j]} |"; else middle_top+="  ${values[j]}  |"; fi
		middle_core+="_____|"
		middle_bottom+="     |"
		#if  [[ $j<=${#values[@]}-square_root_table-1 ]]; then middle_bottom+="     |"; fi

		done
		echo -e "\t|$middle_top"
		echo -e "\t|$middle_core"
		echo -e "\t|$middle_bottom"
	done
	echo -e "\n"
}




#./table.sh: line 13: i+square_root_table-1: command not found
#./table.sh: line 13: ((: j<=: syntax error: operand expected (error token is "<=")



