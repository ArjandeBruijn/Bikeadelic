﻿<%@ Page Title="Home" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Bikeadelic._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    

    <div style="width: 100%; float: left;">
        <h1 style="font-family: Jokerman; color: darkorange;">Welcome to our menagerie of mechanical mayhem! 
            We rent out penny farthings and other weird bikes.
        </h1>
    </div>

    <div class="wrapper">
        <img class="logoImage" style="width: 50%; border: none;" src="Images/Logo.jpg" />
    </div>
        
    <div style="width: 100%; background-color: white">

         <!--
         <span  class="circle-text" style="display: inline; margin:10px; float: right; background-color: white">
            <div>We are looking for feedback and we now give you a 50% discount if you fill in our survey</div>
        </span>
        -->

        <h2>We are:</h2>

        Bikeadelic-rentals.com is our small business to rent out cool and weird bicycles. 
        We currently have <a href="/Bikes">Penny Farthing replicas and glide cycles</a> 

        <br><br>
        
        We rent them out on evenings and in the weekends. In most cases we will de able to deliver them to any 
        location in the Fort Collins area.  We will be able to show you how to ride the bikes and practice with 
        you untill you are comfortable to take them out on this awesome trail system that our city has. 
         
         
        <h2>Check it out!</h2>

        We are currently doing FREE biweekly Penny Farthing rides. The way it works: 
        We meet at a city park in Fort Collins, you borrow a penny farthing from us, we practice with you until you are comfortable and we visit a brewery on the bikes, have a beer and ride back. 
        We have a variety of sizes that can fit most people. We also welcome kids (8+) to try our mini-penny farthing. 
        Please RSVP if you want to come. The next ride is August 17.

    </div>

    <div style="width: 100%;min-height: 600px; background-color: white">

        <iframe class="fb-review" src="https://www.facebook.com/plugins/post.php?href=https%3A%2F%2Fwww.facebook.com%2FBikeadelic%2Fposts%2F2275444759435917&width=500" ;style="border:none;overflow:hidden" scrolling="no" frameborder="0" allowTransparency="true" allow="encrypted-media"></iframe>
        
        
        <span id ="FrontPagePhoto"  style="height:600px; display: inline; margin:10px; float: left; background-color: white">
            <img   style="width:100%; border: none; margin: 0px"
                src="Images/FrontPageFamilyPicture.jpg" />
            Bikeadelic-rentals is a family business. 
        </span>
         
        <h2>Are you:</h2>
         
            a. An on-the-go person?<br>
            b. Fun-loving?<br>
            c. The type who likes to challenge yourself?<br>
            d. The first of your friends to try the weirdest gadgets?<br>
            e. Looking for a team building exercise?<br>
            f. Hoping to up your game for Tour de Fat with a bike so cool it doesn't need decorating?<br>
            g. Looking for awesome selfies?<br>
            

         
        <br>
        Answers: 
                     (a)-(g): you are perfect for trying out one of our bikes!
                    (h) selfies are not advised when riding a bicycle, so this may not be for you.  
                    We would like both you and the bike to come back intact.  But maybe you 
                    could talk someone into taking your picture…
         
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
