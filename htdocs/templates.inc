<table>
<tr>
	<td><b>Name of the template:</b></td>
	<td>&nbsp;</td>
	<td><b>Last modified:</b></td>
</tr>
<?
$dir = getcwd()."/templates";
$tempdir = dir($dir);
while($file = $tempdir->read()){
	if($file!="." && $file!=".." && strncmp($file,"CVS",3)){
		$filetable[] = $file;
	}
}
$tempdir->close();
asort($filetable);
foreach ($filetable as $tempfile){
echo "<tr><td><a href='templates/".$tempfile."'>".$tempfile."</a></td>";
echo "<td>&nbsp;</td>";
echo "<td>".date("F j, Y", filemtime($dir."/".$tempfile))."</td></tr>\n";
}
?>
</table>
