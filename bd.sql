-- WARNING: This schema is for context only and is not meant to be run.
-- Table order and constraints may not be valid for execution.

CREATE TYPE public.tipo_posicao AS ENUM (
  'guarda redes',
  'fixo',
  'fixo/ala',
  'fixo/pivot',
  'ala',
  'ala/pivot',
  'pivot',
  'universal'
);

CREATE TYPE public.tipo_pe AS ENUM (
  'Direito',
  'Esquerdo',
  'Ambidextro'
);

CREATE TYPE public.tipo_funcao AS ENUM (
  'treinador principal',
  'treinador adjunto',
  'treinador de GR',
  'delegado',
  'fisioterapeuta',
  'médico',
  'massagista',
  'enfermeiro',
  'coordenador da academia'
);

CREATE TABLE public.jogadoras (
  id_jogadora integer NOT NULL DEFAULT nextval('jogadoras_id_jogadora_seq'::regclass),
  nome_desportivo character varying NOT NULL,
  nome_completo character varying NOT NULL,
  data_nascimento date NOT NULL,
  nacionalidade character varying DEFAULT 'Portuguesa'::character varying,
  posicao tipo_posicao,
  pe_preferencial tipo_pe,
  numero_preferido integer,
  clube_anterior character varying,
  primeira_epoca character varying,
  escalao_etario character varying,
  jogos_clube integer DEFAULT 0,
  golos_clube integer DEFAULT 0,
  golos_sofridos integer DEFAULT 0,
  assistencias_clube integer DEFAULT 0,
  ativo boolean DEFAULT true,
  CONSTRAINT jogadoras_pkey PRIMARY KEY (id_jogadora)
);
CREATE TABLE public.treinadores (
  id_treinador integer NOT NULL DEFAULT nextval('treinadores_id_treinador_seq'::regclass),
  nome_desportivo character varying NOT NULL,
  nome_completo character varying NOT NULL,
  data_nascimento date NOT NULL,
  nacionalidade character varying DEFAULT 'Portuguesa'::character varying,
  clube_anterior character varying,
  primeira_epoca character varying,
  ativo boolean DEFAULT true,
  CONSTRAINT treinadores_pkey PRIMARY KEY (id_treinador)
);
CREATE TABLE public.vinculo_epocas (
  id_vinculo integer NOT NULL DEFAULT nextval('vinculo_epocas_id_vinculo_seq'::regclass),
  id_jogadora integer,
  id_treinador integer,
  epoca character varying NOT NULL,
  escalao_equipa character varying NOT NULL,
  jogos integer DEFAULT 0,
  golos integer DEFAULT 0,
  assistencias integer DEFAULT 0,
  funcao_treinador tipo_funcao,
  CONSTRAINT vinculo_epocas_pkey PRIMARY KEY (id_vinculo),
  CONSTRAINT vinculo_epocas_id_jogadora_fkey FOREIGN KEY (id_jogadora) REFERENCES public.jogadoras(id_jogadora),
  CONSTRAINT vinculo_epocas_id_treinador_fkey FOREIGN KEY (id_treinador) REFERENCES public.treinadores(id_treinador)
);