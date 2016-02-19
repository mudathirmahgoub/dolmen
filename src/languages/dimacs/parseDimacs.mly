
(* This file is free software, part of dolmen. See file "LICENSE" for more details *)

/* Functor parameters */

%parameter <L : ParseLocation.S>
%parameter <T : Ast_dimacs.Term with type location := L.t>
%parameter <S : Ast_dimacs.Statement with type location := L.t and type atom := T.t>

/* Starting symbols */

%start <S.t list> file

%%

file:
  | NEWLINE* start l=clause* EOF
    { l }

start:
  | P CNF nbvar=INT nbclause=INT NEWLINE+
    { () }

clause:
  | c=nonempty_list(atom) ZERO NEWLINE+
    { let loc = L.mk_pos $startpos $endpos in S.clause ~loc c }

atom:
  | i=INT
    { let loc = L.mk_pos $startpos $endpos in T.atom ~loc i }
