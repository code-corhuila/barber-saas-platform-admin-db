-- Creating a plan carries an Idempotency-Key (norm 5.3.8): the key and the plan are written in
-- one transaction, and a retry returns the same plan (06-data/models.md §10).
CREATE TABLE platform_admin.idempotency_key (
    key            text        NOT NULL,
    operation      text        NOT NULL,
    resource_id    uuid        NOT NULL,
    request_hash   text        NOT NULL,
    created_at     timestamptz NOT NULL DEFAULT now(),
    CONSTRAINT pk_idempotency_key PRIMARY KEY (key, operation),
    CONSTRAINT chk_idempotency_key_length CHECK (char_length(key) BETWEEN 8 AND 128)
);
