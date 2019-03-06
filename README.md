# Aqueduct & AngularDart Deployment

## Structure
It is a really small project, it uses **dart** as its language.

The *server* dirctory contains an aqueduct project. It runs as a server, handle http requests, route them to different *controller*. 

The *client* dirctory contains an angulardart project. For now, it host ui interactions and so on.

## Deployment

The two project could run separately. 

Server Project Part: get into server dir
```bash
# get dependencies
pub get
# start aqueduct server
aqueduct serve
# above command will omit config written in main.dart
# if specify port or threads should use:
dart ./bin/main.dart
```

Client Project Part: get into client dir
```
# get dependencies
pub get
# if debug on local server, could use
webdev serve
# webdev use 8080 as default, and test on 8081
webdev serve web:5100 test:5101
# when deploy, should compile files into javascript files, using
# then it would generate files in build dirctory
pub run build_runner build -r -o web:build
```

## Initial Version

Both server and client part offer handful empty project using:
```
# angulardart part, should get into target dir
stagehand web-angular
# aqueduct part
aqueduct create project_name
```
