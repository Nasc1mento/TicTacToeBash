#!/bin/bash
source ./lib/table.sh

resp_length=3
mount_array $resp_length
show_table
in_a_row=3
human="o"
computer="x"
is_maximizing="false"
depth=0

# board[2]=$computer
# board[3]=$computer

re_isnumber="^[0-9]+$"

current_player=$human


#10:computer;-10:player;0:running;1:tie
check_winner(){

    if [[ ${board[1]} == ${board[2]} ]] && [[ ${board[2]} == ${board[3]} ]]; then
        if [[ ${board[1]} == $computer ]]; then echo 10; fi
        if [[ ${board[1]} == $human ]]; then echo -10; fi
    fi
    if [[ ${board[4]} == ${board[5]} ]] && [[ ${board[5]} == ${board[6]} ]]; then
        if [[ ${board[5]} == $computer ]]; then echo 10; fi
        if [[ ${board[5]} == $human ]]; then echo -10; fi
    fi
    if [[ ${board[7]} == ${board[8]} ]] && [[ ${board[8]} == ${board[9]} ]]; then
        if [[ ${board[7]} == $computer ]]; then echo 10; fi
        if [[ ${board[7]} == $human ]]; then echo -10; fi
    fi
##################################################################################
    if [[ ${board[1]} == ${board[4]} ]] && [[ ${board[4]} == ${board[7]} ]]; then
        if [[ ${board[1]} == $computer ]]; then echo 10; fi
        if [[ ${board[1]} == $human ]]; then echo -10; fi
    fi
    if [[ ${board[2]} == ${board[5]} ]] && [[ ${board[5]} == ${board[8]} ]]; then
        if [[ ${board[1]} == $computer ]]; then echo 10; fi
        if [[ ${board[1]} == $human ]]; then echo -10; fi
    fi
    if [[ ${board[3]} == ${board[6]} ]] && [[ ${board[6]} == ${board[9]} ]]; then
        if [[ ${board[3]} == $computer ]]; then echo 10; fi
        if [[ ${board[3]} == $human ]]; then echo -10; fi
    fi
####################################################################################
    if [[ ${board[1]} == ${board[5]} ]] && [[ ${board[5]} == ${board[9]} ]]; then
        if [[ ${board[1]} == $computer ]]; then echo 10; fi
        if [[ ${board[1]} == $human ]]; then echo -10; fi
    fi
    if [[ ${board[3]} == ${board[5]} ]] && [[ ${board[5]} == ${board[7]} ]]; then
        if [[ ${board[3]} == $computer ]]; then echo 10; fi
        if [[ ${board[3]} == $human ]]; then echo -10; fi
    fi
###################################################################################
    for element in ${board[@]}
    do
        if [[ $element =~ $re_isnumber ]]; then echo "false"; return; fi
    done
    echo 0
}


human_move(){  
    while [[ $(check_winner) = "false" ]]
    do
        if [[ $current_player == $human ]]; then
            read -p "move" index
            board[$index]=$human
            current_player=$computer
            show_table
        else
            best_move
            show_table
        fi
    done 
}






best_move(){
    best_score_bm=-1000
    for (( i=1; i<=${#board[@]}; i++ ))
    do
        if [[ ${board[$i]} =~ $re_isnumber ]]; then
            board[$i]=$computer
            score_bm=$(minimax 0 "false")
            board[$i]=$i
            if [ $score_bm -gt $best_score_bm ]; then
                best_score_bm=$score_bm
                move=$i
                echo $i
            fi
        fi
    done
    board[$move]=$computer
    current_player=$human
    echo $maximizing
}


minimax(){
    result=$(check_winner)
    if [[ $result == 10 ]]; then
        echo result
        return
    fi

    if [[ $result == -10 ]]; then
        echo $result
        return
    fi

    if [[ $result == 0 ]]; then
        echo $result
        return
    fi
    
    if [[ $2 == "true" ]]; then
        maximize
    else
        minimize
    fi
}

maximize(){
    best_score_max=-1000

    for (( i=0; i<${#board[@]}; i++ ))
    do
        if [[ ${board[$i]} =~ $re_isnumber ]]; then
            board[$i]=$computer
            score_max=$(minimax 0 "true")
            
        fi
    done
}

minimize(){
    echo 1
}
human_move