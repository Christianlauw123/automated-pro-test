--
-- PostgreSQL database dump
--

-- Dumped from database version 15.1 (Ubuntu 15.1-1.pgdg22.04+1)
-- Dumped by pg_dump version 15.1 (Ubuntu 15.1-1.pgdg22.04+1)

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: bookings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bookings (
    id uuid NOT NULL,
    status character varying(255) NOT NULL,
    quantity double precision NOT NULL,
    user_id uuid NOT NULL,
    ticket_id uuid NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);


ALTER TABLE public.bookings OWNER TO postgres;

--
-- Name: cache; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cache (
    key character varying(255) NOT NULL,
    value text NOT NULL,
    expiration integer NOT NULL
);


ALTER TABLE public.cache OWNER TO postgres;

--
-- Name: cache_locks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cache_locks (
    key character varying(255) NOT NULL,
    owner character varying(255) NOT NULL,
    expiration integer NOT NULL
);


ALTER TABLE public.cache_locks OWNER TO postgres;

--
-- Name: events; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.events (
    id uuid NOT NULL,
    title character varying(255) NOT NULL,
    description text NOT NULL,
    date date NOT NULL,
    location text NOT NULL,
    created_by uuid NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);


ALTER TABLE public.events OWNER TO postgres;

--
-- Name: failed_jobs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.failed_jobs (
    id bigint NOT NULL,
    uuid character varying(255) NOT NULL,
    connection text NOT NULL,
    queue text NOT NULL,
    payload text NOT NULL,
    exception text NOT NULL,
    failed_at timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.failed_jobs OWNER TO postgres;

--
-- Name: failed_jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.failed_jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.failed_jobs_id_seq OWNER TO postgres;

--
-- Name: failed_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.failed_jobs_id_seq OWNED BY public.failed_jobs.id;


--
-- Name: job_batches; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.job_batches (
    id character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    total_jobs integer NOT NULL,
    pending_jobs integer NOT NULL,
    failed_jobs integer NOT NULL,
    failed_job_ids text NOT NULL,
    options text,
    cancelled_at integer,
    created_at integer NOT NULL,
    finished_at integer
);


ALTER TABLE public.job_batches OWNER TO postgres;

--
-- Name: jobs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.jobs (
    id uuid NOT NULL,
    queue character varying(255) NOT NULL,
    payload text NOT NULL,
    attempts smallint NOT NULL,
    reserved_at integer,
    available_at integer NOT NULL,
    created_at integer NOT NULL
);


ALTER TABLE public.jobs OWNER TO postgres;

--
-- Name: migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.migrations (
    id integer NOT NULL,
    migration character varying(255) NOT NULL,
    batch integer NOT NULL
);


ALTER TABLE public.migrations OWNER TO postgres;

--
-- Name: migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.migrations_id_seq OWNER TO postgres;

--
-- Name: migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.migrations_id_seq OWNED BY public.migrations.id;


--
-- Name: password_reset_tokens; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.password_reset_tokens (
    email character varying(255) NOT NULL,
    token character varying(255) NOT NULL,
    created_at timestamp(0) without time zone
);


ALTER TABLE public.password_reset_tokens OWNER TO postgres;

--
-- Name: payments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payments (
    id uuid NOT NULL,
    status character varying(255) NOT NULL,
    amount real NOT NULL,
    booking_id uuid NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone,
    CONSTRAINT payments_status_check CHECK (((status)::text = ANY ((ARRAY['success'::character varying, 'failed'::character varying, 'refunded'::character varying])::text[])))
);


ALTER TABLE public.payments OWNER TO postgres;

--
-- Name: personal_access_tokens; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.personal_access_tokens (
    id bigint NOT NULL,
    tokenable_type character varying(255) NOT NULL,
    tokenable_id uuid NOT NULL,
    name text NOT NULL,
    token character varying(64) NOT NULL,
    abilities text,
    last_used_at timestamp(0) without time zone,
    expires_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.personal_access_tokens OWNER TO postgres;

--
-- Name: personal_access_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.personal_access_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.personal_access_tokens_id_seq OWNER TO postgres;

--
-- Name: personal_access_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.personal_access_tokens_id_seq OWNED BY public.personal_access_tokens.id;


--
-- Name: sessions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sessions (
    id character varying(255) NOT NULL,
    user_id bigint,
    ip_address character varying(45),
    user_agent text,
    payload text NOT NULL,
    last_activity integer NOT NULL
);


ALTER TABLE public.sessions OWNER TO postgres;

--
-- Name: tickets; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tickets (
    id uuid NOT NULL,
    type character varying(255) NOT NULL,
    price real NOT NULL,
    quantity double precision NOT NULL,
    event_id uuid NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);


ALTER TABLE public.tickets OWNER TO postgres;

--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id uuid NOT NULL,
    name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    email_verified_at timestamp(0) without time zone,
    password character varying(255) NOT NULL,
    phone character varying(255) NOT NULL,
    role character varying(255) DEFAULT 'customer'::character varying NOT NULL,
    remember_token character varying(100),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone,
    CONSTRAINT users_role_check CHECK (((role)::text = ANY ((ARRAY['admin'::character varying, 'organizer'::character varying, 'customer'::character varying])::text[])))
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: failed_jobs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.failed_jobs ALTER COLUMN id SET DEFAULT nextval('public.failed_jobs_id_seq'::regclass);


--
-- Name: migrations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migrations ALTER COLUMN id SET DEFAULT nextval('public.migrations_id_seq'::regclass);


--
-- Name: personal_access_tokens id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personal_access_tokens ALTER COLUMN id SET DEFAULT nextval('public.personal_access_tokens_id_seq'::regclass);


--
-- Data for Name: bookings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.bookings (id, status, quantity, user_id, ticket_id, created_at, updated_at, deleted_at) FROM stdin;
019c55aa-cd04-73f9-af79-9270460e7167	pending	3	019c55aa-caf5-72bd-be35-accdfa6fd4a1	019c55aa-cc05-71db-aa11-f711f8a4391f	2026-02-13 06:23:02	2026-02-13 06:23:02	\N
019c55aa-cd20-7139-94bc-c7fef771955b	pending	4	019c55aa-caf5-72bd-be35-accdfa6fd4a1	019c55aa-cc05-71db-aa11-f711f8a4391f	2026-02-13 06:23:02	2026-02-13 06:23:02	\N
019c55aa-cd2d-7143-a6fb-cc2a6790932b	confirmed	2	019c55aa-cb09-73a1-93e3-b6a76591fd33	019c55aa-cc28-7191-9bc9-26a4e4c174b4	2026-02-13 06:23:02	2026-02-13 06:23:02	\N
019c55aa-cd43-7256-b2e6-5fad92bebf28	pending	1	019c55aa-cb09-73a1-93e3-b6a76591fd33	019c55aa-cc28-7191-9bc9-26a4e4c174b4	2026-02-13 06:23:02	2026-02-13 06:23:02	\N
019c55aa-cd56-722a-a147-5200ecfd7304	confirmed	5	019c55aa-cb17-7343-9566-f7a34d7e9022	019c55aa-cc65-73af-b19c-71c221ee074e	2026-02-13 06:23:02	2026-02-13 06:23:02	\N
019c55aa-cd66-7140-bcd5-0f804d458588	confirmed	4	019c55aa-cb17-7343-9566-f7a34d7e9022	019c55aa-cc65-73af-b19c-71c221ee074e	2026-02-13 06:23:03	2026-02-13 06:23:03	\N
019c55aa-cd84-70c3-8916-9871c1e091bf	pending	5	019c55aa-cb31-70b0-94e6-ced71958a2bb	019c55aa-cc83-737a-b94f-9a8b6970ac63	2026-02-13 06:23:03	2026-02-13 06:23:03	\N
019c55aa-cd93-7121-91ea-3b28b7dfe7df	pending	5	019c55aa-cb31-70b0-94e6-ced71958a2bb	019c55aa-cc83-737a-b94f-9a8b6970ac63	2026-02-13 06:23:03	2026-02-13 06:23:03	\N
019c55aa-cdae-7271-b7f3-bcf8296ef506	cancelled	2	019c55aa-cb3f-7362-902b-a18f66314ffc	019c55aa-cc65-73af-b19c-71c221ee074e	2026-02-13 06:23:03	2026-02-13 06:23:03	\N
019c55aa-cdb9-7180-8efa-a8d2c7e53b78	pending	5	019c55aa-cb3f-7362-902b-a18f66314ffc	019c55aa-cc65-73af-b19c-71c221ee074e	2026-02-13 06:23:03	2026-02-13 06:23:03	\N
019c55aa-cdce-71ba-a678-73e657d29028	cancelled	2	019c55aa-cb4c-7137-ab95-e09b031707ff	019c55aa-cca4-7222-a70c-1be01a673ed3	2026-02-13 06:23:03	2026-02-13 06:23:03	\N
019c55aa-cde6-7234-87a8-416dee571892	cancelled	3	019c55aa-cb4c-7137-ab95-e09b031707ff	019c55aa-cca4-7222-a70c-1be01a673ed3	2026-02-13 06:23:03	2026-02-13 06:23:03	\N
019c55aa-cdf8-705b-8cd0-422a92057f32	pending	2	019c55aa-cb56-72d1-ad6f-10f4927ed60f	019c55aa-cc28-7191-9bc9-26a4e4c174b4	2026-02-13 06:23:03	2026-02-13 06:23:03	\N
019c55aa-ce0e-70ef-9fcc-da330f18923e	pending	2	019c55aa-cb56-72d1-ad6f-10f4927ed60f	019c55aa-cc28-7191-9bc9-26a4e4c174b4	2026-02-13 06:23:03	2026-02-13 06:23:03	\N
019c55aa-ce1f-7305-960d-330468e12e65	pending	2	019c55aa-cb68-7189-8e7d-04fc62aa42e0	019c55aa-cc50-7313-8136-70ed55c72f02	2026-02-13 06:23:03	2026-02-13 06:23:03	\N
019c55aa-ce33-71e8-a918-1fb819c9d822	confirmed	5	019c55aa-cb68-7189-8e7d-04fc62aa42e0	019c55aa-cc50-7313-8136-70ed55c72f02	2026-02-13 06:23:03	2026-02-13 06:23:03	\N
019c55aa-ce41-7015-9c72-3176172dc260	cancelled	2	019c55aa-cb7f-71f7-b971-2caecc3a8ffe	019c55aa-ccda-701b-b9c8-3839d04699b7	2026-02-13 06:23:03	2026-02-13 06:23:03	\N
019c55aa-ce60-7290-bd3c-e366903808ad	confirmed	5	019c55aa-cb7f-71f7-b971-2caecc3a8ffe	019c55aa-ccda-701b-b9c8-3839d04699b7	2026-02-13 06:23:03	2026-02-13 06:23:03	\N
019c55aa-ce6f-707b-957b-9dc977dbe400	confirmed	4	019c55aa-cb8d-71f1-9818-725fbfe89e18	019c55aa-cc15-728a-b2c3-dad14e06736f	2026-02-13 06:23:03	2026-02-13 06:23:03	\N
019c55aa-ce85-7205-9aba-57e29cb6ec64	pending	1	019c55aa-cb8d-71f1-9818-725fbfe89e18	019c55aa-cc15-728a-b2c3-dad14e06736f	2026-02-13 06:23:03	2026-02-13 06:23:03	\N
\.


--
-- Data for Name: cache; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cache (key, value, expiration) FROM stdin;
\.


--
-- Data for Name: cache_locks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cache_locks (key, owner, expiration) FROM stdin;
\.


--
-- Data for Name: events; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.events (id, title, description, date, location, created_by, created_at, updated_at, deleted_at) FROM stdin;
019c55aa-cba6-7258-8226-4f09943c39cb	Burnice Graham	c1AKIaC6hWGMbXp3AVPflM3tx8pAcf	2026-02-13	Estelle Deckow	019c55aa-cabb-7270-873c-74ac95adff09	2026-02-13 06:23:02	2026-02-13 06:23:02	\N
019c55aa-cbb6-73f6-ad95-73a829a773cf	Dr. Jade Schultz	SuufQPRrEos4xCTZH03p8mZ6VJ62CY	2026-02-13	Prof. Marietta Bartoletti DDS	019c55aa-cabb-7270-873c-74ac95adff09	2026-02-13 06:23:02	2026-02-13 06:23:02	\N
019c55aa-cbc2-73cb-b127-221bda122848	Catharine Gibson	21M8XB1Fh7xiy6GT59492qVQBRiYm2	2026-02-13	Ms. Zelda Lindgren Sr.	019c55aa-cabb-7270-873c-74ac95adff09	2026-02-13 06:23:02	2026-02-13 06:23:02	\N
019c55aa-cbdd-7276-adde-f96547d8c914	Mrs. Jennie Harvey	d5ctuePVN4pRYW8kyjV0xxDBLvuNo6	2026-02-13	Damian Kemmer	019c55aa-cabb-7270-873c-74ac95adff09	2026-02-13 06:23:02	2026-02-13 06:23:02	\N
019c55aa-cbea-72e7-a0b3-6e3e654881b3	Candace Lehner	ZoF92BFP3KayIxbHBXMyZfEwQU3oc4	2026-02-13	Prof. Jocelyn Little MD	019c55aa-cabb-7270-873c-74ac95adff09	2026-02-13 06:23:02	2026-02-13 06:23:02	\N
\.


--
-- Data for Name: failed_jobs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.failed_jobs (id, uuid, connection, queue, payload, exception, failed_at) FROM stdin;
\.


--
-- Data for Name: job_batches; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.job_batches (id, name, total_jobs, pending_jobs, failed_jobs, failed_job_ids, options, cancelled_at, created_at, finished_at) FROM stdin;
\.


--
-- Data for Name: jobs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.jobs (id, queue, payload, attempts, reserved_at, available_at, created_at) FROM stdin;
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.migrations (id, migration, batch) FROM stdin;
9	0001_01_01_000000_create_users_table	1
10	0001_01_01_000001_create_cache_table	1
11	0001_01_01_000002_create_jobs_table	1
12	2026_02_13_023753_create_events_table	1
13	2026_02_13_023803_create_tickets_table	1
14	2026_02_13_023807_create_bookings_table	1
15	2026_02_13_023811_create_payments_table	1
16	2026_02_13_023929_create_personal_access_tokens_table	1
\.


--
-- Data for Name: password_reset_tokens; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.password_reset_tokens (email, token, created_at) FROM stdin;
\.


--
-- Data for Name: payments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.payments (id, status, amount, booking_id, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: personal_access_tokens; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.personal_access_tokens (id, tokenable_type, tokenable_id, name, token, abilities, last_used_at, expires_at, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sessions (id, user_id, ip_address, user_agent, payload, last_activity) FROM stdin;
\.


--
-- Data for Name: tickets; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tickets (id, type, price, quantity, event_id, created_at, updated_at, deleted_at) FROM stdin;
019c55aa-cc05-71db-aa11-f711f8a4391f	VIP	31023	4	019c55aa-cba6-7258-8226-4f09943c39cb	2026-02-13 06:23:02	2026-02-13 06:23:02	\N
019c55aa-cc15-728a-b2c3-dad14e06736f	VIP	36053	1	019c55aa-cba6-7258-8226-4f09943c39cb	2026-02-13 06:23:02	2026-02-13 06:23:02	\N
019c55aa-cc28-7191-9bc9-26a4e4c174b4	Standard	37697	5	019c55aa-cba6-7258-8226-4f09943c39cb	2026-02-13 06:23:02	2026-02-13 06:23:02	\N
019c55aa-cc42-7030-ae95-8dcb875a6875	Standard	45331	2	019c55aa-cbb6-73f6-ad95-73a829a773cf	2026-02-13 06:23:02	2026-02-13 06:23:02	\N
019c55aa-cc50-7313-8136-70ed55c72f02	VIP	41581	5	019c55aa-cbb6-73f6-ad95-73a829a773cf	2026-02-13 06:23:02	2026-02-13 06:23:02	\N
019c55aa-cc65-73af-b19c-71c221ee074e	VIP	30166	2	019c55aa-cbb6-73f6-ad95-73a829a773cf	2026-02-13 06:23:02	2026-02-13 06:23:02	\N
019c55aa-cc74-70bd-a1b3-e27879177dd3	VVIP	36979	5	019c55aa-cbc2-73cb-b127-221bda122848	2026-02-13 06:23:02	2026-02-13 06:23:02	\N
019c55aa-cc83-737a-b94f-9a8b6970ac63	VIP	42332	4	019c55aa-cbc2-73cb-b127-221bda122848	2026-02-13 06:23:02	2026-02-13 06:23:02	\N
019c55aa-cc90-7256-8ffc-b4dc016558bf	Standard	46647	4	019c55aa-cbc2-73cb-b127-221bda122848	2026-02-13 06:23:02	2026-02-13 06:23:02	\N
019c55aa-cca4-7222-a70c-1be01a673ed3	VIP	40028	2	019c55aa-cbdd-7276-adde-f96547d8c914	2026-02-13 06:23:02	2026-02-13 06:23:02	\N
019c55aa-ccb6-71ae-8018-63f0e4cbb785	VIP	32656	4	019c55aa-cbdd-7276-adde-f96547d8c914	2026-02-13 06:23:02	2026-02-13 06:23:02	\N
019c55aa-ccc9-7252-8c51-49fbc9207b11	Standard	30609	5	019c55aa-cbdd-7276-adde-f96547d8c914	2026-02-13 06:23:02	2026-02-13 06:23:02	\N
019c55aa-ccda-701b-b9c8-3839d04699b7	Standard	44042	4	019c55aa-cbea-72e7-a0b3-6e3e654881b3	2026-02-13 06:23:02	2026-02-13 06:23:02	\N
019c55aa-ccea-71b1-984a-e2d2bea728c3	Standard	38729	1	019c55aa-cbea-72e7-a0b3-6e3e654881b3	2026-02-13 06:23:02	2026-02-13 06:23:02	\N
019c55aa-ccf8-7132-b32b-b077024e5761	VVIP	47066	4	019c55aa-cbea-72e7-a0b3-6e3e654881b3	2026-02-13 06:23:02	2026-02-13 06:23:02	\N
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, name, email, email_verified_at, password, phone, role, remember_token, created_at, updated_at, deleted_at) FROM stdin;
019c55aa-ca8c-72a6-9b4d-f6dc7762bb01	Lillie Dare	ernesto.christiansen@example.com	2026-02-13 06:23:02	$2y$12$niqjIo7bW12sY2DD.KlcXeV4IDR89Jr4gAjzlGyrbZGFPVrJimzfa	845.380.6096	admin	\N	2026-02-13 06:23:02	2026-02-13 06:23:02	\N
019c55aa-caa2-705a-94cc-ca4043a048e1	Miss Avis Carroll	ehowell@example.net	2026-02-13 06:23:02	$2y$12$niqjIo7bW12sY2DD.KlcXeV4IDR89Jr4gAjzlGyrbZGFPVrJimzfa	+1.412.533.1948	admin	\N	2026-02-13 06:23:02	2026-02-13 06:23:02	\N
019c55aa-cabb-7270-873c-74ac95adff09	Lenore Rowe	lynch.kyla@example.org	2026-02-13 06:23:02	$2y$12$niqjIo7bW12sY2DD.KlcXeV4IDR89Jr4gAjzlGyrbZGFPVrJimzfa	1-805-761-3708	organizer	\N	2026-02-13 06:23:02	2026-02-13 06:23:02	\N
019c55aa-cac9-7235-8697-f439a0f3ca4c	Noe Rogahn	anthony52@example.com	2026-02-13 06:23:02	$2y$12$niqjIo7bW12sY2DD.KlcXeV4IDR89Jr4gAjzlGyrbZGFPVrJimzfa	+1.541.819.8466	organizer	\N	2026-02-13 06:23:02	2026-02-13 06:23:02	\N
019c55aa-cadc-70a6-9af1-ade9d88b86c2	Mrs. Laila Cormier	pdurgan@example.org	2026-02-13 06:23:02	$2y$12$niqjIo7bW12sY2DD.KlcXeV4IDR89Jr4gAjzlGyrbZGFPVrJimzfa	1-865-815-8079	organizer	\N	2026-02-13 06:23:02	2026-02-13 06:23:02	\N
019c55aa-caf5-72bd-be35-accdfa6fd4a1	Hilma Haley	selmer54@example.net	2026-02-13 06:23:02	$2y$12$niqjIo7bW12sY2DD.KlcXeV4IDR89Jr4gAjzlGyrbZGFPVrJimzfa	1-279-862-1711	customer	\N	2026-02-13 06:23:02	2026-02-13 06:23:02	\N
019c55aa-cb09-73a1-93e3-b6a76591fd33	Jamey Runolfsdottir	nlarson@example.net	2026-02-13 06:23:02	$2y$12$niqjIo7bW12sY2DD.KlcXeV4IDR89Jr4gAjzlGyrbZGFPVrJimzfa	517-216-8205	customer	\N	2026-02-13 06:23:02	2026-02-13 06:23:02	\N
019c55aa-cb17-7343-9566-f7a34d7e9022	Nikko Langworth	kreiger.nathaniel@example.com	2026-02-13 06:23:02	$2y$12$niqjIo7bW12sY2DD.KlcXeV4IDR89Jr4gAjzlGyrbZGFPVrJimzfa	786.675.4984	customer	\N	2026-02-13 06:23:02	2026-02-13 06:23:02	\N
019c55aa-cb31-70b0-94e6-ced71958a2bb	Arthur Bahringer	kelvin.stark@example.org	2026-02-13 06:23:02	$2y$12$niqjIo7bW12sY2DD.KlcXeV4IDR89Jr4gAjzlGyrbZGFPVrJimzfa	(512) 223-8836	customer	\N	2026-02-13 06:23:02	2026-02-13 06:23:02	\N
019c55aa-cb3f-7362-902b-a18f66314ffc	Melody Klocko	brionna17@example.org	2026-02-13 06:23:02	$2y$12$niqjIo7bW12sY2DD.KlcXeV4IDR89Jr4gAjzlGyrbZGFPVrJimzfa	(386) 969-1874	customer	\N	2026-02-13 06:23:02	2026-02-13 06:23:02	\N
019c55aa-cb4c-7137-ab95-e09b031707ff	Larry Purdy	hoeger.austyn@example.com	2026-02-13 06:23:02	$2y$12$niqjIo7bW12sY2DD.KlcXeV4IDR89Jr4gAjzlGyrbZGFPVrJimzfa	+1-432-747-4258	customer	\N	2026-02-13 06:23:02	2026-02-13 06:23:02	\N
019c55aa-cb56-72d1-ad6f-10f4927ed60f	Genoveva Will V	fay.goldner@example.com	2026-02-13 06:23:02	$2y$12$niqjIo7bW12sY2DD.KlcXeV4IDR89Jr4gAjzlGyrbZGFPVrJimzfa	+13214451467	customer	\N	2026-02-13 06:23:02	2026-02-13 06:23:02	\N
019c55aa-cb68-7189-8e7d-04fc62aa42e0	Ms. Lucy Schmeler II	robel.rodger@example.net	2026-02-13 06:23:02	$2y$12$niqjIo7bW12sY2DD.KlcXeV4IDR89Jr4gAjzlGyrbZGFPVrJimzfa	+1-475-529-7501	customer	\N	2026-02-13 06:23:02	2026-02-13 06:23:02	\N
019c55aa-cb7f-71f7-b971-2caecc3a8ffe	Armani Reichert II	dlittel@example.org	2026-02-13 06:23:02	$2y$12$niqjIo7bW12sY2DD.KlcXeV4IDR89Jr4gAjzlGyrbZGFPVrJimzfa	(319) 396-0126	customer	\N	2026-02-13 06:23:02	2026-02-13 06:23:02	\N
019c55aa-cb8d-71f1-9818-725fbfe89e18	Maximilian Deckow	louvenia.johnston@example.net	2026-02-13 06:23:02	$2y$12$niqjIo7bW12sY2DD.KlcXeV4IDR89Jr4gAjzlGyrbZGFPVrJimzfa	(628) 917-1364	customer	\N	2026-02-13 06:23:02	2026-02-13 06:23:02	\N
\.


--
-- Name: failed_jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.failed_jobs_id_seq', 1, false);


--
-- Name: migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.migrations_id_seq', 16, true);


--
-- Name: personal_access_tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.personal_access_tokens_id_seq', 1, false);


--
-- Name: bookings bookings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT bookings_pkey PRIMARY KEY (id);


--
-- Name: cache_locks cache_locks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cache_locks
    ADD CONSTRAINT cache_locks_pkey PRIMARY KEY (key);


--
-- Name: cache cache_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cache
    ADD CONSTRAINT cache_pkey PRIMARY KEY (key);


--
-- Name: events events_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.events
    ADD CONSTRAINT events_pkey PRIMARY KEY (id);


--
-- Name: failed_jobs failed_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_pkey PRIMARY KEY (id);


--
-- Name: failed_jobs failed_jobs_uuid_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_uuid_unique UNIQUE (uuid);


--
-- Name: job_batches job_batches_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job_batches
    ADD CONSTRAINT job_batches_pkey PRIMARY KEY (id);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- Name: password_reset_tokens password_reset_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.password_reset_tokens
    ADD CONSTRAINT password_reset_tokens_pkey PRIMARY KEY (email);


--
-- Name: payments payments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_pkey PRIMARY KEY (id);


--
-- Name: personal_access_tokens personal_access_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personal_access_tokens
    ADD CONSTRAINT personal_access_tokens_pkey PRIMARY KEY (id);


--
-- Name: personal_access_tokens personal_access_tokens_token_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personal_access_tokens
    ADD CONSTRAINT personal_access_tokens_token_unique UNIQUE (token);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: tickets tickets_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT tickets_pkey PRIMARY KEY (id);


--
-- Name: users users_email_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_unique UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: cache_expiration_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cache_expiration_index ON public.cache USING btree (expiration);


--
-- Name: cache_locks_expiration_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cache_locks_expiration_index ON public.cache_locks USING btree (expiration);


--
-- Name: jobs_queue_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX jobs_queue_index ON public.jobs USING btree (queue);


--
-- Name: personal_access_tokens_expires_at_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX personal_access_tokens_expires_at_index ON public.personal_access_tokens USING btree (expires_at);


--
-- Name: personal_access_tokens_tokenable_type_tokenable_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX personal_access_tokens_tokenable_type_tokenable_id_index ON public.personal_access_tokens USING btree (tokenable_type, tokenable_id);


--
-- Name: sessions_last_activity_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX sessions_last_activity_index ON public.sessions USING btree (last_activity);


--
-- Name: sessions_user_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX sessions_user_id_index ON public.sessions USING btree (user_id);


--
-- Name: bookings bookings_ticket_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT bookings_ticket_id_foreign FOREIGN KEY (ticket_id) REFERENCES public.tickets(id);


--
-- Name: bookings bookings_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT bookings_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: events events_created_by_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.events
    ADD CONSTRAINT events_created_by_foreign FOREIGN KEY (created_by) REFERENCES public.users(id);


--
-- Name: payments payments_booking_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_booking_id_foreign FOREIGN KEY (booking_id) REFERENCES public.bookings(id);


--
-- Name: tickets tickets_event_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT tickets_event_id_foreign FOREIGN KEY (event_id) REFERENCES public.events(id);


--
-- PostgreSQL database dump complete
--

