# Password Manager CLI

A secure command-line password manager written in Dart.

Passwords are encrypted using a master password before being stored in a PostgreSQL database. The application never stores the master password itself. Only encrypted credentials.

## Features

* Secure vault protected by a master password
* AES-256 encryption for stored passwords
* PostgreSQL database backend
* Cross-platform standalone executable
* Simple command-line interface

---

## Requirements

Before using the application, install:

* Docker Desktop
* Git (optional)
* The compiled executable for your operating system

---

## Project Structure

```text
PasswordManager-Release/
│
├── password-manager.exe
├── docker-compose.yml
├── .env
└── migrations/
```

---

## 1. Configure the Database

Create a `.env` file in the same directory as `docker-compose.yml`.

Example:

```env
DB_HOST=localhost
DB_PORT=5433
DB_NAME=password_manager
DB_USER=postgres
DB_PASSWORD=change-me
```

---

## 2. Start PostgreSQL

Run:

```bash
docker compose up -d
```

Verify the container is running:

```bash
docker ps
```

You should see something similar to:

```text
password-db
0.0.0.0:5433->5432/tcp
```

Leave this container running while using the application.

---

## 3. Create Your Vault

Run:

```bash
password-manager.exe vault create -m "YourStrongMasterPassword"
```

Example:

```bash
password-manager.exe vault create -m "CorrectHorseBatteryStaple123!"
```

This creates your encrypted vault.

**Important:** If you forget your master password, your stored passwords cannot be recovered.

---

## Managing Credentials

### Add a credential

```bash
password-manager.exe credentials add -m "YourStrongMasterPassword" -u "<USERNAME>" -p "<PASSWORD>" -w "<GITHUB.COM>"
```

### List stored credentials

```bash
password-manager.exe credentials display -m "YourStrongMasterPassword"
```

### Delete a credential

```bash
password-manager.exe credentials delete -id 5 -m "YourStrongMasterPassword"
```

> Run `--help` after any command to see its available options.

Example:

```bash
password-manager.exe credentials --help
```

or

```bash
password-manager.exe vault --help
```

---

## Security

* Passwords are encrypted before being written to the database.
* The master password is never stored.
* The encryption key exists only while the vault is unlocked.
* Losing the master password means the encrypted data cannot be decrypted.

---

## Database

The application uses PostgreSQL running inside Docker.

The executable connects to:

```
Host: localhost
Port: 5433
```

The Docker container exposes PostgreSQL on port **5433**, which is forwarded to PostgreSQL's internal port **5432**.

---

## Stopping the Database

To stop PostgreSQL:

```bash
docker compose down
```

To stop it while keeping your data:

```bash
docker compose stop
```

Your passwords remain stored because Docker keeps the named volume (`postgres-data`).

---

## Troubleshooting

### Failed host lookup

Ensure PostgreSQL is running:

```bash
docker ps
```

### Connection refused

Verify Docker Desktop is running and that port **5433** is available.

### Vault already exists

A vault has already been created. Unlock the existing vault instead of creating a new one.

---

## License

This project is provided for educational and personal use.
