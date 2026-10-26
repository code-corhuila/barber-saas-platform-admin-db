-- One notice per barbershop, end date and threshold (HU-SADMIN-004): the daily job never warns twice.
CREATE TABLE platform_admin.subscription_notice (
    barbershop_id  uuid        NOT NULL,
    ends_at        timestamptz NOT NULL,
    threshold      text        NOT NULL,
    created_at     timestamptz NOT NULL DEFAULT now(),
    CONSTRAINT pk_subscription_notice PRIMARY KEY (barbershop_id, ends_at, threshold),
    CONSTRAINT chk_subscription_notice_threshold CHECK (threshold IN ('DAYS_7','DAYS_1'))
);
