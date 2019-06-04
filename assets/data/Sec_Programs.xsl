<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:template match="/">
    <html>
      <head>
        <style>
          body {
            font-family: Arial, Helvetica, sans-serif;
            font-size: 14px;
          }
          div {
            margin-left: 150px;
            margin-right: 20px;
            margin-top: 50px;
            width: 80%;
          }
          h1 {
            font-size: 24px;
            color: #F00;
          }
          .headings {
            background-color: #06F;
            text-align: left;
          }
          .data {
            background-color: #6F9;
          }
          .table {
            width: 100%;
            text-align: left;
          }
          .program {
            margin-left: 150px;
            margin-right: 20px;
            margin-top: 50px;
            width: 80%;
          }
        </style>
      </head>
      <body>
        <div>
          <h1>Programs</h1>

          <xsl:for-each select="Programs/Program">
            <div class="program">
              <table class="headings">
                <tr class="data">
                  <th><xsl:value-of select="Name"/></th>
                  <th><xsl:value-of select="License"/></th>
                </tr>
                <tr>
                  <td><xsl:value-of select="URL"/></td>
                </tr>
              </table>

              <table>
                <tr>
                  <th>Description:</th>
                  <td><xsl:value-of select="Description"/></td>
                </tr>
                <tr>
                  <th>Installation:</th>
                  <td><xsl:value-of select="Installation"/></td>
                </tr>
                <tr>
                  <th>Example:</th>
                  <td><xsl:value-of select="Example"/></td>
                </tr>
              </table>

            </div>
          </xsl:for-each>
        </div>
      </body>
    </html>
  </xsl:template>

</xsl:stylesheet>
