use dotenvy::dotenv;

pub struct Config {
    pub jwt_salt: String,
    pub jwt_secret: String,
    pub jwt_expiration: String,
}

pub fn load_env() -> Config {
    dotenv().ok();

    let JWT_SALT = std::env::var("JWT_SALT").unwrap_or_else(|_| {
        panic!("JWT_SALT environment variable is not set");
    });
    let JWT_SECRET = std::env::var("JWT_SECRET").unwrap_or_else(|_| {
        panic!("JWT_SECRET environment variable is not set");
    });
    let JWT_EXPIRATION = std::env::var("JWT_EXPIRATION").unwrap_or_else(|_| {
        panic!("JWT_EXPIRATION environment variable is not set");
    });

    return Config {
        jwt_salt: JWT_SALT,
        jwt_secret: JWT_SECRET,
        jwt_expiration: JWT_EXPIRATION,
    };
}
