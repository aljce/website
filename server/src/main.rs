#[macro_use] extern crate nickel;

use nickel::{Nickel, HttpRouter, StaticFilesHandler};

fn main() {
    let mut server = Nickel::new();
    let mut router = Nickel::router();

    router.get("/api/ping", middleware!("pong"));

    server.utilize(StaticFilesHandler::new("../../client"));
    server.utilize(router);

    server.listen("localhost:3000");
}
