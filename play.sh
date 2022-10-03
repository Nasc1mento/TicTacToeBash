#!/bin/bash

#AUTOR
# Adryan Reis  <github.com/Nasc1mento>
#
#

source ./components/title.sh


declare -A values
values=([1]=1 [2]=2 [3]=3 [4]=4 [5]=5 [6]=6 [7]=7 [8]=8 [9]=9)
re_isnumber="^[0-9]+$"
player_turn=1 #temporary
square_root_table=$(echo "${#values[@]}" | awk '{print sqrt($1)}') #key


table(){
    echo -e "\n"
    echo -e "\t|‾‾‾‾‾|‾‾‾‾‾|‾‾‾‾‾|"
    echo -e "\t|  ${values[1]}  |  ${values[2]}  |  ${values[3]}  |"
    echo -e "\t|_____|_____|_____|"
    echo -e "\t|     |     |     |"
    echo -e "\t|  ${values[4]}  |  ${values[5]}  |  ${values[6]}  |"
    echo -e "\t|_____|_____|_____|"
    echo -e "\t|     |     |     |"
    echo -e "\t|  ${values[7]}  |  ${values[8]}  |  ${values[9]}  |"
    echo -e "\t|_____|_____|_____|"
    echo -e "\n"
}

check_board(){
    #row
    for (( i=1; i<=${#values[@]}; i+=$square_root_table ))
    do
        count_row=0
        for (( j=$i; j<=$square_root_table; j++ ))
        do
            if  [[ "${values[$j]}" == "${values[$((i+j))]}" ]]; then count_row=$((count_row+1)); fi
            if [[ "$count_row" == "$((square_root_table-1))" ]]; then echo "row"; winner true; fi
        done
    done
    #col
    for (( i=1; i<=$square_root_table; i++ ))
    do
        count_col=0
        for (( j=$i; j<=${#values[@]}; j+=$square_root_table ))
        do
            if  [[ "${values[$j]}" == "${values[$((j+square_root_table))]}" ]]; then count_col=$((count_col+1)); fi
            if [[ "$count_col" == "$((square_root_table-1))" ]]; then echo "col"; winner true; fi
        done
    done
    #diagonal_right
    for (( j=1; j<=${#values[@]}; j+=$square_root_table+1 ))
    do
        count_diagonal_right=0
        if  [[ "${values[$j]}" == "${values[$((j+square_root_table+1))]}" ]]; then count_diagonal_right=$((count_diagonal_right+1)); fi
        if [[ "$count_diagonal_right" == "$((square_root_table-1))" ]]; then echo "dr"; winner true; fi
    done
    #diagonal_left
    for (( j=$square_root_table; j<=${#values[@]}; j+=$square_root_table-1 ))
    do
        count_diagonal_left=0
        if  [[ "${values[$j]}" == "${values[$((j+square_root_table-1))]}" ]]; then count_diagonal_left=$((count_diagonal_left+1)); fi
        if [[ "$count_diagonal_left" == "$((square_root_table-1))" ]]; then echo "dl"; winner true; fi
    done 
}


plays(){
    if [ $player_turn -eq 1 ]
    then
        values[$index]="X"
    elif [ $player_turn -eq 2 ]
    then
        values[$index]="O"
    fi
}

loop(){
    while [ $(winner) == false ]
    do
	echo "Turn: $(current_player)"
        check_play
        plays index
        table
        check_board index
        change
    done
}


change(){
    if [ $player_turn -eq 1 ]
    then
        player_turn=2
    elif [ $player_turn -eq 2 ]
    then
        player_turn=1
    fi
}

create_player(){
    read -p "Player 1 name: " player1
    read -p "Player 2 name: " player2
}

current_player(){
    if [ $player_turn -eq 1 ]
    then
        echo $player1
    elif [ $player_turn -eq 2 ]
    then
        echo $player2
    fi
}

check_play(){
    read -p "> " index
    while ! [[ $index =~ $re_isnumber ]] || ! [[ ${values[$index]} =~ $re_isnumber ]]; do check_play index; done
}

winner(){
    if [ "$1" == "true" ]; then echo "$(current_player) Win !!!"; exit; fi
    echo false
}

is_tie(){
    echo ""
}

main(){
    print_title
    create_player
    table
    loop
}

main



