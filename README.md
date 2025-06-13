# Postgres Setup for MacOS and Homebrew

## 1- Install [Homebrew](https://brew.sh/)

- 1.1- If you don't have Homebrew already installed:

    ```bash
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    ```

## 2- Install Postgres

- 2.1- Use Homebrew to install Postgres:

    ```bash
    brew update && brew install postgresql@17
    ```

- 2.2- Review the "Caveats" section of the installation output, and add Postgres to the PATH:

    ```bash
    echo 'export PATH="/opt/homebrew/opt/postgresql@17/bin:$PATH"' >> ~/.zshrc
    ```

- 2.3- Reload the Terminal:

    ```bash
    source ~/.zshrc
    ```

- 2.4- Start the Postgres service on every computer startup:

    ```bash
    brew services start postgresql@17
    ```

- 2.5- Verify that the service is running:

    ```bash
    brew services list
    ```

- 2.6- Extras (Do NOT do this):

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

- 3.1- Check versions:

    ```bash
    postgres --version
    psql --version
    ```

- 3.2- Connect to the `postgres` database:

    ```bash
    psql postgres
    ```

- 3.3- Disconnect from the `postgres` database:

    ```sql
    \q
    ```

## 4- Create a `create_user_table.sql` file (included in this repo)

- 4.1- The quotes around the table name enforce case sensitivity (Prisma likes CamelCase table names):

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

- 5.1- Create a `test_db` database:

    ```bash
    createdb test_db
    ```

    (Alternatively, create a `test_db` database using [PgAdmin4](https://formulae.brew.sh/cask/pgadmin4).)

- 5.2- Execute the `create_user_table.sql` file to create the "User" table and seed some data:

    ```bash
    psql -d test_db -f create_user_table.sql
    ```

- 5.3- Connect to the `test_db` database:

    ```bash
    psql test_db
    ```

- 5.4- Run a query:

    ```sql
    SELECT * FROM "User";
    ```

- 5.5- Disconnect from the `test_db` database:

    ```sql
    \q
    ```

- 5.6- Delete the `test_db` database:

    ```bash
    dropdb test_db
    ```

    (Alternatively, delete the `test_db` database using [PgAdmin4](https://formulae.brew.sh/cask/pgadmin4).)

## 6- Install [PgAdmin4](https://formulae.brew.sh/cask/pgadmin4)

- 6.1- Use Homebrew to install PgAdmin4:

    ```bash
    brew install --cask pgadmin4
    ```
