#!/bin/bash

#AUTOR
# Adryan Reis  <github.com/Nasc1mento>
#
#
source ./lib/print_components.sh
source ./lib/table.sh

check_board(){
    count_play=$((count_play+1))
    #row
    for (( i=1; i<=${#values[@]}; i+=$square_root_table ))
    do
        count_row=0
        for (( j=$i; j<=$i+$square_root_table-2; j++ ))
        do
            if  [[ "${values[$j]}" == "${values[$((j+1))]}" ]]; then count_row=$((count_row+1)); fi
            if [[ "$count_row" == "$((square_root_table-1))" ]]; then winner true; fi
        done
    done
    #col
    for (( i=1; i<=$square_root_table; i++ ))
    do
        count_col=0
        for (( j=$i; j<=${#values[@]}; j+=$square_root_table ))
        do
            if  [[ "${values[$j]}" == "${values[$((j+square_root_table))]}" ]]; then count_col=$((count_col+1)); fi
            if [[ "$count_col" == "$((square_root_table-1))" ]]; then winner true; fi
        done
    done
    #diagonal_right
    count_diagonal_right=0
    for (( j=1; j<=${#values[@]}; j+=$square_root_table+1 ))
    do
        if  [[ "${values[$j]}" == "${values[$((j+square_root_table+1))]}" ]]; then count_diagonal_right=$((count_diagonal_right+1)); fi
        if [[ "$count_diagonal_right" == "$((square_root_table-1))" ]]; then winner true; fi
    done
    #diagonal_left
    count_diagonal_left=0
    for (( j=$square_root_table; j<=${#values[@]}; j+=$square_root_table-1 ))
    do
        if  [[ "${values[$j]}" == "${values[$((j+square_root_table-1))]}" ]]; then count_diagonal_left=$((count_diagonal_left+1)); fi
        if [[ "$count_diagonal_left" == "$((square_root_table-1))" ]]; then winner true; fi
    done

    [ $count_play -eq ${#values[@]} ] && is_tie
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
    #[ "$1" == "true" ] && echo "$(current_player) Win !!!" && exit
    if [ "$1" == "true" ]; then 
        echo "$(current_player) Win !!!"
        save_csv $(current_player)
        exit
    fi
    echo false
}

is_tie(){
    echo "Tie !!!"
    save_csv "Tie"
    exit
}


save_csv(){
    File="components/log.csv"
    Header="Player1,Player2,Date,Winner,Modality"
    [ -s $File ] || echo $Header >> $File
    echo "$player1,$player2,`date`,$1,$square_root_table x $square_root_table" >> $File
}


start(){
    create_player
    re_isnumber="^[0-9]+$"
    player_turn=1
    echo -e "\nInsert the length of table (Ex.: 3->3x3; 4->4x4...) between 2 and 9"
    check_length
    mount_array $resp_length
    square_root_table=$(echo "${#values[@]}" | awk '{print sqrt($1)}')
    show_table
    loop
}

menu(){
    _PRINT "title.txt"
    index=""
    for option in "Start game" "About" "Exit"; do
        index=$(($index+1))
        echo "[$index]$option"
    done
    read -p $'\n> ' choice
    case $choice in
        1) start;;
        2) _PRINT "about.txt" && menu;;
        3) exit;;
    esac
}

menu
