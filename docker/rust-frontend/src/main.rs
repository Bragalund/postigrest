use actix_web::{
    get,
    web::{self, Data},
    App, HttpResponse, HttpServer, Responder,
};
use reqwest::Client;
use serde::Deserialize;

#[derive(Clone)]
struct AppState {
    client: Client,
    postgrest_base_url: String,
}

#[derive(Deserialize)]
struct Todo {
    id: i32,
    task: String,
    done: bool,
}

#[get("/")]
async fn index() -> impl Responder {
    HttpResponse::Ok()
        .content_type("text/html; charset=utf-8")
        .body(
            r##"<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <script src="https://unpkg.com/htmx.org@1.9.12"></script>
    <title>Postigrest + HTMX</title>
  </head>
  <body>
    <h1>Todos</h1>
    <button hx-get="/todos" hx-target="#todos" hx-swap="innerHTML">Load todos</button>
    <ul id="todos"></ul>
  </body>
</html>"##,
        )
}

#[get("/health")]
async fn health() -> impl Responder {
    HttpResponse::Ok().body("ok")
}

#[get("/todos")]
async fn render_todos(state: Data<AppState>) -> impl Responder {
    let url = format!(
        "{}/todos?select=id,task,done&order=id.desc",
        state.postgrest_base_url
    );

    match state.client.get(url).send().await {
        Ok(response) => match response.error_for_status() {
            Ok(valid_response) => match valid_response.json::<Vec<Todo>>().await {
                Ok(todos) => {
                    let html = if todos.is_empty() {
                        "<li>No todos found</li>".to_string()
                    } else {
                        todos
                            .iter()
                            .map(|todo| {
                                format!(
                                    "<li data-id=\"{}\">{} {}</li>",
                                    todo.id,
                                    if todo.done { "✅" } else { "⬜" },
                                    todo.task
                                )
                            })
                            .collect::<Vec<String>>()
                            .join("\n")
                    };

                    HttpResponse::Ok()
                        .content_type("text/html; charset=utf-8")
                        .body(html)
                }
                Err(error) => HttpResponse::BadGateway()
                    .content_type("text/plain; charset=utf-8")
                    .body(format!("Failed to decode todos: {error}")),
            },
            Err(error) => HttpResponse::BadGateway()
                .content_type("text/plain; charset=utf-8")
                .body(format!("Upstream returned error: {error}")),
        },
        Err(error) => HttpResponse::BadGateway()
            .content_type("text/plain; charset=utf-8")
            .body(format!("Unable to reach PostgREST API: {error}")),
    }
}

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    let state = AppState {
        client: Client::new(),
        postgrest_base_url: std::env::var("POSTGREST_BASE_URL")
            .unwrap_or_else(|_| "http://postgrest_api:3000".to_string()),
    };

    HttpServer::new(move || {
        App::new()
            .app_data(web::Data::new(state.clone()))
            .service(index)
            .service(health)
            .service(render_todos)
    })
    .bind(("0.0.0.0", 3000))?
    .run()
    .await
}
