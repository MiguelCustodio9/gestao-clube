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

CREATE TYPE public.tipo_perfil AS ENUM (
  'admin',
  'gestor',
  'visualizador'
);

CREATE SEQUENCE IF NOT EXISTS public.usuarios_id_usuario_seq;
CREATE SEQUENCE IF NOT EXISTS public.jogadoras_id_jogadora_seq;
CREATE SEQUENCE IF NOT EXISTS public.treinadores_id_treinador_seq;
CREATE SEQUENCE IF NOT EXISTS public.vinculo_epocas_id_vinculo_seq;

CREATE TABLE public.usuarios (
  id_usuario integer NOT NULL DEFAULT nextval('usuarios_id_usuario_seq'::regclass),
  username text NOT NULL UNIQUE,
  nome character varying,
  perfil tipo_perfil DEFAULT 'gestor',
  senha text NOT NULL,
  ativo boolean DEFAULT true,
  criado_em timestamp with time zone DEFAULT now(),
  CONSTRAINT usuarios_pkey PRIMARY KEY (id_usuario)
);

CREATE FUNCTION public.autenticar_usuario(p_username text, p_senha text)
RETURNS TABLE (id_usuario integer, username text, nome character varying, perfil tipo_perfil, ativo boolean)
LANGUAGE sql STABLE AS $$
  SELECT id_usuario, username, nome, perfil, ativo
  FROM public.usuarios
  WHERE username = p_username
    AND ativo = true
    AND senha = p_senha;
$$;

CREATE FUNCTION public.criar_usuario(p_username text, p_nome character varying, p_perfil tipo_perfil, p_senha text)
RETURNS integer
LANGUAGE plpgsql VOLATILE AS $$
DECLARE
    novo_id integer;
BEGIN
    INSERT INTO public.usuarios (username, nome, perfil, senha)
    VALUES (p_username, p_nome, p_perfil, p_senha)
    RETURNING id_usuario INTO novo_id;
    RETURN novo_id;
END;
$$;

-- Exemplo de utilização direta no banco:
-- SELECT criar_usuario('admin', 'Administrador', 'admin', 'senha-segura');
-- Ou use INSERT manual:
-- INSERT INTO public.usuarios (username, nome, perfil, senha)
-- VALUES ('admin', 'Administrador', 'admin', 'senha-segura');

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