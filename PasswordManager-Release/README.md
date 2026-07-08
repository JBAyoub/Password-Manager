# Password Manager

## Requirements

- Docker Desktop

## First Run

Clone or download this release.

Copy

```text
.env.example
```

to

```text
.env
```

Then

```bash
docker compose up -d
```

This starts PostgreSQL.

Now create your vault

```bash
password-manager.exe vault create -m "MyStrongPassword"
```

Unlock

```bash
password-manager.exe vault unlock -m "MyStrongPassword"
```

Store credentials

```bash
password-manager.exe credentials add ...
```

Stop PostgreSQL

```bash
docker compose down
```