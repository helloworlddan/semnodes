type node =
  {
    executable : string;
    arguments : string list;
  }

let rec arguments_to_string args =
  match args with
  | [] -> ""
  | [arg] -> arg
  | arg :: args -> arg ^ " " ^ arguments_to_string args

let node_to_string {executable;arguments} =
  executable ^ " " ^ arguments_to_string arguments

let rec nodes_to_string nodes =
  match nodes with
  | [] -> ""
  | [node] -> (node_to_string node)
  | node :: nodes -> (node_to_string node) ^ "\n" ^ nodes_to_string nodes

let node_to_command {executable;arguments} =
  executable ^ " " ^ arguments_to_string arguments ^ " &"

let rec nodes_to_command nodes =
  match nodes with
  | [] -> ""
  | [node] -> (node_to_command node)
  | node :: nodes -> (node_to_command node) ^ "\n" ^ nodes_to_command nodes

type monitor =
  {
    number : int;
    name : string;
    icon : string;
    nodes : node list;
  }

let monitor_to_string {number;name;icon;nodes} =
  (Int.to_string number) ^ ": " ^ icon ^ " " ^ name ^ "\n" ^ nodes_to_string nodes

let rec monitors_to_string monitors =
  match monitors with
  | [] -> ""
  | [monitor] -> monitor_to_string monitor
  | monitor :: monitors -> (monitor_to_string monitor) ^ "\n" ^ monitors_to_string monitors

let find_monitors name monitors = List.filter (fun x -> x.name = name) monitors

let switch_to_command monitors name =
  let monitors = find_monitors name monitors in
  match monitors with
  | [] -> "echo 'no op' # monitor not found"
  | [x] -> "bspc desktop -f '^" ^ Int.to_string x.number ^ "'"
  | _ -> "echo 'no op' # double config found"

let launch_to_command monitors name =
  let monitors = find_monitors name monitors in
  match monitors with
  | [] -> "echo 'no op' # monitor not found"
  | [x] -> switch_to_command monitors name ^ "\n" ^ nodes_to_command x.nodes
  | _ -> "echo 'no op' # double config found"

let evaluate_command monitors name launch =
  match launch with
  | false -> switch_to_command monitors name
  | true -> launch_to_command monitors name

