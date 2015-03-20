% James Finlay
% CMPUT 325 - LEC B1
% Assignment # 3

%*******************************************************************
% rmember(+X,+L) : Recursive 'member' call that cycles all levels of
% a multi-dimensional list.

rmember(X,[X|_]).
rmember(X,[H|T]) :- rmember(X,H); rmember(X,T).

%*******************************************************************
% flatten(+L,-L1): flatten a list of atoms (atoms and numbers) L to
% a flat list L1.

flatten([],[]).
flatten([A|L],[A|L1]) :-
     xatom(A), flatten(L,L1).
flatten([A|L],R) :-
     flatten(A,A1), flatten(L,L1), append(A1,L1,R).


xatom(A) :- atom(A).
xatom(A) :- number(A).

% Q1 ***************************************************************
% setDifference(+S1,+S2,-S3): select atoms that exist in S1 but not
% in S2.

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
rmAllDup([H|T],Acc,R) :- xatom(H), rmember(H,Acc), rmAllDup(T,Acc,R).
rmAllDup([H|T],Acc,[H|R]) :- xatom(H), L=[H,Acc], rmAllDup(T,L,R).
rmAllDup([H|T],Acc,[R1|R2]) :- rmAllDup(H,Acc,R1), rmAllDup(T,[R1|Acc],R2).

% Q4 - generate(+L, +Choice, -N)
generate([],_,A,A).
generate(L,Choice,N) :-
    flatten(L,L2),
    [H|T] = L2,
    generate(T,Choice,H,N).
generate([H|T],Choice,A,N) :-
    g_compare(A,H,Choice,A2),
    generate(T,Choice,A2,N).

g_compare(A,B,smallest,A) :- A < B.
g_compare(A,B,smallest,B).
g_compare(A,B,largest,A)  :- A > B.
g_compare(A,B,largest,B).
