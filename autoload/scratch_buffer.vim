" Entry point for :ScratchBuffer command
function! scratch_buffer#(mods, count, ...) abort

  " Start building command argument vector
  let command = []

  " Add any modifiers first (e.g. :vertical)
  call add(command, a:mods)

  " If a count of more than zero was provided, add that as a prefix for :new
  if a:count > 0
    call add(command, a:count)
  endif

  " Add the :new command
  call add(command, 'new')

  " Add any other arguments passed in
  call extend(command, a:000)

  " Execute the command
  execute join(command)

  " Set the new buffer to a scratch 'buftype' to stop it from saving and to
  " reassure Vim that it doesn't need to be saved
  set buftype=nofile

endfunction

