<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl"
>
	<xsl:output method="xml" indent="yes"/>

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
				<th>Vanem</th>
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
							<xsl:if test="not(parent::lapsed)">background-color: orange;</xsl:if>
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
					<td>
						<xsl:if test="parent::lapsed">
							<xsl:value-of select="parent::lapsed/parent::inimene/nimi"/>
						</xsl:if>
					</td>
				</tr>
			</xsl:for-each>
		</table>
		<ul>
			<li>Peamine esivanem on oranžiga esile tõstetud</li>
			<li>Inimesed kellel on lapsed kollasega esile tõstetud</li>
			<li>Inimesed, kelle nimes on täht M tõstetud punasega</li>
		</ul>

		<strong>Elukohtade statistika:</strong>
		<ul>
			<xsl:for-each select="//inimene">
				<xsl:variable name="currentElukoht" select="@elukoht"/>
				<xsl:if test="not(ancestor::inimene[@elukoht = $currentElukoht])">
					<li>
						<xsl:value-of select="$currentElukoht"/>:
						<xsl:value-of select="count(//inimene[@elukoht = $currentElukoht])"/>
					</li>
				</xsl:if>
			</xsl:for-each>
		</ul>
	</xsl:template>
</xsl:stylesheet>
