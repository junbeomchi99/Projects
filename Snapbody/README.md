# snapbody_mobile

SNAPBODY MOBILE  

Flutter Project

Frontend: Flutter
Backend: Firebase, Python

# File name, Widge Name, Variable Name Rules:

File name: use lower case names separated by underbar.

    param_get_it.dart
    param_screen.dart
    parma_datasource.dart
   
Widge Name: Use CamelCase with first alphabet as capital 

    CaramelWidget
    AlbumScreen
    HomeScreen
    
Varible name: use camelCase with first alphabet as small letters 

    nativeColor
    thisIsVariable


#  snapbody_mobile Folder directory

### /device/$DocumentPath
* pictures - pictures input into snapbody record 
* slideshows - slideshows

### /asset - Image to be used in the application 

### /lib - Source Code
* constant - constant used throughout the application (e.g. color, font, style, enum, etc.)
* data
  - datasource - Class for connection to data storage 
  - model - Class for data model, data mapping function 
  - repository - Class for determing and configuring data source 
* screen - UI folder
  - controller ( logic / to be used for getx )
  - to be used for provider/bloc provider/bloc ( logic )
* service - for services provided by external resources 
* util - classes and functions that can be used throughout the app
* widget - Custom widgets with independent functions for use in the UI
* test - test code
