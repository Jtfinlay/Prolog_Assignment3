% James Finlay
% CMPUT 325 - LEC B1
% Assignment # 3

rmember(X,[X|_]).
rmember(X,[H|T]) :- rmember(X,H); rmember(X,T).

% Q1 - setDifference(+S1,+S2,-S3)
setDifference([],_,[]).
setDifference([H|T1],S2,R) :- member(H,S2), setDifference(T1,S2,R).
setDifference([H|T1],S2,[H|R]) :- setDifference(T1,S2,R).

% Q2 - swap(+L,-R)
swap([],[]).
swap([A,B|L],[B,A|R]) :- swap(L,R).
swap([A],[A]).

% Q3a - rmDup(+L, -R)
rmDup([],[]).
rmDup([H|T],R) :- member(H,T), rmDup(T,R).
rmDup([H|T],[H|R]) :- rmDup(T,R).

% Q3b - rmAllDup(+L,-R)
rmAllDup(A,B) :- rmAllDup(A,[],B).
rmAllDup([],_,[]).
rmAllDup([H|T],Acc,R) :- atom(H), rmember(H,Acc), rmAllDup(T,Acc,R).
rmAllDup([H|T],Acc,[H|R]) :- atom(H), L=[H,Acc], rmAllDup(T,L,R).
rmAllDup([H|T],Acc,[R1|R2]) :- rmAllDup(H,Acc,R1), rmAllDup(T,[R1|Acc],R2).
