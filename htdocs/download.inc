Latest stable version of latexSuite:
<ul>
<li><a href="download/latexSuite.zip">zip</a>
(<? echo round(filesize("download/latexSuite.zip")/1024,1)." Kb; ";
	echo date("F j, Y", filemtime("download/latexSuite.zip")).")"; ?>
</li>
<li><a href="download/latexSuite.tar.gz">tar.gz</a>
(<? echo round(filesize("download/latexSuite.tar.gz")/1024,1)." Kb; ";
	echo date("F j, Y", filemtime("download/latexSuite.tar.gz")).")"; ?>
</li>
</ul>
<a name=installation>
<h3>Installation Instructions</h3>
Extract one of the archives above into your ~/vimfiles directory (if you
are using windows) or ~/.vim directory (if you are using *nix). Make sure you have the
following setting in your .vimrc
<pre>
    " Necessary. This setting tells vim to load latex-suite
    " when a tex file opened.
    filetype plugin on
    " Optional. This enables automatic indentation as you
    " type.
    filetype indent on
    " IMPORTANT: win32 users will need to have 'shellslash'
    " set so that latex can be called correctly.
    set shellslash
</pre>
Next time you start vim and edit a latex file, latex-suite should
automatically be activated.
<p>
To install the included latex-suit.txt and latexhelp.txt files as vim help
files, start vim and do the following:
<p>
<tt>helptags ~/.vim/doc</tt> &nbsp; &nbsp; (for *nix users) <br>
<tt>helptags ~/vimfiles/doc</tt>  &nbsp; &nbsp; (for windows users) <br>
</p>
After that, you can do
<p><tt>help latex-suite</tt></p> from within vim to get help for
latex-suite.
<br>
<p></p>
<b>NOTE: </b>
If you have already have a system of filetype specific files (ftplugin,
indent etc) files set up for the 'tex' filetype, then you might want to
read the <a href="#advanced">advanced installation instructions</a> for
potential conflicts.

<h3>Other Stuff</h3>

<ul>
<li>
User documentation:
	<ul>
		<li>
		<a href="download/latex-suite.html" class="list">In html format</a>
		For online viewing.
		</li>
		<li>
		<a href="download/latex-suite.txt" class="list">In vim help .txt format</a>
		This file ships with the distribution as doc/latex-suite.txt.
		</li>
	</ul>
	<br>
</li>
<li>
LaTeX TeX-info documentation:
	<ul>
		<li>
		<a href="download/latexhelp.html" class="list">In html format</a>
		For online viewing.
		</li>
		<li>
		<a href="download/latexhelp.txt" class="list">In vim help .txt format</a>
		This file ships with the distribution as doc/latexhelp.txt.
		</li>
	</ul>
	<br>
</li>
<li>
<a href="http://cvs.sourceforge.net/cvstarballs/vim-latex-cvsroot.tar.gz"
class="list">CVS snapshot</a> Sourceforge provides projects with a nightly
updated archived version of the CVS repository. A better way to stay in
step with the project if you use CVS but do not want to be a developer is
to follow the instructions for anonymous CVS access <a
href="http://sourceforge.net/cvs/?group_id=52322">here</a>. Use vimfiles in
place of <i>modulename</i>.
</li>
</ul>

<a name="advanced">
<h3>Advanced Installation Instructions</h3>
The archive above will unzip in the following manner:<br>

<pre>
latexSuite.zip
    |
    |   ltags
    |
    +---plugin
    |       imaps.vim
    |       SyntaxFolds.vim
    |       libList.vim
    |
    +---ftplugin
    |   |   tex_latexSuite.vim
    |   |
    |   \---latex-suite
    |       ... latex suite files ...
    |          includes templates,
    |             macros etc
    +---doc
    |       latex-suite.txt
    |       latexhelp.txt
    | <span class=conflict>
    +---indent
    |       tex.vim
    |
    \---compiler
            tex.vim
</span>
</pre>
The files shown in <span class=conflict>red</span> will potentially
over-write files already in your system. In this case, you will want to
unpack the archive into a temporary folder and then copy over the files
which you need. Note however, that this is not supported. You will have to
take care of the bugs which you encounter because of this yourself.

<!-- 
vim:ft=php 
-->
