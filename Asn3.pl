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

%*******************************************************************
% Define a relation reverse(X,Y) such that Y is the reversed list of X

reverse([], []).
reverse([A|L1], L2) :- reverse(L1, N), append(N, [A], L2).

% Q1 ***************************************************************
% setDifference(+S1,+S2,-S3): select atoms that exist in S1 but not
% in S2.

setDifference([],_,[]).
setDifference([H|T1],S2,R) :- member(H,S2), setDifference(T1,S2,R).
setDifference([H|T1],S2,[H|R]) :- setDifference(T1,S2,R).

% Q2 ***************************************************************
% swap(+L,-R): Take list, and swap every two elements. If odd
% elements, leave last element.

swap([],[]).
swap([A,B|L],[B,A|R]) :- swap(L,R).
swap([A],[A]).

% Q3a **************************************************************
% rmDup(+L, -R): Remove duplicates from the given list.

rmDup([],[]).
rmDup([H|T],R) :- member(H,T), rmDup(T,R).
rmDup([H|T],[H|R]) :- rmDup(T,R).

% Q3b **************************************************************
% rmAllDup(+L,-R): Remove all duplicates from a nested list, and
% keep the elements in the same nested positions.

rmAllDup(A,B) :- rmAllDup(A,[],B).
rmAllDup([],_,[]).
rmAllDup([H|T],Acc,R) :- xatom(H), rmember(H,Acc), rmAllDup(T,Acc,R).
rmAllDup([H|T],Acc,[H|R]) :- xatom(H), L=[H,Acc], rmAllDup(T,L,R).
rmAllDup([H|T],Acc,[R1|R2]) :- rmAllDup(H,Acc,R1), rmAllDup(T,[R1|Acc],R2).

% Q4 ***************************************************************
% generate(+L,+Choice,-N): Find the smallest or largest number in
% the nested list, as set  y the 'Choice' param.

generate([],_,A,A).
generate(L,Choice,N) :-
    flatten(L,L2),
    [H|T] = L2,
    generate(T,Choice,H,N).
generate([H|T],Choice,A,N) :-
    g_compare(A,H,Choice,A2),
    generate(T,Choice,A2,N).

% g_compare(+A,+B,+Choice,-R): Comparative method for getting
% min/max of two items.
g_compare(A,B,smallest,A) :- A < B.
g_compare(A,B,smallest,B).
g_compare(A,B,largest,A)  :- A > B.
g_compare(A,B,largest,B).

% Q5 ***************************************************************
% countAll(+L,-N): Count the occurrence of each element and return
% them in a sorted pair.

countAll([],A,A).
countAll(L,N) :-
    flatten(L,L2), countAll(L2,[],T1), sort(T1,T2), reverse(T2,T3), rswap(T3,N).
countAll([H|T],A,R) :- map(H,A,A2), countAll(T,A2,R).

% map(+E,+L,-R): Push the element into the paired mapping. If elem
% already exists, it increments the pair.
map(E,[],[[1,E]]).
map(H,[[I,H|_]|T],[[R,H]|T]) :- R is I+1.
map(E,[H|T],[H|R]) :- map(E,T,R).

% rswap(+L,-R): Recursively swap the order for all pairs in the
% list
rswap([],[]).
rswap([H|T],[R1|R]) :- swap(H,R1), rswap(T,R).

% Q6 ***************************************************************
% convert(+Term, -Result): Convert the given Term as explained in
% the assignment. Rules are as follows:
%   - anything between two matching q's are not changed
%   - any e's outside of a pair of matching q's are removed
%   - any letter outside a pair of matching q's is changed to c
%   - an unmatched q will be left as is

convert([],_,[]).
convert(L,R) :- convert(L,false,R).
convert([e|T],false,R) :- convert(T,false,R).
convert([q|T],false,[q|R]) :- member(q,T), convert(T,true,R).
convert([q|T],false,[q|R]) :- convert(T,false,R).
convert([H|T],false,[c|R]) :- convert(T,false,R).
convert([q|T],true,[q|R]) :- convert(T,false,R).
convert([H|T],true,[H|R]) :- convert(T,true,R).
