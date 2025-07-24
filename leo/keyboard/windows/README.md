# Features:
- [x] Control and Escape Key on CapsLock
- [ ] Compose key (Original Ctrl-Left)
    - [ ] Brackets ([{}]) alternative easy mapping
    - [ ] Special characters (esszet & türkisch)

# CapsLock Behaviour

TLDR: 
- Press Win+R and type "shell:startup"
- Copy the "leo_keyboard.ahk" file into the opened folder

## Theory

To facilitate my life, i would like to change my CapsLock behaviour:
- single press: ESC
- press with other key: CTRL+{key}

## Implementation 

This can be implemented using AutoHotKey v2. 

The file that does contains the script for the CapsLock behaviour is 'leo_keyboard.ahk'

Running this file will set the wanted behaviour. 

To make this persistent, we need to put in our Windows startup folder:

Press Win+R and enter "shell:startup". 
This will open the startup folder.
Copy the "leo_keyboard.ahk" file into this folder

# Special characters: 
 
These alternative mappings are all with the Left-Ctrl Key (that is unused now that we use CapsLock for Ctrl)

Currently supported characters are:

Ctrl+s = ş
Ctrl+z = ß
Ctrl+y = ı
Ctrl+g = ğ
Ctrl+c = ç

# Alternative Brackets:

Alt-Mappings for [{()}] brackets also use the Left-Ctrl Key:

Ctrl+j = ( - also creates '()'
Ctrl+k = [ - also creates '[]'
Ctrl+l = { - also creates '{}'

Ctrl+u = )
Ctrl+i = ]
Ctrl+o = }


