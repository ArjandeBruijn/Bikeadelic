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

                    hdrDayWeekDay.innerHTML = "Day";

                    var hdrHalfDay = hdrRow.insertCell(-1);

                    hdrHalfDay.innerHTML = "Half day";

                    var hdrDay = hdrRow.insertCell(-1);

                    hdrDay.innerHTML = "Day";

                    var hdrClass = hdrRow.insertCell(-1);

                    hdrClass.innerHTML = "Class";

                    for (var i = 0; i < result.d.length; i++) {

                        var row = table.insertRow(-1);

                        var prices = result.d[i];

                        var nameCell = row.insertCell();

                        nameCell.innerHTML = prices.BikeName;

                        var dayWeekdayCell = row.insertCell();

                        dayWeekdayCell.innerHTML = prices.DayWeekDay;

                        var halfDayCell = row.insertCell();

                        halfDayCell.innerHTML = prices.HalfDayWeekend;

                        var dayCell = row.insertCell();

                        dayCell.innerHTML = prices.DayWeekend;

                        var dayClass = row.insertCell();

                        dayClass.innerHTML = prices.Class;

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

            <div>- Half day: 9:00 AM to 2:00 PM or 2:00 PM to 7:00 PM</div>
            <div>- Day: 9:00 AM to 7:00 PM</div>
            <div>- Class: instruction each Saturday from 9:00 AM to 10:00 AM in East Side Park, included 4 hours rental (10:00 AM to 2:00 PM)</div>
        </div>
        <div class="one50">

            <h2 >Delivery</h2>

            <div class="narrowOnLargeScreens">
                We charge a $25 flat fee for delivery.
         

            </div>

        </div>
    </div>


</asp:Content>
