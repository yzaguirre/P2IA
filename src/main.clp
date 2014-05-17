; David Yzaguirre Gonzalez
; 200819312
(deftemplate Seleccion
	(slot nombre (type STRING))
	(slot ata (type INTEGER))
	(slot med (type INTEGER))
	(slot def (type INTEGER))
	(slot ip (type INTEGER))
)
(deftemplate Jugador
	(slot nombre (type STRING))
	(slot Seleccion (type STRING))
	(slot Media (type INTEGER))
	(slot Dorsal (type INTEGER))
	(slot Marcado (type INTEGER)) ; para no volver a recomendarlo

	(slot centros (type INTEGER)) ; ATAQUE
	(slot definicion (type INTEGER)) ; ATAQUE
	(slot precision_cabeza (type INTEGER)) ; ATAQUE
	(slot pases_cortos (type INTEGER)) ; ATAQUE
	(slot voleas (type INTEGER)) ; ATAQUE
	(slot regates (type INTEGER)) ; HABILIDAD
	(slot efecto (type INTEGER)) ; HABILIDAD
	(slot precision_falta (type INTEGER)) ; HABILIDAD
	(slot pases_largos (type INTEGER)) ; HABILIDAD
	(slot control_balon (type INTEGER)) ; HABILIDAD
	(slot aceleracion (type INTEGER)) ; MOVIMIENTO
	(slot velocidad_sprint (type INTEGER)) ; MOVIMIENTO
	(slot agilidad (type INTEGER)) ; MOVIMIENTO
	(slot mreflejos (type INTEGER)) ; MOVIMIENTO
	(slot equilibrio (type INTEGER)) ; MOVIMIENTO
	(slot potencia_disparo (type INTEGER)) ; POTENCIA
	(slot saldo (type INTEGER)) ; POTENCIA
	(slot resistencia (type INTEGER)) ; POTENCIA
	(slot fuerza (type INTEGER)) ; POTENCIA
	(slot disparos_lejanos (type INTEGER)) ; POTENCIA
	(slot agresividad (type INTEGER)) ; MENTALIDAD
	(slot tactico (type INTEGER)) ; MENTALIDAD
	(slot mposicionamiento (type INTEGER)) ; MENTALIDAD
	(slot vision (type INTEGER)) ; MENTALIDAD
	(slot penaltis (type INTEGER)) ; MENTALIDAD
	(slot marcaje (type INTEGER)) ; DEFENSA
	(slot entrada (type INTEGER)) ; DEFENSA
	(slot entrada_agresiva (type INTEGER)) ; DEFENSA
	(slot estirada (type INTEGER)) ; PORTEROS
	(slot parada (type INTEGER)) ; PORTEROS
	(slot saque_puerta (type INTEGER)) ; PORTEROS
	(slot posicionamiento (type INTEGER)) ; PORTEROS
	(slot reflejos (type INTEGER)) ; PORTEROS
)
(defglobal ?*rival* = "")
(defglobal ?*EstrategiaRival* = "Defensiva")
(defglobal ?*EstrategiaBolivia* = "Defensiva")
(defglobal ?*Defensa* = "Bien")
(defglobal ?*Ataque* = "Bien")
(defglobal ?*GolesRival* = 0)
(defglobal ?*GolesBolivia* = 0)
(deftemplate jugador-en-pos
	(slot dorsal (type INTEGER))
	(slot posicion (type INTEGER))
)
(defrule menu-o10
	?f <- (menu-oficial 9)
=>
	(retract ?f)
)
(defrule menu-o9-3
	(declare (salience 198))
	?f <- (menu-oficial 8)
	?sp <- (sustitucion-por ?d-out ?d-in)
	?jep <- (jugador-en-pos (dorsal ?d-out) (posicion ?pos))
	?j <- (Jugador (Dorsal ?d-out))
=>
	(modify ?jep (dorsal ?d-in))
	(modify ?j (Marcado 1))
	(retract ?f)
	(retract ?sp)
	(assert (menu-oficial 0))
)
(defrule menu-o9-2
	(declare (salience 199))
	(menu-oficial 8)
=>
	(printout t "Ingrese el dorsal del jugador saliente: ")
	(bind ?dor-out (read))
	(printout t crlf "Ingrese el dorsal del jugador entrante: ")
	(bind ?dor-in (read))
	(assert (sustitucion-por ?dor-out ?dor-in))
)
(defrule menu-o9
	(declare (salience 200))
	(menu-oficial 8)
	?jep <- (jugador-en-pos (dorsal ?dorsal) (posicion ?pos))
	(Jugador (Dorsal ?dorsal) (nombre ?nombre) )
=>
	(printout t "Dorsal: " ?dorsal ", Nombre: " ?nombre ", Posicion: " ?pos crlf)
)
(defrule menu-o8-2-2
	(declare (salience 199))
	?f <- (menu-oficial 7)
	?r <- (recomendacion 0) ; defensivo
	?j <- (Jugador (nombre ?nombre) (Media ?media) (Dorsal ?dorsal) (Marcado 0)
		(marcaje ?mar1) (entrada ?ent1) (entrada_agresiva ?entagre1))
	(jugador-en-pos (dorsal ~?dorsal))
	(forall (and (Jugador (Dorsal ?d) (Media ?m) (Marcado 0)
		(marcaje ?mar2) (entrada ?ent2) (entrada_agresiva ?entagre2))
		(jugador-en-pos (dorsal ?d)))
		(test (>= (/ (+ ?mar1 ?ent1 ?entagre1) 3) (/ (+ ?mar2 ?ent2 ?entagre2) 3)))
	)
=>
	(printout t "Se recomienda ingresar a Dorsal: " ?dorsal ", " ?nombre crlf)
	(modify ?j (Marcado 1))
	(retract ?f)
	(retract ?r)
	(assert (menu-oficial 0))
)
(defrule menu-o8-2-1
	(declare (salience 199))
	?f <- (menu-oficial 7)
	?r <- (recomendacion 1) ; ofensivo
	?j <- (Jugador (nombre ?nombre) (Media ?media) (Dorsal ?dorsal) (Marcado 0)
		(centros ?c1) (definicion ?d1) (precision_cabeza ?p1) (pases_cortos ?pc1) (voleas ?v1))
	(jugador-en-pos (dorsal ~?dorsal))
	(forall (and (Jugador (Dorsal ?d) (Media ?m) (Marcado 0)
		(centros ?c2) (definicion ?d2) (precision_cabeza ?p2) (pases_cortos ?pc2) (voleas ?v2))
	 	(jugador-en-pos (dorsal ~?d)))
		(test (>= (/ (+ ?c1 ?d1 ?p1 ?pc1 ?v1) 5) (/ (+ ?c2 ?d2 ?p2 ?pc2 ?v2) 5)))
	)
=>
	(printout t "Se recomienda ingresar a Dorsal: " ?dorsal ", " ?nombre crlf)
	(modify ?j (Marcado 1))
	(retract ?f)
	(retract ?r)
	(assert (menu-oficial 0))
)
(defrule menu-o8
	(declare (salience 200))
	(menu-oficial 7)
	(Seleccion (nombre ?n) (ata ?rata) (med ?rmed) (def ?rdef))
	(test (eq (str-compare ?n ?*rival*) 0))
	(Seleccion (nombre "Bolivia") (ata ?bata) (med ?bmed) (def ?bdef))
=>
	(bind ?defender 0)
	(bind ?atacar 0)
	(if (>= ?rata ?bata) then
		(bind ?defender (+ ?defender 1))
		else
		(bind ?atacar (+ ?atacar 1))
	)
	(if (>= ?rdef ?bdef) then
		(bind ?atacar (+ ?atacar 1))
		else
		(bind ?defender (+ ?defender 1))
	)
	(if (>= ?rmed ?bmed) then
		(bind ?defender (+ ?defender 1))
		else
		(bind ?atacar (+ ?atacar 1))
	)
; ?*EstrategiaRival*
; ?*EstrategiaBolivia*
	(if (and (eq (str-compare ?*EstrategiaBolivia* "Defensiva") 0) (eq (str-compare ?*EstrategiaRival* "Defensiva") 0)) then
		(bind ?atacar (+ ?atacar 1))
		else 
		(if (and (eq (str-compare ?*EstrategiaBolivia* "Defensiva") 0) (eq (str-compare ?*EstrategiaRival* "Ofensiva") 0)) then
			(bind ?defender (+ ?defender 1))
			else 
			(if (and (eq (str-compare ?*EstrategiaBolivia* "Ofensiva") 0) (eq (str-compare ?*EstrategiaRival* "Defensiva") 0)) then
				(bind ?atacar (+ ?atacar 1))
				else 
				(if (and (eq (str-compare ?*EstrategiaBolivia* "Ofensiva") 0) (eq (str-compare ?*EstrategiaRival* "Ofensiva") 0)) then
					(bind ?defender (+ ?defender 1))
				)
			)
		)
	)
; ?*Defensa*
	(if (eq (str-compare ?*Defensa* "Bien") 0) then
		(bind ?atacar (+ ?atacar 1))
		else 
		(bind ?defender (+ ?defender 1))
	)
; ?*Ataque* ; 
	(if (eq (str-compare ?*Ataque* "Bien") 0) then
		(bind ?defender (+ ?defender 1))
		else 
		(bind ?atacar (+ ?atacar 1))
	)
; ?*GolesRival* ; incluye defensa
; ?*GolesBolivia* ; influye ataque
	(if (>= ?*GolesBolivia* ?*GolesRival*) then 
		(bind ?atacar (+ ?atacar 1))
		else 
		(bind ?defender (+ ?defender 1))
	)
	(if (>= ?atacar ?defender) then
		(printout t "Se recomienda estrategia de Ataque " crlf)
		(assert (recomendacion 1))
		else 
		(printout t "Se recomienda estrategia de Defensa " crlf)
		(assert (recomendacion 0))
	)
	;(printout t "atacar: " ?atacar " defender: " ?defender crlf)
)
(defrule menu-o7
	?f <- (menu-oficial 6)
=>
	(printout t "Bolivia esta atacando actualmente: " ?*Ataque* crlf "La nueva es [Bien|Mal]: ")
	(bind ?*Ataque* (readline))
	(retract ?f)
	(assert (menu-oficial 0))
)
(defrule menu-o6
	?f <- (menu-oficial 5)
=>
	(printout t "Bolivia se esta defendiendo actualmente: " ?*Defensa* crlf "La nueva es [Bien|Mal]: ")
	(bind ?*Defensa* (readline))
	(retract ?f)
	(assert (menu-oficial 0))
)
(defrule menu-o5
	?f <- (menu-oficial 4)
=>
	(printout t "Bolivia tiene estrategia actual: " ?*EstrategiaBolivia* crlf "La nueva es [Ofensiva|Defensiva]: ")
	(bind ?*EstrategiaBolivia* (readline))
	(retract ?f)
	(assert (menu-oficial 0))
)
(defrule menu-o4
	?f <- (menu-oficial 3)
=>
	(printout t ?*rival* " tiene estrategia actual: " ?*EstrategiaRival* crlf "La nueva es [Ofensiva|Defensiva]: ")
	(bind ?*EstrategiaRival* (readline))
	(retract ?f)
	(assert (menu-oficial 0))
)
(defrule menu-o3
	?f <- (menu-oficial 2)
=>
	(bind ?*GolesRival* (+ ?*GolesRival* 1))
	(printout t "Marcador" ?*rival* ": " ?*GolesRival*)
	(retract ?f)
	(assert (menu-oficial 0))
)
(defrule menu-o2
	?f <- (menu-oficial 1)
=>
	(bind ?*GolesBolivia* (+ ?*GolesBolivia* 1))
	(printout t "Marcador Bolivia: " ?*GolesBolivia*)
	(retract ?f)
	(assert (menu-oficial 0))
)
(defrule menu-oficial1
	?f <- (menu-oficial 0)
=>
	(printout t crlf crlf "Opciones de ingreso para estado del partido:" crlf "1.) Nuestro Equipo anotó gol" crlf "2.) Equipo Rival anotó gol" crlf "3.) Equipo Rival tiene estrategia..." crlf "4.) Equipo Bolivia tiene estrategia..." crlf "5.) Nuestra defensa cambio para..." crlf "6.) Nuestro ataque cambio para..." crlf "7.) Solicitar Recomendacion" crlf "8.) Sustituir Jugador" crlf "9.) Salir" crlf) 
	(printout t "Elija opcion [1-8]: ")
	(bind ?opcion (read))
	(retract ?f)
	(assert (menu-oficial ?opcion))
	(printout t crlf)
)
(defrule seleccion-jugador
	(declare (salience 201))
	(initial-fact)
=>
	(printout t crlf "Ingrese dorsal de jugador 1: ")
	(bind ?dorsal (read))
	(assert (jugador-en-pos (dorsal ?dorsal)(posicion 1)))
	(printout t crlf "Ingrese dorsal de jugador 2: ")
	(bind ?dorsal (read))
	(assert (jugador-en-pos (dorsal ?dorsal)(posicion 2)))
	(printout t crlf "Ingrese dorsal de jugador 3: ")
	(bind ?dorsal (read))
	(assert (jugador-en-pos (dorsal ?dorsal)(posicion 3)))
	(printout t crlf "Ingrese dorsal de jugador 4: ")
	(bind ?dorsal (read))
	(assert (jugador-en-pos (dorsal ?dorsal)(posicion 4)))
	(printout t crlf "Ingrese dorsal de jugador 5: ")
	(bind ?dorsal (read))
	(assert (jugador-en-pos (dorsal ?dorsal)(posicion 5)))
	(printout t crlf "Ingrese dorsal de jugador 6: ")
	(bind ?dorsal (read))
	(assert (jugador-en-pos (dorsal ?dorsal)(posicion 6)))
	(printout t crlf "Ingrese dorsal de jugador 7: ")
	(bind ?dorsal (read))
	(assert (jugador-en-pos (dorsal ?dorsal)(posicion 7)))
	(printout t crlf "Ingrese dorsal de jugador 8: ")
	(bind ?dorsal (read))
	(assert (jugador-en-pos (dorsal ?dorsal)(posicion 8)))
	(printout t crlf "Ingrese dorsal de jugador 9: ")
	(bind ?dorsal (read))
	(assert (jugador-en-pos (dorsal ?dorsal)(posicion 9)))
	(printout t crlf "Ingrese dorsal de jugador 10: ")
	(bind ?dorsal (read))
	(assert (jugador-en-pos (dorsal ?dorsal)(posicion 10)))
	(printout t crlf "Ingrese dorsal de jugador 11: ")
	(bind ?dorsal (read))
	(assert (jugador-en-pos (dorsal ?dorsal)(posicion 11)))
	(assert (menu-oficial 0))
)
(defrule jugadores
	(declare (salience 202))
	(initial-fact)
	(Jugador (nombre ?nombre) (Media ?media) (Dorsal ?dorsal))
=>
	(printout t ?dorsal ": " ?nombre ", tiene media " ?media "." crlf)
)
(defrule seleccion-rival
	(declare (salience 203))
	(initial-fact)
=>
	(printout t crlf "Seleccione Pais Rival: ")
	(bind ?*rival* (readline))
	;(assert (rival =(readline)))
	(printout t crlf "JUGADORES SELECCION BOLIVIA" crlf)
)
(defrule mostrar-paises
	(declare (salience 204))
	(initial-fact)
	(Seleccion (nombre ?nombre))
=>
	(printout t ?nombre crlf)
)
(defrule inicio
	(declare (salience 205))
	(initial-fact)
=>
	(load-facts main_facts.clp)
	;(printout t " Exito!!, Se cargaron los datos correctamente" crlf crlf )
	(printout t "Paises: " crlf)
)
