-- The test realm's one account: DUI, password DUI, game master everywhere (tools/realm/up.sh).
INSERT IGNORE INTO account (username, salt, verifier, expansion) VALUES ('DUI', X'6f9475c6d9fc90dd9cea26de522043e2c8d8d015e120ff5c1bb43d47ae365a7f', X'399ca19352c7b4d417c000f4999739857484a17283744c3a02e79457d262cd85', 2);
INSERT IGNORE INTO account_access (id, gmlevel, RealmID) SELECT id, 3, -1 FROM account WHERE username = 'DUI';
