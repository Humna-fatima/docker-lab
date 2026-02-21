
#!/usr/bin/env sh

# 1. Wait for database connection (MOVED TO TOP)
while ! nc -z "$POSTGRES_HOST" "$POSTGRES_PORT"; do
  sleep 10
  printf "Database %s:%s not ready" "$POSTGRES_HOST" "$POSTGRES_PORT"
done

# 2. Wait a bit more for readiness
sleep 10

# 3. Now run migrations
alembic upgrade head

# 4. Start the app
exec "$@"

# Wait for database connection
while ! nc -z "$POSTGRES_HOST" "$POSTGRES_PORT"; do
  sleep 10
  printf "Database %s:%s not ready" "$POSTGRES_HOST" "$POSTGRES_PORT"
done
# Make sure database is ready to accept connections
sleep 10

