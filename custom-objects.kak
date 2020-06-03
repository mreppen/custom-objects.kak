declare-option str-to-str-map custom_objects

define-command add-custom-object -params 3..4 -docstring "add-custom-object <scope> <key> <cust_obj> [<docstring>]" %{
  set-option -add %arg{1} custom_objects "%arg{2}=%arg{3}"
  map %arg{1} object %arg{2} %{} -docstring "%arg{4}"
}

# Suggested pair:
#hook global BufSetOption filetype=.* %{
#  add-custom-object buffer "#" "\Q%opt{comment_block_begin}\E,\Q%opt{comment_block_end}\E" "comment"
#}

define-command obj_prompt -params 1 %{
  exec "%arg{1}"
  on-key %{ eval %sh{
      echo "echo -debug $kak_opt_custom_objects"
      for kv in $kak_opt_custom_objects
      do
        echo "echo -debug ${kv#$kak_key}"
        if [ ${kv#$kak_key} != ${kv} ]
        then
          echo "exec c${kv#$kak_key=}<ret>"
          exit 0
        fi
      done
      echo "exec $kak_key"
    }
  }
}
define-command -hidden inner            %{ obj_prompt "<a-i>" }
define-command -hidden inner_start      %{ obj_prompt "<a-[>" }
define-command -hidden inner_end        %{ obj_prompt "<a-]>" }
define-command -hidden inner_start_ext  %{ obj_prompt "<a-{>" }
define-command -hidden inner_end_ext    %{ obj_prompt "<a-}>" }

define-command -hidden around           %{ obj_prompt "<a-a>" }
define-command -hidden around_start     %{ obj_prompt "["     }
define-command -hidden around_end       %{ obj_prompt "]"     }
define-command -hidden around_start_ext %{ obj_prompt "{"     }
define-command -hidden around_end_ext   %{ obj_prompt "}"     }

map global normal <a-i> ": inner<ret>"
map global normal <a-[> ": inner_start<ret>"
map global normal <a-]> ": inner_end<ret>"
map global normal <a-{> ": inner_start_ext<ret>"
map global normal <a-}> ": inner_end_ext<ret>"

map global normal <a-a> ": around<ret>"
map global normal [     ": around_start<ret>"
map global normal ]     ": around_end<ret>"
map global normal {     ": around_start_ext<ret>"
map global normal }     ": around_end_ext<ret>"
