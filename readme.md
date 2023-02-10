# Postigrest  

Project for experimenting with postrest and htmx.
Postgrest is an api on top of a postgres-database.  
Htmx is a js library that makes you write html-like syntax.  

Both of these frameworks combined reduces a lot of overhead! No backendapi. No Singlepage-app.  

Just html(htmx) and sql!  


## Run locally  

First, run postgres database initialized with db-script    
```shell
docker build -t posti .
docker run --name posti_container -p 5433:5432 \
                -e POSTGRES_PASSWORD=mysecretpassword \
                -d posti:latest
```

Second, run postgrest with config  
```shell  
./postgrest tutorial.conf
```

Go to index.html in your browser:  
/home/YOURUSERNAME/path/to/code/postigrest/index.html

## Configuration of database  

Connect to database to do changes  
```shell 
docker exec -it tutorial psql -U postgres  
```

## Install postgrest  

```shell  
wget "https://github.com/PostgREST/postgrest/releases/download/v10.1.2/postgrest-v10.1.2-linux-static-x64.tar.xz"  
tar xJf postgrest-v10.1.2-linux-static-x64.tar.xz  
./postgrest  
```

## Inspiration  

[tutorial postgrest](https://postgrest.org/en/stable/tutorials/tut0.html)  

[Htmx docs](https://htmx.org/)  
