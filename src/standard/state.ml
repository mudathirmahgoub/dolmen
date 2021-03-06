
(* This file is free software, part of dolmen. See file "LICENSE" for more information *)

(* Type definition *)
(* ************************************************************************* *)

type perm =
  | Allow
  | Warn
  | Error

type ('lang, 'typer, 'solver) state = {

  (* Limits for time and size *)
  time_limit        : float;
  size_limit        : float;

  (* Input settings *)
  input_dir         : string;
  input_lang        : 'lang option;
  input_mode        : [ `Full
                      | `Incremental ] option;
  input_source      : [ `Stdin
                      | `File of string
                      | `Raw of string * string ];

  (* Typechecking state *)
  type_state        : 'typer;
  type_check        : bool;
  type_infer        : perm option;
  type_shadow       : perm option;
  type_smtlib_logic : string option;

  (* Solving state *)
  solve_state       : 'solver;

  (* Output settings *)
  export_lang       : 'lang option;

}

(* Getting/Setting options *)
(* ************************************************************************* *)

let time_limit t = t.time_limit
let size_limit t = t.size_limit

let input_dir t = t.input_dir
let input_mode t = t.input_mode
let input_lang t = t.input_lang
let input_source t = t.input_source

let set_mode t m = { t with input_mode = Some m; }
let set_lang t l = { t with input_lang = Some l; }

let is_interactive = function
  | { input_source = `Stdin; _ } -> true
  | _ -> false

let prelude _ = "prompt>"

(* Semantic operations *)
(* ************************************************************************* *)

let set_logic t s =
  { t with type_smtlib_logic = Some s; }

(* Some dummy implementations *)
let get_info t _ = t
let set_info t _ = t

let get_option t _ = t
let set_option t _ = t

let pop t _  = t
let push t _ = t

let reset_assertions t = t
let plain t _ = t

let get_proof t = t
let get_unsat_core t = t
let get_unsat_assumptions t = t
let get_model t = t
let get_values t _ = t
let get_assignment t = t
let get_assertions t = t
let echo t _ = t
let reset t = t
let exit t = t

