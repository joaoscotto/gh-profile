CREATE TABLE IF NOT EXISTS "schema_migrations" ("version" varchar NOT NULL PRIMARY KEY);
CREATE TABLE IF NOT EXISTS "ar_internal_metadata" ("key" varchar NOT NULL PRIMARY KEY, "value" varchar, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL);
CREATE TABLE IF NOT EXISTS "profiles" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar, "url" varchar, "short_url" varchar, "username" varchar, "followers" varchar, "following" varchar, "organization" varchar, "location" varchar, "stars" integer, "last_year_contributions" integer, "avatar_url" varchar, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL);
CREATE VIRTUAL TABLE profiles_fts USING fts5(
        name,
        url,
        short_url,
        username,
        followers,
        following,
        organization,
        location,
        stars UNINDEXED,
        last_year_contributions UNINDEXED,
        avatar_url,
        content='profiles',
        content_rowid='id'
      )
/* profiles_fts(name,url,short_url,username,followers,"following",organization,location,stars,last_year_contributions,avatar_url) */;
CREATE TABLE IF NOT EXISTS 'profiles_fts_data'(id INTEGER PRIMARY KEY, block BLOB);
CREATE TABLE IF NOT EXISTS 'profiles_fts_idx'(segid, term, pgno, PRIMARY KEY(segid, term)) WITHOUT ROWID;
CREATE TABLE IF NOT EXISTS 'profiles_fts_docsize'(id INTEGER PRIMARY KEY, sz BLOB);
CREATE TABLE IF NOT EXISTS 'profiles_fts_config'(k PRIMARY KEY, v) WITHOUT ROWID;
INSERT INTO "schema_migrations" (version) VALUES
('20251026192539');

