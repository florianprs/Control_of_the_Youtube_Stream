# Control_of_the_Youtube_Stream

The goal of this project is to remote activate a Youtube Stream from a Raspberry Pi 2 or 3. You can use a smartphone or a computer for example.


## What you will need 

You will need the following: 

- Raspberry pi 2 or 3 with the lastest version of Raspbian
- an USB camera
- an internet connection
- an YouTube account
- breadboard
- 2 cables Raspberry (cable male to female)
- LED
- 330 ohm resistor

### 1. Update your Raspberry Pi

Open a terminal and insert those lines : 

```
sudo apt-get update 
sudo apt-get upgrade
sudo apt-get update
```

### 2. Install Apache

Apache is use tu create a server on the Raspberry Pi

```
sudo apt install apache2
```

### 3. Install PHP



```
sudo apt install php php-mbstring
```

### 4. Install WiringPi

WiringPi it's a way to control the GPIO port of the Raspberry.

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

We can finaly remove the wiringPi folder 
```
cd 
sudi rm -rf wiringPi
```

To test WiringPi you can use those lines

```
 gpio -v
 gpio readall
```

### 5. ServerN

Go to the folder of the Apache server

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

Make a stylesheet.css file for the graphical part

```
sudo nano stylesheet.css
```

Put those lines inside

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


Make a script.php file for the interrasction with the buttons

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

Open your web browser and go to the ipaddress of your Raspberry Pi.
To found it you can use ifconfig command.

```
ifconfig
```

Now you will see the two buttons. 

### 7. Connecte a LED

To see when the stream is on, you can connect a LED to the pin 7 (GPIO 4). Don't forget to put a resistor of 330 ohms. 

### 8. Interconnection between the server and the stream 

We will modifie the stream2youtube.sh from https://github.com/florianprs/Stream_RPI_Youtube.git.

### 9. Run the code

Then, copy Control_stream2Youtube.sh from the git to your Raspberry Pi. 
