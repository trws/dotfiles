Vim-Latex aims at providing a comprehensive set of tools so you can do all
you latekng from within vim. Take a look at the <a
href="index.php?subject=screenshots">screenshots</a> to see a typical
working session with latex-suite. Here's a brief tour of the various
features:
<ul>
<li><a href="download/latex-suite.html#latex-macros">Editing</a>
	Latex-Suite ships with a very comprehensive set of insert mode and
	visual mode mappings and menu items to typeset most of the LaTeX
	elements. These range from 3 letter insert mode mappings which insert a
	skeleton of common typesetting elements to visual mode mappings which
	enclose the selected region in braces, parentheses, etc. The mappings
	can also be accessed via the menus.
<li>
<li><a href="download/latex-suite.html#latex-compiling">Compiling</a> You
	can compile the tex file from within vim. The list of errors is shown
	in a quickfix window so you can directly go to the location of an
	error. The compiler plugin can be dynamically reconfigured to show you
	more or less warnings.<p></p>
</li>
<li><a href="download/latex-suite.html#latex-viewing">Viewing</a> By
	pressing a key from within vim, the .dvi viewer is started up. You can
	also do <a href="download/latex-suite.html#latex-searching">forward and
	inverse searching</a> on your .dvi file from within vim.<p></p>
</li>
<li><a href="">Folding</a>
	Latex-suite ships with the plugin SyntaxFolds.vim which is a plugin for
	creating "fake" syntax folds on the fly. The fold method is actually
	manual but the folding is based on LaTeX syntax. This offers a speed
	increase over regular syntax folding.
	When you open up a LaTeX file, all the portions will be automatically
	folded up.<p></p>
</li>
<li><a href="">Packages</a> Latex-suite 
	This module provides ways of customizing the menus based on which
	packages are being used in the current LaTeX file. When latex-suite
	first starts up, it scans the <a href="">latex-master-file</a> for
	<tt>\usepackage{name}</tt> lines and if the corresponding package is found in
	the <tt>latex-suite/packages/</tt> directory, then creates a sub-menu
	based on the specification found in that file. See <a
	href="?subject=packages">the list of currently supported packages.</a><p></p>
</li>
<li><a href="">Dictionary</a> Latex-suite ships with a dictionary with over
	600 LaTeX commands, which speeds up typing using the <tt>CTRL-X_d</tt>
	command of vim.<p></p>
</li>
<li><a href="">Customized Templates</a> Latex-suite ships with some
	commonly used latex templates. It is trivial to add your own templates.
	The templates can contain dynamic data such as time of creation etc.
	See <a href="index.php?subject=templates">list of current templates</a>.
	<p></p>
</li>
<li><a href="">Customized Macros</a> Latex-suite makes it easy to add
	custom macros, again with the possibility of dynamic content and
	automatic cursor placement. <p></p>
</li>
<li>analyze of preamble and adding menus and special commands for used packages<br>
see <a href="http://vim-latex.sourceforge.net?subject=packages">list of supported packages</a></li>
<li>set of intuitive shortcuts for inserting environments, sections and font formats</li>
<li>LaTeX help file</li>
</ul>
