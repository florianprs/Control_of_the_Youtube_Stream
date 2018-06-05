# Control_of_the_Youtube_Stream

The purpose of this project is to remote activate a Youtube Stream from a Raspberry Pi 2 or 3. You can use your computer, for example, or even your smartphone. This video shows the final version of this tutorial : https://youtu.be/l9Hk3dre_84  


## What will you need 

You will need these followings: 

- Raspberry pi 2 or 3 with the lastest version of Raspbian
- an USB camera
- an internet connection
- an YouTube account
- a breadboard
- 2 jumper wires male to female 
- a LED
- a 330 ohm resistor

### 1. Update your Raspberry Pi

Open a terminal and insert those lines : 

```
sudo apt-get update 
sudo apt-get upgrade
sudo apt-get update
```

### 2. Install Apache

Apache is used to create a server on the Raspberry Pi. Use this line in a terminal to install Apache : 

```
sudo apt install apache2
```

### 3. Install PHP

Same things that the Apache installation : 

```
sudo apt install php php-mbstring
```

### 4. Install WiringPi

WiringPi is a library to control the GPIO port of the Raspberry.

First we need to install git

``` 
sudo apt-get install git-core
```

After we copy the WiringPi library 

```
git clone git://git.drogon.net/wiringPi
```

Now we can install it

```
cd wiringPi
sudo git pull origin
./build
```

We can finaly remove the WiringPi folder 
```
cd 
sudi rm -rf wiringPi
```

To test WiringPi you can use those lines

```
 gpio -v
 gpio readall
```

Normaly, you will see something like this picture https://i.stack.imgur.com/v7Dam.png 

### 5. ServerN

Go to the Apache server folder

```
cd /var/www/html
```

Delete the index.html file

```
sudo rm -rf index.html
```

Make a inde.php file

```
sudo nano index.php
```

Put those lines inside

```
<!doctype html>
<html lang="fr">
    <head>
        
        <meta charset="utf-8">
        <title>Contrôle GPIO</title>
        
        <link rel="stylesheet" type="text/css" href="stylesheet.css">
        
    </head>
    <body>
        
        <form action="script.php" method="post">
            <input type="submit" name="executer" value="ON" class="button" id="ON">
            <br/>
            <input type="submit" name="executer" value="OFF" class="button" id="OFF">
        </form>
        
    </body>
</html>
```

After that, make a stylesheet.css file for the graphical part

```
sudo nano stylesheet.css
```

Put those lines inside this .css file

```
html, body
{
    margin: 0;
}

.button 
{
    border: none;
    color: white;
    text-align: center;
    font-size: 10em;
    padding: 25px 25px;
    cursor: pointer;
    width: 100%;
    height: 50vh;
}

#ON
{
    background-color: green;
}

#OFF
{
    background-color: red;
    
}
```


Make a script.php file for the interraction with the buttons

```
sudo nano script.php
```

```
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
```

### 6. Acces to the server

Find the IP address of your Raspberry Pi.
To find it, use ifconfig command in a terminal.

```
ifconfig
```

Open a web browser and insert this IP adress.

Now you will see the two buttons. The green ON button(start the stream) and the red OFF button (stop live video). 
### 7. Connecte a LED

Check if the stream is on, then you can connect a LED to the pin 7 (GPIO 4). Don't forget to put a 330 ohms resistor. 

### 8. Run the code

Finally, copy the file "Control_stream2Youtube.sh" from this git to your Raspberry Pi. You can paste this file to the folder /home/pi. 
Open a terminal in this folder and run this script : 

```
bash Control_stream2Youtube.sh

```
