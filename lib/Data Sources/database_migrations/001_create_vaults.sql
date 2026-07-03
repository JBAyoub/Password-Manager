CREATE TABLE IF NOT EXISTS vaults (
    id SERIAL PRIMARY KEY,
    salt BYTEA NOT NULL,
    verification_cipher BYTEA NOT NULL,
    verification_nonce BYTEA NOT NULL,
    verification_mac BYTEA NOT NULL
);