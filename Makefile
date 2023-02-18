run: 
	docker build -f postgres_Dockerfile -t postgres_local .;
	docker build -f postgREST_Dockerfile -t postgrest_local .;
	docker build -f nginx_apihardening_Dockerfile -t nginx_api_local .;
	docker build -f nginx_frontend_Dockerfile -t nginx_local .;
	docker-compose up --remove-orphans;

stop:
	docker-compose down;
	