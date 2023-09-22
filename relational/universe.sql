--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)

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

DROP DATABASE universe;
--
-- Name: universe; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE universe WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE universe OWNER TO freecodecamp;

\connect universe

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
-- Name: asteroid; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.asteroid (
    asteroid_id integer NOT NULL,
    star_id integer NOT NULL,
    name character varying(20),
    revolution_in_years numeric(5,1),
    size integer
);


ALTER TABLE public.asteroid OWNER TO freecodecamp;

--
-- Name: asteroid_asteroid_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.asteroid_asteroid_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.asteroid_asteroid_id_seq OWNER TO freecodecamp;

--
-- Name: asteroid_asteroid_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.asteroid_asteroid_id_seq OWNED BY public.asteroid.asteroid_id;


--
-- Name: galaxy; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.galaxy (
    galaxy_id integer NOT NULL,
    name character varying(30) NOT NULL,
    description text,
    distance_from_earth integer,
    age integer,
    age_in_billion_years numeric(5,1),
    light_years_from_earth numeric(7,1)
);


ALTER TABLE public.galaxy OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.galaxy_galaxy_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.galaxy_galaxy_id_seq OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.galaxy_galaxy_id_seq OWNED BY public.galaxy.galaxy_id;


--
-- Name: moon; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.moon (
    moon_id integer NOT NULL,
    name character varying(30) NOT NULL,
    age_in_billion_years numeric(5,1),
    planet_id integer NOT NULL,
    light_years_from_earth numeric(7,1),
    is_life_possible boolean
);


ALTER TABLE public.moon OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.moon_moon_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.moon_moon_id_seq OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.moon_moon_id_seq OWNED BY public.moon.moon_id;


--
-- Name: planet; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.planet (
    planet_id integer NOT NULL,
    name character varying(30) NOT NULL,
    age_in_billion_years numeric(5,1),
    revoluion_time_in_years numeric(5,1),
    is_life_possible boolean,
    star_id integer NOT NULL,
    light_years_from_earth numeric(7,1)
);


ALTER TABLE public.planet OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.planet_planet_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.planet_planet_id_seq OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.planet_planet_id_seq OWNED BY public.planet.planet_id;


--
-- Name: star; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.star (
    star_id integer NOT NULL,
    name character varying(30) NOT NULL,
    age_in_billion_years numeric(5,1),
    galaxy_id integer NOT NULL,
    light_years_from_earth numeric(7,1)
);


ALTER TABLE public.star OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.star_star_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.star_star_id_seq OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.star_star_id_seq OWNED BY public.star.star_id;


--
-- Name: asteroid asteroid_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.asteroid ALTER COLUMN asteroid_id SET DEFAULT nextval('public.asteroid_asteroid_id_seq'::regclass);


--
-- Name: galaxy galaxy_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy ALTER COLUMN galaxy_id SET DEFAULT nextval('public.galaxy_galaxy_id_seq'::regclass);


--
-- Name: moon moon_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon ALTER COLUMN moon_id SET DEFAULT nextval('public.moon_moon_id_seq'::regclass);


--
-- Name: planet planet_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet ALTER COLUMN planet_id SET DEFAULT nextval('public.planet_planet_id_seq'::regclass);


--
-- Name: star star_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star ALTER COLUMN star_id SET DEFAULT nextval('public.star_star_id_seq'::regclass);


--
-- Data for Name: asteroid; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.asteroid VALUES (1, 10, 'Asteroid 1', 4.0, 100);
INSERT INTO public.asteroid VALUES (2, 11, 'Asteroid 2', 3.5, 80);
INSERT INTO public.asteroid VALUES (3, 12, 'Asteroid 3', 2.8, 60);
INSERT INTO public.asteroid VALUES (4, 13, 'Asteroid 4', 4.2, 90);
INSERT INTO public.asteroid VALUES (5, 14, 'Asteroid 5', 3.9, 75);
INSERT INTO public.asteroid VALUES (6, 15, 'Asteroid 6', 2.1, 55);
INSERT INTO public.asteroid VALUES (7, 16, 'Asteroid 7', 5.0, 110);
INSERT INTO public.asteroid VALUES (8, 17, 'Asteroid 8', 3.0, 70);
INSERT INTO public.asteroid VALUES (9, 18, 'Asteroid 9', 4.5, 95);
INSERT INTO public.asteroid VALUES (10, 19, 'Asteroid 10', 2.5, 50);


--
-- Data for Name: galaxy; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.galaxy VALUES (1, 'Milky Way', 'The Milky Way is the galaxy that contains our Solar System.', NULL, NULL, NULL, NULL);
INSERT INTO public.galaxy VALUES (2, 'Andromeda', 'The Andromeda Galaxy is the nearest spiral galaxy to the Milky Way.', NULL, NULL, NULL, NULL);
INSERT INTO public.galaxy VALUES (3, 'Triangulum', NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.galaxy VALUES (4, 'Sombrero Galaxy (M104)', 'The Sombrero Galaxy is an unbarred spiral galaxy.', NULL, NULL, NULL, NULL);
INSERT INTO public.galaxy VALUES (5, 'Whirlpool', 'The Whirlpool Galaxy is an interacting grand-design spiral galaxy.', NULL, NULL, NULL, NULL);
INSERT INTO public.galaxy VALUES (6, 'Pinwheel Galaxy', 'The Pinwheel Galaxy is a face-on spiral galaxy in the constellation Ursa Major.', NULL, NULL, NULL, NULL);


--
-- Data for Name: moon; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.moon VALUES (1, 'Moon', 5.0, 3, NULL, NULL);
INSERT INTO public.moon VALUES (2, 'Phobos', 5.0, 4, NULL, NULL);
INSERT INTO public.moon VALUES (3, 'Deimos', 5.0, 4, NULL, NULL);
INSERT INTO public.moon VALUES (4, 'Io', 5.0, 5, NULL, NULL);
INSERT INTO public.moon VALUES (5, 'Europa', 5.0, 5, NULL, NULL);
INSERT INTO public.moon VALUES (6, 'Ganymede', 5.0, 5, NULL, NULL);
INSERT INTO public.moon VALUES (7, 'Callisto', 5.0, 5, NULL, NULL);
INSERT INTO public.moon VALUES (8, 'Titan', 5.0, 6, NULL, NULL);
INSERT INTO public.moon VALUES (9, 'Enceladus', 5.0, 6, NULL, NULL);
INSERT INTO public.moon VALUES (10, 'Triton', 5.0, 7, NULL, NULL);
INSERT INTO public.moon VALUES (11, 'Charon', 5.0, 9, NULL, NULL);
INSERT INTO public.moon VALUES (12, 'Kepler-186f Moon 1', 1.0, 10, NULL, NULL);
INSERT INTO public.moon VALUES (13, 'Kepler-186f Moon 2', 1.0, 10, NULL, NULL);
INSERT INTO public.moon VALUES (14, 'Gliese 581c Moon 1', 7.0, 11, NULL, NULL);
INSERT INTO public.moon VALUES (15, 'TRAPPIST-1d Moon 1', 0.0, 12, NULL, NULL);
INSERT INTO public.moon VALUES (16, 'TRAPPIST-1d Moon 2', 0.0, 12, NULL, NULL);
INSERT INTO public.moon VALUES (17, 'HD 209458 b Moon 1', 0.0, 13, NULL, NULL);
INSERT INTO public.moon VALUES (18, 'HD 209458 b Moon 2', 0.0, 13, NULL, NULL);
INSERT INTO public.moon VALUES (19, 'WASP-39b Moon 1', 0.0, 14, NULL, NULL);
INSERT INTO public.moon VALUES (20, 'TOI 700d Moon 1', 0.0, 15, NULL, NULL);


--
-- Data for Name: planet; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.planet VALUES (1, 'Mercury', 5.0, 0.2, false, 10, NULL);
INSERT INTO public.planet VALUES (2, 'Venus', 5.0, 0.6, false, 10, NULL);
INSERT INTO public.planet VALUES (3, 'Earth', 5.0, 1.0, true, 10, NULL);
INSERT INTO public.planet VALUES (4, 'Mars', 5.0, 1.9, false, 10, NULL);
INSERT INTO public.planet VALUES (5, 'Jupiter', 5.0, 11.9, false, 10, NULL);
INSERT INTO public.planet VALUES (6, 'Saturn', 5.0, 29.5, false, 10, NULL);
INSERT INTO public.planet VALUES (7, 'Uranus', 5.0, 84.0, false, 10, NULL);
INSERT INTO public.planet VALUES (8, 'Neptune', 5.0, 164.8, false, 10, NULL);
INSERT INTO public.planet VALUES (9, 'Pluto', 5.0, 248.6, false, 10, NULL);
INSERT INTO public.planet VALUES (10, 'Kepler-186f', 1.0, 130.6, true, 12, NULL);
INSERT INTO public.planet VALUES (11, 'Gliese 581c', 7.0, 12.9, true, 13, NULL);
INSERT INTO public.planet VALUES (12, 'TRAPPIST-1d', 0.0, 4.1, true, 14, NULL);
INSERT INTO public.planet VALUES (13, 'HD 209458 b', 0.0, 3.5, false, 15, NULL);
INSERT INTO public.planet VALUES (14, 'WASP-39b', 0.0, 4.1, false, 16, NULL);
INSERT INTO public.planet VALUES (15, 'TOI 700d', 0.0, 37.4, true, 17, NULL);


--
-- Data for Name: star; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.star VALUES (10, 'Sun', 5.0, 1, NULL);
INSERT INTO public.star VALUES (11, 'Alpha Centauri A', 6.0, 1, NULL);
INSERT INTO public.star VALUES (12, 'Alpha Centauri B', 6.0, 1, NULL);
INSERT INTO public.star VALUES (13, 'Betelgeuse', 8.0, 2, NULL);
INSERT INTO public.star VALUES (14, 'Sirius', 3.0, 1, NULL);
INSERT INTO public.star VALUES (15, 'Vega', 0.0, 3, NULL);
INSERT INTO public.star VALUES (16, 'Proxima Centauri', 6.0, 1, NULL);
INSERT INTO public.star VALUES (17, 'Polaris', 0.0, 4, NULL);
INSERT INTO public.star VALUES (18, 'Antares', 12.0, 5, NULL);
INSERT INTO public.star VALUES (19, 'Deneb', 20.0, 6, NULL);


--
-- Name: asteroid_asteroid_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.asteroid_asteroid_id_seq', 10, true);


--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.galaxy_galaxy_id_seq', 6, true);


--
-- Name: moon_moon_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.moon_moon_id_seq', 20, true);


--
-- Name: planet_planet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.planet_planet_id_seq', 15, true);


--
-- Name: star_star_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.star_star_id_seq', 19, true);


--
-- Name: asteroid asteroid_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.asteroid
    ADD CONSTRAINT asteroid_name_key UNIQUE (name);


--
-- Name: asteroid asteroid_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.asteroid
    ADD CONSTRAINT asteroid_pkey PRIMARY KEY (asteroid_id);


--
-- Name: galaxy galaxy_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_name_key UNIQUE (name);


--
-- Name: galaxy galaxy_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_pkey PRIMARY KEY (galaxy_id);


--
-- Name: moon moon_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_name_key UNIQUE (name);


--
-- Name: moon moon_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_pkey PRIMARY KEY (moon_id);


--
-- Name: planet planet_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_name_key UNIQUE (name);


--
-- Name: planet planet_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_pkey PRIMARY KEY (planet_id);


--
-- Name: star star_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_name_key UNIQUE (name);


--
-- Name: star star_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_pkey PRIMARY KEY (star_id);


--
-- Name: asteroid asteroid_star_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.asteroid
    ADD CONSTRAINT asteroid_star_id_fkey FOREIGN KEY (star_id) REFERENCES public.star(star_id);


--
-- Name: moon moon_planet_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_planet_id_fkey FOREIGN KEY (planet_id) REFERENCES public.planet(planet_id);


--
-- Name: planet planet_star_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_star_id_fkey FOREIGN KEY (star_id) REFERENCES public.star(star_id);


--
-- Name: star star_galaxy_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_galaxy_id_fkey FOREIGN KEY (galaxy_id) REFERENCES public.galaxy(galaxy_id);


--
-- PostgreSQL database dump complete
--

