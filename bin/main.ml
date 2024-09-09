open Semnodes

let monitors =
  [
    { number = 1; name = "bsh"; icon = ""; nodes =
      [
        { executable = "/usr/bin/xterm"; arguments = [] };
        { executable = "/usr/bin/xterm"; arguments = [] };
        { executable = "/usr/bin/xterm"; arguments = [] }
      ]
    };
    { number = 2; name = "vim"; icon = ""; nodes =
      [
        { executable = "/usr/bin/xterm"; arguments = [ "-e"; "nvim" ] }
      ]
    };
    { number = 3; name = "doc"; icon = "󱔗"; nodes =
      [
        { executable = "/usr/local/google/home/stamer/.go/bin/goto"; arguments =
          [ "-p"; "1"; "-u";
            "cloud.google.com/go/docs/reference/cloud.google.com/go/latest" ] 
        };
        { executable = "/usr/local/google/home/stamer/.go/bin/goto"; arguments =
          [ "-p"; "1"; "-u"; "pkg.go.dev" ] }
      ]
    };
    { number = 4; name = "gcp"; icon = ""; nodes =
      [
        { executable = "/usr/local/google/home/stamer/.go/bin/goto"; arguments =
          [ "-p"; "2"; "-g"; "console.cloud" ] 
        }
      ]
    };
    { number = 5; name = "add"; icon = ""; nodes = []
    };
    { number = 6; name = "web"; icon = ""; nodes =
      [
        { executable = "/usr/local/google/home/stamer/.go/bin/goto"; arguments =
          [ "-p"; "1"] 
        }
      ]
    };
    { number = 7; name = "com"; icon = "󰺻"; nodes =
      [
        { executable = "/usr/local/google/home/stamer/.go/bin/goto"; arguments =
          [ "-p"; "1"; "-g"; "mail" ] 
        }
      ]
    };
    { number = 8; name = "cal"; icon = "󰃰"; nodes =
      [
        { executable = "/usr/local/google/home/stamer/.go/bin/goto"; arguments =
          [ "-p"; "1"; "-g"; "calendar" ] 
        }
      ]
    };
    { number = 9; name = "not"; icon = ""; nodes =
      [
        { executable = "/usr/local/google/home/stamer/.go/bin/goto"; arguments =
          [ "-p"; "1"; "stamer:notes" ] 
        }
      ]
    };
    { number = 10; name = "gvc"; icon = ""; nodes =
      [
        { executable = "/usr/local/google/home/stamer/.go/bin/goto"; arguments =
          [ "-p"; "1"; "companion" ] 
        }
      ]
    };
    { number = 11; name = "pers"; icon = ""; nodes =
      [
        { executable = "/usr/local/google/home/stamer/.go/bin/goto"; arguments =
          [ "-p"; "3"] 
        }
      ]
    }
  ]


let configure =
  let usage = "semnodes [-l] [monitor-name]" in
  let toggle_launch = ref false in
  let option_list = [("-l", Arg.Set toggle_launch, "Show launch commands for [monitor-name]")] in
  let monitor_name = ref "" in
  let set_monitor_name name = monitor_name := name in
  let () = Arg.parse option_list set_monitor_name usage in
  (!monitor_name, !toggle_launch)

let evaluate monitor launch =
  match monitor with
  | "" -> print_endline (monitors_to_string monitors)
  | name -> print_endline (evaluate_command monitors name launch)

let () =
  let (monitor_name, toggle_launch) = configure in
  evaluate monitor_name toggle_launch;

