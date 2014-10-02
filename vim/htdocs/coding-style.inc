<h2>Coding Style in the Latex-Suite project</h2>
If you are a current developer or want to be a developer on the
Latex-Suite project, please follow the following coding guidelines. If you
are an active developer, then you will _have_ to follow these guidelines.
If you are submitting a patch, then you can submit it in whatever way you
find coding most comfortable. However, it will be converted before getting
added to the project.
<ol>
 <li>When you start a new file, then include the following
 modeline at the end of the file.
 <pre>fdm=marker:ff=unix:noet:ts=4:sw=4</pre>
 </li>
 <li>We use TABS in the Latex-Suite project for indentation, _not_
 spaces. Please do not try to convince us otherwise. Its futile :)</li>
 <li>Each new function should be created in the following format: 
 <pre>" Tex_Function: short &lt; 40 character description {{{
" Description: longer description which can span several lines.
function! <SID>SetCompilerMaps()
	" ... body of the function ...
endfunction 
" }}}</pre>
  Notice the marker characters <tt>{{{</tt> and <tt>}}}</tt> which fold the
  entire function into a single concise line while viewing.
 </li>
 <li>A function name should start with the prefix <tt>Tex_</tt> whether or
 not it is script-local. (There is unfortunately, some legacy code in
 latex-suite which does not follow this convention.) The first character
 after the underscore should be upper case. The rest of the function name
 should be written using the
 <tt>CamelCase</tt> convention. In other words, individual words should be
 visually demarcated using upper case characters (no more underscores!)</li>
 <li>A function name should be a _verb_, i.e. an action as far as possible.
 For example, if you create a function which detects whether or not a
 package exists in a file, then use <tt>Tex_CheckForPackage</tt> instead of
 <tt>Tex_PackageCheck</tt>.</li>
 <li>Global settings should go into the <tt>texrc</tt> file, using the
 same convention as function names, i.e, they should all have the
 <tt>Tex_</tt> prefix and should be in <tt>CamelCase</tt> afterwards.</li>
 <li>For settings, it is not necessary at all for the name to be a verb or
 an action or a noun or whatever. Use whatever makes the most sense for
 that setting.</li>
 <li>For both function names and settings, try to use complete words. Do
 not truncate unnecessarily, unless its standard practice. For example,
 <tt>Tex_ChkForPacks</tt> is much worse than <tt>Tex_CheckForPackages</tt>.
 Do not complain that you will have to type a long word everytime. Vim's
 <tt>&lt;C-p&gt;</tt> is your friend.</li>
 <li>Please comment liberally. Do not worry about too much verbosity. Try
 to follow Donald Knuth's "Literate Programming" paradigm.</li>
</ol>
<!--
vim:ft=php
-->
