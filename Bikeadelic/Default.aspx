<%@ Page Title="Home" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Bikeadelic._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">


    <div style="width: 100%; float: left;">
        <h1 style="font-family: Jokerman; color: darkorange;">Welcome to our menagerie of mechanical mayhem! 
            We rent out boneshakers and other weird bikes.
        </h1>
    </div>

    <div class="wrapper">
        <img class="logoImage" style="width: 50%; border: none;" src="Images/Logo.jpg" />
    </div>


    <div style="width: 100%;min-height: 750px; background-color: white">

        <span  style="display: inline; margin:10px; width: 30%; float: left; background-color: white">
            <img id="FrontPagePhoto" style="border: none; margin: 0px"
                src="Images/FrontPageFamilyPicture.jpg" />
            Bikeadelics-rentals is a family business. 
        </span>

        <h2>Cosmo Quiz</h2>

            Are you:


            a. An on-the-go person?<br>
            b. Fun-loving?<br>
            c. The type who likes to challenge yourself?<br>
            d. The first of your friends to try the weirdest gadgets?<br>
            e. Wondering how to get girls/guys/non-binaries to notice you?<br>
            f. Hoping to up your game for Tour de Fat with a bike so cool it doesn't need decorating?<br>
            g. Looking for awesome selfies?<br>
            

         
        <br>
        Answers: 
                     (a)-(g): you are perfect for trying out one of our bikes!
                    (h) selfies are not advised when riding a bicycle, so this may not be for you.  
                    We would like both you and the bike to come back intact.  But maybe you 
                    could talk someone into taking your picture…

       

        <h2>Boneshaker lessons</h2>

           Most people will learn to ride a boneshaker within half an hour and spend a bit more time
                on learning how to get on and off.
        
        <span style="display: inline;  float: right; background-color: blue">
           <img style="width:300px" src="Images/LeeMartinezPark.JPG" />
        </span>
        
        
        We have a couple of tools to make the learning 
                process a little easier for you. 

       <br>
        <br>

        


            For example, we found that some people are helped 
                by starting off with our mini-boneshaker that rides a lot like a full sized boneshaker 
                but that has a break and allows you to reach the floor without jumping off.
                
                <br>
            
          <br>
            If available, you can use the mini-boneshakers without extra charge when you 
            rent a full sized boneshaker.We will bring small benches to practice getting on and off as well. We will meet you in 
            Lee Martinez park and practice with you with each rental.

   

        

      
         
        
         

    </div>



    <div class="wrapper" style="width: 100%">
        <img id="centered" style="width: 100px" src="Images/Quote/Top.png" />
        <p id="quote" style="border-bottom: groove; border-top: groove"></p>
        <img style="width: 100px" src="Images/Quote/Bottom.png" />
    </div>

    <script type="text/javascript">

        $(document).ready(function () {

            $.ajax({
                type: "POST",
                async: true,
                data: '{}',
                url: "Default.aspx/GetRandomQuote",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {
                    var quoteElement = document.getElementById('quote');

                    quoteElement.innerHTML = result.d;
                },
                failure: function (response) {

                }
            });


        });

    </script>



</asp:Content>
