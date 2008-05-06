<?
/// Returns the latest latexSuite2003.*.tar.gz or .zip file present in the
// download area.
function GetLatestDevVersion($pat) {
	$dir = opendir('download');
	if (!$dir)
		return '';
	
	$curmodtime = -1;
	$latestfile = '';
	while (($file = readdir($dir)) != FALSE) {
		if (ereg('^latexSuite200.*'.$pat, $file)) {
			if (filemtime("download/$file") > $curmodtime) {
				$curmodtime = filemtime("download/$file");
				$latestfile = $file;
			}
		}
	}
	return "$latestfile";
}
$latestTgz = GetLatestDevVersion('tar.gz');
$latestZip = GetLatestDevVersion('zip');

// Find out the modification times and sizes of the latest developement
// snapshots. The optional argument to round() is the number of decimal
// places to retain.
$latestTgzTime = date("F j, Y", filemtime("download/$latestTgz"));
$latestZipTime = date("F j, Y", filemtime("download/$latestZip"));
$latestTgzSize = round(filesize("download/$latestTgz")/1024,1)." Kb";
$latestZipSize = round(filesize("download/$latestZip")/1024,1)." Kb";

// This provides an easy way to go from one release to the next. All that
// will be need to go from release 1.5 to 1.6 is to change the next line.
$relName = "latexSuite-1.5";
$relTgz = "$relName.tar.gz";
$relZip = "$relName.zip";
$relTgzTime = date("F j, Y", filemtime("download/$relTgz"));
$relZipTime = date("F j, Y", filemtime("download/$relZip"));
$relTgzSize = round(filesize("download/$relTgz")/1024,1)." Kb";
$relZipSize = round(filesize("download/$relZip")/1024,1)." Kb";
?>

Latest version of Latex-Suite:
<?
echo <<<END
<ul>
  <li><a href="download/$latestZip">$latestZip</a> ($latestZipSize; $latestZipTime)</li>
	<li><a href="download/$latestTgz">$latestTgz</a> ($latestTgzSize; $latestTgzTime)</li>
</ul>
END;
?>
<a href="vimfiles/ChangeLog">ChangeLog</a>

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
Make sure you have the following setting in your .vimrc
<pre>
" REQUIRED. This makes vim invoke latex-suite when you open a tex file.
filetype plugin on

" IMPORTANT: win32 users will need to have 'shellslash' set so that latex
" can be called correctly.
set shellslash

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse latex-suite. Set your grep
" program to alway generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: This enables automatic indentation as you type.
filetype indent on
</pre>

<h4>Step 3 of 4: Install the help files</h4>
To install the included latex-suit.txt and latexhelp.txt files as vim help
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

<a href="http://cvs.sourceforge.net/cvstarballs/vim-latex-cvsroot.tar.gz"
class="list">CVS snapshot</a> Sourceforge provides projects with a nightly
updated archived version of the CVS repository. A better way to stay in
step with the project if you use CVS but do not want to be a developer is
to follow the instructions for anonymous CVS access <a
href="http://sourceforge.net/cvs/?group_id=52322">here</a>. Use vimfiles in
place of <i>modulename</i>.

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
