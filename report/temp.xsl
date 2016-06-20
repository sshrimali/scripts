<xsl:stylesheet	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:output method="html" indent="yes" encoding="US-ASCII"/>
	<xsl:decimal-format decimal-separator="." grouping-separator="," />
	<!--
     The Apache Software License, Version 1.1

     Copyright (c) 2001-2002 The Apache Software Foundation.  All rights
     reserved.

     Redistribution and use in source and binary forms, with or without
     modification, are permitted provided that the following conditions
     are met:

     1. Redistributions of source code must retain the above copyright
        notice, this list of conditions and the following disclaimer.

     2. Redistributions in binary form must reproduce the above copyright
        notice, this list of conditions and the following disclaimer in
        the documentation and/or other materials provided with the
        distribution.

     3. The end-user documentation included with the redistribution, if
        any, must include the following acknowlegement:
           "This product includes software developed by the
            Apache Software Foundation (http://www.apache.org/)."
        Alternately, this acknowlegement may appear in the software itself,
        if and wherever such third-party acknowlegements normally appear.

     4. The names "The Jakarta Project", "Ant", and "Apache Software
        Foundation" must not be used to endorse or promote products derived
        from this software without prior written permission. For written
        permission, please contact apache@apache.org.

     5. Products derived from this software may not be called "Apache"
        nor may "Apache" appear in their names without prior written
        permission of the Apache Group.

     THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESSED OR IMPLIED
     WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
     OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
     DISCLAIMED.  IN NO EVENT SHALL THE APACHE SOFTWARE FOUNDATION OR
     ITS CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
     SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
     LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
     USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
     ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
     OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT
     OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
     SUCH DAMAGE.
     ====================================================================

     This software consists of voluntary contributions made by many
     individuals on behalf of the Apache Software Foundation.  For more
     information on the Apache Software Foundation, please see
     <http://www.apache.org/>.
     -->

	<!--



     It creates a non-framed report that can be useful to send via
     e-mail or such.

     @author Stephane Bailliez <a href="mailto:sbailliez@apache.org"/>
     @author Erik Hatcher <a href="mailto:ehatcher@apache.org"/>

    -->
	<xsl:template match="/">
		<HTML>
			<HEAD>
				<title>Chegg test framework report</title>
				<script src="https://code.jquery.com/jquery-1.9.1.min.js">test </script>
				<script src="https://www.amcharts.com/lib/3/amcharts.js"> test</script>
				<script src="https://www.amcharts.com/lib/3/pie.js"> test </script>
				<script src="https://www.amcharts.com/lib/3/themes/light.js"> test </script>
				<script type="text/javascript">

					$(document).ready(function()
					{
					var listSize = document.getElementsByClassName("graphSuiteTotal").length;
					var result1 = document.getElementsByClassName("graphSuiteFailure")[1].innerHTML;

					console.log("listSize : " + listSize);
					var totalFailures=0;
					var data=[];
					for (var iterator=0;iterator<xsl:text disable-output-escaping="yes">&lt;</xsl:text>listSize;iterator++)
					{
						var suiteName=document.getElementsByClassName("graphSuiteName")[iterator].innerHTML;
						var failures=document.getElementsByClassName("graphSuiteFailure")[iterator].innerHTML;
						totalFailures=+totalFailures + +document.getElementsByClassName("graphSuiteFailure")[iterator].innerHTML;

					var stat= {suiteName: suiteName,failures: failures};

					data.push(stat);
					}
					console.log("Data : " + JSON.stringify(data));
					console.log("Data : " + data);


					var chart = AmCharts.makeChart( "chartdiv", {
					"type": "pie",
					"setLegendPosition" : "top center",
					"bezierX": 1,
					"theme": "light",
					"legends": "true",
					"dataProvider": data,
					"valueField": "failures",
					"titleField": "suiteName",
					"balloon":{
					"fixedPosition":true
					},
					"export": {
					"enabled": true
					}
					} );
					chart.setPiePosition(400,400);
					chart.draw();
					});
				</script>
				<style type="text/css">
					#chartdiv {
					width		: 800px;
					height		: 400px;
					font-size	: 10px;
					}
					body {
					font:normal 68% verdana,arial,helvetica;
					color:#000000;
					}
					table tr td, table tr th {
					font-size: 68%;
					}
					table.details tr th{
					font-weight: bold;
					text-align:left;
					background:#a6caf0;
					}
					table.details tr td{
					background:#eeeee0;
					}

					p {
					line-height:1.5em;
					margin-top:0.5em; margin-bottom:1.0em;
					}
					h1 {
					margin: 0px 0px 5px; font: 165% verdana,arial,helvetica
					}
					h2 {
					margin-top: 1em; margin-bottom: 0.5em; font: bold 125% verdana,arial,helvetica
					}
					h3 {
					margin-bottom: 0.5em; font: bold 115% verdana,arial,helvetica
					}
					h4 {
					margin-bottom: 0.5em; font: bold 100% verdana,arial,helvetica
					}
					h5 {
					margin-bottom: 0.5em; font: bold 100% verdana,arial,helvetica
					}
					h6 {
					margin-bottom: 0.5em; font: bold 100% verdana,arial,helvetica
					}
					.Error {
					font-weight:bold; color:red;
					}
					.Failure {
					font-weight:bold; color:purple;
					}
					.Properties {
					text-align:right;
					}
				</style>

			</HEAD>
			<body>
				<a name="top"></a>
				<xsl:call-template name="pageHeader"/>

				<!-- Summary part -->
				<xsl:call-template name="summary"/>
				<hr size="1" width="100%" align="left"/>

				<!-- Package List part -->
				<xsl:call-template name="packagelist"/>
				<hr size="1" width="100%" align="left"/>

				<!-- For each package create its part -->
				<!--<xsl:call-template name="packages"/>-->
				<hr size="1" width="100%" align="left"/>

				<!-- For each class create the  part -->
				<xsl:call-template name="classes"/>

			</body>
		</HTML>
	</xsl:template>



	<!-- ================================================================== -->
	<!-- Write a list of all packages with an hyperlink to the anchor of    -->
	<!-- of the package name.                                               -->
	<!-- ================================================================== -->
	<xsl:template name="packagelist">
		<h2>Test Suites</h2>
		<table class="details" border="0" cellpadding="5" cellspacing="2" width="100%">
			<xsl:call-template name="testsuite.test.header"/>
			<!-- list all packages recursively -->
			<!--<xsl:for-each select="/testsuite/testcase[not(@classname = current())]">-->
			<xsl:for-each select="/testsuite/testcase[not(@classname = following::testcase/@classname)]">
				<xsl:sort select="@classname"/>
				<xsl:variable name="testsuites-in-package" select="/testsuite/testcase[@classname = current()/@classname]"/>
				<xsl:variable name="testCount" select="count($testsuites-in-package)"/>
				<xsl:variable name="successCount" select="count($testsuites-in-package/info)"/>
				<xsl:variable name="errorCount" select="count($testsuites-in-package/error1)"/>
				<xsl:variable name="failureCount" select="count($testsuites-in-package/error)"/>
				<xsl:variable name="timeCount" select="sum($testsuites-in-package/@time)"/>

				<!-- write a summary for the package -->
				<tr valign="top">
					<!-- set a nice color depending if there is an error/failure -->
					<xsl:attribute name="class">
						<xsl:choose>
							<xsl:when test="$failureCount &gt; 0">Failure</xsl:when>
							<xsl:when test="$errorCount &gt; 0">Failure</xsl:when>
						</xsl:choose>
					</xsl:attribute>
					<td><a href="#{@classname}" class="graphSuiteName"><xsl:value-of select="substring-after(@classname,'freshen.noseplugin.')"/></a></td>
					<td class="graphSuiteTotal"><xsl:value-of select="$testCount"/></td>
					<td class="graphSuiteSuccess"><xsl:value-of select="$successCount"/></td>
					<td class="graphSuiteFailure"><xsl:value-of select="$failureCount"/></td>
					<td>
						<xsl:call-template name="display-time">
							<xsl:with-param name="value" select="$timeCount"/>
						</xsl:call-template>
					</td>
				</tr>
			</xsl:for-each>
		</table>
	</xsl:template>


	<!-- ================================================================== -->
	<!-- Write a package level report                                       -->
	<!-- It creates a table with values from the document:                  -->
	<!-- Name | Tests | Errors | Failures | Time                            -->
	<!-- ================================================================== -->
	<xsl:template name="packages">
		<!-- create an anchor to this package name -->
		<xsl:for-each select="/testsuite/testcase[not(@classname = following::testcase/@classname)]">
			<xsl:sort select="@classname"/>
			<a name="{@classname}"></a>
			<h3>Package <xsl:value-of select="@classname"/></h3>

			<table class="details" border="0" cellpadding="5" cellspacing="2" width="100%">
				<xsl:call-template name="testsuite.test.header"/>

				<!-- match the testsuites of this package -->
				<xsl:apply-templates select="/testsuite[./@package = current()/@package]" />
			</table>
			<a href="#top">Back to top</a>
			<p/>
			<p/>
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="classes">
		<xsl:for-each select="/testsuite/testcase[not(@classname = following::testcase/@classname)]">
			<xsl:sort select="@classname"/>
			<!-- create an anchor to this class name -->
			<a name="{@classname}"></a>
			<h3>TestSuite - <xsl:value-of select="substring-after(@classname,'freshen.noseplugin.')"/></h3>

			<table class="details" border="0" cellpadding="5" cellspacing="2" width="100%">
				<xsl:call-template name="testcase.test.header"/>
				<!--
                test can even not be started at all (failure to load the class)
                so report the error directly
                -->
				<!--<xsl:if test="./error">-->
				<!--<tr class="Failure">-->
				<!--<td colspan="4"><xsl:apply-templates select="./error"/></td>-->
				<!--</tr>-->
				<!--</xsl:if>-->
				<xsl:apply-templates select="/testsuite/testcase[@classname = current()/@classname]" />
			</table>

			<p/>

			<a href="#top">Back to top</a>
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="summary">
		<h2>Summary</h2>
		<xsl:variable name="testCount" select="sum(testsuite/@tests)"/>
		<xsl:variable name="successCount" select="count(testsuite/testcase/info)"/>
		<xsl:variable name="errorCount" select="sum(testsuite/@errors1)"/>
		<xsl:variable name="failureCount" select="sum(testsuite/@errors)"/>
		<xsl:variable name="timeCount" select="sum(testsuite/testcase/@time)"/>
		<xsl:variable name="successRate" select="($testCount - $failureCount - $errorCount) div $testCount"/>
		<table class="details" border="0" cellpadding="5" cellspacing="2" width="100%">
			<tr valign="top">
				<th>Tests</th>
				<th>Success</th>
				<th>Failures</th>
				<th>Errors</th>
				<th>Success rate</th>
				<th width="150px">Time(H:MM:SS)</th>
			</tr>
			<tr valign="top">
				<xsl:attribute name="class">
					<xsl:choose>
						<xsl:when test="$failureCount &gt; 0">Failure</xsl:when>
						<xsl:when test="$errorCount &gt; 0">Error</xsl:when>
					</xsl:choose>
				</xsl:attribute>
				<td><xsl:value-of select="$testCount"/></td>
				<td><xsl:value-of select="$successCount"/></td>
				<td><xsl:value-of select="$failureCount"/></td>
				<td><xsl:value-of select="$errorCount"/></td>
				<td>
					<xsl:call-template name="display-percent">
						<xsl:with-param name="value" select="$successRate"/>
					</xsl:call-template>
				</td>
				<td>
					<xsl:call-template name="display-time">
						<xsl:with-param name="value" select="$timeCount"/>
					</xsl:call-template>
				</td>

			</tr>
		</table>
		<table border="0" width="100%">
			<tr>
				<td	style="text-align: justify;">
					Note: <i>failures</i> are anticipated and checked for with assertions while <i>errors</i> are unanticipated.
				</td>
			</tr>
		</table>
	</xsl:template>

	<!--
     Write properties into a JavaScript data structure.
     This is based on the original idea by Erik Hatcher (ehatcher@apache.org)
     -->
	<xsl:template match="properties">
		cur = TestCases['<xsl:value-of select="../@package"/>.<xsl:value-of select="../@name"/>'] = new Array();
		<xsl:for-each select="property">
			<xsl:sort select="@name"/>
			cur['<xsl:value-of select="@name"/>'] = '<xsl:call-template name="JS-escape"><xsl:with-param name="string" select="@value"/></xsl:call-template>';
		</xsl:for-each>
	</xsl:template>

	<!-- Page HEADER -->
	<xsl:template name="pageHeader">

		<h1>Chegg Test Report</h1>
		<h2>Graphical Failure Analysis</h2>
		<div id="chartdiv" width="200px"> test </div>
		<hr size="1"/>
	</xsl:template>

	<xsl:template match="testsuite">
		<tr valign="top">
			<th width="80%">Name1</th>
			<th>Tests</th>
			<th>Success</th>
			<th>Errors</th>
			<th>Failures</th>
			<th nowrap="nowrap">Time(H:MM:SS)</th>
		</tr>
	</xsl:template>

	<!-- class header -->
	<xsl:template name="testsuite.test.header">
		<tr valign="top">
			<th width="80%">Name</th>
			<th>Tests</th>
			<th>Success</th>
			<th>Failures</th>
			<th nowrap="nowrap">Time(H:MM:SS)</th>
		</tr>
	</xsl:template>

	<!-- method header -->
	<xsl:template name="testcase.test.header">
		<tr valign="top">
			<th>Testcase</th>
			<th width="20%">Name</th>
			<th>Status</th>
			<th width="70%">Details</th>
			<th nowrap="nowrap">Time<br/>(H:MM:SS)</th>
		</tr>
	</xsl:template>


	<!-- class information -->
	<xsl:template match="testsuite" >
		<tr valign="top">
			<!-- set a nice color depending if there is an error/failure -->
			<xsl:attribute name="class">
				<xsl:choose>
					<xsl:when test="@failures[.&gt; 0]">Failure</xsl:when>
					<xsl:when test="@errors[.&gt; 0]">Error</xsl:when>
				</xsl:choose>
			</xsl:attribute>

			<!-- print testsuite information -->
			<td><a href="#{@name}"><xsl:value-of select="@name"/></a></td>
			<td><xsl:value-of select="@tests"/></td>
			<td><xsl:value-of select="@errors"/></td>
			<td><xsl:value-of select="@failures"/></td>
			<td>
				<xsl:call-template name="display-time">
					<xsl:with-param name="value" select="@time"/>
				</xsl:call-template>
			</td>
		</tr>
	</xsl:template>

	<xsl:template match="testcase" >
		<tr valign="top">
			<xsl:attribute name="class">
				<xsl:choose>
					<xsl:when test="failure | error">Failure</xsl:when>
				</xsl:choose>
			</xsl:attribute>
			<!--TODO-->
			<xsl:variable name="testID" select="substring-before(@name, ' ')"/>
			<td> <a href="https://chegg.testrail.com/index.php?/cases/view/{$testID}" target="_blank"><xsl:value-of select="$testID"/></a>  </td>
			<td width="50%"><xsl:value-of select="substring-after(@name, ' ')"/> </td>
			<xsl:choose>
				<xsl:when test="failure">
					<td>Failure</td>
					<td><xsl:apply-templates select="failure"/></td>
				</xsl:when>
				<xsl:when test="error">
					<td>Failure</td>
					<td>Screenshot : <br/><a href="./{@name} (before).png" target="_blank">Before</a>  <a style="float:right" href="./{@name} (after).png" target="_blank">After</a>
						<xsl:apply-templates select="error"/></td>
				</xsl:when>
				<xsl:otherwise>
					<td>Success</td>
					<td>Screenshot : <br/><a href="./{@name} (before).png" target="_blank">Before</a>  <a style="float:right" href="./{@name} (after).png" target="_blank">After</a></td>
				</xsl:otherwise>
			</xsl:choose>
			<td>
				<xsl:call-template name="display-time">
					<xsl:with-param name="value" select="@time"/>
				</xsl:call-template>
			</td>
		</tr>
	</xsl:template>


	<xsl:template match="failure">
		<xsl:call-template name="display-failures"/>
	</xsl:template>

	<xsl:template match="error">
		<xsl:call-template name="display-failures"/>
	</xsl:template>

	<!-- Style for the error and failure in the tescase template -->
	<xsl:template name="display-failures">
		<xsl:choose>
			<xsl:when test="not(text())">N/A</xsl:when>
			<xsl:otherwise>
				<!--<xsl:value-of select="text()"/>-->
			</xsl:otherwise>
		</xsl:choose>
		<!-- display the stacktrace -->
		<code>
			<p/>
			<xsl:call-template name="br-replace">
				<xsl:with-param name="word" select="."/>
			</xsl:call-template>
		</code>
		<!--the later is better but might be problematic for non-21" monitors... -->
		<!--pre><xsl:value-of select="."/></pre-->
	</xsl:template>

	<xsl:template name="JS-escape">
		<xsl:param name="string"/>
		<xsl:choose>
			<xsl:when test="contains($string,&quot;'&quot;)">
				<xsl:value-of select="substring-before($string,&quot;'&quot;)"/>\&apos;<xsl:call-template name="JS-escape">
				<xsl:with-param name="string" select="substring-after($string,&quot;'&quot;)"/>
			</xsl:call-template>
			</xsl:when>
			<xsl:when test="contains($string,'\')">
				<xsl:value-of select="substring-before($string,'\')"/>\\<xsl:call-template name="JS-escape">
				<xsl:with-param name="string" select="substring-after($string,'\')"/>
			</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$string"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>


	<!--
        template that will convert a carriage return into a br tag
        @param word the text from which to convert CR to BR tag
    -->
	<xsl:template name="br-replace">
		<xsl:param name="word"/>

		<xsl:choose>
			<xsl:when test="contains($word,'ERROR')">

				<xsl:choose>
					<xsl:when test="contains($word,'&#xA;')">
						<xsl:value-of select="substring-before($word,'&#xA;')"/>
						<br/>
						<xsl:call-template name="br-replace">

							<xsl:with-param name="word" select="substring-after($word,'&#xA;')"/>
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$word"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
		</xsl:choose>

	</xsl:template>

	<xsl:template name="display-time">
		<xsl:param name="value"/>

		<xsl:value-of select="floor($value div 3600)" />

		<xsl:variable name="r" select="$value mod 3600"/>
		<xsl:value-of select="format-number(floor($r div 60), ':00')"/>
		<xsl:value-of select="format-number($r mod 60, ':00')"/>
	</xsl:template>

	<xsl:template name="display-percent">
		<xsl:param name="value"/>
		<xsl:value-of select="format-number($value,'0.00%')"/>
	</xsl:template>

</xsl:stylesheet>

