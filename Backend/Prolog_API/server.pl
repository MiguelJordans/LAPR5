% Bibliotecas
:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_parameters)).
:-use_module(library(persistency)).
:-use_module(library(semweb/rdf_db)).
:-use_module(library(http/http_json)).
%:-use_module(order).
%:-ensure_loaded('base').

% Relação entre pedidos HTTP e predicados que os processam
:- http_handler('/lapr5', responde_ola, []).
:- http_handler('/register_user', register_user, []).
:- http_handler('/send_file_post', send_file_post, []).
:- http_handler('/receive_path_post', receive_path_post, []).
:-http_handler('/receive_warehouse_post',receive_warehouse_post,[]).
:-http_handler('/receive_order_post',receive_order_post,[]).
:-http_handler('/receive_truck_post',receive_truck_post,[]).
:-http_handler('/receive_trucks_post',receive_trucks_post,[]).

:-http_handler('/send_heuristic',send_heuristic,[]).
:-http_handler('/send_heuristic_weight',send_heuristic_weight,[]).
:-http_handler('/send_heuristic_weight_time',send_heuristic_weight_time,[]).
:-http_handler('/send_best_ind',send_best_ind,[]).


:-http_handler('/send_fleet_trip',send_fleet_trip,[]).
:- dynamic a/1.

% :-include('/lei21-22-s5-3dj-56/Backend/GestLogistica_API/GestLogistica/src/core/infra/orders.pl').
% :-include('warehousesBD.pl'). :-include('truckBD.pl').
:-dynamic orders/4.
:-dynamic paths/6.
:-dynamic warehouses/2.
:-dynamic carateristicasCam/6.
:-dynamic cam/2.
:-dynamic entrega/6.
:-dynamic entrega_armazens/1.
:-dynamic dadosCam_t_e_ta/6.
%ensure is loaded
:-ensure_loaded('AGProjetoReal.pl').




% Criar servidor HTTP no porto 'Port'
server(Port) :-
        http_server(http_dispatch, [port(Port)]).

send_fleet_trip(_Request):-
        format('Content-type: text/plain~n'),
        atribui(A),write(A).

aaaa:-atribui(A),write(A).

send_best_ind(_Request):-
        format('Content-type: text/plain~n~n'),
        gera().

% GET Heusristic by Time= 'http://localhost:5003/send_heuristic'
send_heuristic(_Request):-
        bfs_tempo(Cam,_),
        format('Content-type: text/plain~n~n'),
        recursivity(Cam).

% GET Heuristic by Weight =
% 'http://localhost:5003/send_heuristic_weight'

send_heuristic_weight(_Request):-
        bfs_massa(Cam,_),
        format('Content-type: text/plain~n~n'),
        recursivity(Cam).

%GET Heuristic by Time/Weight=
% 'http://localhost:5003/send_heuristic_time_weight'

send_heuristic_weight_time(_Request):-
        bfs_massa_tempo(Cam),
        format('Content-type: text/plain~n~n'),
        recursivity(Cam).

recursivity([X]):-format(X).
recursivity([A|C]):- format(A),format(','),recursivity(C).

%-----------------

responde_ola(_Request) :-
        format('Content-type: text/plain~n~n'),
        format('OlÁ LAPR5!~n').


send_file_post(Request) :-
	http_parameters(Request,[ file(X,[])]),
        format('Content-type: text/plain~n~n'),
        consult([X]),
        format('Received: ~w~n',[X]).


% METODO POST enviando um ficheiro de texto
% http_client:http_post('http://localhost:5000/send_file_post', form_data([file=file('./teste.txt')]), Reply, []).


%POST Path = 'http://localhost:5003/receive_path_post'
receive_path_post(Request):-
        http_parameters(Request, [ file(X,[])]),
        format('Content-type: text/plain~n~n'),
        absolute_file_name('path.pl',D),
        open(D,write,OS),
        write(OS,X),
        nl(OS),
        close(OS),
        consult(path),
        format('Received: ~w~n',[X]).

%POST Path = 'http://localhost:5003/receive_warehouse_post'
receive_warehouse_post(Request):-
        http_parameters(Request, [file(X,[])]),
        format('Content-type: text/plain~n~n'),
        absolute_file_name('warehouse.pl',D),
        open(D,write,OS),
        write(OS,X),
        nl(OS),
        close(OS),
        consult(warehouse),
        format('Received: ~w~n',[X]).

%POST Path = 'http://localhost:5003/receive_order_post'
receive_order_post(Request):-
        http_parameters(Request, [file(X,[])]),
        format('Content-type: text/plain~n~n'),
        absolute_file_name('order.pl',D),
        open(D,write,OS),
        write(OS,X),
        nl(OS),
        close(OS),
        consult(order),
        format('Received: ~w~n',[X]).

%POST Truck= 'http://localhost:5003/receive_truck_post'
receive_truck_post(Request):-
        http_parameters(Request, [file(X,[])]),
        format('Content-type: text/plain~n~n'),
        absolute_file_name('trucktemp.pl',D),
        open(D,write,OS),
        write(OS,X),
        nl(OS),
        close(OS),
        consult(trucktemp),
        format('Received: ~w~n',[X]).

%POST Trucks= 'http://localhost:5003/receive_trucks_post'
receive_trucks_post(Request):-
        http_parameters(Request, [file(X,[])]),
        format('Content-type: text/plain~n~n'),
        absolute_file_name('trucks.pl',D),
        open(D,write,OS),
        write(OS,X),
        nl(OS),
        close(OS),
        consult(trucks),
        format('Received: ~w~n',[X]).

% WRITE AND READ FILES FOR BASE KNOWLEDGE:

file_write():-
    %absolute_file_name('base',D),
    absolute_file_name('base.pl',D),
    open(D,write,OS),
    write(OS,'ficheijjhkjhroaa.'),
    nl(OS),
    close(OS).

append_file():-
    absolute_file_name('base.pl',D),
    open(D,append,OS),
    write(OS,'aaaaaa'),
    nl(OS),
    close(OS).

readfacts():-
    %absolute_file_name('../lei21-22-s5-3dj-56/Backend/Prolog_API',D,[file_type(prolog),relative_to('base.pl')]),
    %absolute_file_name('lei21-22-s5-3dj-56/Backend/Prolog_API/base.pl',D),
    %writef(D),
    absolute_file_name('base.pl',D),
    open(D,read,Str),
    read_houses(Str,Houses),
    close(Str),
    write(Houses),  nl.

read_houses(Stream,[]):-
    at_end_of_stream(Stream).

read_houses(Stream,[X|L]):-
    \+  at_end_of_stream(Stream),
    read(Stream,X),
    read_houses(Stream,L).




