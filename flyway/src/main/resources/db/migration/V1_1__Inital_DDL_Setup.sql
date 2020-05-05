CREATE SCHEMA IF NOT EXISTS hogajama;

SET search_path TO hogajama;

CREATE SEQUENCE seq_owner_id
    INCREMENT BY 50;

ALTER SEQUENCE seq_owner_id OWNER TO hogajama;

CREATE SEQUENCE seq_sensor_id
    INCREMENT BY 50;

ALTER SEQUENCE seq_sensor_id OWNER TO hogajama;

CREATE SEQUENCE seq_sensor_type_id
    INCREMENT BY 50;

ALTER SEQUENCE seq_sensor_type_id OWNER TO hogajama;

CREATE SEQUENCE seq_unit_id
    INCREMENT BY 50;

ALTER SEQUENCE seq_unit_id OWNER TO hogajama;

CREATE TABLE owner
(
    id          bigint       NOT NULL
        CONSTRAINT pk_owner PRIMARY KEY,
    sso_user_id varchar(255) NOT NULL
);

ALTER TABLE owner
    OWNER TO hogajama;

CREATE TABLE sensor_type
(
    id   bigint       NOT NULL
        CONSTRAINT pk_sensor_type PRIMARY KEY,
    name varchar(255) NOT NULL
);

ALTER TABLE sensor_type
    OWNER TO hogajama;

CREATE TABLE unit
(
    id          bigint                NOT NULL
        CONSTRAINT pk_unit PRIMARY KEY,
    description varchar(255),
    is_default  boolean DEFAULT FALSE NOT NULL,
    name        varchar(255),
    owner_id    bigint                NOT NULL
        CONSTRAINT fk_unit_owner REFERENCES owner
);

ALTER TABLE unit
    OWNER TO hogajama;


CREATE TABLE sensor
(
    id             bigint       NOT NULL
        CONSTRAINT pk_sensor PRIMARY KEY,
    device_id      varchar(255) NOT NULL
        CONSTRAINT pui_sensor_device_id UNIQUE,
    name           varchar(255),
    sensor_type_id bigint       NOT NULL
        CONSTRAINT fk_sensor_sensor_type REFERENCES sensor_type,
    unit_id        bigint       NOT NULL
        CONSTRAINT fk_sensor_unit REFERENCES unit
);

ALTER TABLE sensor
    OWNER TO hogajama;
