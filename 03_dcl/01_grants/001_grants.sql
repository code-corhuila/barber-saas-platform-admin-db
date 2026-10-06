GRANT USAGE ON SCHEMA platform_admin TO platform_admin_reader, platform_admin_writer;
GRANT SELECT ON ALL TABLES IN SCHEMA platform_admin TO platform_admin_reader;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA platform_admin TO platform_admin_writer;
ALTER DEFAULT PRIVILEGES IN SCHEMA platform_admin GRANT SELECT ON TABLES TO platform_admin_reader;
ALTER DEFAULT PRIVILEGES IN SCHEMA platform_admin GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO platform_admin_writer;

-- The domain grants its writer role to its own login user (Annex J J.7). The user exists only
-- where the infrastructure created it, so the grant is conditional.
DO $$
BEGIN
    IF EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'platform_admin_app') THEN
        GRANT platform_admin_writer TO platform_admin_app;
    END IF;
END
$$;
