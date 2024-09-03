open Semnodes

let monitors = 
  [
    { number = 0; name = "bsh"; icon = ""; nodes = 
      [
        { executable = "/usr/bin/xterm"; arguments = [] };
        { executable = "/usr/bin/xterm"; arguments = [] };
        { executable = "/usr/bin/xterm"; arguments = [] }
      ]
    };
    { number = 1; name = "vim"; icon = ""; nodes = 
      [
        { executable = "/usr/bin/xterm"; arguments = [ "-e"; "nvim" ] }
      ]
    };
    { number = 2; name = "doc"; icon = "󱔗"; nodes = 
      [
        { executable = "/usr/bin/google-chrome"; arguments = [ "google.com" ] }
      ]
    }
  ]

let () = print_endline (monitors_to_string monitors)
