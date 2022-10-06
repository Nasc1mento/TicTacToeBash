File="components/log.csv"
Header="Player1,Player2,Date,Winner,Modality,InARow Modality"
persistence(){
    [ -s $File ] || echo $Header >> $File
    echo "$player1,$player2,`date`,$1,$square_root_table x $square_root_table,$in_a_row" >> $File
}


show_persistence(){
    _PRINT "history.txt"
    # File exists and it's empty
    [ -f $File ] && [ -s $File ] && sed 's/,,/, ,/g;s/,,/, ,/g' $File | column -s, -t || echo "Empty!"
}
    

clear_persistence(){
    > $File
}