#!/bin/bash

#AUTOR
# Adryan Reis  <github.com/Nasc1mento>
#
#
source ./lib/print_components.sh
source ./lib/table.sh
source ./lib/persistence.sh

check_board(){
    count_play=$((count_play+1))
    #row
    for (( i=1; i<=${#values[@]}; i+=$square_root_table ))
    do
        count_row=0
        for (( j=$i; j<=$i+$square_root_table-2; j++ ))
        do
            [[ "${values[$j]}" == "${values[$((j+1))]}" ]] && count_row=$((count_row+1))
            [[ "$count_row" == "$((square_root_table-1))" ]] && winner true
        done
    done
    #col
    for (( i=1; i<=$square_root_table; i++ ))
    do
        count_col=0
        for (( j=$i; j<=${#values[@]}; j+=$square_root_table ))
        do
            [[ "${values[$j]}" == "${values[$((j+square_root_table))]}" ]] && count_col=$((count_col+1))
            [[ "$count_col" == "$((square_root_table-1))" ]] && winner true
        done
    done
    #diagonal_right
    count_diagonal_right=0
    for (( j=1; j<=${#values[@]}; j+=$square_root_table+1 ))
    do
        [[ "${values[$j]}" == "${values[$((j+square_root_table+1))]}" ]] && count_diagonal_right=$((count_diagonal_right+1))
        [[ "$count_diagonal_right" == "$((square_root_table-1))" ]] && winner true
    done
    #diagonal_left
    count_diagonal_left=0
    for (( j=$square_root_table; j<=${#values[@]}; j+=$square_root_table-1 ))
    do
        [[ "${values[$j]}" == "${values[$((j+square_root_table-1))]}" ]] && count_diagonal_left=$((count_diagonal_left+1))
        [[ "$count_diagonal_left" == "$((square_root_table-1))" ]] && winner true
    done

    [ $count_play -eq ${#values[@]} ] && is_tie
}


sort_player(){
    echo -e "\nSorting Player...\n" | awk '{print toupper($0)}'
    sleep 1
    player_turn=$[ ( $RANDOM % 2 )  + 1 ]
    echo -e "\nPlayer $(current_player) is going first\n" 
    sleep 1
}

plays(){
    [ $player_turn -eq 1 ] && values[$index]="X" || values[$index]="O" 
}

loop(){
    while [ $(winner) == false ]
    do
	echo "Turn: $(current_player)"
        check_play
        plays index
        show_table
        check_board
        change
    done
}


change(){ 
    [ $player_turn -eq 1 ] && player_turn=2 || player_turn=1
}

create_player(){
    read -p "Player 1 name: " player1
    read -p "Player 2 name: " player2
}

current_player(){
    [ $player_turn -eq 1 ] && echo $player1 || echo $player2
}

check_play(){
    read -p "> " index
    if ! [[ $index =~ $re_isnumber ]] || ! [[ ${values[$index]} =~ $re_isnumber ]]; then check_play index; fi
}

winner(){
    if [ "$1" == "true" ]; then 
        echo "$(current_player) Win !!!"
        persistence $(current_player)
        reset
        menu
    fi
    echo false
}

is_tie(){
    echo "Tie !!!"
    persistence "Tie"
    exit
}


reset(){
    count_play=0
    values=()
}

start(){
    create_player
    re_isnumber="^[0-9]+$"
    sort_player
    echo -e "Insert the length of table (Ex.: 3->3x3; 4->4x4...) between 2 and 9"
    check_length
    mount_array $resp_length
    square_root_table=$(echo "${#values[@]}" | awk '{print sqrt($1)}')
    show_table
    loop
}

menu(){
    _PRINT "title.txt"
    index=""
    for option in "Start game" "About" "Show History" "Clear History" "Exit"; do
        index=$(($index+1))
        echo "[$index]$option"
    done
    read -p $'\n> ' choice
    case $choice in
        1) start;;
        2) _PRINT "about.txt" && menu;;
        3) show_persistence && menu;;
        4) clear_persistence && menu;;
        5) exit;;
    esac
}

menu
