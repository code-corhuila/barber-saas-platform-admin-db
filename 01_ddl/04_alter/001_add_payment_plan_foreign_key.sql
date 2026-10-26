-- A payment keeps its plan: a plan with payments is deactivated, never deleted (DEC-PLAT-02).
ALTER TABLE platform_admin.payment
    ADD CONSTRAINT fk_payment_plan FOREIGN KEY (plan_id)
        REFERENCES platform_admin.subscription_plan (id) ON DELETE RESTRICT;
