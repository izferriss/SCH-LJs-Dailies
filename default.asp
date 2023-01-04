<!--#include file="includes/main.asp" -->
<% Sub Title %>
    LJ's Soups
<% End Sub %>

<% Sub Includes %>
    <link rel="stylesheet" href="css/main.css">
    <script>
        let datalines = [];
        let slideTimer = 7500; //in ms
    </script>
<% End Sub %>

<% Sub Content %>
    <!-- reads data to array -->
    <%
        fname = "admin/data.txt"

        set FSO_R = Server.CreateObject("Scripting.FileSystemObject")
        set F_R = FSO_R.OpenTextFile(Server.MapPath("admin\data.txt"), 1)

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
    <DIV class="hidden">
        <a href="admin/form.asp">hidden</a>
    </DIV>
    <DIV class="wrapper">
        <DIV class="admin">
            
        </DIV>
        <DIV class="carousel">
            <script>
                //flag in case all entries are blank
                var blank = true;

                for(var i = 0; i < datalines.length; i++)
                {
                    if(datalines[i].substring(datalines[i].indexOf(":") + 2) != "blank" && datalines[i].substring(0, datalines[i].indexOf(":") - 1) == "soup")
                    {
                        document.write("<DIV class=\"slide soup\"><h2>Soup of the Day</h2><span>" + datalines[i].substring(datalines[i].indexOf(":") + 2) + "</span></DIV>");
                        blank = false;
                    }
                    if(datalines[i].substring(datalines[i].indexOf(":") + 2) != "blank" && datalines[i].substring(0, datalines[i].indexOf(":")) == "special")
                    {
                        document.write("<DIV class=\"slide special\"><h2>Daily Special</h2><span>" + datalines[i].substring(datalines[i].indexOf(":") + 2) + "</span></DIV>");
                        blank = false;
                    }
                    if(datalines[i].substring(datalines[i].indexOf(":") + 2) != "blank" && datalines[i].substring(0, datalines[i].indexOf(":")) == "wing")
                    {
                        document.write("<DIV class=\"slide wing\"><h2>Wing of the Week</h2><span>" + datalines[i].substring(datalines[i].indexOf(":") + 2) + "</span></DIV>");
                        blank = false;
                    }
                }
                if(blank)
                {
                    document.write("<DIV class=\"slide empty\"><h2>Attention</h2><span>No specials!</span></DIV>");
                }

                // Select all slides
                const slides = document.querySelectorAll(".slide");

                // loop through slides and set each slides translateX property to index * 100% 
                slides.forEach((slide, indx) => {
                slide.style.transform = `translateX(${indx * 100}%)`;
                });

                // current slide counter
                let curSlide = 0;
                
                // maximum number of slides
                let maxSlide = slides.length - 1;

                // add event listener and next slide functionality
                setInterval(() => 
                {
                    if(curSlide == maxSlide)
                    {
                        curSlide = 0;
                    }
                    else
                    {
                        curSlide++;
                    }

                    slides.forEach((slide, indx) => 
                    {
                        slide.style.transform = `translateX(${100 * (indx - curSlide)}%)`;
                    });
                }, slideTimer);
            </script>
        </DIV>
    </DIV>
<% End Sub %>