-- locations users politicians financiers posts

----------------------------------------------------------------------

create table locations (
    id                    varchar primary key,
    name                  varchar,
    parent_id             varchar references locations,
    search_relevance      int,
    ibge_estado_codigo    int,
    ibge_municipio_codigo int
);

-- cpf não é primary key porque alguma hora podemos querer adicionar um
-- "político" cujo cpf não sabemos

create table politicians (
    token          varchar primary key,
    name           varchar,
    political_name varchar,
    party          varchar,
    cpf            varchar unique
);

create table financiers (
    name                 varchar,
    token                varchar primary key,
    cnpjf                varchar unique,
    economic_sector      varchar,
    economic_sector_code varchar
);

create table candidatures (
    politician_id        varchar references politicians,
    year                 varchar,
    state                varchar,
    city                 varchar,
    ue_numero            varchar,
    political_position   varchar,
    party                varchar,
    candidato_sequencial varchar, -- núm. seqüencial do candidato na eleição
    candidato_numero     varchar, -- núm. do candidato na eleição
    primary key (politician_id, year)
    -- -- scrap divulgacad
    -- coligacao varchar,              -- coligação

    -- -- scrap ???
    -- votos_turno_1
    -- votos_turno_2
    -- resultado_turno_1               -- "eleito" "não eleito" "segundo turno"
    -- resultado_turno_2               -- "eleito" "não eleito"
);

--------------------------------------------------------------------------------
-- 2010 ------------------------------------------------------------------------
--------------------------------------------------------------------------------

create table candidates_donations_2010 (
    id serial primary key,

    data_hora               varchar, -- Data e hora
    uf                      varchar, -- UF
    partido_sigla           varchar, -- Sigla Partido
    candidato_numero        varchar, -- Número candidato
    cargo                   varchar, -- Cargo
    candidato_nome          varchar, -- Nome candidato
    candidato_cpf           varchar references politicians(cpf), -- CPF do candidato
    entrega_em_conjunto     varchar, -- Entrega em conjunto?
    recibo_eleitoral_numero varchar, -- Número Recibo Eleitoral
    documento_numero        varchar, -- Número do documento
    doador_cnpjf            varchar references financiers(cnpjf), -- CPF/CNPJ do doador
    doador_nome             varchar, -- Nome do doador
    receita_data            varchar, -- Data da receita
    receita_valor           numeric, -- Valor receita
    receita_tipo            varchar, -- Tipo receita
    recurso_fonte           varchar, -- Fonte recurso
    recurso_especie         varchar, -- Espécie recurso
    receita_descricao       varchar, -- Descrição da receita

    dados_originais         varchar
);

create table committees_donations_2010 (
    id                serial primary key,
    data_hora         varchar, -- Data e hora
    uf                varchar, -- UF
    comite_tipo       varchar, -- Tipo comite
    partido_sigla     varchar, -- Sigla Partido
    documento_tipo    varchar, -- Tipo do documento
    documento_numero  varchar, -- Número do documento
    doador_cnpjf      varchar references financiers(cnpjf), -- CPF/CNPJ do doador
    doador_nome       varchar, -- Nome do doador
    receita_data      varchar, -- Data da receita
    receita_valor     numeric, -- Valor receita
    receita_tipo      varchar, -- Tipo receita
    recurso_fonte     varchar, -- Fonte recurso
    recurso_especie   varchar, -- Espécie recurso
    receita_descricao varchar, -- Descrição da receita

    dados_originais   varchar
);

create table parties_donations_2010 (
    id                serial primary key,
       
    data_hora         varchar, -- Data e hora
    uf                varchar, -- UF
    partido_tipo      varchar, -- Tipo partido
    partido_sigla     varchar, -- Sigla Partido
    documento_tipo    varchar, -- Tipo do documento
    documento_numero  varchar, -- Número do documento
    doador_cnpjf      varchar references financiers(cnpjf), -- CPF/CNPJ do doador
    doador_nome       varchar, -- Nome do doador
    receita_data      varchar, -- Data da receita
    receita_valor     numeric, -- Valor receita
    receita_tipo      varchar, -- Tipo receita
    recurso_fonte     varchar, -- Fonte recurso
    recurso_especie   varchar, -- Espécie recurso
    receita_descricao varchar, -- Descrição da receita

    dados_originais   varchar
);

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
    candidato_cpf                 varchar references politicians(cpf),            -- politician
    recibo_eleitoral_numero       varchar,            -- donation
    documento_numero              varchar,            -- donation
    doador_cnpjf                  varchar references financiers(cnpjf),            -- financier
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
    doador_cnpjf                  varchar references financiers(cnpjf), -- CPF/CNPJ do doador
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
    doador_cnpjf                  varchar references financiers(cnpjf), -- CPF/CNPJ do doador
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
);

--------------------------------------------------------------------------------
-- 2014 ------------------------------------------------------------------------
--------------------------------------------------------------------------------

create table candidates_donations_2014 (
    id                            serial primary key,

    eleicao_codigo                varchar,
    eleicao_descricao             varchar,
    data_hora                     varchar,            -- donation
    prestador_conta_cnpj          varchar,            -- donation
    candidato_sequencial          varchar,            -- candidature
    uf                            varchar,            -- candidature
    partido_sigla                 varchar,            -- candidature
    candidato_numero              varchar,            -- candidature
    cargo                         varchar,            -- candidature
    candidato_nome                varchar,            -- politician
    candidato_cpf                 varchar references politicians(cpf),            -- politician
    recibo_eleitoral_numero       varchar,            -- donation
    documento_numero              varchar,            -- donation
    doador_cnpjf                  varchar references financiers(cnpjf),            -- financier
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
    doador_originario_cnpjf       varchar,            -- donation
    doador_originario_nome        varchar,            -- donation
    doador_originario_tipo        varchar,            -- donation
    doador_originario_setor_economico varchar,        -- donation
    doador_originario_nome_receita_federal varchar,   -- donation

    dados_originais               varchar
);

create table committees_donations_2014 (
    id                            serial primary key,

    eleicao_codigo                varchar, -- Cód. Eleição
    eleicao_descricao             varchar, -- Desc. Eleição
    data_hora                     varchar, -- Data e hora
    prestador_conta_cnpj          varchar, -- CNPJ Prestador Conta
    comite_sequencial             varchar, -- Sequencial Comite
    uf                            varchar, -- UF
    comite_tipo                   varchar, -- Tipo Comite
    partido_sigla                 varchar, -- Sigla  Partido
    documento_tipo                varchar, -- Tipo do documento
    documento_numero              varchar, -- Número do documento
    doador_cnpjf                  varchar references financiers(cnpjf), -- CPF/CNPJ do doador
    doador_nome                   varchar, -- Nome do doador
    doador_nome_receita_federal   varchar, -- Nome do doador (Receita Federal)
    doador_ue_sigla               varchar, -- Sigla UE doador
    doador_partido_numero         varchar, -- Número partido doador
    doador_candidato_numero       varchar, -- Número candidato doador
    doador_setor_economico_codigo varchar, -- Cod setor econômico do doador
    doador_setor_economico        varchar, -- Setor econômico do doador
    receita_data                  varchar, -- Data da receita
    receita_valor                 numeric, -- Valor receita
    receita_tipo                  varchar, -- Tipo receita
    recurso_fonte                 varchar, -- Fonte recurso
    recurso_especie               varchar, -- Espécie recurso
    receita_descricao             varchar, -- Descrição da receita
    doador_originario_cnpjf       varchar, -- CPF/CNPJ do doador originário
    doador_originario_nome        varchar, -- Nome do doador originário
    doador_originario_tipo        varchar, -- Tipo doador originário
    doador_originario_setor_economico varchar, -- Setor econômico do doador originário
    doador_originario_nome_receita_federal varchar, -- Nome do doador originário (Receita Federal)

    dados_originais               varchar
);

create table parties_donations_2014 (
    id                            serial primary key,

    eleicao_codigo                varchar, -- Cód. Eleição
    eleicao_descricao             varchar, -- Desc. Eleição
    data_hora                     varchar, -- Data e hora
    prestador_conta_cnpj          varchar, -- CNPJ Prestador Conta
    diretorio_sequencial          varchar, -- Sequencial Diretorio
    uf                            varchar, -- UF
    diretorio_tipo                varchar, -- Tipo diretorio
    partido_sigla                 varchar, -- Sigla  Partido
    documento_tipo                varchar, -- Tipo do documento
    documento_numero              varchar, -- Número do documento
    doador_cnpjf                  varchar references financiers(cnpjf), -- CPF/CNPJ do doador
    doador_nome                   varchar, -- Nome do doador
    doador_nome_receita_federal   varchar, -- Nome do doador (Receita Federal)
    doador_ue_sigla               varchar, -- Sigla UE doador
    doador_partido_numero         varchar, -- Número partido doador
    doador_candidato_numero       varchar, -- Número candidato doador
    doador_setor_economico_codigo varchar, -- Cod setor econômico do doador
    doador_setor_economico        varchar, -- Setor econômico do doador
    receita_data                  varchar, -- Data da receita
    receita_valor                 numeric, -- Valor receita
    receita_tipo                  varchar, -- Tipo receita
    recurso_fonte                 varchar, -- Fonte recurso
    recurso_especie               varchar, -- Espécie recurso
    receita_descricao             varchar, -- Descrição da receita
    doador_originario_cnpjf       varchar, -- CPF/CNPJ do doador originário
    doador_originario_nome        varchar, -- Nome do doador originário
    doador_originario_tipo        varchar, -- Tipo doador originário
    doador_originario_setor_economico varchar, -- Setor econômico do doador originário
    doador_originario_nome_receita_federal varchar, -- Nome do doador originário (Receita Federal)

    dados_originais               varchar
);

create table finbra_funcoes (
    funcao_codigo varchar primary key, -- Código da função
    nome varchar -- Nome da função
);

create table finbra_subfuncoes (
    subfuncao_codigo varchar primary key, -- Código da subfunção
    nome varchar, -- Nome da subfunção
    finbra_funcao_id varchar references finbra_funcoes(funcao_codigo) -- Código da função
);
