use strict;
use warnings;
use WikiPoliticos::Web::Model::DB;
use WikiPoliticos::Util;

my $schema = WikiPoliticos::Web::Model::DB->new->schema;
my $locations_rs = $schema->resultset('Location')->search_rs;

my $csvs_basedir = $ARGV[0];

my %municipios_csv = make_municipios_csv();
my %tokens_problematicos_map = make_tokens_problematicos_map();

while (my ($municipio_key, $municipio) = each %municipios_csv) {
    # Atenção: $municipio_key não é só, exemplo, 'fortaleza', mas 'ce-fortaleza'

    $municipio_key =~ s/-/_/g;    # troca qualquer - por _
    $municipio_key =~ s/_/-/;     # troca só o primeiro _ por -

    # Tenta achar no BD uma location correspondente ao token feito com
    # o nome do município do CSV
    my $location_id_to_find = 'br-' . $municipio_key;
    my $location = $locations_rs->find($location_id_to_find);

    # Se não achar uma location, usa o hash %tokens_problematicos_map
    # e o token feito com nome do município para achar o token de uma
    # location. Esse hash mapeia tokens de municípios problemáticos a
    # tokens de locations
    if (!$location) {
        my $new_location_id_to_find = $tokens_problematicos_map{ $location_id_to_find };
        $location = $locations_rs->find($new_location_id_to_find);
    }

    if ($location) {
        $location->ibge_estado_codigo( $municipio->{estado_codigo} );
        $location->ibge_municipio_codigo( $municipio->{municipio_codigo} );
        $location->update;
    }
    else {
        print "Token nao encontrado: $location_id_to_find\n";
    }
}

sub make_municipios_csv {
    my %municipios;

    open my $fh, '<:encoding(utf8)', $csvs_basedir;
    <$fh>; # Descarta a primeira linha

    while (my $line = <$fh>) {
        my @split_line = split /,/, $line;
        $split_line[2] =~ s/^"|"$//g;

        my $municipio_name_tokenized = WikiPoliticos::Util::make_token( $split_line[2] );
        my $estado_sigla = lc get_estado_sigla( $split_line[0] );

        my $estado_municipio_token = $estado_sigla . '-' . $municipio_name_tokenized;

        $municipios{ $estado_municipio_token } = { estado_codigo    => $split_line[0],
                                                   municipio_codigo => $split_line[1] };
    }

    close $fh or die "$fh: $!";

    return %municipios;
}

sub get_estado_sigla {
    my $codigo = shift;

    my %map = (11 => "RO",
               12 => "AC",
               13 => "AM",
               14 => "RR",
               15 => "PA",
               16 => "AP",
               17 => "TO",
               21 => "MA",
               22 => "PI",
               23 => "CE",
               24 => "RN",
               25 => "PB",
               26 => "PE",
               27 => "AL",
               28 => "SE",
               29 => "BA",
               31 => "MG",
               32 => "ES",
               33 => "RJ",
               35 => "SP",
               41 => "PR",
               42 => "SC",
               43 => "RS",
               50 => "MS",
               51 => "MT",
               52 => "GO",
               53 => "DF");

    return $map{ $codigo };
}

# esquerda: token do csv; direta: token da tabela 'locations'
sub make_tokens_problematicos_map {
    return
      qw/br-pa-tomeacu                    br-pa-tome-acu
         br-al-olho_dagua_das_flores      br-al-olho_d_agua_das_flores
         br-ma-conceicao_do_lagoacu       br-ma-conceicao_do_lago-acu
         br-rn-augusto_severo             br-rn-campo_grande
         br-sp-santa_clara_doeste         br-sp-santa_clara_d_oeste
         br-pb-serido                     br-pb-sao_vicente_do_serido
         br-go-sao_joao_dalianca          br-go-sao_joao_d_alianca
         br-rj-parati                     br-rj-paraty
         br-rn-presidente_juscelino       br-rn-serra_caiada
         br-sp-santa_rita_doeste          br-sp-santa_rita_d_oeste
         br-ro-nova_brasilandia_doeste    br-ro-nova_brasilandia_do_oeste
         br-ro-santa_luzia_doeste         br-ro-santa_luzia_do_oeste
         br-pb-mae_dagua                  br-pb-mae_d_agua
         br-ro-sao_felipe_doeste          br-ro-sao_felipe_do_oeste
         br-pb-campo_de_santana           br-pb-tacima
         br-pi-pau_darco_do_piaui         br-pi-pau_d_arco_do_piaui
         br-pa-igarapeacu                 br-pa-igarape-acu
         br-to-pau_darco                  br-to-pau_d_arco
         br-ba-santa_teresinha            br-ba-santa_terezinha
         br-mt-lambari_doeste             br-mt-lambari_d_oeste
         br-mt-gloria_doeste              br-mt-gloria_d_oeste
         br-rn-acu                        br-rn-assu
         br-pe-lagoa_do_itaenga           br-pe-lagoa_de_itaenga
         br-rn-governador_dixsept_rosado  br-rn-governador_dix-sept_rosado
         br-ro-espigao_doeste             br-ro-espigao_do_oeste
         br-sp-arcoiris                   br-sp-arco-iris
         br-sp-biritibamirim              br-sp-biritiba_mirim
         br-ba-xiquexique                 br-ba-xique-xique
         br-pa-peixeboi                   br-pa-peixe-boi
         br-ro-jiparana                   br-ro-ji-parana
         br-sp-sao_joao_do_pau_dalho      br-sp-sao_joao_do_pau_d_alho
         br-mg-sempeixe                   br-mg-sem_peixe
         br-ap-pedra_branca_do_amapari    br-ap-agua_branca_do_amapari
         br-se-itaporanga_dajuda          br-se-itaporanga_d_ajuda
         br-sp-guarani_doeste             br-sp-guarani_d_oeste
         br-ro-alvorada_doeste            br-ro-alvorada_do_oeste
         br-pi-barra_dalcantara           br-pi-barra_d_alcantara
         br-pr-perola_doeste              br-pr-perola_d_oeste
         br-mt-mirassol_doeste            br-mt-mirassol_d_oeste
         br-sp-pariqueraacu               br-sp-pariquera-acu
         br-pi-olho_dagua_do_piaui        br-pi-olho_d_agua_do_piaui
         br-rs-xangrila                   br-rs-xangri-la
         br-sc-luiz_alves                 br-sc-luis_alves
         br-se-gracho_cardoso             br-se-graccho_cardoso
         br-pr-itapejara_doeste           br-pr-itapejara_d_oeste
         br-ba-muquem_de_sao_francisco    br-ba-muquem_do_sao_francisco
         br-sp-santa_barbara_doeste       br-sp-santa_barbara_d_oeste
         br-pb-olho_dagua                 br-pb-olho_d_agua
         br-ba-dias_davila                br-ba-dias_d_avila
         br-mg-brasopolis                 br-mg-brazopolis
         br-ro-guajaramirim               br-ro-guajara-mirim
         br-ro-alta_floresta_doeste       br-ro-alta_floresta_do_oeste
         br-pa-igarapemiri                br-pa-igarape-miri
         br-mg-sapucaimirim               br-mg-sapucai-mirim
         br-sp-embuguacu                  br-sp-embu-guacu
         br-sc-grao_para                  br-sc-grao-para
         br-rs-naometoque                 br-rs-nao-me-toque
         br-ro-machadinho_doeste          br-ro-machadinho_do_oeste
         br-pa-pau_darco                  br-pa-pau_d_arco
         br-al-olho_dagua_do_casado       br-al-olho_d_agua_do_casado
         br-ba-quijingue                  br-ba-quinjingue
         br-rn-januario_cicco             br-rn-boa_saude
         br-rs-entreijuis                 br-rs-entre-ijuis
         br-sp-estrela_doeste             br-sp-estrela_d_oeste
         br-mg-guardamor                  br-mg-guarda-mor
         br-rn-olhodagua_do_borges        br-rn-olho_d_agua_do_borges
         br-ma-olho_dagua_das_cunhas      br-ma-olho_d_agua_das_cunhas
         br-sc-herval_doeste              br-sc-herval_d_oeste
         br-sp-embu                       br-sp-embu_das_artes
         br-mt-conquista_doeste           br-mt-conquista_d_oeste
         br-ma-apicumacu                  br-ma-apicum-acu
         br-go-sitio_dabadia              br-go-sitio_d_abadia
         br-sp-florinia                   br-sp-florinea
         br-mt-poxoreo                    br-mt-poxoreu
         br-al-tanque_darca               br-al-tanque_d_arca
         br-ma-pindaremirim               br-ma-pindare-mirim
         br-rn-cearamirim                 br-rn-ceara-mirim
         br-sp-moji_mirim                 br-sp-mogi_mirim
         br-mt-figueiropolis_doeste       br-mt-figueiropolis_d_oeste
         br-rn-lagoa_danta                br-rn-lagoa_d_anta
         br-pr-diamante_doeste            br-pr-diamante_d_oeste
         br-sp-aparecida_doeste           br-sp-aparecida_d_oeste
         br-mg-pingodagua                 br-mg-pingo_d_agua
         br-sp-palmeira_doeste            br-sp-palmeira_d_oeste
         br-pr-sao_jorge_doeste           br-pr-sao_jorge_d_oeste
         br-al-olho_dagua_grande          br-al-olho_d_agua_grande
         br-mg-passavinte                 br-mg-passa_vinte
         br-rj-varresai                   br-rj-varre-sai
         br-sc-presidente_castello_branco br-sc-presidente_castelo_branco
         br-pr-rancho_alegre_doeste       br-pr-rancho_alegre_d_oeste
         br-rn-venhaver                   br-rn-venha-ver
         br-mg-olhosdagua                 br-mg-olhos_d_agua/;
}
