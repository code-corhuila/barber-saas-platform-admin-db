-- A plan payment through Wompi in sandbox (ADR-017, DEC-PLAT-05/06): PENDING until Wompi's signed
-- event says otherwise. paidUntil is not stored: it is max(period_end) of the APPROVED payments.
-- New changeset: the applied ones are never edited (Liquibase checksums).
CREATE TABLE platform_admin.payment (
    id                       uuid        NOT NULL,
    barbershop_id            uuid        NOT NULL,
    plan_id                  uuid        NOT NULL,
    plan_name                text        NOT NULL,
    reference                text        NOT NULL,
    amount_cents             bigint      NOT NULL,
    currency                 text        NOT NULL DEFAULT 'COP',
    status                   text        NOT NULL DEFAULT 'PENDING',
    provider_transaction_id  text        NULL,
    period_end               timestamptz NULL,
    created_at               timestamptz NOT NULL DEFAULT now(),
    updated_at               timestamptz NOT NULL DEFAULT now(),
    CONSTRAINT pk_payment PRIMARY KEY (id),
    CONSTRAINT uq_payment_reference UNIQUE (reference),
    CONSTRAINT uq_payment_provider_transaction UNIQUE (provider_transaction_id),
    CONSTRAINT chk_payment_status   CHECK (status IN ('PENDING','APPROVED','DECLINED','VOIDED','ERROR')),
    CONSTRAINT chk_payment_amount   CHECK (amount_cents > 0),
    CONSTRAINT chk_payment_currency CHECK (currency = 'COP'),
    CONSTRAINT chk_payment_period   CHECK ((status = 'APPROVED') = (period_end IS NOT NULL)),
    CONSTRAINT chk_payment_reference CHECK (char_length(reference) BETWEEN 1 AND 64)
);
