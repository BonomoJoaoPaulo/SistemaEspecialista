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
                  "Cefaleia" "Perda de apetite" "Pintinhas vermelhas"))
      (tratamento 
         (create$ "Repouso" "Hidratação" "Evitar coçar as feridas" "Paracetamol" "Dipirona" "Aciclovir"))
      (prevencao 
         (create$ "Vacina Contra Varicela")))
   
   ;; Caxumba
   (Doenca 
      (nome "Caxumba")
      (sintomas 
         (create$ "Inchaço das glândulas salivares" "Dor no pescoço" "Dor de cabeça" 
                  "Dores musculares" "Fraqueza" "Febre" "Calafrios" "Dor ao mastigar ou engolir"
                  "Orquite" "Ooforite" "Meningite" "Diminuição da capacidade auditiva"))
      (tratamento 
         (create$ "Repouso" "Hidratação" "Paracetamol" "Dipirona" "Ibuprofeno"))
      (prevencao
         (create$ "Vacina Tríplice Viral")))
   
   ;; Coqueluche
   (Doenca 
      (nome "Coqueluche")
      (sintomas 
         (create$ "Tosse intensa e persistente" "Som de guincho ao inspirar" "Espirros" 
                  "Coriza" "Febre leve" "Vômito após tossir" "Cansaço" "Apneia em bebês"))
      (tratamento 
         (create$ "Repouso" "Hidratação" "Paracetamol" "Dipirona" "Azitromicina"))
      (prevencao 
         (create$ "Vacina DTP")))
   
   ;; Meningite
   (Doenca 
      (nome "Meningite")
      (sintomas 
         (create$ "Febre" "Rigidez na nuca" "Dores de cabeça fortes" "Vômito" "Mal-estar" 
                  "Calafrios" "Dores musculares" "Confusão mental"))
      (tratamento 
         (create$ "Repouso" "Hidratação" "Paracetamol" "Dipirona" "Ibuprofeno" "Ceftriaxona"))
      (prevencao 
         (create$ "Vacina anti HIB")))
   
   ;; Poliomielite
   (Doenca 
      (nome "Poliomielite")
      (sintomas 
         (create$ "Febre" "Dores de cabeça" "Dores de garganta" "Coriza" "Vômitos" 
                  "Rigidez de nuca" "Paralisia"))
      (tratamento 
         (create$ "Repouso" "Hidratação" "Paracetamol"))
      (prevencao 
         (create$ "Vacina Anti-Pólio")))
   
   ;; Rubéola
   (Doenca 
      (nome "Rubéola")
      (sintomas 
         (create$ "Febre alta" "Cefaleia" "Mal-estar" "Dor de garganta" 
                  "Aumento das glândulas no pescoço" "Pintinhas vermelhas"))
      (tratamento 
         (create$ "Repouso" "Hidratação" "Paracetamol" "Dipirona" "Ibuprofeno"))
      (prevencao 
         (create$ "Vacina Tríplice Viral")))
   
   ;; Sarampo
   (Doenca 
      (nome "Sarampo")
      (sintomas 
         (create$ "Febre" "Tosse" "Olhos inchados" "Ínguas no pescoço" "Pintinhas vermelhas" 
                  "Desânimo" "Coceira"))
      (tratamento 
         (create$ "Repouso absoluto" "Hidratação" "Paracetamol" "Dipirona"))
      (prevencao 
         (create$ "Vacina Tríplice Viral")))
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
   ?doenca <- (Doenca (nome ?nome) 
                      (sintomas $?sint)
                      (tratamento $?trat)
                      (prevencao $?prev))
   =>
   (printout t "Sintomas Observados: " $?obs crlf)
   (if (subsetp $?obs $?sint)
       then
          (printout t "----------------------------------------" crlf)
          (printout t "Possível Doença: " ?nome crlf)
          (printout t "Conjunto de sintomas encontrado para a doença." crlf)
          (printout t "Sintomas da Doença: " $?sint crlf)
          (printout t "Tratamento: " (join-with-comma $?trat) crlf)
          (if (eq (length$ $?prev) 0)
             then
                (printout t "Prevenção: Nenhuma informação disponível." crlf)
             else
                (printout t "Prevenção: " (join-with-comma $?prev) crlf))
          (printout t "----------------------------------------" crlf)
       else
          (printout t "Nenhuma subconjunto de sintomas encontrado para " ?nome crlf)
          (printout t "----------------------------------------" crlf)
   )
)