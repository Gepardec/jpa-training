SET search_path TO hogajama;

ALTER TABLE ONLY owner
    ADD CONSTRAINT pui_owner_sso_user_id UNIQUE (sso_user_id);
