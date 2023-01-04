<!--#include virtual="ljsoups/includes/main.asp" -->

<% Sub Title %>
    Soup Form Results
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
    dim FSO_W, F_W, FSO_R, F_R, line, soup1, soup2, soup3, special, wing
    fname = "data.txt"

    set FSO_W = Server.CreateObject("Scripting.FileSystemObject")
    
    'create file if it doesn't exist and open for writing
    set F_W = FSO_W.OpenTextFile(Server.MapPath(fname), 2, true)

    'Process form for soup1
    if Request.QueryString("soup1") = "" then
        soup1 = "blank"
    else
        soup1 = Request.QueryString("soup1")
    end if

    'Process form for soup2
    if Request.QueryString("soup2") = "" then
        soup2 = "blank"
    else
        soup2 = Request.QueryString("soup2")
    end if

    'Process form for soup3
    if Request.QueryString("soup3") = "" then
        soup3 = "blank"
    else
        soup3 = Request.QueryString("soup3")
    end if

    'Process form for special
    if Request.QueryString("special") = "" then
        special = "blank"
    else
        special = Request.QueryString("special")
    end if

    'Process form for wing
    if Request.QueryString("wing") = "" then
        wing = "blank"
    else
        wing = Request.QueryString("wing")
    end if

    F_W.WriteLine("soup1: " & soup1)
    F_W.WriteLine("soup2: " & soup2)
    F_W.WriteLine("soup3: " & soup3)
    F_W.WriteLine("special: " & special)
    F_W.WriteLine("wing: " & wing)

    F_W.Close
    set F_W = nothing
    set FSO_W = nothing

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
        <H1>Results</H1>
        <B style="color: red">Click "Customer View" and confirm changes.</B>
        <BR>
        <script>
            for(var i = 0; i < datalines.length; i++)
            {
                document.write("<SPAN class=\"label\"><B>" + datalines[i].substring(0, datalines[i].indexOf(":")) + "</B>" + datalines[i].substring(datalines[i].indexOf(":")) +"</SPAN><BR>");
            }
        </script>
        <BR>
        <A HREF="//webservices/ljsoups/admin/form.asp">Back to Form</A><BR>
        <A HREF="//webservices/ljsoups/">Customer View</A>
    </DIV>
<% End Sub %>

