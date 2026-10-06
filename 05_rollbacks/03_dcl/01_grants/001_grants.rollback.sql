DO $$
BEGIN
    IF EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'platform_admin_app') THEN
        REVOKE platform_admin_writer FROM platform_admin_app;
    END IF;
END
$$;
ALTER DEFAULT PRIVILEGES IN SCHEMA platform_admin REVOKE ALL ON TABLES FROM platform_admin_reader, platform_admin_writer;
REVOKE ALL ON ALL TABLES IN SCHEMA platform_admin FROM platform_admin_reader, platform_admin_writer;
REVOKE USAGE ON SCHEMA platform_admin FROM platform_admin_reader, platform_admin_writer;
