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
          [ "-p"; "2"; "-g"; "mail" ] 
        }
      ]
    };
    { number = 8; name = "cal"; icon = "󰃰"; nodes =
      [
        { executable = "/usr/local/google/home/stamer/.go/bin/goto"; arguments =
          [ "-p"; "2"; "-g"; "calendar" ] 
        }
      ]
    };
    { number = 9; name = "not"; icon = ""; nodes =
      [
        { executable = "/usr/local/google/home/stamer/.go/bin/goto"; arguments =
          [ "-p"; "2"; "stamer:notes" ] 
        }
      ]
    };
    { number = 10; name = "gvc"; icon = ""; nodes =
      [
        { executable = "/usr/local/google/home/stamer/.go/bin/goto"; arguments =
          [ "-p"; "2"; "companion" ] 
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

let usage = "semnodes [-cl] [monitor-name]"
let toggle_launch = ref false
let monitor_name = ref ""
let set_monitor_name name = monitor_name := name
let option_list = [("-l", Arg.Set toggle_launch, "Show launch commands for [monitor-name]")]

let evaluate monitor launch =
  match monitor with
  | "" -> print_endline (monitors_to_string monitors)
  | name -> print_endline (evaluate_command monitors name launch)

let () =
  Arg.parse option_list set_monitor_name usage;
  evaluate !monitor_name !toggle_launch;

