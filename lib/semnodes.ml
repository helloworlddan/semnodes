type node =
  {
    executable : string;
    arguments : string list;
  }

let rec arguments_to_string args =
  match args with
  | [] -> ""
  | arg :: args -> arg ^ " " ^ arguments_to_string args;;

let node_to_string {executable;arguments} = executable ^ " " ^
  arguments_to_string arguments;;

let rec nodes_to_string nodes =
  match nodes with
  | [] -> ""
  | node :: nodes -> (node_to_string node) ^ "\n" ^ nodes_to_string nodes

type monitor =
  {
    number : int;
    name : string;
    icon : string;
    nodes : node list;
  }

let monitor_to_string {number;name;icon;nodes} =
  (Int.to_string number) ^ ": " ^ icon ^ " " ^ name ^ "\n" ^ nodes_to_string nodes;;

let rec monitors_to_string monitors =
  match monitors with
  | [] -> ""
  | monitor :: monitors -> (monitor_to_string monitor) ^ "\n" ^ monitors_to_string monitors;;

