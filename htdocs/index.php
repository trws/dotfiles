<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<!--
index.php generates the html page using <table>'s to create the layout.
Essentially, the HTML page has the following structure:

--------------------%<--------------------
<table>
  <tr>
    <td>$navigation_panel</td>
    <td>$main_panel</td>
  </tr>
  <tr>
    <td colspan=2>$footnote_panel</td>
  </tr>
</table>
--------------------%<--------------------

In the above structure, the various elements are formed as follows:

1. $navigation_panel: This is simply done by including head.inc.

2. $main_panel: This is formed via the subject key in the query to this
   page. For example, if we call index.php as
   	 index.php?subject=coding-style
   then it will $main_panel will simply include coding-style.inc.

   If no subject key is specified, then we include main.inc.

   In addition, if a title is specified in the query, then it is used to
   form the title of the HTML page.

3. $footnote_panel is simply foot.inc.

-->
<?
if (isset($_GET['subject'])) {
	$mainpanel = $_GET['subject'].".inc";
}
else {
	$mainpanel = "main.inc";
}
if (isset($_GET['title'])) {
	$pagetitle = $_GET['title'];
}
else {
	$pagetitle = "";
}
include "head.inc"
?>
<!-- End of left navigation bar. -->

<td class="mainpanel">
<!-- Begin of Main Panel -->

<h2 class="hline"><? echo $pagetitle ?></h2>
<?  include $mainpanel ?>

<!-- End of Main Panel -->
</td>
</tr>
<tr>
<td colspan=2 class=footpanel>
<!-- Begin of footer -->

<? include "foot.inc" ?>

</td>
</tr>
</table>

</body>
</html>
