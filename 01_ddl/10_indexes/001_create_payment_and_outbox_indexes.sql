-- "the payments of a barbershop, newest first" (GET /api/v1/payments)
CREATE INDEX IF NOT EXISTS idx_payment_barbershop_created ON platform_admin.payment (barbershop_id, created_at DESC);
-- "paidUntil of a barbershop": the approved payments by end of period (DEC-PLAT-07)
CREATE INDEX IF NOT EXISTS idx_payment_barbershop_period ON platform_admin.payment (barbershop_id, period_end)
    WHERE status = 'APPROVED';
-- foreign key columns are always indexed
CREATE INDEX IF NOT EXISTS idx_payment_plan_id ON platform_admin.payment (plan_id);
-- the worker's read: pending events only, oldest first (ADR-016)
CREATE INDEX IF NOT EXISTS idx_outbox_event_unpublished ON platform_admin.outbox_event (occurred_at)
    WHERE published_at IS NULL AND failed_at IS NULL;
