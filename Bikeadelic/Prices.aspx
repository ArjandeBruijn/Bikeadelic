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
             

        </div>


        
    </div>


</asp:Content>
