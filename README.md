# Postgres env setup (Apple Silicon)

## 1- Install Homebrew

```bash
# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

## 2- Install Postgres

```bash
brew update
brew install postgresql@17
# Check the "Caveats" section of the installation output:
echo 'export PATH="/opt/homebrew/opt/postgresql@17/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

```bash
brew services start postgresql@17
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

```bash
postgres --version
psql --version
# Drop into the postgres database
psql postgres
```

```sql
-- to disconnect from the postgres database
\q
```

## 4- Create a `create_user_table.sql` file

```sql
-- Quotes around table name Prisma style
CREATE TABLE IF NOT EXISTS "User" (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT NOW()
);
INSERT INTO "User" (name, email)
VALUES ('Alice', 'alice@example.com');
```

## 5- Create a test database

```bash
createdb test_db
psql -d test_db -f create_user_table.sql
# Connect to the test_db database
psql test_db
```

```sql
SELECT * FROM "User";
```
