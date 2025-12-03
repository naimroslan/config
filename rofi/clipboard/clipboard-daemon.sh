#!/usr/bin/env bash

db="$HOME/.clipboard.sqlite"

# Initialize database if it doesn't exist
if [ ! -f "$db" ]; then
    sqlite3 "$db" "
    CREATE TABLE c (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, contents text);
    CREATE INDEX IF NOT EXISTS idx_id ON c(id DESC);
    CREATE TRIGGER rotate_rows AFTER INSERT ON c
    BEGIN
        DELETE FROM c WHERE id <= (SELECT id FROM c ORDER BY id DESC LIMIT 1000, 1);
    END;
    "
fi

# Function to insert clipboard content
insert_clipboard() {
    local content
    content="$(cat)"
    if [ -n "$content" ]; then
        # Escape single quotes for SQL
        content="$(echo "$content" | sed "s/'/''/g")"
        sqlite3 "$db" "INSERT INTO c (contents) VALUES ('$content');" 2>/dev/null
    fi
}

# Export function so wl-paste can use it
export -f insert_clipboard
export db

# Watch clipboard and insert new content
wl-paste -w bash -c 'insert_clipboard'
