#!/bin/bash


declare -A values
values=([1]=1 [2]=2 [3]=3 [4]=4 [5]=5 [6]=6 [7]=7 [8]=8 [9]=9)
re_isnumber="^[0-9]+$"
player_turn=1



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
    if [[ "${values[1]}" == "X" ]] && [[ "${values[2]}" == "X" ]] && [[ "${values[3]}" == "X" ]] 
    then echo "sim"
    else
        echo "na0"
    fi
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
        read -p " Where do you want to play $(current_player)? " index
        plays index
        table
        check_board
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


winner(){
    echo false
}


main(){
    create_player
    table
    loop
}

main




