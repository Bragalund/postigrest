build:
	docker build -f postgres_Dockerfile -t postgres_local .;
	docker build -f postgREST_Dockerfile -t postgrest_local .;

run: 
	docker-compose up;

stop:
	docker-compose down;
	
