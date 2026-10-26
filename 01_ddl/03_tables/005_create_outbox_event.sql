-- platform-admin now publishes PlanExpiringSoon and BarbershopSuspended (DEC-PLAT-07): the change and
-- its event in one transaction (norm 5.3.11), relayed by barber-saas-worker (ADR-016).
CREATE TABLE platform_admin.outbox_event (
    id              uuid        NOT NULL,
    aggregate_type  text        NOT NULL,
    aggregate_id    uuid        NOT NULL,
    event_type      text        NOT NULL,
    payload         jsonb       NOT NULL,
    correlation_id  text        NOT NULL,
    occurred_at     timestamptz NOT NULL DEFAULT now(),
    published_at    timestamptz NULL,
    failed_at       timestamptz NULL,
    last_error      text        NULL,
    CONSTRAINT pk_outbox_event PRIMARY KEY (id),
    CONSTRAINT chk_outbox_event_last_error CHECK (char_length(last_error) <= 500)
);
