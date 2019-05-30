flight(edirne,erzurum,5).
flight(erzurum,antalya,2).
flight(istanbul,trabzon,3).
flight(ankara,kars,3).
flight(trabzon,ankara,6).
flight(ankara,diyarbakir,8).
flight(antalya,izmir,1).
flight(antalya,diyarbakir,5).
flight(izmir,ankara,6).
flight(izmir,istanbul,3).
flight(kars,gaziantep,3).
flight(istanbul,ankara,2).

route(X,Y,C):-func(X,Y,C,[X]).

route_1(X,Y,C):-flight(X,Y,C);flight(Y,X,C) .

func(X, Y, C, ARR) :-
                     route_1(X,Z,Q),
                     not(member(Z,ARR)),
                     append([Z],ARR,ARR2),
                     func(Z, Y, W, ARR2),
                     C is Q + W.

func(X,Y,C,ARR):- route_1(X,Y,C),
                   not(member(Y,ARR)).
