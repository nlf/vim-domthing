if version < 600
  so <sfile>:p:h/html.vim
else
  runtime! syntax/html.vim
  unlet b:current_syntax
endif

if version < 600
    syntax clear
elseif exists("b:current_syntax")
    finish
endif

if version < 508
  command! -nargs=+ HtmlHiLink hi link <args>
else
  command! -nargs=+ HtmlHiLink hi def link <args>
endif

syntax region domthingInside matchgroup=Delimiter start=/{{/ end=/}}/ contains=@domthingRegions,@htmlTop containedin=@htmlDomthingContainer
syntax region domthingCondition start='{{#if' end='{{\/if}}' keepend contains=@domthingRegions,@htmlTop
syntax region domthingList matchgroup=Delimiter start=/(/ end=/)/ contained containedin=@domthingRegions contains=domthingList

syntax cluster domthingRegions add=domthingInside,domthingCondition,domthingList

syntax region domthingString start=/'/ skip=/\\'/ end=/'/ contained containedin=@domthingRegions
syntax region domthingDString start=/"/ skip=/\\"/ end=/"/ contained containedin=@domthingRegions

syntax keyword domthingFunctions if leq lteq geq gteq concat safe call apply not contained containedin=domthingList
syntax match domthingFunctions /\*\|===\|==\|+\|-\|\/\|%\|<\|>\|!/ contained containedin=domthingList

syntax match domthingConditionals /[#/]if\|#else/ contained containedin=domthingInside

syntax cluster htmlDomthingContainer add=htmlHead,htmlTitle,htmlH1,htmlH2,htmlH3,htmlH4,htmlH5,htmlH6,htmlLink,htmlBold,htmlUnderline,htmlItalic,htmlValue

HtmlHiLink domthingString String
HtmlHiLink domthingDString String
HtmlHiLink domthingFunctions Statement
HtmlHiLink domthingConditionals Conditional

let b:current_syntax = "domthing"
delcommand HtmlHiLink
