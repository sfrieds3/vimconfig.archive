*scratch_buffer.txt*	For Vim version 7.0	Last change: 2019 Jul 24

DESCRIPTION				*scratch_buffer*

User command to open a scratch buffer.

REQUIREMENTS				*scratch_buffer-requirements*

This plugin only loads if 'compatible' is not set.

COMMANDS				*scratch_buffer-commands*

					*:ScratchBuffer:*

Execute `:ScratchBuffer` to open the buffer.  Wraps around |:new|.  Modifier
prefixes like |:vertical| should work, as should count prefixes to specify the
window height.  Any arguments are passed to |:new|.

AUTHOR					*scratch_buffer-author*

Written and maintained by Tom Ryder <tom@sanctum.geek.nz>.

LICENSE					*scratch_buffer-license*

Licensed for distribution under the same terms as Vim itself (see |license|).

 vim:tw=78:ts=8:ft=help:norl:

