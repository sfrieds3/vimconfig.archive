*vertical_region.txt*	For Vim version 7.0	Last change: 2019 Jun 14

DESCRIPTION				*vertical_region*

This plugin provides mapping targets to move up or down to lines that have
non-space characters before or in the current column, usually to find lines
that begin or end blocks in languages where indenting is used to show or
specify structure.

REQUIREMENTS				*vertical_region-requirements*

This plugin only loads if 'compatible' is not set.

MAPPINGS				*vertical_region-mappings*

Two mapping targets are provided.  They can be mapped in normal,
operator-pending, and visual mode, and accept a [count] prefix to move by more
than one matching line.

					*<Plug>(VerticalRegionUp)*
`<Plug>(VerticalRegionUp)` moves up to the previous line with non-space
characters before or in the current column.

					*<Plug>(VerticalRegionDown)*
`<Plug>(VerticalRegionDown)` moves down to the previous line with non-space
characters before or in the current column.

There are no default key mappings; you should define those yourself in your
|vimrc|.  Here are the author's choices, using \{ and \} in all three modes:
>
	nmap <Bslash>{ <Plug>(VerticalRegionUp)
	nmap <Bslash>} <Plug>(VerticalRegionDown)
	omap <Bslash>{ <Plug>(VerticalRegionUp)
	omap <Bslash>} <Plug>(VerticalRegionDown)
	xmap <Bslash>{ <Plug>(VerticalRegionUp)
	xmap <Bslash>} <Plug>(VerticalRegionDown)
<
AUTHOR					*vertical_region-author*

Written and maintained by Tom Ryder <tom@sanctum.geek.nz>.

CREDITS					*vertical_region-credits*

Thanks to Antony in Freenode #vim for providing a working implementation of a
very similar approach for reference, and informing the choice of plugin name.

Antony has a funny habit of always already having written some form of what
you're currently writing in Vimscript.

LICENSE					*vertical_region-license*

Licensed for distribution under the same terms as Vim itself (see |license|).

 vim:tw=78:ts=8:ft=help:norl:
