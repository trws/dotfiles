<h2>Questions</h2>
<ul>
	<li><a class=question href="#faq-1">What are those annoying <tt>«»</tt> characters whenever I invoke a
	mapping?</a></li>
	<li><a class=question href="#faq-2">Compiling/Viewing does not seem to
	work for me. My gvim hangs/does nothing.</a></li>
</ul>
<h2>Answers</h2>
<a name="faq-1">
<div class=qa>Q: What are those annoying <tt>«»</tt> characters whenever I
invoke a mapping?</div>
<blockquote>
<div class=ans>Those are called <i>placeholders</i> and when you get used
to them, they will prove invaluable. They are essentially markers left in
the text file to tell latex-suite where the next point of interest is. This
lets you directly go to the next placeholder with a single key-press.
Consider a working example. Pressing <tt>EFI</tt> will insert the following
micro template:
<pre>
\begin{figure}[h]
    \centerline{\psfig{figure=«eps file»}}
    \caption{«caption text»}
    \label{fig:«label»}
\end{figure}«»
</pre>
The text <tt>«eps file»</tt> will be selected and vim will be left in 
<a
href="http://vimdoc.sourceforge.net/cgi-bin/vim2html2.pl?page=version5.txt#new-Select-mode">select-mode</a>
so that the user can continue typing straight away. After having typed in the
file name, she can press Control-J (while still in insert-mode). This will
take her directly to the next "place-holder". i.e, <tt>«caption text»</tt> will be
visually selected with vim in select mode again for typing in the caption.
This saves on a lot of key presses.
<p></p>
If you still do not feel like using placeholders, include
<pre>let g:Imap_UsePlaceHolders = 0</pre>
in your <tt>.vimrc</tt>.
</div>
</blockquote>
<a name="faq-2">
<div class=qa>
Q: Compiling/Viewing does not seem to work for me. My gvim hangs/does
nothing.
</div>
<blockquote>
<div class=ans>
There is a known bug when you have <tt>'shell'</tt> set to <tt>'bash'</tt>
in win32. This causes gvim to apparently hang when <tt>\ll</tt> is pressed.
As of now, an elegant solution has not presented itself. There are two
work-arounds as of now for this problem:
<ol>
<li>Unset <tt>shell = bash</tt> from your .vimrc</li>
<li>Include
<pre>
let g:Tex_CompileRule_dvi = 'latex --src-special \\\\nonstopmode \\\\input\\{$*\\}'
</pre>
in your <tt>.vimrc</tt> or <tt>ftplugin/tex.vim</tt>. NOTE: There are actually 4 backslashes there.
</li>
</ol>
If you are not on win32 and are still having problems, then it is most
probably because the flavor of LaTeX you are using is not supported out of
the box by latex-suite. You will need to set the value for
<tt>g:Tex_CompileRule_dvi</tt> in your <tt>.vimrc</tt> or
<tt>ftplugin/tex.vim</tt>. This is a string like the following:
<pre>
latex  \\nonstopmode \\input\{$*\}
</pre>
Make sure that you set this variable to a value which permits it to be
executed from within vim without user intervention. For example, if
you set <tt>g:Tex_CompileRule_dvi</tt> to a value which makes the output of 
<pre>
set makeprg?
</pre>
show the above string, then you should be able to do
<pre>
!latex  \\nonstopmode \\input\{myfile.tex\}
</pre>
from within vim without any problems. <br>
<p></p>
<b>NOTE:</b> Please be careful about using single or double backslashes.
Different platforms/compilers work differently, so experiment with both.
Also, If you do face problems, please <a
href="index.php?subject=weare">contact us</a> with your setup (i.e, your
OS, latex flavor, gvim version and any other special configuration stuff
you might think of), so we can take care of the problem.
</div>
</blockquote>

<!-- A sample Q & A
<div class=qa>
Q: 
</div>
<blockquote>
<div class=ans>
Answer
</div>
</blockquote>
-->

