source ./lib/table.sh

resp_length=3
mount_array $resp_length
show_table


# copy=(${board[@]})
# # echo ${copy[@]}
# copy[2]=99

human="o"
computer="x"
re_isnumber="^[0-9]+$"

current_player=$human

check_winner(){

    #row
    for (( i=1; i<=${#board[@]}; i+=$resp_length ))
    do
        count_row=0
        for (( j=$i; j<=$i+$resp_length-2; j++ ))
        do
            [[ "${board[$j]}" == "${board[$((j+1))]}" ]] && count_row=$((count_row+1))
            [[ $count_row -eq $((in_a_row-1)) ]] && echo true
        done
    done
    #col
    for (( i=1; i<=$resp_length; i++ ))
    do
        count_col=0
        for (( j=$i; j<=${#board[@]}; j+=$resp_length ))
        do
            [[ "${board[$j]}" == "${board[$((j+resp_length))]}" ]] && count_col=$((count_col+1))
            [[ $count_col -eq $((in_a_row-1)) ]] && echo true
        done
    done
    #diagonal_right
    count_diagonal_right=0
    for (( j=1; j<=${#board[@]}; j+=$resp_length+1 ))
    do
        [[ "${board[$j]}" == "${board[$((j+resp_length+1))]}" ]] && count_diagonal_right=$((count_diagonal_right+1))
        [[ $count_diagonal_right -eq $((in_a_row-1)) ]] && echo true
    done
    #diagonal_left
    count_diagonal_left=0
    for (( j=$resp_length; j<=${#board[@]}; j+=$resp_length-1 ))
    do
        [[ "${board[$j]}" == "${board[$((j+resp_length-1))]}" ]] && count_diagonal_left=$((count_diagonal_left+1))
        [[ $count_diagonal_left -eq $((in_a_row-1)) ]] && echo true
    done


}


human_move(){  
    if [[ $current_player == $human ]]; then
        read -p "move" index
        board[$index]=$human
        current_player=$computer
        show_table
        best_move
        show_table
    fi
}


best_move(){

    best_score=-1000
    best_move=""

    for (( i=1; i<=${#board[@]}; i++ ))
    do
        if [[ ${board[$i]} =~ $re_isnumber ]]; then
            board[$i]=$computer
            score=$(minimax)
            board[$i]=$i
            if [ $score -gt $best_score ]; then
                best_score=$score
                best_move=$i
                echo $i
            fi
        fi
    done
    board[$best_move]=$computer
    current_player=$human
}


minimax(){
    echo 1
}

human_move

