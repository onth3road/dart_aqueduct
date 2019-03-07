# Aqueduct & AngularDart Deployment

## Update Mar 7
Well, since I have no experience in web devlopment, at very beginning I thought there should be a server or 'something' host the app, and I think aqueduct is this something. But actually, if it only host static files, or very 'front end', it could just be a file anywhere that could be access through net.

But I really like aqueduct and its structure, then I think, it's a well-formed route system, so I could use it to make dart web app in separate slices. What I mean is that, every page or component is a module with view and functions which can be compile to a structure that contains bone(html), stlye(css), actions(js), resources(assets etc.), since I'm really new to everything, then why don't I make every intact page a 'web app' and use aqueduct to control routeings or auth or database relavant thing.

I think this made my work easier, but I lack experiences that I cannot tell if it is a stupid idea. But at first edition, I will do it as this way. 

And finally, I made it work as it supposed to be today... in a degree.

## Structure
It is a really small project, it uses **dart** as its language.

The *server* dirctory contains an aqueduct project. It runs as a server, handle http requests, route them to different *controllers*. 

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
```bash
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
```bash
# angulardart part, should get into target dir
stagehand web-angular
# aqueduct part
aqueduct create project_name
```
