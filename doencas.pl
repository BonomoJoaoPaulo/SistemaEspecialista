% Sintomas da rubéola
sintoma(rubeola, febre_alta).
sintoma(rubeola, cefaleia).
sintoma(rubeola, mal_estar).
sintoma(rubeola, dor_garganta).
sintoma(rubeola, glandulas_inchadas).
sintoma(rubeola, pintinhas_vermelhas).

% Sintomas do sarampo
sintoma(sarampo, febre).
sintoma(sarampo, tosse).
sintoma(sarampo, olhos_inchados).
sintoma(sarampo, olhos_irritados).
sintoma(sarampo, sensibilidade_luz).
sintoma(sarampo, glandulas_inchadas).
sintoma(sarampo, pintinhas_vermelhas).
sintoma(sarampo, coceira).
sintoma(sarampo, descamacao).

% Sintomas da poliomielite
sintoma(poliomielite, febre).
sintoma(poliomielite, dor_cabeca).
sintoma(poliomielite, dor_garganta).
sintoma(poliomielite, coriza).
sintoma(poliomielite, vomito).
sintoma(poliomielite, rigidez_nuca).
sintoma(poliomielite, paralisia).

% Sintomas da caxumba
sintoma(caxumba, inchaco_glandulas).
sintoma(caxumba, dor_garganta).
sintoma(caxumba, febre).
sintoma(caxumba, dor_ao_mastigar).
sintoma(caxumba, dor_cabeca).
sintoma(caxumba, dores_musculares).

% Sintomas da catapora
sintoma(catapora, febre_alta).
sintoma(catapora, pintinhas_vermelhas).
sintoma(catapora, coceira).
sintoma(catapora, dor_cabeca).
sintoma(catapora, perda_apetite).
sintoma(catapora, cansaço).

% Sintomas da meningite
sintoma(meningite, febre).
sintoma(meningite, rigidez_nuca).
sintoma(meningite, dor_cabeca).
sintoma(meningite, vomito).
sintoma(meningite, mal_estar).
sintoma(meningite, calafrios).
sintoma(meningite, dores_musculares).
sintoma(meningite, confusao_mental).

% Sintomas da coqueluche
sintoma(coqueluche, tosse_intensa).
sintoma(coqueluche, tosse_persistente).
sintoma(coqueluche, som_guincho_ao_inspirar).
sintoma(coqueluche, espirros).
sintoma(coqueluche, coriza).
sintoma(coqueluche, febre_leve).
sintoma(coqueluche, vomito_apos_tosse).
sintoma(coqueluche, cansaco).
sintoma(coqueluche, apneia).

% Lista todas as doencas que possuem um determinado sintoma
doencas_por_sintoma(Sintoma, Doencas) :-
    findall(Doenca, sintoma(Doenca, Sintoma), Doencas).

% Conta quantos sintomas de uma determinada doenca estao presentes na lista de sintomas
contar_sintomas(Doenca, Sintomas, Contagem) :-
    findall(Sintoma, (member(Sintoma, Sintomas), sintoma(Doenca, Sintoma)), Correspondencias),
    length(Correspondencias, Contagem).

% Diagnostica a doenca com base nos sintomas
diagnosticar(Sintomas, Doenca) :-
    findall(Doenca-Contagem, (sintoma(Doenca, _), contar_sintomas(Doenca, Sintomas, Contagem)), DoencasContagem),
    sort(2, @>=, DoencasContagem, [Doenca-_ | _]).

% Lista todos os sintomas de uma determinada doenca
sintomas_da_doenca(Doenca,Sintomas) :-
    findall(Sintoma, sintoma(Doenca, Sintoma), Sintomas).
