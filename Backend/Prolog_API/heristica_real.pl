:-dynamic entrega/1.
:-dynamic entrega_armazens/1.
:-dynamic entregas/1.
:-dynamic dadosCam_t_e_ta/6.
:-dynamic idArmazem/2.
:-dynamic tempo/1.
:-dynamic massa/1.
:-dynamic massatempo/1.
:-dynamic cam/2.

% bfs_orders([A|L],Orig,Cam):-entrega(A,_,_,B,_,_),bfs(Orig,B,Cam), Orig2
% is B, bfs_orders(L,Orig2,Cam).





bfs_massa(Cam,M):-
    retractall(massa(_)),
    assertz(massa(0)),
    entrega_armazens(Ent),
    delete(Ent,5,Ent2),
    bfs_massa2(Ent2,[5],Cam,M).

bfs_massa2([],LA,Cam,M):-
    !,reverse([5|LA],Cam),M is 0.

bfs_massa2(Ent,[Act|LA],Cam,M):-
    findall([X|LA],
            (dadosCam_t_e_ta(_,Act,X,_,_,_),member(X,Ent)),Novos),
    massa_act(Act,Novos,P),
    delete(Ent,P,Ent2),
    massa(Massa),
    append_inicio3(P,[Act|LA],Todos),
    bfs_massa2(Ent2,Todos,Cam,M2),
    M is Massa + M2.

append_inicio3(P,L,[P|L]).

massa_act(_,[],0):-retract(massa(_)),assertz(massa(0)).
massa_act(Act,[[A|_]|Novos],X):-
    massa_act(Act,Novos,X2),
    entrega(_,_,M,A,_,_),
    massa(Massa),
    (   (Massa<M,!,retract(massa(_)),assertz(massa(M)),X=A);X=X2).

bfs_massa_tempo(Cam):-
    retractall(massa(_)),
    assertz(massatempo(0)),
    entrega_armazens(Ent),
    delete(Ent,5,Ent2),
    bfs_massa_tempo2(Ent2,[5],Cam).

bfs_massa_tempo2([],LA,Cam):-
    !,reverse([5|LA],Cam).

bfs_massa_tempo2(Ent,[Act|LA],Cam):-
    findall([X|LA],(dadosCam_t_e_ta(_,Act,X,_,_,_),member(X,Ent)),Novos),
    massa_tempo_act(Act,Novos,P),
    delete(Ent,P,Ent2),
    append_inicio4(P,[Act|LA],Todos),
    bfs_massa_tempo2(Ent2,Todos,Cam).

append_inicio4(P,L,[P|L]).

massa_tempo_act(_,[],0):-retract(massatempo(_)),assertz(massatempo(0)).
massa_tempo_act(Act,[[A|_]|Novos],X):-
    massa_tempo_act(Act,Novos,X2),
    entrega(_,_,M,A,_,RET),
    dadosCam_t_e_ta(_,Act,A,T,E,_),
    massatempo(MassaTempo),
    cam(TR,CE),
    ED is CE - E,
    (   (ED > 0,!,T2 is T + RET,CE2 is CE);(getChargingTime(CE,CT),T2 is T + CT + RET,CE2 is CE)  ),
    D = M / T2,
    (   (MassaTempo< D,!,retract(cam(_,_)),assertz(cam(TR,CE2)),retract(massatempo(_)),assertz(massatempo(D)),X=A);X=X2).



bfs_tempo(Cam,T):-
    retractall(tempo(_)),
    assertz(tempo(10000)),
    entrega_armazens(Ent),
    delete(Ent,5,Ent2),
    bfs2_tempo(Ent2,[5],Cam,T).

bfs2_tempo([],[Final|LA],Cam,T):-
    !,reverse([5,Final|LA],Cam),
    dadosCam_t_e_ta(_,Final,5,T,_,_).

bfs2_tempo(Ent,[Act|LA],Cam,T):-
    findall([X|LA],
            (   dadosCam_t_e_ta(_,Act,X,_,_,_),member(X,Ent)),Novos),
    tempo_act_x10(Act,Novos,P),
    delete(Ent,P,Ent2),
    tempo(TempoMin),
    append_inicio12(P,[Act|LA],Todos),
    bfs2_tempo(Ent2,Todos,Cam,T2),
    T is TempoMin+T2.

append_inicio12(P,L,[P|L]).

tempo_act_x10(_,[],0):-retract(tempo(_)),assertz(tempo(10000)).
tempo_act_x10(Act,[[A|_]|Novos],X):-
    tempo_act_x10(Act,Novos,X2),
    dadosCam_t_e_ta(_,Act,A,T,E,_),
    entrega(_,_,_,A,COLO,_),
    tempo(TempoMin),
    cam(TR,CE),
    ED is CE - E,
    (   (ED > 0,!,T2 is T + COLO , CE2 is CE);(getChargingTime(CE,CT),T2 is T + CT + COLO , CE2 is 100)  ),
    (   (TempoMin>T2,!,retract(cam(_,_)),assertz(cam(TR,CE2)),retract(tempo(_)),assertz(tempo(T2)),X=A);X=X2).


getChargingTime(CE,CT) :- cam(Tr,_),
                          carateristicasCam(Tr,_,_,FullCharge,_,RechargeTime),
                          ruleOfThree((FullCharge * 0.6),60,CE,R),
                          ruleOfThree(60,RechargeTime,(60 - R),CT).

% Calculates the rule of three (regra de três simples).
% ruleOfThree/4 (<A - first term>, <B - second term>, <C - third term>,
% <X - result>).

ruleOfThree(X,Y,Z,R) :- R is ((Z * Y) / X).
