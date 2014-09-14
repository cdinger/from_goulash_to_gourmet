<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">

  <xsl:template name="half-title">
    <fo:block font-size="32pt" span="all" text-align="center" margin-top="1.7in">
      From Goulash to Gourmet
    </fo:block>
  </xsl:template>

  <xsl:template name="cover">
    <fo:block span="all">
      <fo:external-graphic src='url("file:///Users/ding0057/Dropbox/betty_dinger_cookbook/fop/images/cover_front.png")' content-width="scale-to-fit" content-height="100%" width="100%" scaling="uniform"/>
    </fo:block>
  </xsl:template>

  <xsl:template name="cover-back">
    <fo:block span="all">
      <fo:external-graphic src='url("file:///Users/ding0057/Dropbox/betty_dinger_cookbook/fop/images/cover_back.png")' content-width="scale-to-fit" content-height="100%" width="100%" scaling="uniform"/>
    </fo:block>
  </xsl:template>

  <xsl:template name="coverdescription">
    <fo:block-container display-align="after">
      <fo:block break-before="page" span="all" linefeed-treatment="preserve" font-size="9pt">
        The front cover is a photo of Mother's personal recipe book.  Handwritten, mostly in Polish, it is a keepsake as precious as any family heirloom.

        The back cover is an example of the traditional Polish art form called <fo:inline font-style="italic">wycinanki</fo:inline>. Very detailed designs are traced on thin glossy paper, folded one or more times, and then cut out.

        Poles are known for their hospitality, and nothing expresses Polish hospitality better than the traditional Polish greeting:
        "<fo:inline font-style="italic">Gość w Dom, Bog w Dóm</fo:inline>" (Guest in the house: God in the house)
      </fo:block>
    </fo:block-container>
  </xsl:template>

  <xsl:template name="dedication">
    <fo:block break-before="page" span="all" margin-right="1.5in" margin-left="1.5in" margin-top="1in">
      <fo:block font-size="12pt" margin-bottom=".1in">Dedication</fo:block>
      <fo:block font-style="italic" font-family="Constantia" text-align="justify">
        This cookbook is dedicated to the three women who influenced me most as I developed my cooking ability:
        my mother, Karolina Wojtowicz; my mother-in-law, Bertha Dinger; and my adopted mother-in-law, Val Ruchie.
        I also dedicate it to my husband, Fred, for always saying "Thank You" and telling me how good dinner was - even when it wasn't - and to my four children, Dave, Deb, Fred and Don, for "surviving" a lot of Goulash when times were hard and I had to stretch a pound of hamburger.  I love you all.
      </fo:block>
      <fo:block font-size="12pt" margin-top=".25in" text-align="right">- Betty Dinger (December 1999)</fo:block>
    </fo:block>
  </xsl:template>

  <xsl:template name="toc">
    <fo:block break-before="page" span="all" margin-left="2in" margin-right="2in">
      <fo:block font-size="16pt" text-align="center" margin-bottom=".25in">Table of Contents</fo:block>
      <xsl:for-each select="//recipe[not(category = preceding-sibling::recipe[1]/category)]/category">
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

  <xsl:template name="recipe" match="//recipe">
    <xsl:apply-templates/>
    <fo:block span="all" text-align="center" page-break-before="always" font-size="20pt" font-family="Britannic Bold" margin-bottom=".5in" id="{generate-id(.)}">
      <xsl:value-of select="./title" />
    </fo:block>

    <fo:block span="all" margin-bottom=".1in">
      INGREDIENTS:
    </fo:block>

    <xsl:for-each select="./ingredients">
      <xsl:choose>
        <xsl:when test="@title != ''">
          <fo:block keep-together="always">
            <fo:block text-transform="uppercase" font-size="11pt">
              <xsl:value-of select="@title" />
            </fo:block>
            <fo:list-block font-size="11pt" margin-bottom=".1in">
              <xsl:for-each select="ingredient">
                <fo:list-item>
                  <fo:list-item-label><fo:block></fo:block></fo:list-item-label>
                  <fo:list-item-body><fo:block><xsl:value-of select="." /></fo:block></fo:list-item-body>
                </fo:list-item>
              </xsl:for-each>
            </fo:list-block>
          </fo:block>
        </xsl:when>
        <xsl:otherwise>
          <fo:list-block font-size="11pt" margin-bottom=".1in">
            <xsl:for-each select="ingredient">
              <fo:list-item>
                <fo:list-item-label><fo:block></fo:block></fo:list-item-label>
                <fo:list-item-body><fo:block><xsl:value-of select="." /></fo:block></fo:list-item-body>
              </fo:list-item>
            </xsl:for-each>
          </fo:list-block>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>

    <fo:block span="all" margin-bottom=".1in" margin-top=".25in">
      PREPARATION:
    </fo:block>

    <fo:block span="all" linefeed-treatment="preserve">
      <xsl:value-of select="./instructions" />
    </fo:block>
  </xsl:template>

  <xsl:template name="index">
    <fo:block break-before="page">
      <fo:block font-size="16pt" span="all" border-bottom="solid .01in #000" margin-bottom=".1in">Index</fo:block>
      <xsl:for-each select="//recipe">
        <fo:block text-align-last="justify" font-size="10pt">
          <fo:basic-link internal-destination="{generate-id(.)}">
            <xsl:value-of select="title" />
            <fo:leader leader-pattern="dots" />
            <fo:page-number-citation ref-id="{generate-id(.)}" />
          </fo:basic-link>
        </fo:block>
      </xsl:for-each>
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
    <fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format" font-family="Adobe Garamond Pro">

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
          <xsl:call-template name="half-title"/>
          <xsl:call-template name="coverdescription"/>
          <xsl:call-template name="dedication"/>
          <xsl:call-template name="toc"/>
        </fo:flow>
      </fo:page-sequence>

      <fo:page-sequence master-reference="Ahalf" id="{generate-id(.)}">
        <fo:static-content flow-name="xsl-region-after">
          <xsl:call-template name="footer"/>
        </fo:static-content>
        <fo:flow flow-name="xsl-region-body">
          <xsl:apply-templates/>
          <xsl:call-template name="index"/>
          <!--<xsl:call-template name="cover-back"/>-->
        </fo:flow>
      </fo:page-sequence>

    </fo:root>
  </xsl:template>

</xsl:stylesheet>
