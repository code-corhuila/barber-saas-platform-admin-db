-- The plans of 06-data/models.md §9, converted from the prototype's seed (prices in cents of COP).
-- Idempotent: an upsert on the unique name, so running it again changes nothing. Fixed ids keep the
-- same plan across environments.
INSERT INTO platform_admin.subscription_plan (id, name, price_cents, max_barbers, features_json, is_active)
VALUES
    ('7b0e2f4a-1c3d-4e5f-8a9b-000000000001', 'Basico',  4990000,   2, NULL, true),
    ('7b0e2f4a-1c3d-4e5f-8a9b-000000000002', 'Pro',     9990000,   6, NULL, true),
    ('7b0e2f4a-1c3d-4e5f-8a9b-000000000003', 'Premium', 17990000, 999, NULL, true)
ON CONFLICT (name) DO UPDATE
    SET price_cents = EXCLUDED.price_cents,
        max_barbers = EXCLUDED.max_barbers;
