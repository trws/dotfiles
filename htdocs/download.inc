<h2>Latest version</h2>
<p> Currently only irregular svn snapshots are provided. These and older
releases can be found at the <a
href="http://sourceforge.net/projects/vim-latex/files/">SourceForge Files for
vim-latex</a> page.
</p>

<a name=installation>
<h2>Installation Instructions</h2>

<h4>Step 1 of 4: Download and extract the archives</h4>
Extract one of the archives above into your <tt>~/vimfiles</tt> directory
(if you are using windows) or <tt>~/.vim</tt> directory (if you are using
*nix). 
<p>If you are updating after a long time, it might be a good idea to remove
the <tt>~/vimfiles/ftplugin/latex-suite</tt> directory from previous
installations before reinstalling.</p>
<p><b>NOTE:</b> If you already have some latex ftplugin files, read the
<a href="#advanced">Advanced Installation Instructions</a> to make sure you
do not over-write any of your files.</p>

<h4>Step 2 of 4: Set a few things in .vimrc</h4>
The recommended settings for vim-latex in your .vimrc file are now only described in
the <a href="/documentation/latex-suite/recommended-settings.html">vim-latex manual</a>.

<h4>Step 3 of 4: Install the help files</h4>
To install the included latex-suite.txt and latexhelp.txt files as vim help
files, start vim and do the following:
<p>
<tt>helptags ~/.vim/doc</tt> &nbsp; &nbsp; (for *nix users) <br>
<tt>helptags ~/vimfiles/doc</tt>  &nbsp; &nbsp; (for windows users) <br>
</p>

<h4>Step 4 of 4: Done!</h4>
Thats it! You are done! Now start editing a latex file in vim. Latex-Suite
should start up automatically. You can do
<pre>:help latex-suite.txt</pre>
from within vim to get the online Latex-Suite reference.
<hr>

<h3>Other ways to keep up with changes</h3>
<p>The sourcecode is managed using subversion (svn). To access the repository,
follow the instructions that are linked in the navigation bar.
</p>

<a name="advanced">
<h3>Advanced Installation Instructions</h3>
<p>
If you have already have a system of filetype specific files (ftplugin,
indent etc) files set up for the 'tex' filetype, then please make sure that
Latex-Suite does not over-write your files. 
</p>

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
