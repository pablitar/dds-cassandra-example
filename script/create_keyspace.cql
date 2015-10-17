CREATE KEYSPACE foro WITH REPLICATION = { 'class' : 'SimpleStrategy', 'replication_factor' : 1 };

CREATE TYPE foro.comment_user (
   username text,
   displayName text
);

CREATE TYPE foro.comment (
   comment text,
   user frozen<comment_user>,
   timestamp bigint
);

CREATE TYPE foro.post (
   content text,
   comments list<frozen<comment>>,
   timestamp bigint
);

CREATE TABLE foro.users (
   username text PRIMARY KEY,
   displayName text,
   posts list<frozen<post>>
);