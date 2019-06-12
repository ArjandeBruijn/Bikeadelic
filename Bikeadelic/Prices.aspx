<%@ Page Title="Prices" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Prices.aspx.cs" Inherits="Bikeadelic.Prices" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
     
    <script type="text/javascript">

        $(document).ready(function () {

            $.ajax({
                type: "POST",
                async: true,
                url: "Prices.aspx/GetPrices",
                data: '{}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {

                    var table = document.getElementById("priceTable");

                    var hdrRowWeekPart = table.insertRow(-1);

                    hdrRowWeekPart.style.borderBottom = '1px dotted #000';
 
                    hdrRowWeekPart.insertCell(-1);

                    var cell = hdrRowWeekPart.insertCell(-1);

                    cell.innerHTML = 'Weekday';
                     
                    var cellWeekendHdrCell = hdrRowWeekPart.insertCell(-1);

                    cellWeekendHdrCell.innerHTML = 'Weekend';

                    cellWeekendHdrCell.style.textAlign = 'center';

                    cellWeekendHdrCell.colSpan = 3;

                    var hdrRow = table.insertRow(-1);

                    hdrRow.style.borderBottom = '1px solid #000';

                    var hdrCellBikeName = hdrRow.insertCell(-1);

                    hdrCellBikeName.innerHTML = "Bike Model";

                    var hdrDayWeekDay = hdrRow.insertCell(-1);

                    hdrDayWeekDay.innerHTML = "Evening";

                    var hdrHalfDay = hdrRow.insertCell(-1);

                    hdrHalfDay.innerHTML = "Half day";

                    var hdrDay = hdrRow.insertCell(-1);

                    hdrDay.innerHTML = "Day";
                     
                    for (var i = 0; i < result.d.length; i++) {

                        var row = table.insertRow(-1);

                        var prices = result.d[i];

                        var nameCell = row.insertCell();

                        nameCell.innerHTML = prices.BikeName;

                        var eveningCell = row.insertCell();

                        eveningCell.innerHTML = prices.Evening;

                        var halfDayCell = row.insertCell();

                        halfDayCell.innerHTML = prices.HalfDayWeekend;

                        var dayCell = row.insertCell();

                        dayCell.innerHTML = prices.DayWeekend;
                         
                    }


                },
                failure: function (response) {

                }
            });


        });


    </script>

    <div class="wrap">
        <div class="one50">
            
            <h2 >Rental</h2>

            <table id="priceTable" class="columnBorderTable"></table>

            <div>- Evening: weekdays from 4:00 PM to dusk</div>
            <div>- Half day: 9:00 AM to 2:00 PM or 2:00 PM to dusk</div>
            <div>- Day: 9:00 AM to dusk</div>
            
            <h2 >Delivery</h2>

            <div class="narrowOnLargeScreens">
                We charge a $25 flat fee for delivery.
          
            </div>


        </div>


        <div class="one50">

            
            <h2 >Boneshaker lessons</h2>

            <div >
                It is a well kept secret that riding a boneshaker is really pretty easy. 
                Most people will learn riding it within half an hour and spend just a bit more
                on learning how to get on and off. We have a couple of tools to make the learning 
                process a little easier for you. For example, we found that some people are helped 
                by starting off with our mini-boneshaker that rides a lot like a full sized boneshaker 
                but that has a break and allows you to reach the floor without jumping off.
                <br><br>
                If available, you can use the mini-boneshakers without extra charge when you 
                rent a full sized boneshaker.  
                <br><br>
                We will bring small benches to practice getting on and off as well. We will meet you in 
                Lee Martinez park and practice with you for a maximum of an hour with each rental.
                 
            </div>
            <img  src="Images/LeeMartinezPark.JPG" />
        </div>
    </div>


</asp:Content>
