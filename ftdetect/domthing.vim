if has("autocmd")
    au BufNewFile,BufRead *.dom set filetype=html.domthing syntax=domthing | runtime! ftplugin/domthing.vim
endif
