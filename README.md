# Postgres env setup (MacOS)

## 1- Install Homebrew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

## 2- Install Postgres

```bash
brew update && brew install postgresql@17
```

Review the "Caveats" section of the installation output, and add postgres to the PATH:

```bash
echo 'export PATH="/opt/homebrew/opt/postgresql@17/bin:$PATH"' >> ~/.zshrc
```

Reload the terminal:

```bash
source ~/.zshrc
```

Make the postgres service begin on startup:

```bash
brew services start postgresql@17
```

Verify that the service is running:

```bash
brew services list
```

```bash
# ⚠️  Do NOT do this
# The above should work fine
# Only in case there are PATH issues
brew link postgresql@17 --force
```

```bash
# ⚠️  Do NOT do this
# It's just FYI
brew services stop postgresql@17
brew services restart postgresql@17
```

## 3- Verify installation

Check versions:

```bash
postgres --version
psql --version
```

Connect to the postgres database:

```bash
psql postgres
```

Disconnect from the postgres database:

```sql
\q
```

## 4- Create a `create_user_table.sql` file (included in this repo)

The quotes around the table name enforce case sensitivity (Prisma likes CamelCase table names):

```sql
CREATE TABLE IF NOT EXISTS "User" (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT NOW()
);
INSERT INTO "User" (name, email)
VALUES ('Alice', 'alice@example.com');
```

## 5- Create and test a postgres database

Create a `test_db` database:

```bash
createdb test_db
```

Execute the `create_user_table.sql` file to create the "User" table and seed some data:

```bash
psql -d test_db -f create_user_table.sql
```

Connect to the `test_db` database:

```bash
psql test_db
```

Run a query:

```sql
SELECT * FROM "User";
```

Disconnect from the `test_db` database:

```sql
\q
```

Delete the `test_db` database:

```bash
dropdb test_db
```
