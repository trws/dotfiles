<h3>Branching Cheat Sheet</h3>
This is a pretty basic cheat sheet on how to create branches using CVS,
which is what is used in the Latex-Suite project to maintain the code and
collaborate between the developers. (I have developed a bad habit of saying
"Developers! Developers! Developers!" whenever I want to say developers,
wonder why?) 

This document is compiled from the following sources:

<ol>
<li><a href="http://www.cvshome.org/docs/manual/">http://www.cvshome.org/docs/manual/</a></li>
<li><a href="http://cvsbook.red-bean.com/cvsbook.html">http://cvsbook.red-bean.com/cvsbook.html</a></li>
</ol>
<p>
<b>NOTE:</b> Not all these steps are mandatory. They are just a good thing to
do.
</p>
<p>
Branching in CVS is used when some major change is being planned which
might destabilize the code. Branching enables you to work on a copy of the
files till the code on that "branch" has been suitably stabilized, and then
"merge" the changes in the branch back into the main trunk.
</p>
<p>
Branching essentially consists of four stages. In the first stage, you
create the branch itself, i.e, you "tag" the files in some stage as the
"root" of the "branch". You then "checkout" a copy of the files in the
branch and work on that. After you are confident that you want the changes
to be "merged" into the main trunk, you prepare both the branch and the
trunk and then finally do the merging itself. These things have been
explained in great detail <a
href="http://cvsbook.red-bean.com/cvsbook.html#Branches">here</a>.
</p>
<h3>Creating a branch</h3>
<ol>
	<li><pre>$ cd /path/to/trunk</pre>
	(This is where you have checked out the main trunk.
	Note, if you want to create branches off branches (not
	recommended), then you'll want to cd to where you have checked out
	the branch).
	</li>
	<li><pre>$ cvs update</pre>
	(If this shows some errors for non-mergeable files, then you'll need
	to resolve the conflicts manually).
	</li>
	<li><pre>$ cvs diff</pre>
	If this shows some diffs , then
	<pre>$ cvs commit</pre>
	(If this shows more errors for non-mergeable files, you'll also need to
	check for conflicts etc).
	</li>
	<li><pre>$ cvs tag -b b-&lt;branchname&gt;</pre>
	(This is the branch name chosen)
	</li>
</ol>
<h3>Checking out a branch</h3>
<pre>$ cvs co -r b-&lt;branchname&gt; -d /path/to/branch &lt;modulename&gt;</pre>
The <tt>-d /path/to/branch</tt> argument specifies where the files in
<tt>&lt;modulename&gt;</tt> will be checked out to on the local machine. It
can be relative to the local directory, in which case use
<tt>path/to/branch</tt> instead of <tt>/path/to/branch</tt>.

<h3>Preparing a branch for merging into trunk</h3>

<ol>
	<li><pre>$ cd /path/to/branch</pre>
	(This is where you have checked out a copy of the branch).
	</li>
	<li><pre>$ cvs update</pre>
	(If this step shows conflicts, then resolve and commit).
	</li>
	<li><pre>$ cvs diff</pre>
	If this part shows some diffs, then
	<pre>$ cvs commit</pre>
	(Again, if this shows conflicts, resolve and commit).
	</li>
	<li>
	<pre>$ cvs tag b-&lt;branchname&gt;-&lt;authorname&gt;-merge-&lt;mergenumber&gt;</pre>
	(where <tt>&lt;mergenumber&gt;</tt> is the number of times you have merged from this
	branch to the trunk <tt>&lt;authorname&gt;</tt> is your name,
	preferably initials).
	</li>
</ol>
<h3>The final Merging Step</h3>
<ol>
	<li><pre>$ cd /path/to/main/trunk</pre>
	This is where you have checked out a copy of the main trunk.
	</li>
	<li><pre>$ cvs diff</pre>
	If there are locally modified copies of any files, 
	<pre>$ cvs commit</pre>
	</li>
	<li> This step depends on whether or not a merge has been done
	previously from this branch or not.
	<ol>
		<li>
		If this is the first time a merge is being done from this branch onto
		the main trunk
		<pre>$ cvs update -d -j b-&lt;branchname&gt;</pre>
		Here <tt>b-&lt;branchname&gt;</tt> is the branch name, not a revision name.
		This is the name with which the branch was created.
		</li>
		<li>
		If this is not the first merge from branch to main trunk
		<pre>$ cvs update -d -j b-&lt;branchname&gt;-&lt;author&gt;-merge-&lt;mergenumber&gt; -j b-&lt;branchname&gt;</pre>
		Note: the first tag refers to a revision tag name, whereas the the
		second revision is the branch tag.
		</li>
	</ol>
	</li>
</ol>

<!--
vim: ft=php
-->
