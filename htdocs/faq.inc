<h2>Questions</h2>
<ul>
	<li><a class=question href="#faq-1">What are those annoying <tt>«»</tt> characters whenever I invoke a
	mapping?</a></li>
	<li><a class=question href="#faq-2">Compiling does not seem to
	work for me. My gvim hangs/does nothing.</a></li>
	<li><a class=question href="#faq-3">Viewing does not seem to work for
	me.</a></li>
	<li><a class="question" href="#faq-7">Completion does not work for me
	on a Microsoft Windows machine.</a></li>
	<li><a class=question href="#faq-4">After a recent upgrade, whenever I
	launch gvim I get some python-ish errors</a></li>
	<li><a class=question href="#faq-5">Typing some European characters
	becomes problematic in Latex-suite because those characters seem to be
	mapped to something.</a></li>
	<li><a class="question" href="#faq-8">I cannot type the e-acute
	character! HELP!</a></li>
	<li><a class=question href="#faq-6">Sometimes I need to insert a
	literal double quote. But whenever I press <tt>"</tt>, I get
	<tt>``</tt>. How do I do get around this? Can I disable the <tt>"</tt>
	to <tt>``</tt> conversion permanently for certain files?</a></li>
	<li><a class="question" href="#faq-8">I need to type SSS in my document
	a lot. But latex-suite always converts it into a
	<tt>\subsection{}&lt;++&gt;</tt>. How do I get around this? (OR How do
	I disable a mapping created by Latex-suite?)</a></li>
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
Q: Compiling does not seem to work for me. My gvim hangs/does
nothing.
</div>
<blockquote>
<div class=ans>
If you are using cygwin with windows, see <a href=#known_issues>this</a>
for a workaround. If you still face a problem using the compiler and wish
to contact the <a
	href="index.php?subject=contact&title=Contact">developers</a> for
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
	<pre>:call Tex_RunLaTeX()</pre>
	from the command line? In normal operation conditions, this should
	spawn a shell command which looks like <tt>Tex_CompileRule_dvi</tt>.
	The shell should call the latex compiler, which should run without user
	intervention.  If this gives any errors, <tt>g:Tex_CompileRule_dvi</tt>
	has not been set properly. If the command above gives an error like
	<pre>E117: Unknown function: Tex_RunLaTeX()</pre>
	you are using an older Latex-suite. Upgrade!
	<p></p>
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
let g:Tex_CompileRule_dvi = 'latex --src-special --interaction=nonstopmode $*'
</pre>
in your <tt>.vimrc</tt> or <tt>ftplugin/tex.vim</tt>.
</li>
</ol>
</div>
</blockquote>

<a name="faq-3">
<div class=qa>
Q: Viewing does not seem to work for me.
</div>
<blockquote>
<div class=ans>
First check to make sure that you can call the programs specified by
the <a
href="documentation/latex-suite/viewer-customization.html#Tex_ViewRule_format">viewing
rules</a> from within vim. For example, if you specified
the PDF viewing program as <tt>AcroRd32</tt>, then you should be able to do
<pre>!start AcroRd32</pre>
from within vim and get Acrobat reader to launch. On windows, this means
setting the <tt>PATH</tt> variable to include the location in which
<tt>AcroRd32.exe</tt> resides. See the system documentation how to do this.
On Windows 2000/XP, the settings can be changed from
<pre>Control Panel &gt; System &gt; Advanced &gt; Environment Variables</pre>
</li>
Some versions of gvim on windows have problems calling external programs
which reside in directories containing spaces in their names even if the
<tt>%PATH%</tt> variable contains the correct directories. In this case,
you need to change the <tt>g:Tex_ViewRule_format</tt> variable to use the
full path to the viewer. For example:
<pre>let g:Tex_ViewRule_pdf = 'c:/Program\ Files/Adobe/Acrobat 5.0/Reader/AcroRd32'</pre>
</div>
</blockquote>

<a name="faq-7">
<div class=qa>
Q: Completion does not work for me on a Microsoft Windows machine.
</div>
<blockquote>
<div class=ans>
You will need to install a good <tt>grep</tt> program to make completion
work on MS Windows. Latex-suite on windows has been tested with cygwin
which comes with a port of GNU grep. That works fine. If you do not want to
install cygwin, then you can install just <tt>grep</tt> from 
<a href="http://gnuwin32.sourceforge.net/packages/grep.htm">here</a>.
Make sure that your version of <tt>grep</tt> supports the <tt>-H</tt> flag
which makes <tt>grep</tt> include the filename even when searching with a
single filename.
</div>

</blockquote>
<a name="faq-4">
<div class=qa>
Q: After a recent upgrade, whenever I launch gvim I get some python-ish
errors.
</div>
<blockquote>
<div class=ans>
Latex-suite uses python in some of the multiple compilation code if
available because it speeds things up and also saves on some unnecessary
buffers getting introduced in the buffer list. If your version of python is
very old or your python via vim is not working, then you need to tell
Latex-suite not to use python if your vim returns <tt>1</tt> for
<tt>has('python')</tt>. This is done by setting the
<tt>g:Tex_UsePython</tt> variable to zero.
</div>
</blockquote>

<a name="faq-5">
<div class=qa>
Q: Typing some European characters becomes problematic in Latex-suite
because those characters seem to be mapped to something.
</div>
<blockquote>
<div class=ans>
Latex-suite maps certain <tt>Alt</tt> key sequences to some functions as
described <a
href="documentation/latex-suite/bracketing-macros.html">here</a>. If you
need to use these keys for regular editing, you will need to remap the Alt
keys to something else as described in <a
href="documentation/latex-suite/latex-suite-maps.html">here</a>. In
particular, put the following commands in your
<tt>~/.vim/ftplugin/tex.vim</tt> file:
<pre>
imap &lt;C-b&gt; &lt;Plug&gt;Tex_MathBF
imap &lt;C-c&gt; &lt;Plug&gt;Tex_MathCal
imap &lt;C-l&gt; &lt;Plug&gt;Tex_LeftRight
</pre>
This will make <tt>&lt;C-b&gt;</tt> etc. assume the functionality of
<tt>&lt;Alt-b&gt;</tt> and so forth without mapping the
<tt>&lt;Alt&gt;</tt> keys to anything. If you wish you can use something
like <tt>&lt;Plug&gt;foo1</tt> etc in the LHS of the mappings (do not use
the same LHS for all three) to effectively disable any mappings.
</div>
</blockquote>
<a name="faq-8">
<div class=qa>
Q: I cannot insert the <tt>e-acute (é)</tt> character! HELP!
</div>
<blockquote>
<div class=ans>
Insert the following line in your <tt>~/.vim/ftplugin/tex.viim</tt> file:
<pre>
imap &lt;buffer&gt; &lt;leader&gt;it &lt;Plug&gt;Tex_InsertItemOnThisLine
</pre>
Replace <tt>&lt;leader&gt;it</tt> with any other key-sequence. This will
make <tt>&lt;leader&gt;it</tt> key insert an <tt>\item</tt> command
corresponding to the last opened environment in the current line in insert
mode. The <tt>&lt;M-i&gt;</tt> key which is used for inserting the
<tt>e-acute</tt> character will remain unmapped. 
</div>
</blockquote>

<a name="faq-6">
<div class=qa>
Q: Sometimes I need to insert a literal double quote. But whenever I press
<tt>"</tt>, I get <tt>``</tt>. How do I get around this? Can I disable the
<tt>"</tt> to <tt>``</tt> conversion permanently for certain files?
</div>
<blockquote>
<div class=ans>
If you only need to insert a <tt>"</tt> occasionally but would like to
retain the <tt>"</tt> to <tt>``</tt> functionality, then use Vim's
<tt>&lt;C-v&gt;</tt> functionality.
<pre>:help i_CTRL-v</pre>
from within Vim for more information. In short press
<tt>&lt;C-v&gt;"</tt> instead of just <tt>"</tt>.
<p></p>
If for some files, you need to permanently disable smart quotes, then you
need to set the <tt>Tex_SmartKeyQuote</tt> setting to zero as described
<a href="documentation/latex-suite/customizing-smart-keys.html">here</a>.
Setting <tt>b:Tex_SmartKeyQuote</tt> to <tt>0</tt> will disable it for a
particular buffer, setting <tt>g:Tex_SmartKeyQuote</tt> will disable it for
all buffers.
</div>
</blockquote>
<a name="faq-8">
<div class=qa>
Q: I need to type SSS in my document a lot. But latex-suite always converts
it into a <tt>\subsection{}&lt;++&gt;</tt>. How do I get around this?
</div>
<blockquote>
<div class=ans>
To disable a mapping which Latex-suite creates by default, you will need to
create a "fake" mapping and place it in a <tt>.vim</tt> file which gets
sourced after Latex-suite. For example, to disable the mapping for
<tt>SSS</tt>, put the line
<pre>call IMAP('SSS', 'SSS', 'tex')</pre>
in one of the following files (you might need to create these if they do
not already exist)
<pre>~/.vim/after/ftplugin/tex.vim
~/.vim/after/ftplugin/tex_afterls.vim
~/.vim/after/ftplugin/tex/afterls.vim</pre>
</div>
</blockquote>

<!-- A sample Q & A
<a name="faq-#">
<div class=qa>
Q: 
</div>
<blockquote>
<div class=ans>
Answer
</div>
</blockquote>
-->

<!--
vim:ft=php
-->
