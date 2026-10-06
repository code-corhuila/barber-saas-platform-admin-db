-- The plans a barbershop can have (FR-024, 06-data/models.md §9). Money in cents of COP (ADR-010).
-- Barbershops point at a plan by id from their own schema; there is no foreign key across domains.
CREATE TABLE platform_admin.subscription_plan (
    id             uuid        NOT NULL,
    name           text        NOT NULL,
    price_cents    bigint      NOT NULL,
    max_barbers    integer     NOT NULL,
    features_json  jsonb       NULL,
    is_active      boolean     NOT NULL DEFAULT true,
    created_at     timestamptz NOT NULL DEFAULT now(),
    CONSTRAINT pk_subscription_plan PRIMARY KEY (id),
    CONSTRAINT uq_subscription_plan_name UNIQUE (name),
    CONSTRAINT chk_subscription_plan_name CHECK (char_length(name) BETWEEN 1 AND 50),
    CONSTRAINT chk_subscription_plan_price CHECK (price_cents >= 0),
    CONSTRAINT chk_subscription_plan_max_barbers CHECK (max_barbers >= 1)
);
