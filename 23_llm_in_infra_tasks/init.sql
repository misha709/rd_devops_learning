SELECT 'CREATE DATABASE form_db'
WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'form_db')\gexec

\c form_db

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";  -- For UUID generation
CREATE EXTENSION IF NOT EXISTS "pg_trgm";    -- For text search and similarity

CREATE SCHEMA IF NOT EXISTS public;

GRANT ALL ON SCHEMA public TO PUBLIC;

ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO PUBLIC;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON SEQUENCES TO PUBLIC;

CREATE TABLE IF NOT EXISTS public.form_events (
    id bigserial primary key,
    name text not null,
    email text not null,
    email_normalized text not null unique,
    request_type text null,
    comment text null,
    priority text null,
    status text not null,
    telegram_sent boolean not null default false,
    telegram_error text null,
    created_at timestamptz not null default now(),
    updated_at timestamptz not null default now()
);