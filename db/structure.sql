SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: unaccent; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS unaccent WITH SCHEMA public;


--
-- Name: EXTENSION unaccent; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION unaccent IS 'text search dictionary that removes accents';


--
-- Name: fr; Type: TEXT SEARCH CONFIGURATION; Schema: public; Owner: -
--

CREATE TEXT SEARCH CONFIGURATION public.fr (
    PARSER = pg_catalog."default" );

ALTER TEXT SEARCH CONFIGURATION public.fr
    ADD MAPPING FOR asciiword WITH french_stem;

ALTER TEXT SEARCH CONFIGURATION public.fr
    ADD MAPPING FOR word WITH public.unaccent, french_stem;

ALTER TEXT SEARCH CONFIGURATION public.fr
    ADD MAPPING FOR numword WITH simple;

ALTER TEXT SEARCH CONFIGURATION public.fr
    ADD MAPPING FOR email WITH simple;

ALTER TEXT SEARCH CONFIGURATION public.fr
    ADD MAPPING FOR url WITH simple;

ALTER TEXT SEARCH CONFIGURATION public.fr
    ADD MAPPING FOR host WITH simple;

ALTER TEXT SEARCH CONFIGURATION public.fr
    ADD MAPPING FOR sfloat WITH simple;

ALTER TEXT SEARCH CONFIGURATION public.fr
    ADD MAPPING FOR version WITH simple;

ALTER TEXT SEARCH CONFIGURATION public.fr
    ADD MAPPING FOR hword_numpart WITH simple;

ALTER TEXT SEARCH CONFIGURATION public.fr
    ADD MAPPING FOR hword_part WITH public.unaccent, french_stem;

ALTER TEXT SEARCH CONFIGURATION public.fr
    ADD MAPPING FOR hword_asciipart WITH french_stem;

ALTER TEXT SEARCH CONFIGURATION public.fr
    ADD MAPPING FOR numhword WITH simple;

ALTER TEXT SEARCH CONFIGURATION public.fr
    ADD MAPPING FOR asciihword WITH french_stem;

ALTER TEXT SEARCH CONFIGURATION public.fr
    ADD MAPPING FOR hword WITH public.unaccent, french_stem;

ALTER TEXT SEARCH CONFIGURATION public.fr
    ADD MAPPING FOR url_path WITH simple;

ALTER TEXT SEARCH CONFIGURATION public.fr
    ADD MAPPING FOR file WITH simple;

ALTER TEXT SEARCH CONFIGURATION public.fr
    ADD MAPPING FOR "float" WITH simple;

ALTER TEXT SEARCH CONFIGURATION public.fr
    ADD MAPPING FOR "int" WITH simple;

ALTER TEXT SEARCH CONFIGURATION public.fr
    ADD MAPPING FOR uint WITH simple;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: recipes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.recipes (
    id bigint NOT NULL,
    name character varying NOT NULL,
    author character varying NOT NULL,
    rate character varying,
    difficulty character varying NOT NULL,
    people_quantity character varying,
    cook_time character varying NOT NULL,
    author_tip character varying NOT NULL,
    budget character varying NOT NULL,
    prep_time character varying NOT NULL,
    ingredients character varying[] NOT NULL,
    tags character varying[] NOT NULL,
    total_time character varying NOT NULL,
    image character varying NOT NULL,
    nb_comments character varying NOT NULL
);


--
-- Name: recipes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.recipes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: recipes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.recipes_id_seq OWNED BY public.recipes.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: recipes id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.recipes ALTER COLUMN id SET DEFAULT nextval('public.recipes_id_seq'::regclass);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: recipes recipes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.recipes
    ADD CONSTRAINT recipes_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: index_recipes_on_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_recipes_on_id ON public.recipes USING btree (id);


--
-- Name: index_recipes_on_ingredients; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_recipes_on_ingredients ON public.recipes USING btree (ingredients);


--
-- Name: recipes_ingredients_gin_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX recipes_ingredients_gin_idx ON public.recipes USING gin (ingredients);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20220215140952'),
('20220215141025'),
('20220215142347');

