"        File: html.vim
"      Author: Srinath Avadhanula
"     Created: Tue Mar 19 09:00 PM 2002 PST
" Last Change: Thu Nov 21 01:00 AM 2002 PST
" Description: 
" 
" Installation: 
"      History: 
"         TODO:
"=============================================================================

" HTMLMAP: sets up maps for 'html' and 'php' type files {{{
" Description: 
function! HTMLMAP(lhs, rhs)
	call IMAP (a:lhs, a:rhs, 'html')
	call IMAP (a:lhs, a:rhs, 'php')
endfunction " }}}
" maps {{{
let s:ml = exists('g:mapleader') ? g:mapleader : '\'
" HTML commands {{{
call HTMLMAP ('tab'.s:ml, "<table border=2 cellspacing=2 cellpadding=5>\<cr><tr>\<cr>\<tab><td>ä</td>\<cr>\<bs></tr>\<cr></table>")
call HTMLMAP ('ref'.s:ml, "<a href=\"ä\">«»</a>«»")
call HTMLMAP ('ol'.s:ml, "<ol>\<cr><li>ä</li>\<cr></ol>«»")
call HTMLMAP ('ul'.s:ml, "<ul>\<cr><li>ä</li>\<cr></ul>«»")
call HTMLMAP ('tr'.s:ml, "<tr>\<cr>\<tab><td>ä</td>\<cr></tr>«»")
call HTMLMAP ('td'.s:ml, "<td>ä</td>«»")
call HTMLMAP ('bb'.s:ml, "<b>ä</b>«»")
call HTMLMAP ('tt'.s:ml, "<tt>ä</tt>«»")
call HTMLMAP ('pre'.s:ml, "<pre>ä</pre>«»")
call HTMLMAP ('li'.s:ml, "<li>ä</li>«»")
" }}}
" HTML greek characters {{{
call HTMLMAP ('a'.s:ml, "\&alpha;")
call HTMLMAP ('b'.s:ml, "\&beta;")
call HTMLMAP ('c'.s:ml, "\&chi;")
call HTMLMAP ('d'.s:ml, "\&delta;")
call HTMLMAP ('e'.s:ml, "\&epsilon;")
call HTMLMAP ('f'.s:ml, "\&phi;")
call HTMLMAP ('g'.s:ml, "\&gamma;")
call HTMLMAP ('h'.s:ml, "\&eta;")
call HTMLMAP ('k'.s:ml, "\&kappa;")
call HTMLMAP ('l'.s:ml, "\&lambda;")
call HTMLMAP ('m'.s:ml, "\&mu;")
call HTMLMAP ('n'.s:ml, "\&nu;")
call HTMLMAP ('p'.s:ml, "\&pi;")
call HTMLMAP ('q'.s:ml, "\&theta;")
call HTMLMAP ('r'.s:ml, "\&rho;")
call HTMLMAP ('s'.s:ml, "\&sigma;")
call HTMLMAP ('t'.s:ml, "\&tau;")
call HTMLMAP ('u'.s:ml, "\&upsilon;")
call HTMLMAP ('v'.s:ml, "\&varsigma;")
call HTMLMAP ('w'.s:ml, "\&omega;")
call HTMLMAP ('x'.s:ml, "\&xi;")
call HTMLMAP ('y'.s:ml, "\&psi;")
call HTMLMAP ('z'.s:ml, "\&zeta;")
call HTMLMAP ('A'.s:ml, "\&Alpha;")
call HTMLMAP ('B'.s:ml, "\&Beta;")
call HTMLMAP ('C'.s:ml, "\&Chi;")
call HTMLMAP ('D'.s:ml, "\&Delta;")
call HTMLMAP ('E'.s:ml, "\&Epsilon;")
call HTMLMAP ('F'.s:ml, "\&Phi;")
call HTMLMAP ('G'.s:ml, "\&Gamma;")
call HTMLMAP ('H'.s:ml, "\&Eta;")
call HTMLMAP ('K'.s:ml, "\&Kappa;")
call HTMLMAP ('L'.s:ml, "\&Lambda;")
call HTMLMAP ('M'.s:ml, "\&Mu;")
call HTMLMAP ('N'.s:ml, "\&Nu;")
call HTMLMAP ('P'.s:ml, "\&Pi;")
call HTMLMAP ('Q'.s:ml, "\&Theta;")
call HTMLMAP ('R'.s:ml, "\&Rho;")
call HTMLMAP ('S'.s:ml, "\&Sigma;")
call HTMLMAP ('T'.s:ml, "\&Tau;")
call HTMLMAP ('U'.s:ml, "\&Upsilon;")
call HTMLMAP ('V'.s:ml, "\&Varsigma;")
call HTMLMAP ('W'.s:ml, "\&Omega;")
call HTMLMAP ('X'.s:ml, "\&Xi;")
call HTMLMAP ('Y'.s:ml, "\&Psi;")
call HTMLMAP ('Z'.s:ml, "\&Zeta;")
" }}}
" }}}
"
" vim600: fdm=marker
