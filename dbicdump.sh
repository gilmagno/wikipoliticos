script/wikipoliticos_web_create.pl model DB DBIC::Schema WikiPoliticos::Schema create=static \
                     'dbi:Pg:dbname=wikipoliticos;host=127.0.0.1' 'wikipoliticos' 'wikipoliticos' \
                     '{ loader_options => { moniker_map => { candidates_donations_2012 => "CandidateDonation2012", committees_donations_2012 => "CommitteeDonation2012", parties_donations_2012 => "PartyDonation2012" }, generate_pod => 0, components => ["InflateColumn::DateTime", "TimeStamp"] } }'
