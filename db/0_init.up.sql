CREATE TABLE AdvCompany
(
    id uuid NOT NULL,
    title VARCHAR NOT NULL,
    descr VARCHAR,
    PRIMARY KEY(id)
)

CREATE TABLE Advertisement
(
    id uuid NOT NULL,
    id_campaign uuid NOT NULL UNIQUE REFERENCES AdvCompany(id) ON DELETE CASCADE,
    cpm VARCHAR NOT NULL,
    title VARCHAR NOT NULL,
    descr VARCHAR,
    PRIMARY KEY(id)
)