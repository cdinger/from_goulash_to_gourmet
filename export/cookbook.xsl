<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">

  <xsl:template name="toc">
    <fo:block break-before="page" span="all" margin-left="2in" margin-right="2in">
      <fo:block font-size="16pt" text-align="center" margin-bottom=".25in">Table of Contents</fo:block>
      <xsl:for-each select="//recipe[not(category = preceding-sibling::recipe[1]/category)]/category">
        <xsl:sort select="category"/>
        <xsl:sort select="h1"/>
        <fo:block text-align-last="justify" font-size="11pt">
          <fo:basic-link internal-destination="{generate-id(.)}">
            <xsl:value-of select="." />
            <fo:leader leader-pattern="dots" />
            <fo:page-number-citation ref-id="{generate-id(.)}" />
          </fo:basic-link>
        </fo:block>
      </xsl:for-each>
    </fo:block>
  </xsl:template>

  <xsl:template name="chapter" match="//recipe[not(category = preceding-sibling::recipe[1]/category)]/category">
    <fo:block span="all" padding-top="1.7in" text-align="center" page-break-before="always" font-size="32pt" font-family="Britannic Bold" id="{generate-id(.)}">
      <xsl:value-of select="."/>
    </fo:block>
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template name="title" match="//h1">
    <fo:block span="all" text-align="center" page-break-before="always" font-size="20pt" margin-bottom=".25in" font-family="Britannic Bold" id="{generate-id(.)}">
      <xsl:value-of select="." />
    </fo:block>
  </xsl:template>

  <xsl:template name="h2" match="//h2">
    <fo:block span="all" margin-bottom=".1in" margin-top=".25in" text-transform="uppercase">
      <xsl:value-of select="." />:
    </fo:block>
  </xsl:template>

  <xsl:template name="ingredients" match="//ul">

    <xsl:choose>
      <xsl:when test="preceding-sibling::h3 != ''">
        <fo:block keep-together="always">
          <xsl:if test="preceding-sibling::h3 != ''">
            <fo:block keep-together="always">
              <fo:block text-transform="uppercase">
                <xsl:value-of select="preceding-sibling::h3[1]" />
              </fo:block>
              <xsl:for-each select="li">
                <fo:block>
                  <xsl:value-of select="." />
                </fo:block>
              </xsl:for-each>
            </fo:block>
          </xsl:if>
        </fo:block>
      </xsl:when>
      <xsl:otherwise>
        <xsl:for-each select="li">
          <fo:block>
            <xsl:value-of select="." />
          </fo:block>
        </xsl:for-each>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="paragraph" match="//p">
    <fo:block span="all">
      <xsl:value-of select="." />
    </fo:block>
  </xsl:template>

  <xsl:template name="footer">
    <fo:block font-size="10pt" margin-right=".25in" margin-left=".25in">
      <fo:table>
        <fo:table-column column-width="50%"/>
        <fo:table-column column-width="50%"/>
        <fo:table-body>
          <fo:table-row>
            <fo:table-cell>
              <fo:block>
                From Goulash to Gourmet, 2nd Edition
              </fo:block>
            </fo:table-cell>
            <fo:table-cell text-align="right">
              <fo:block>
                Page <fo:page-number/>
              </fo:block>
            </fo:table-cell>
          </fo:table-row>
        </fo:table-body>
      </fo:table>
    </fo:block>
  </xsl:template>

  <xsl:template match="/cookbook">
    <fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format" font-family="Adobe Garamond Pro" font-size="11pt">

      <fo:layout-master-set>
        <fo:simple-page-master master-name="frontmatter" page-width="8.5in" page-height="5.5in">
          <fo:region-body margin=".5in" margin-bottom=".75in" />
        </fo:simple-page-master>
        <fo:simple-page-master master-name="Ahalf" page-width="8.5in" page-height="5.5in">
          <fo:region-body margin=".5in" margin-bottom=".75in" column-count="2"/>
          <fo:region-after extent=".5in" />
        </fo:simple-page-master>
      </fo:layout-master-set>

      <fo:page-sequence master-reference="frontmatter" id="{generate-id(.)}">
        <fo:flow flow-name="xsl-region-body">
          <!--<xsl:call-template name="cover"/>-->
          <!--<xsl:call-template name="half-title"/>-->
          <!--<xsl:call-template name="coverdescription"/>-->
          <!--<xsl:call-template name="dedication"/>-->
          <xsl:call-template name="toc"/>
        </fo:flow>
      </fo:page-sequence>

      <fo:page-sequence master-reference="Ahalf" id="{generate-id(.)}">
        <fo:static-content flow-name="xsl-region-after">
          <xsl:call-template name="footer"/>
        </fo:static-content>
        <fo:flow flow-name="xsl-region-body">
          <xsl:apply-templates>
            <xsl:sort select="category"/>
            <xsl:sort select="h1"/>
          </xsl:apply-templates>
        </fo:flow>
      </fo:page-sequence>

    </fo:root>
  </xsl:template>

</xsl:stylesheet>
