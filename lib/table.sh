check_length(){
    read -p "> " resp_length
    while ! [[ $resp_length =~ $re_isnumber ]] || [ $resp_length -gt 9 ] || [ $resp_length -lt 2 ]; do check_length resp_length; done
}
mount_array(){
    for (( i=1; i<=$resp_length*$resp_length; i++ ))
    do
        values[$i]=$i
    done
}

table_core(){
	for (( i=1; i<=${#values[@]}; i+=$square_root_table ))
	do
		#reset
		middle_top=""
		middle_core=""
		middle_bottom=""
		for (( j=$i; j<=$i+$square_root_table-1; j++ ))
		do
			middle_core+="_____|"
			middle_bottom+="     |"
			if ! [[ ${values[$j]} =~ $re_isnumber ]]; then middle_top+="  ${values[j]}  |"; continue; fi
			[ $j -ge 10 ] && middle_top+="  ${values[j]} |" || middle_top+="  ${values[j]}  |"
		done
		echo -e "\t|$middle_top"
		echo -e "\t|$middle_core"
		[[ $i == $(( ${#values[@]} - $square_root_table + 1)) ]] && break || echo -e "\t|$middle_bottom"
		
	done
}


table_top(){
	#reset
	top=""
	for (( i=1; i<=${#values[@]}; i+=$square_root_table ))
	do
		top+="‾‾‾‾‾|"
	done
	echo -e "\t|$top"
}

show_table(){
	table_top
	table_core
}