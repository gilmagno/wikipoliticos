-- locations users politicians financiers posts

-- cpf não é primary key porque alguma hora podemos querer adicionar um
-- "político" cujo cpf não sabemos
-- create table politicians (
--     token          varchar primary key,
--     name           varchar,
--     political_name varchar,
--     party          varchar,
--     cpf            varchar unique
-- );

-- create table financiers (
--     token varchar primary key,
--     name  varchar,
--     cnpjf varchar unique
-- );

-- create table candidatures (
--     politician_id
--     ano
--     uf
--     municipio
--     ue_numero
--     cargo
--     partido
--     candidato_sequencial            -- núm. seqüencial do candidato na eleição
--     candidato_numero                -- núm. do candidato na eleição

--     -- scrap divulgacad
--     -- coligacao varchar,              -- coligação
--     -- /scrap
    
--     -- votos_turno_1
--     -- votos_turno_2
--     -- resultado_turno_1               -- "eleito" "não eleito" "segundo turno"
--     -- resultado_turno_2               -- "eleito" "não eleito"

--     primary key (politician_id, year)
-- );

--------------------------------------------------------------------------------
-- 2012 ------------------------------------------------------------------------
--------------------------------------------------------------------------------

create table candidates_donations_2012 (
    id                            serial primary key,

    data_hora                     varchar,            -- donation
    candidato_sequencial          varchar,            -- candidature
    uf                            varchar,            -- candidature
    ue_numero                     varchar,            -- candidature
    municipio                     varchar,            -- candidature
    partido_sigla                 varchar,            -- candidature
    candidato_numero              varchar,            -- candidature
    cargo                         varchar,            -- candidature
    candidato_nome                varchar,            -- politician
    candidato_cpf                 varchar,            -- politician
    recibo_eleitoral_numero       varchar,            -- donation
    documento_numero              varchar,            -- donation
    doador_cnpjf                  varchar,            -- financier
    doador_nome                   varchar,            -- financier
    doador_nome_receita_federal   varchar,            -- financier
    doador_ue_sigla               varchar,            -- financier
    doador_partido_numero         varchar,            -- financier
    doador_candidato_numero       varchar,            -- financier
    doador_setor_economico_codigo varchar,            -- financier
    doador_setor_economico        varchar,            -- financier
    receita_data                  varchar,            -- donation
    receita_valor                 numeric,            -- donation
    receita_tipo                  varchar,            -- donation
    recurso_fonte                 varchar,            -- donation
    recurso_especie               varchar,            -- donation
    receita_descricao             varchar,            -- donation
    
    dados_originais               varchar

    -- politician_id                 varchar references politicians on update cascade on delete cascade
    -- financier_id                  varchar references financiers update cascade delete cascade
);

create table committees_donations_2012 (
    id                            serial primary key,

    data_hora                     varchar, -- Data e hora
    comite_sequencial             varchar, -- Sequencial Comite
    uf                            varchar, -- UF
    ue_numero                     varchar, -- Número UE
    municipio                     varchar, -- Municipio
    comite_tipo                   varchar, -- Tipo comite
    partido_sigla                 varchar, -- Sigla Partido
    documento_tipo                varchar, -- Tipo do documento
    documento_numero              varchar, -- Numero do documento
    doador_cnpjf                  varchar, -- CPF/CNPJ do doador
    doador_nome                   varchar, -- Nome do doador
    doador_nome_receita_federal   varchar, -- Nome receita doador
    doador_ue_sigla               varchar, -- Sigla UE doador
    doador_partido_numero         varchar, -- Numero partido doador
    doador_candidato_numero       varchar, -- Numero candidato doador
    doador_setor_economico_codigo varchar, -- Cod setor economico doador
    doador_setor_economico        varchar, -- Setor economico doador
    receita_data                  varchar, -- Data da receita
    receita_valor                 numeric, -- Valor receita
    receita_tipo                  varchar, -- Tipo receita
    recurso_fonte                 varchar, -- Fonte recurso
    recurso_especie               varchar, -- Especie recurso
    receita_descricao             varchar,  -- Descricao da receita

    dados_originais               varchar

    -- politician_id                 varchar references politicians on update cascade on delete cascade
    -- financier_id                  varchar references financiers update cascade delete cascade
);

create table parties_donations_2012 (
    id                            serial primary key,

    data_hora                     varchar, -- Data e hora
    diretorio_sequencial          varchar, -- Sequencial Diretorio
    uf                            varchar, -- UF
    ue_numero                     varchar, -- Numero UE
    municipio                     varchar, -- Municipio
    diretorio_tipo                varchar, -- Tipo diretorio
    partido_sigla                 varchar, -- Sigla Partido
    documento_tipo                varchar, -- Tipo do documento
    documento_numero              varchar, -- Numero do documento
    doador_cnpjf                  varchar, -- CPF/CNPJ do doador
    doador_nome                   varchar, -- Nome do doador
    doador_nome_receita_federal   varchar, -- Nome receita doador
    doador_ue_sigla               varchar, -- Sigla UE doador
    doador_partido_numero         varchar, -- Numero partido doador
    doador_candidato_numero       varchar, -- Numero candidato doador
    doador_setor_economico_codigo varchar, -- Cod setor economico doador
    doador_setor_economico        varchar, -- Setor economico doador
    receita_data                  varchar, -- Data da receita
    receita_valor                 numeric, -- Valor receita
    receita_tipo                  varchar, -- Tipo receita
    recurso_fonte                 varchar, -- Fonte recurso
    recurso_especie               varchar, -- Especie recurso
    receita_descricao             varchar, -- Descricao da receita

    dados_originais               varchar

    -- politician_id                 varchar references politicians on update cascade on delete cascade
    -- financier_id                  varchar references financiers update cascade delete cascade
);

--------------------------------------------------------------------------------
-- 2014 ------------------------------------------------------------------------
--------------------------------------------------------------------------------

-- create table candidates_donations_2014 (
--     id                            serial primary key,

--     eleicao_codigo                varchar,
--     eleicao_descricao             varchar,
--     data_hora                     varchar,            -- donation
--     prestador_conta_cnpj          varchar,            -- donation
--     candidato_sequencial          varchar,            -- candidature
--     uf                            varchar,            -- candidature
--     partido_sigla                 varchar,            -- candidature
--     candidato_numero              varchar,            -- candidature
--     cargo                         varchar,            -- candidature
--     candidato_nome                varchar,            -- politician
--     candidato_cpf                 varchar,            -- politician
--     recibo_eleitoral_numero       varchar,            -- donation
--     documento_numero              varchar,            -- donation
--     doador_cnpjf                  varchar,            -- financier
--     doador_nome                   varchar,            -- financier
--     doador_nome_receita_federal   varchar,            -- financier
--     doador_ue_sigla               varchar,            -- financier
--     doador_partido_numero         varchar,            -- financier
--     doador_candidato_numero       varchar,            -- financier
--     doador_setor_economico_codigo varchar,            -- financier
--     doador_setor_economico        varchar,            -- financier
--     receita_data                  varchar,            -- donation
--     receita_valor                 numeric,            -- donation
--     receita_tipo                  varchar,            -- donation
--     recurso_fonte                 varchar,            -- donation
--     recurso_especie               varchar,            -- donation
--     receita_descricao             varchar,            -- donation
--     doador_originario_cnpjf       varchar,            -- donation
--     doador_originario_nome        varchar,            -- donation
--     doador_originario_tipo        varchar,            -- donation
--     doador_originario_setor_economico varchar,        -- donation
--     doador_originario_nome_receita_federal varchar,   -- donation

--     dados_originais               varchar

--     --politician_id                 varchar references politicians update cascade delete cascade,
--     --financier_id                  varchar references financiers update cascade delete cascade
-- );

-- =head2 id
-- =head2 data_hora
-- =head2 candidato_sequencial
-- =head2 uf
-- =head2 partido_sigla
-- =head2 candidato_numero
-- =head2 cargo
-- =head2 candidato_cpf
-- =head2 recibo_eleitoral_numero
-- =head2 documento_numero
-- =head2 doador_cnpjf
-- =head2 doador_nome
-- =head2 doador_nome_receita
-- =head2 doador_ue_sigla
-- =head2 doador_partido_numero
-- =head2 doador_candidato_numero
-- =head2 doador_setor_economico_codigo
-- =head2 doador_setor_economico
-- =head2 receita_data
-- =head2 receita_valor  data_type: 'numeric'
-- =head2 receita_tipo
-- =head2 recurso_fonte
-- =head2 recurso_especie
-- =head2 receita_descricao
-- =head2 dados_originais

-- create table committees_donations_2014 ();

-- create table parties_donations_2014 ();
