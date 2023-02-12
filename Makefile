run: 
	docker build -t posti .;
	docker run --name postigrest -p 5433:5432 -e POSTGRES_PASSWORD=mysecretpassword -d posti:latest;
	./postgrest postgrest.conf;

stop:
	docker stop postigrest
	docker rm postigrest