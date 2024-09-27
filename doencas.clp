; Definição do Template para Doenças
(deftemplate Doenca
   (slot nome)
   (multislot sintomas (default nil))
   (multislot tratamento (default nil))
   (multislot prevencao (default nil)))

; Fatos sobre Conhecimento de Doenças
(deffacts Conhecimento-Doencas
   ;; Catapora
   (Doenca 
      (nome "Catapora")
      (sintomas 
         (create$ "Erupções cutâneas" "Bolhas de água" "Coceira intensa" "Febre alta" "Cansaço" 
                  "Cefaleia" "Perda de apetite"))
      (tratamento 
         (create$ "Repouso" "Ingestão de líquidos" "Evitar coçar as feridas"))
      (prevencao 
         (create$ "Vacina Varicela")))
   
   ;; Caxumba
   (Doenca 
      (nome "Caxumba")
      (sintomas 
         (create$ "Inchaço das glândulas salivares" "Dor no pescoço" "Dor de cabeça" 
                  "Dores musculares" "Fraqueza" "Febre" "Calafrios" "Dor ao mastigar ou engolir"
                  "Orquite" "Ooforite" "Meningite" "Diminuição da capacidade auditiva"))
      (tratamento 
         (create$ "Repouso" "Uso de analgésicos"))
      (prevencao nil))
   
   ;; Coqueluche
   (Doenca 
      (nome "Coqueluche")
      (sintomas 
         (create$ "Tosse intensa e persistente" "Som de guincho ao inspirar" "Espirros" 
                  "Coriza" "Febre leve" "Vômito após tossir" "Cansaço" "Apneia em bebês"))
      (tratamento 
         (create$ "Antibióticos" "Medicamentos para alívio da tosse" "Hidratação" "Repouso"))
      (prevencao 
         (create$ "Vacina DTP")))
   
   ;; Meningite
   (Doenca 
      (nome "Meningite")
      (sintomas 
         (create$ "Febre" "Rigidez na nuca" "Dores de cabeça fortes" "Vômito" "Mal-estar" 
                  "Calafrios" "Dores musculares" "Confusão mental"))
      (tratamento 
         (create$ "Antibióticos" "Hidratação" "Repouso"))
      (prevencao 
         (create$ "Vacina anti HIB")))
   
   ;; Poliomielite
   (Doenca 
      (nome "Poliomielite")
      (sintomas 
         (create$ "Febre" "Dores de cabeça" "Dores de garganta" "Coriza" "Vômitos" 
                  "Rigidez de nuca" "Paralisia"))
      (tratamento 
         (create$ "Repouso" "Hidratação"))
      (prevencao 
         (create$ "Vacina Sabin" "Vacina anti-pólio")))
   
   ;; Rubéola
   (Doenca 
      (nome "Rubéola")
      (sintomas 
         (create$ "Febre alta" "Cefaleia" "Mal-estar" "Dor de garganta" 
                  "Aumento das glândulas no pescoço" "Pintinhas vermelhas na pele"))
      (tratamento 
         (create$ "Repouso" "Alívio dos sintomas"))
      (prevencao 
         (create$ "Vacina tríplice viral")))
   
   ;; Sarampo
   (Doenca 
      (nome "Sarampo")
      (sintomas 
         (create$ "Febre" "Tosse" "Olhos inchados" "Ínguas no pescoço" "Pintinhas vermelhas" 
                  "Desânimo" "Coceira" "Descamação da pele"))
      (tratamento 
         (create$ "Repouso absoluto" "Medicação para sintomas" "Antibióticos para infecções"))
      (prevencao 
         (create$ "Vacina contra o sarampo")))
)

; Template para Sintomas Observados
(deftemplate Sintomas-Observados
   (multislot sintomas))

; Função para Concatenar Elementos com Vírgula
(deffunction join-with-comma (?list)
   (if (or (eq ?list nil) (eq (length$ ?list) 0))
       then ""
       else
          (str-cat (nth$ 1 ?list)
                   (if (> (length$ ?list) 1)
                       then (str-cat ", " (join-with-comma (rest$ ?list)))
                       else ""))))

; Regra de Diagnóstico Geral
(defrule diagnostico-geral
   ?sintomasObs <- (Sintomas-Observados (sintomas $?obs))
   (Doenca (nome ?nome) 
           (sintomas $?sint)
           (tratamento $?trat)
           (prevencao $?prev))
   (test (subsetp $?sint $?obs))
   =>
   (printout t "----------------------------------------" crlf)
   (printout t "Doença Identificada: " ?nome crlf)
   (printout t "Tratamento: " (join-with-comma $?trat) crlf)
   
   ;; Verifica se há prevenção disponível
   (if (neq (length$ $?prev) 0) then
      (printout t "Prevenção: " (join-with-comma $?prev) crlf)
      (printout t "----------------------------------------" crlf))
   
   (if (eq (length$ $?prev) 0) then
      (printout t "Prevenção: Nenhuma informação disponível." crlf)
      (printout t "----------------------------------------" crlf))
)

; Inserir os Sintomas Observados
(assert (Sintomas-Observados 
            (sintomas "Febre alta" 
                     "Erupções cutâneas" 
                     "Coceira intensa" 
                     "Cansaço" 
                     "Cefaleia")))

; Executar o Motor de Inferência
(reset)
(run)
