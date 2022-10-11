#!/bin/bash

#AUTOR
# Adryan Reis  <github.com/Nasc1mento>
#
#
source ./lib/print_components.sh
source ./lib/table.sh
source ./lib/persistence.sh
source ./lib/message.sh


# check winner
check_winner(){
    count_play=$((count_play+1))
    #row
    for (( i=1; i<=${#board[@]}; i+=$resp_length ))
    do
        count_row=0
        for (( j=$i; j<=$i+$resp_length-2; j++ ))
        do
            [[ "${board[$j]}" == "${board[$((j+1))]}" ]] && count_row=$((count_row+1))
            [[ $count_row -eq $((in_a_row-1)) ]] && winner true
        done
    done
    #col
    for (( i=1; i<=$resp_length; i++ ))
    do
        count_col=0
        for (( j=$i; j<=${#board[@]}; j+=$resp_length ))
        do
            [[ "${board[$j]}" == "${board[$((j+resp_length))]}" ]] && count_col=$((count_col+1))
            [[ $count_col -eq $((in_a_row-1)) ]] && winner true
        done
    done
    #diagonal_right
    count_diagonal_right=0
    for (( j=1; j<=${#board[@]}; j+=$resp_length+1 ))
    do
        [[ "${board[$j]}" == "${board[$((j+resp_length+1))]}" ]] && count_diagonal_right=$((count_diagonal_right+1))
        [[ $count_diagonal_right -eq $((in_a_row-1)) ]] && winner true
    done
    #diagonal_left
    count_diagonal_left=0
    for (( j=$resp_length; j<=${#board[@]}; j+=$resp_length-1 ))
    do
        [[ "${board[$j]}" == "${board[$((j+resp_length-1))]}" ]] && count_diagonal_left=$((count_diagonal_left+1))
        [[ $count_diagonal_left -eq $((in_a_row-1)) ]] && winner true
    done

    [ $count_play -eq ${#board[@]} ] && is_tie
}

# sort player
sort_player(){
    msg_sorting_player
    sleep 1
    player_turn=$[ ( $RANDOM % 2 )  + 1 ]
    msg_going_first_player
    sleep 1
}

# write O/X
write(){
    [ $player_turn -eq 1 ] && board[$index]="X" || board[$index]="O" 
}

# loop game
loop(){
    while [ $(winner) == false ]
    do
        msg_current_player
        check_play
        write index
        show_table
        check_winner
        change
    done
}

# change turn 
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
    if ! [[ $index =~ $re_isnumber ]] || ! [[ ${board[$index]} =~ $re_isnumber ]]; then check_play index; fi
}

winner(){
    if [ "$1" == "true" ]; then 
        msg_player_winner
        persistence $(current_player)
        reset
        menu
    fi
    echo false
}

is_tie(){
    msg_tie
    persistence "Tie"
    reset
    menu
    exit
}

row_win_condition(){
    read -p '>' in_a_row
    if [[ $in_a_row -lt 2 ]] || [[ $in_a_row -gt 20 ]] || [[ $in_a_row -gt $resp_length ]]; then
        row_win_condition
    fi
}

reset(){
    count_play=0
    board=()
}

start(){
    create_player
    re_isnumber="^[0-9]+$"
    sort_player
    msg_board_length
    check_length
    mount_array $resp_length
    msg_in_a_row
    row_win_condition
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
