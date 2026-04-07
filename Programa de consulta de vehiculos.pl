:- dynamic respuesta/2.



auto(toyota_corolla, sedan, combustion, automatico, 20000, no).
auto(honda_civic, sedan, combustion, manual, 21000, si).
auto(hyundai_elantra, sedan, combustion, automatico, 19000, si).
auto(kia_rio, sedan, combustion, manual, 17000, no).
auto(nissan_sentra, sedan, combustion, automatico, 19500, si).

auto(toyota_rav4, suv, combustion, automatico, 28000, no).
auto(honda_crv, suv, combustion, automatico, 30000, si).
auto(hyundai_tucson, suv, combustion, automatico, 27000, si).
auto(kia_sportage, suv, combustion, automatico, 26000, no).
auto(nissan_xtrail, suv, combustion, automatico, 29000, si).

auto(toyota_hilux, pickup, combustion, manual, 35000, no).
auto(ford_ranger, pickup, combustion, automatico, 37000, si).
auto(chevrolet_colorado, pickup, combustion, automatico, 36000, no).
auto(nissan_frontier, pickup, combustion, manual, 34000, si).

auto(tesla_model_3, sedan, electrico, automatico, 45000, si).
auto(nissan_leaf, hatchback, electrico, automatico, 30000, si).
auto(bmw_i3, hatchback, electrico, automatico, 42000, no).
auto(audi_q4_etron, suv, electrico, automatico, 50000, si).

auto(volkswagen_golf, hatchback, combustion, manual, 23000, no).
auto(mazda_cx5, suv, combustion, automatico, 31000, si).



preguntar(Pregunta, Respuesta) :-
    format('~w (escriba opcion en minuscula): ', [Pregunta]),
    read(Respuesta),
    assertz(respuesta(Pregunta, Respuesta)).

obtener_respuesta(Pregunta, Respuesta) :-
    respuesta(Pregunta, Respuesta), !.
obtener_respuesta(Pregunta, Respuesta) :-
    preguntar(Pregunta, Respuesta).



recomendar :-
    retractall(respuesta(_, _)),

    write('===== SISTEMA EXPERTO DE AUTOS ====='), nl,

    write('Ingrese su presupuesto: '),
    read(Presupuesto),

    obtener_respuesta('Tipo de motor (electrico/combustion)', Motor),
    obtener_respuesta('Transmision (automatico/manual)', Transmision),
    obtener_respuesta('Tipo de vehiculo (sedan/suv/pickup/hatchback)', Tipo),

    nl,
    write('Buscando autos...'), nl,

    buscar_auto(Presupuesto, Motor, Transmision, Tipo).


buscar_auto(Presupuesto, Motor, Transmision, Tipo) :-
    auto(Nombre, Tipo, Motor, Transmision, Precio, Descuento),
    Precio =< Presupuesto,

    nl,
    write('===== RECOMENDACION ====='), nl,
    write('Auto: '), write(Nombre), nl,
    write('Precio: $'), write(Precio), nl,
    write('Tipo: '), write(Tipo), nl,
    write('Motor: '), write(Motor), nl,
    write('Transmision: '), write(Transmision), nl,
    mostrar_descuento(Descuento), nl,
    !.

buscar_auto(_, _, _, _) :-
    nl,
    write('No se encontraron autos con esas caracteristicas.'), nl.


mostrar_descuento(si) :-
    write('Este auto tiene descuento especial.').

mostrar_descuento(no) :-
    write('Este auto no tiene descuento actualmente.').