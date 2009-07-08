<?xml version="1.0"?>

<!-- ||||||||||||||||||||||||||||||||||||||||||| -->
<!-- |||||  Gabriel BODARD 2009-06-21    |||||| -->
<!-- ||||           Last update 2009-07-08       |||||| -->
<!-- ||||||||||||||||||||||||||||||||||||||||||| -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
  xmlns="http://www.tei-c.org/ns/1.0">

  <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="no"
    doctype-public="http://www.stoa.org/epidoc/dtd/6/tei-epidoc.dtd"/>

  <!-- |||||||||||||||||||||||||||||||||||||||||||||||||| -->
  <!-- ||||||||||||  copy all existing elements ||||||||||| -->
  <!-- |||||||||||||||||||||||||||||||||||||||||||||||||| -->

  <xsl:template match="*">
    <xsl:element name="{local-name()}">
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>

  <!-- |||||||||||||||||||||||||||||||||||||||||||||||||||| -->
  <!-- |||||||||||||||| copy all comments  |||||||||||||||| -->
  <!-- |||||||||||||||||||||||||||||||||||||||||||||||||||| -->

  <xsl:template match="//comment()">
    <xsl:comment>
      <xsl:value-of select="."/>
    </xsl:comment>
  </xsl:template>

  <!-- ||||||||||||||||||||||||||||||||||||||||||||||| -->
  <!-- ||||||||||||||     EXCEPTIONS      |||||||||||||| -->
  <!-- ||||||||||||||||||||||||||||||||||||||||||||||| -->

  <xsl:template match="titleStmt/title[not(string(@n))]">
    <xsl:variable name="tmnodump" select="document('../../tmnosdump.xml')"/>

    <xsl:copy>
      <xsl:copy-of select="@*[not(local-name() = 'n')]"/>
      <xsl:if test="$tmnodump//doc[ddbno = current()]">
        <xsl:attribute name="n">
          <xsl:value-of select="$tmnodump//ROW[COL[1]//text() = current()/ancestor::TEI.2/@n]/ROW[2]"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:apply-templates/>
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet>
