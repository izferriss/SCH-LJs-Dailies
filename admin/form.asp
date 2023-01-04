<!--#include virtual="ljsoups/includes/main.asp" -->
<% Sub Title %>
    Soup Form
<% End Sub %>

<% Sub Includes %>
    <link rel="stylesheet" href="../css/main.css">
    <script>
        let datalines = [];
    </script>
<% End Sub %>

<% Sub Content %>
    <%
    Response.Write "Current User: " & Request.ServerVariables("LOGON_USER")
    fname = "data.txt"
    set FSO_R = Server.CreateObject("Scripting.FileSystemObject")
    set F_R = FSO_R.OpenTextFile(Server.MapPath(fname), 1)

    response.Write("<script>")
    Do Until F_R.AtEndOfStream
        line = F_R.ReadLine
        Response.Write("datalines.push('" & line & "');")
    Loop
    response.Write("</script>")

    F_R.Close
    set F_R = nothing
    set FSO_R = nothing

    %>
    <DIV class="wrapper">
    <H1>LJ's Soups and Specials Admin Form</H1>
        <FORM id="soups" method="get" action="processform.asp">
            <SPAN class="label">
                <label for="soup1">Soup of the Day #1:</label>
            </SPAN>
            <input type="text" id="soup1" name="soup1"><br>

            <SPAN class="label">
                <label for="soup2">Soup of the Day #2:</label>
            </SPAN>
            <input type="text" id="soup2" name="soup2"><br>

            <SPAN class="label">
                <label for="soup3">Soup of the Day #3:</label>
            </SPAN>
            <input type="text" id="soup3" name="soup3"><br>

            <SPAN class="label">
                <label for="special">Daily Special:</label>
            </SPAN>
            <input type="text" id="special" name="special"><br>

            <SPAN class="label">
                <label for="special">Wing of the Week:</label>
            </SPAN>
            <input type="text" id="wing" name="wing"><br><br>

            <input type="submit" value="Submit">

            <BR><BR>
            <A HREF="//webservices/ljsoups/">Customer View</A>
        </FORM>
    </DIV>
<% End Sub %>

<script>
    //populates form with existing data
    window.onload = function()
    {
        var soup1 = document.getElementById("soup1");
        var soup2 = document.getElementById("soup2");
        var soup3 = document.getElementById("soup3");
        var special = document.getElementById("special");
        var wing = document.getElementById("wing");

        soup1.value = datalines[0].substring(datalines[0].indexOf(":") + 2);
        soup2.value = datalines[1].substring(datalines[1].indexOf(":") + 2);
        soup3.value = datalines[2].substring(datalines[2].indexOf(":") + 2);
        special.value = datalines[3].substring(datalines[3].indexOf(":") + 2);
        wing.value = datalines[4].substring(datalines[4].indexOf(":") + 2);
    }
</script>