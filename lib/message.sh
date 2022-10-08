msg_board_length(){
    echo -e "Insert the length of board (Ex.: 3->3x3; 4->4x4...) between 2 and 9"
}

msg_in_a_row(){
    echo -e "How many in a row? Insert a number equal or greater than 3, less or equal the length of board"
}

msg_sorting_player(){
    echo -e "\nSorting Player...\n" | awk '{print toupper($0)}'
}

msg_going_first_player(){
     echo -e "\nPlayer $(current_player) is going first\n" 
}

msg_current_player(){
    echo "Turn: $(current_player)"
}

msg_player_winner(){
    echo "$(current_player) Win !!!"
}

msg_tie(){
    echo "Tie !!!"
}