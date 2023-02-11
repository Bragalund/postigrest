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
/home/YOURUSERNAME/path/to/code/postigrest/[index.html](index.html)

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

## Install pgadmin4 on ubuntu with apt  

```shell
#
# Setup the repository
#

# Install the public key for the repository (if not done previously):
curl -fsS https://www.pgadmin.org/static/packages_pgadmin_org.pub | sudo gpg --dearmor -o /usr/share/keyrings/packages-pgadmin-org.gpg

# Create the repository configuration file:
sudo sh -c 'echo "deb [signed-by=/usr/share/keyrings/packages-pgadmin-org.gpg] https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/$(lsb_release -cs) pgadmin4 main" > /etc/apt/sources.list.d/pgadmin4.list && apt update'

#
# Install pgAdmin
#

# Install for both desktop and web modes:
sudo apt install pgadmin4 -y;

# Install for desktop mode only:
sudo apt install pgadmin4-desktop
```

## Inspiration  

[tutorial postgrest](https://postgrest.org/en/stable/tutorials/tut0.html)  

[Htmx docs](https://htmx.org/)  
