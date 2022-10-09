check_length(){
    read -p '> ' resp_length
    while ! [[ $resp_length =~ $re_isnumber ]] || [ $resp_length -gt 9 ] || [ $resp_length -lt 2 ]; do check_length resp_length; done
}
mount_array(){
    for (( i=1; i<=$resp_length*$resp_length; i++ ))
    do
        board[$i]=$i
    done
}

table_core(){
	for (( i=1; i<=${#board[@]}; i+=$resp_length ))
	do
		#reset
		middle_top=""
		middle_core=""
		middle_bottom=""
		for (( j=$i; j<=$i+$resp_length-1; j++ ))
		do
			middle_core+="_____|"
			middle_bottom+="     |"
			if ! [[ ${board[$j]} =~ $re_isnumber ]]; then middle_top+="  ${board[j]}  |"; continue; fi
			[ $j -ge 10 ] && middle_top+="  ${board[j]} |" || middle_top+="  ${board[j]}  |"
		done
		echo -e "\t|$middle_top"
		echo -e "\t|$middle_core"
		[[ $i == $(( ${#board[@]} - $resp_length + 1)) ]] && break || echo -e "\t|$middle_bottom"
	done
}


table_top(){
	#reset
	top=""
	for (( i=1; i<=${#board[@]}; i+=$resp_length ))
	do
		top+="‾‾‾‾‾|"
	done
	echo -e "\t|$top"
}

show_table(){
	table_top
	table_core
}

#square_root_table=$(echo "${#board[@]}" | awk '{print sqrt($1)}')