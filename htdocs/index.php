<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<?
if (isset($_GET['subject']))
{
	$subject = $_GET['subject'];
	switch ($subject)
	{
		case packages:
			$pagetitle="Package files";
		 	break;
		case screenshots:
			$pagetitle="Screenshots";
			break;
		case features:
			$pagetitle="Features";
			break;
		case templates:
			$pagetitle="Templates";
			break;
		case links:
			$pagetitle="Links";
			break;
		case weare:
			$pagetitle="We are...";
			break;
		case download:
			$pagetitle="Download";
			break;
	}
	$leftpanel="left_".$subject.".inc";
	$mainpanel=$subject.".inc";
}
else
{
	$pagetitle="VIM-latexSuite";
	$leftpanel="left_main.inc";
	$mainpanel="main.inc";
}
include "head.inc";
?>


<!-- End of header -->

<table class="meritum" border="0">
<tr>
	<td colspan="3"> 
		<h2 class="hline"><? echo $pagetitle ?></h2>
	</td>
</tr>
<tr>

<td class="leftpanel" width="100">
<!-- Begin of Left Panel -->

<?  include $leftpanel ?>

<!-- End of Left Panel -->
</td>
<td>
&nbsp;
</td>
<td class="meritum">
<!-- Begin of Main Panel -->

<?  include $mainpanel ?>

<!-- End of Main Panel -->
</td></tr>
</table>
</div>

<!-- Begin of footer -->

<? include "foot.inc" ?>
