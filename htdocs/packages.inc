<table>
<tr>
	<td><b>Name of the package:</b></td>
	<td>&nbsp;</td>
	<td><b>Last modified:</b></td>
</tr>
<?
$dir = getcwd()."/packages";
$packdir = dir($dir);
while($file = $packdir->read()){
	if($file!="." && $file!=".."  && strncmp($file,"CVS",3)){
		$filetable[] = $file;
	}
}
$packdir->close();
asort($filetable);
foreach($filetable as $packagefile){
	echo "<tr><td><a href='packages/".$packagefile."'>".$packagefile."</a></td>";
	echo "<td>&nbsp;</td>";
	echo "<td>".date("F j, Y", filemtime($dir."/".$packagefile))."</td></tr>\n";
}
?>
</table>
