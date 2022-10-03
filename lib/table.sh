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

show_table(){
	echo -e "\n"
	for (( i=1; i<=${#values[@]}; i+=$square_root_table ))
	do
		middle_top=""
		middle_core=""
		middle_bottom=""
		for (( j=$i; j<=$i+$square_root_table-1; j++ ))
		do
		if [ $j -ge 10 ]; then middle_top+="  ${values[j]} |"; else middle_top+="  ${values[j]}  |"; fi
		middle_core+="_____|"
		middle_bottom+="     |"
		done
		echo -e "\t|$middle_top"
		echo -e "\t|$middle_core"
		echo -e "\t|$middle_bottom"
	done
	echo -e "\n"
}