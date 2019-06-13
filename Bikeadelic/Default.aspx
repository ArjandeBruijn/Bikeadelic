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

    <table style="width: 100%; table-layout: fixed">

        <tr>
            <td style="width:40%"></td>
            <td style="width:60%"></td>
             
        </tr>

        <tr>


            <td style="background-color: white">
                <img id="FrontPagePhoto" style="width: 100%; border: none; margin: 0px"
                    src="Images/FrontPageFamilyPicture.jpg" />

                Bikeadelics-rentals is a family business. 

            </td>
            <td style="padding-left:20px; background-color: white">

                <h2>Boneshaker lessons</h2>

                <div>
                    Most people will learn to ride a boneshaker within half an hour and spend a bit more time
                on learning how to get on and off. We have a couple of tools to make the learning 
                process a little easier for you. For example, we found that some people are helped 
                by starting off with our mini-boneshaker that rides a lot like a full sized boneshaker 
                but that has a break and allows you to reach the floor without jumping off.
                <br>
                    <br>
                    If available, you can use the mini-boneshakers without extra charge when you 
                rent a full sized boneshaker.  
                <br>
                    <br>
                    We will bring small benches to practice getting on and off as well. We will meet you in 
                Lee Martinez park and practice with you for a maximum of an hour with each rental.
                 
                </div>
                <img style="float:right; width: 70%" src="Images/LeeMartinezPark.JPG" />


            </td>
        </tr>
        <tr>
            <td style="column-span: 2">

                <h2>Cosmo Quiz</h2>

            Are you:

                <br>

            <ol type="a">
                <li>An on-the-go person?</li>
                <li>Fun-loving?</li>
                <li>The type who likes to challenge yourself?</li>
                <li>The first of your friends to try the weirdest gadgets?</li>
                <li>Wondering how to get girls/guys/non-binaries to notice you?</li>
                <li>A non-conformist with a conformist bicycle? </li>
                <li>Hoping to up your game for Tour de Fat with a bike so cool it doesn't need decorating?</li>
                <li>Looking for awesome selfies?</li>
            </ol>

            Answers: 
                     (a)-(g): you are perfect for trying out one of our bikes!
                    (h) selfies are not advised when riding a bicycle, so this may not be for you.  
                    We would like both you and the bike to come back intact.  But maybe you 
                    could talk someone into taking your picture…

            </td>
            <td>
                 
            </td>
        </tr>
    </table>



    <div class="wrapper">
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
