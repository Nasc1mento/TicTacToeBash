File="components/log.csv"
Header="Player1,Player2,Date,Winner,Modality"
persistence(){
    [ -s $File ] || echo $Header >> $File
    echo "$player1,$player2,`date`,$1,$square_root_table x $square_root_table" >> $File
}


show_persistence(){
    _PRINT "history.txt"
    [ -f $File ] && sed 's/,,/, ,/g;s/,,/, ,/g' $File | column -s, -t
}
    

clear_persistence(){
    > $File
}