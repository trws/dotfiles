Vim-Latex aims at providing a comprehensive set of tools so you can do all
you lateking from within vim. Take a look at the <a
href="index.php?subject=screenshots">screenshots</a> to see a typical
working session with latex-suite. Here's a brief tour of the various
features:
<ul>
<li><a href="documentation/latex-suite/latex-macros.html">Editing</a>
	Latex-Suite ships with a very comprehensive set of insert mode and
	visual mode mappings and menu items to typeset most of the LaTeX
	elements. These range from 3 letter insert mode mappings which insert a
	skeleton of common typesetting elements to visual mode mappings which
	enclose the selected region in braces, parentheses, etc. The mappings
	can also be accessed via the menus.
	<p></p>
</li>
<li><a href="documentation/latex-suite/latex-compiling.html">Compiling</a> You
	can compile the tex file from within vim. The list of errors is shown
	in a quickfix window so you can directly go to the location of an
	error. The compiler plugin can be dynamically reconfigured to show you
	more or less warnings.<p></p>
</li>
<li><a href="documentation/latex-suite/latex-viewing.html">Viewing</a> By
	pressing a key from within vim, the .dvi viewer is started up. You can
	also do forward and inverse searching on your .dvi file from within
	vim.<p></p>
</li>
<li><a href="documentation/latex-suite/latex-folding.html">Folding</a>
	Latex-suite ships with the plugin SyntaxFolds.vim which is a plugin for
	creating "fake" syntax folds on the fly. The fold method is actually
	manual but the folding is based on LaTeX syntax. This offers a speed
	increase over regular syntax folding.
	When you open up a LaTeX file, all the portions will be automatically
	folded up.<p></p>
</li>
<li><a href="documentation/latex-suite/latex-packages.html">Packages</a>
	This module provides ways of customizing the menus based on which
	packages are being used in the current LaTeX file. When latex-suite
	first starts up, it scans the <a
	href="documentation/latex-suite/latex-master-file.html">latex-master-file</a>
	for <tt>\usepackage{name}</tt> lines and if the corresponding package
	is found in the <tt>latex-suite/packages/</tt> directory, then creates
	a sub-menu based on the specification found in that file. See <a
	href="index.php?subject=packages">the list of currently supported
	packages.</a><p></p>
</li>
<li><a href="download/latexhelp.txt">LaTeX help file</a>
	Latex-suite ships with the standard texinfo file translated into vim
	help format so that you can get help for common latex commands from
	within vim.  You can view the HTML version of this file <a
	href="download/latexhelp.html">here</a>.  <p></p>
</li> 
<li><a href="download/latex-suite.html#latex-dictionary">Dictionary</a> 
	Latex-suite ships with a dictionary with over
	600 LaTeX commands, which speeds up typing using the <tt>CTRL-X_d</tt>
	command of vim.<p></p>
</li>
<li><a href="documentation/latex-suite/latex-suite-templates.html">Customized Templates</a> 
	Latex-suite ships with some commonly used latex templates. It is
	trivial to add your own templates.  The templates can contain dynamic
	data such as time of creation etc.  See <a
	href="index.php?subject=templates">list of current templates</a>.
	<p></p>
</li>
<li><a href="documentation/latex-suite/custom-macros-menu.html">Customized Macros</a> 
	Latex-suite makes it easy to add custom macros, again with the
	possibility of dynamic content and automatic cursor placement. <p></p>
</li>
</ul>
