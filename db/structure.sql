CREATE TABLE "beer_clubs" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar, "founded" integer, "city" varchar, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "beers" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar, "style" varchar, "brewery_id" integer, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "breweries" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar, "year" integer, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "memberships" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "beer_club_id" integer, "user_id" integer, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "ratings" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "score" integer, "beer_id" integer, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "user_id" integer);
CREATE TABLE "schema_migrations" ("version" varchar NOT NULL);
CREATE TABLE "users" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "username" varchar, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "password_digest" varchar);
CREATE UNIQUE INDEX "unique_schema_migrations" ON "schema_migrations" ("version");
INSERT INTO schema_migrations (version) VALUES ('20150116100859');

INSERT INTO schema_migrations (version) VALUES ('20150116135651');

INSERT INTO schema_migrations (version) VALUES ('20150123092830');

INSERT INTO schema_migrations (version) VALUES ('20150130095106');

INSERT INTO schema_migrations (version) VALUES ('20150131122242');

INSERT INTO schema_migrations (version) VALUES ('20150201131342');

INSERT INTO schema_migrations (version) VALUES ('20150201132416');

INSERT INTO schema_migrations (version) VALUES ('20150201172605');

