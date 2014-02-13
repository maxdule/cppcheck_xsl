<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="/results">

<html>
<head>
<script type="text/javascript" src="https://raw2.github.com/maxdule/cppcheck_xsl/master/jquery-latest.js"></script> 
<script type="text/javascript" src="https://raw2.github.com/maxdule/cppcheck_xsl/master/jquery.tablesorter.js"></script> 
<script>
function myOnLoad()
{
	$(document).ready(function() 
    { 
        $("#errors").tablesorter(); 
    } 
); 
}
</script>
</head>
<body bgColor="white" style="margin:50px; padding:0" onLoad="myOnLoad();" ><h1>CppCheck</h1>
<h2> Summary </h2>
<table border="1px" cellpadding="0px" cellspacing="0px">
<tr><th>Type</th><th>Count</th></tr>
<tr bgColor="salmon"><td>Error:</td><td><xsl:value-of select="count(error[@severity='error'])" /> </td></tr>
<tr bgColor="lightyellow"><td>Style:</td><td><xsl:value-of select="count(error[@severity='style'])" /> </td></tr>
<tr bgColor="plum"><td>Warning:</td><td><xsl:value-of select="count(error[@severity='warning'])" /> </td></tr>
<tr bgColor="tan"><td>Perf:</td><td><xsl:value-of select="count(error[@severity='performance'])" /> </td></tr>
<tr bgColor="lightskyblue"><td>Info:</td><td><xsl:value-of select="count(error[@severity='information'])" /> </td></tr>
<tr bgColor="white"><td>Total:</td><td><xsl:value-of select="count(error)" /> </td></tr>
</table>

<h2>Legend (error type)</h2>
<table border="1px" cellpadding="0px" cellspacing="0px">
<tr><td>error</td><td bgColor="salmon">&#160;&#160;&#160;&#160;</td></tr>
<tr><td>style</td><td bgColor="lightyellow">&#160;&#160;&#160;&#160;</td></tr>
<tr><td>warning</td><td bgColor="plum">&#160;&#160;&#160;&#160;</td></tr>
<tr><td>performance</td><td bgColor="tan">&#160;&#160;&#160;&#160;</td></tr>
<tr><td>information</td><td bgColor="lightskyblue">&#160;&#160;&#160;&#160;</td></tr>
</table>

<h2>Errors</h2>
<table id="errors" border="1px" cellpadding="0px" cellspacing="0px">
<thead>
<tr><th>File</th><th>Severity</th><th>Type</th><th>Message</th></tr>
</thead>
<tbody>
<xsl:for-each select="error">
<xsl:sort select="@file"/>
<xsl:sort select="@severity"/>

<xsl:variable name="file"><xsl:value-of select="concat(@file, ':', @line)" /></xsl:variable>
<xsl:variable name="fileLink"><xsl:value-of select="concat('https://stash.motiondsp.com/projects/IKENA/repos/ikena-isr/browse/', substring(translate(@file, '\', '/'), 18), '#', @line)" /></xsl:variable>
<xsl:variable name="clr">
<xsl:choose>
<xsl:when test="@severity='error'">
salmon
</xsl:when>
<xsl:when test="@severity='style'">
lightyellow
</xsl:when>
<xsl:when test="@severity='warning'">
plum
</xsl:when>
<xsl:when test="@severity='performance'">
tan
</xsl:when>
<xsl:otherwise>
lightskyblue
</xsl:otherwise>
</xsl:choose>
</xsl:variable>

<tr bgColor="{$clr}">
<td><a href="{$fileLink}"> <xsl:value-of select="$file" /></a></td>
<td><xsl:value-of select="@severity" /></td>
<td><xsl:value-of select="@id" /></td>
<td><xsl:value-of select="@msg" /></td>
</tr>

</xsl:for-each>
</tbody>
</table>
</body></html>
</xsl:template></xsl:stylesheet>