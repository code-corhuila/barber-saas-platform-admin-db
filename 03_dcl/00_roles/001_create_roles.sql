-- NOLOGIN roles carry the permissions. The login user platform_admin_app is created by
-- barber-saas-infra from a secret; no password is ever versioned here.
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'platform_admin_reader') THEN
        CREATE ROLE platform_admin_reader NOLOGIN;
    END IF;
    IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'platform_admin_writer') THEN
        CREATE ROLE platform_admin_writer NOLOGIN;
    END IF;
END
$$;
