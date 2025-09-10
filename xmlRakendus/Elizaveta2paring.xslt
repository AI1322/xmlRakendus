<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl"
>
    <xsl:output method="xml" indent="yes"/>

    <xsl:template match="/">
		<strong>Näitame kõik andmed</strong>
		<ul>
			<xsl:for-each select="//inimene" >
				<xsl:sort select="@saasta" order="descending"/>
				<!-- descending - suuremat väiksemani-->
				<li>
					<i>
					<xsl:value-of select="concat(nimi, ', ', @saasta, '.')"/>
					</i>
				, vanus: 
				<xsl:value-of select="2025-@saasta"/>
				</li>
			</xsl:for-each>
		</ul>
		<strong>Kõik andmed tabelina</strong>
		<table border="1">
			<tr>
				<th>Nimi</th>
				<th>Laps</th>
				<th>Sünnipäev</th>
				<th>Vanus</th>
			</tr>
			<xsl:for-each select="//inimene" >
				<xsl:if test ="../..">
					<tr>
						<td>
							<xsl:value-of select="../../nimi"/>,
						</td>
						<td>
							<xsl:value-of select="nimi"/>,
						</td>
						<td>
							<xsl:value-of select="@saasta"/>,
						</td>
						<td>
							<xsl:value-of select="2025-@saasta"/>
						</td>
					</tr>
				</xsl:if>
			</xsl:for-each>
		</table>
		<strong>Iga inimeste kohta näita mitmendal oma vanaema sünniaastal ta sündis</strong>
		<ul>
			<xsl:for-each select="//inimene" >
				<xsl:if test ="../.."> 
					- lapsevanema vanus oli
					<xsl:value-of select="../../@saasta - @saasta"/>. aastat vana
				</xsl:if>
			</xsl:for-each>
		</ul>
		<strong>
			<ol>
				<li>Count() - kogus -üldkogus- kõik nimed xml jadas
					<xsl:value-of select="count(inimene/lapsed/inimene/nimi)"/>
				</li>
				<li>
					substring() - eraldab kolm esimest tähte nimest
					<xsl:for-each select="//inimene" >
						<xsl:value-of select="substring(nimi,0,4)"/> | 
					</xsl:for-each>
				</li>
				<li>
					substring() - eraldab kolm viimast tähte nimest
					<xsl:for-each select="//inimene" >
						<xsl:value-of select="substring(nimi,string-length(nimi)-2,3)"/> |
					</xsl:for-each>
				</li>
				<li>starts-with()</li>
				<xsl:for-each select="//inimene[starts-with(nimi, 'A')]">
					<xsl:value-of select="nimi"/>,
				</xsl:for-each>
			</ol>
		</strong>
    </xsl:template>
</xsl:stylesheet>
