<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<?
if (isset($_GET['subject']))
{
	$subject = $_GET['subject'];
	switch ($subject)
	{
		case 'packages':
			$pagetitle="Package files";
		 	break;
		case 'screenshots':
			$pagetitle="Screenshots";
			break;
		case 'features':
			$pagetitle="Features";
			break;
		case 'templates':
			$pagetitle="Templates";
			break;
		case 'links':
			$pagetitle="Links";
			break;
		case 'weare':
			$pagetitle="We are ...";
			break;
		case 'download':
			$pagetitle="Download";
			break;
		case 'faq':
			$pagetitle="FAQ";
			break;
		case 'comingsoon':
			$pagetitle="Coming Soon ...";
			break;
	}
	$leftpanel="left_".$subject.".inc";
	$mainpanel=$subject.".inc";
}
else
{
	$pagetitle="VIM-LaTeX";
	$leftpanel="left_main.inc";
	$mainpanel="main.inc";
}
include "head.inc";
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
