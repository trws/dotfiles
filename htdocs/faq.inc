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
If you are using cywin with windows, see <a href=#known_issues>this</a>
for a workaround. If you still face a problem using the compiler and wish
to contact the <a
	href="mailto://vim-latex-devel@lists.sourceforge.net">developers</a> for
help, please first gather the following information:
<ol>
<li>What does
	<a name=compile_rule_dvi></a>
	<pre>:echo Tex_CompileRule_dvi</pre> 
	say? This should be a string such as
	<pre>latex --src-specials \input{$*}</pre>
	Make sure that you can execute this command on a terminal (with the
	<tt>$*</tt> replaced with a filename). If you cannot, then you will
	need to change the value of <tt>Tex_CompileRule_dvi</tt> in your
	<tt>~/.vim/ftplugin/tex.vim</tt> file.
	<p></p>
</li>
<li>
	Make sure that
	<pre>:set makeprg?</pre>
	shows the same value as <tt>Tex_CompileRule_dvi</tt>. If it does not,
	try doing
	<pre>:verbose set makeprg?</pre>
	to see which script sets this option. Is that part of latex-suite?
	<p></p>
</li>
<li>What happens when you do
	<pre>:call RunLaTeX()</pre>
	from the command line? In normal operation conditions, this should
	spawn a shell command which looks like <tt>Tex_CompileRule_dvi</tt>.
	The shell should call the latex compiler, which should run without user
	intervention.  If this gives any errors, <tt>g:Tex_CompileRule_dvi</tt>
	has not been set properly.<p></p>
</li>
<li>What is your operating system?<p></p></li>
<li>What version of latex are you using?<p></p></li>
</ol>
<p></p>
<a name=known_issues></a>
<b>Known Issues</b>
There is a known problem with compiling if you are using a bash shell
(cygwin or something similar) on a windows machine. Vim seems to apparently
hang when <tt>\ll</tt> is pressed. This is because latex-suite does not (as
yet) support cygwin+windows out of the box. As of now, an elegant solution
has not presented itself. There are two work-arounds as of now for this
problem:
<ol>
<li>Unset <tt>shell = bash</tt> from your .vimrc
	<p><b>OR</b></p>
</li>
<li>Include
<pre>
let g:Tex_CompileRule_dvi = 'latex --src-special \\\\nonstopmode \\\\input\\{$*\\}'
</pre>
in your <tt>.vimrc</tt> or <tt>ftplugin/tex.vim</tt>. NOTE: There are actually 4 backslashes there.
</li>
</ol>
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

