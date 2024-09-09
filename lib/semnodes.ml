type node =
  {
    executable : string;
    arguments : string list;
  }

let arguments_to_string args =
  String.concat " " args

let node_to_string {executable;arguments} =
  executable ^ " " ^ arguments_to_string arguments

let nodes_to_string nodes =
  let render = List.map (node_to_string) nodes in
  String.concat "\n" render

let node_to_command node =
  node_to_string node ^ " &"

let nodes_to_command nodes =
  let render = List.map (node_to_command) nodes in
  String.concat "\n" render

type monitor =
  {
    number : int;
    name : string;
    icon : string;
    nodes : node list;
  }

let monitor_to_string {number;name;icon;nodes} =
  (Int.to_string number) ^ ": " ^ icon ^ " " ^ name ^ "\n" ^ nodes_to_string nodes

let monitors_to_string monitors =
  let render = List.map (monitor_to_string) monitors in
  String.concat "\n" render

let find_monitors name monitors =
  List.filter (fun x -> x.name = name) monitors

let switch_to_command monitors name =
  let monitors = find_monitors name monitors in
  match monitors with
  | [] -> Stdlib.failwith "echo 'no op' # monitor not found"
  | [x] -> "bspc desktop -f '^" ^ Int.to_string x.number ^ "'"
  | _ -> Stdlib.failwith "echo 'no op' # double config found"

let launch_to_command monitors name =
  let monitors = find_monitors name monitors in
  match monitors with
  | [] -> Stdlib.failwith "echo 'no op' # monitor not found"
  | [x] -> switch_to_command monitors name ^ "\n" ^ nodes_to_command x.nodes
  | _ -> Stdlib.failwith "echo 'no op' # double config found"

let evaluate_command monitors name launch =
  match launch with
  | false -> switch_to_command monitors name
  | true -> launch_to_command monitors name

