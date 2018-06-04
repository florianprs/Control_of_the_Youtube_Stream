<?php

    system("gpio -g mode 4 out");
    
    if($_POST['executer'] == 'ON')
    {
        system("gpio -g write 4 1");
    }
    else
    {
        system("gpio -g write 4 0");
    }

    header('Location: index.php');
    
?>
