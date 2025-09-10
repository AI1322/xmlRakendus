<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl"
>
	<xsl:output method="xml" indent="yes"/>
	<xsl:key name="elukohtKey" match="inimene" use="@elukoht"/>

	<xsl:template match="/">
		<style>
			table, th, td { border: 1px solid black; border-collapse: collapse; padding: 3px; }
		</style>
		<table border="1">
			<tr>
				<th>Nimi</th>
				<th>Perekonnanimi</th>
				<th>Sünniaasta</th>
				<th>Vanus</th>
				<th>Laste arv</th>
				<th>Elukoht</th>
			</tr>
			<xsl:for-each select="//inimene">
				<xsl:sort select="count(lapsed/inimene/lapsed/inimene)" data-type="number" order="descending"/>
				<xsl:variable name="nimi" select="nimi"/>
				<xsl:variable name="elukoht" select="@elukoht"/>
				<xsl:variable name="laste_arv" select="count(lapsed/inimene)"/>
				<xsl:variable name="M" select="contains(nimi, 'm') or contains(nimi, 'M')"/>
				<tr>
					<td>
						<xsl:attribute name="style">
							<xsl:if test="$M"> color: red;</xsl:if>
							<xsl:if test="$laste_arv &gt;= 2"> background-color: yellow; </xsl:if>
						</xsl:attribute>
						<xsl:value-of select="$nimi"/>
					</td>
					<td>
						<xsl:value-of select="perekonnanimi"/>
					</td>
					<td>
						<xsl:value-of select="@saasta"/>
					</td>
					<td>
						<xsl:value-of select="2025 - number(@saasta)"/>
					</td>
					<td>
						<xsl:value-of select="$laste_arv"/>
					</td>
					<td>
						<xsl:value-of select="$elukoht"/>
					</td>
				</tr>
			</xsl:for-each>
		</table>
		<strong>Elukohtade statistika:</strong>
		<ul>
			<xsl:for-each select="//inimene[generate-id() = generate-id(key('elukohtKey', @elukoht)[1])]">
				<li>
					<xsl:value-of select="@elukoht"/>:
					<xsl:value-of select="count(key('elukohtKey', @elukoht))"/>
				</li>
			</xsl:for-each>
		</ul>
	</xsl:template>
</xsl:stylesheet>
