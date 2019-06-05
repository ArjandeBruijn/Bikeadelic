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

                    hdrRowWeekPart.insertCell(-1);

                    var cell = hdrRowWeekPart.insertCell(-1);

                    cell.innerHTML = 'Week';
                     
                    var cellWeekendHdrCell = hdrRowWeekPart.insertCell(-1);

                    cellWeekendHdrCell.innerHTML = 'Weekend';

                    cellWeekendHdrCell.style.textAlign = 'center';

                    cellWeekendHdrCell.colSpan = 2

                    var hdrRow = table.insertRow(-1);

                    var hdrCellBikeName = hdrRow.insertCell(-1);

                    hdrCellBikeName.innerHTML = "Bike Model";

                    var hdrDayWeekDay = hdrRow.insertCell(-1);

                    hdrDayWeekDay.innerHTML = "Day";

                    var hdrHalfDay = hdrRow.insertCell(-1);

                    hdrHalfDay.innerHTML = "Half day";

                    var hdrDay = hdrRow.insertCell(-1);

                    hdrDay.innerHTML = "Day";

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

            <div>- Half day: any time frame that does not cross noon</div>
            <div>- Day: any time frame that does cross noon</div>

        </div>
        <div class="one50">

            <h2 >Delivery</h2>

            <div class="narrowOnLargeScreens">
                We charge a $25 base fee for delivery.
        
                We further charge $1.00 delivery fee for each mile 
                that Google Maps says is between your delivery location and 
                our our business adress at 
                515 Cowan Street 80524 in Fort Collins. 
                If your pickup location is different from your delivery location 
                then we use the location farthest away from our business address.
                We do not charge mileage within Fort Collins 
                Old Town area.

            </div>

        </div>
    </div>


</asp:Content>
