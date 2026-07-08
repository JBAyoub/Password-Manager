CREATE TABLE IF NOT EXISTS credentials(

          id SERIAL PRIMARY KEY,

          website TEXT NOT NULL,

          username TEXT NOT NULL,

          cipher_text BYTEA NOT NULL,

          nonce BYTEA NOT NULL,

          mac BYTEA NOT NULL

);