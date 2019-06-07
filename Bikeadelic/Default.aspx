<%@ Page Title="Home" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Bikeadelic._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">


    <div style="width: 100%; float: left;">
        <h1 style="font-family: Jokerman; color: darkorange;">Welcome to our menagerie of mechanical mayhem!  We rent anything that's wheeled and weird...  
        </h1>
    </div>

    <div class="wrapper">
        <img class="logoImage" style="width: 50%; border: none;" src="Images/Logo.png" />
    </div>

    <div class="wrap">

        <div class="two60 wrapper" style="width: 100%; padding: 20px">

            <div class="centered">

                <img id ="FrontPagePhoto" style="border: none;   margin: 0px"
                    src="Images/FrontPageFamilyPicture.jpg" />
            </div>
             
            Bikeadelics-rentals is an exciting new family business to rent out 
                unconventional bikes.  We are based in Fort Collins but we will drop off 
                the bikes you reserve online anywhere in Fort Collins.  
                You can rent any combination of available bicycles or the whole fleet with 
                trailer for a party or festival. 
        </div>

        <div class="one40">

            <p style="font-family: Impact">Cosmo Quiz</p>

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
             
        </div>


    </div>



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
