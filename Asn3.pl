len([],0).
len([_|T],N) :- len(T,X), N is X+1.



% Q1 - setDifference(+S1,+S2,-S3)
setDifference([],_,[]).
setDifference([H|T1],S2,R) :- member(H,S2), setDifference(T1,S2,R).
setDifference([H|T1],S2,[H|R]) :- setDifference(T1,S2,R).

% Q2 - swap(+L,-R)
swap([],[]).
swap([A,B|L],[B,A|R]) :- swap(L,R).
swap([A],[A]).
