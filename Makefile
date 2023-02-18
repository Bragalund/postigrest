build:
	docker build -f postgres_Dockerfile -t postgres_local .;
	docker build -f postgREST_Dockerfile -t postgrest_local .;
	docker build -f nginx_Dockerfile -t nginx_local .;

run: 
	docker-compose up -d;

stop:
	docker-compose down;
	