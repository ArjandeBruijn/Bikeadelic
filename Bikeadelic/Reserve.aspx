<%@ Page Title="Reserve" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Reserve.aspx.cs" Inherits="Bikeadelic.Book" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <script src="Calendar.js"></script>

    <script type="text/javascript">

        var selectedDateCell = null;
         
        var InventoryGroups = null;
         
        var InitializeDayPartSelection = function () {

            if (selectedDateCell.AvailableDayPartString=="") {
                return;
            }

            document.getElementById('selectMorningAfternoon').style.display = '';
            document.getElementById('selectMorningAfternoon').style.visibility = 'visible';

            document.getElementById('dayPartDay').style.visibility = 'visible';
            document.getElementById('dayPartAfternoon').style.visibility = 'visible';
            document.getElementById('dayPartMorning').style.visibility = 'visible';
            document.getElementById('dayPartEvening').style.visibility = 'visible';
             
            document.getElementById('cbdayPartEvening').checked = '';
            document.getElementById('cbdayPartAfternoon').checked = '';
            document.getElementById('cbdayPartDay').checked = '';
            document.getElementById('cbdayPartMorning').checked = '';

            if (selectedDateCell.AvailableDayPartString.includes('Evening') == false)
            {
                document.getElementById('dayPartEvening').style.visibility = 'collapse';
            }
            if (selectedDateCell.AvailableDayPartString.includes('Day') == false)
            {
                 document.getElementById('dayPartDay').style.visibility = 'collapse';
            }
            if (selectedDateCell.AvailableDayPartString.includes('Afternoon') == false)
            {
                 document.getElementById('dayPartAfternoon').style.visibility = 'collapse';
            }
            if (selectedDateCell.AvailableDayPartString.includes('Morning') == false)
            {
                 document.getElementById('dayPartMorning').style.visibility = 'collapse';
            }
              
        }
         
        var UpdateInventoryGroup = function (id, value) {

            var bikeId = id.split("_")[0];

            var modelId = id.split("_")[1];

            for (var ig = 0; ig < InventoryGroups.length; ig++) {

                var inventoryGroup = InventoryGroups[ig];

                if (inventoryGroup.BikeId == bikeId && inventoryGroup.ModelId == modelId) {
                    inventoryGroup.Wanted = value;
                }

            }

        }
        var GetBikeAvailabilityInfo = function (makeReservation) {

            var name = document.getElementById("Name") != null ?
                document.getElementById("Name").value : null;

            var email = document.getElementById("Email") != null ?
                document.getElementById("Email").value :
                null;

            var phone = document.getElementById("Phone") != null ?
                document.getElementById("Phone").value :
                null;

            var selectedDate = selectedDateCell != null ?
                selectedDateCell.id:
                null;

            var selectedDayPart = selectedDateCell != null ?
                selectedDateCell.SelectedDayPart : null;

            var data = JSON.stringify({
                makeReservation: makeReservation,
                inventoryGroups: InventoryGroups,
                selectedDate: selectedDate,
                selectedDayPart:selectedDayPart,
                name: name,
                email: email,
                phone: phone,
                startDate: calendar.firstDay,
                endDate: calendar.lastDay
            });

            return data;

        }
         
        

        var MakeReservation = function () {

            GetBikesAvailability(true);
             
        }
        var GetBikesAvailability = function (makeReservation) {

            var data = GetBikeAvailabilityInfo(makeReservation);

            $.ajax({
                type: "POST",
                async: true,
                url: "Reserve.aspx/GetBikesAvailability",
                data: data,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {

                    if (makeReservation) {
                        selectedDateCell = null;
                    }

                    var table = document.getElementById("informationAndPreferencesTable");

                    table.innerHTML = '';

                    InventoryGroups = result.d.Inventory;

                    for (var i = 0; i < InventoryGroups.length; i++) {

                        var inventoryGroup = InventoryGroups[i];

                        var row = table.insertRow(-1);

                        var bikeNameHdrCell = row.insertCell(-1);

                        if (i == 0) {
                            bikeNameHdrCell.innerHTML = "<b>What</b>"
                        }

                        var nameCell = row.insertCell(-1);

                        nameCell.innerHTML = inventoryGroup.Name;

                        nameCell.style.paddingRight = "0.2em";

                        var modelCell = row.insertCell(-1);

                        modelCell.innerHTML = inventoryGroup.Model;

                        modelCell.style.paddingRight = "0.2em";

                        var countCell = row.insertCell(-1);

                        countCell.innerHTML = " <input style='padding: 1px;' id = " + inventoryGroup.BikeId + "_" + inventoryGroup.ModelId + " type='number' value = " + inventoryGroup.Wanted + " min = 0  onchange= 'UpdateInventoryGroup(id, value); GetBikesAvailability(false);' max= " + inventoryGroup.Available + " />";

                        row.insertCell(-1);
                    }

                    var nameInfoRow = table.insertRow(-1);

                    var contactHdrCell = nameInfoRow.insertCell(-1);

                    contactHdrCell.innerHTML = "<b>Who</b>";

                    var nameInfoRowHdrCell = nameInfoRow.insertCell(-1);

                    nameInfoRowHdrCell.innerHTML = 'Name';

                    var nameInfoRowCell = nameInfoRow.insertCell(-1);

                    var inputField = document.createElement('input');
                    inputField.id = 'Name';
                    inputField.style = "padding: 1px; type='text' width: 100%";

                    if (result.d.Name != null) {
                        inputField.value = result.d.Name;
                    }

                    nameInfoRowCell.appendChild(inputField);

                    nameInfoRowCell.colSpan = '2';

                    var contactInfoRow = table.insertRow(-1);

                    contactInfoRow.insertCell(-1);

                    var emailHdrCell = contactInfoRow.insertCell(-1);

                    emailHdrCell.innerHTML = "Email";

                    var emailCell = contactInfoRow.insertCell(-1);

                    emailCell.colSpan = '2';

                    var inputFieldEmail = document.createElement('input');
                    inputFieldEmail.id = 'Email';
                    inputFieldEmail.style = "padding: 1px; type='text' width: 100%";

                    if (result.d.Email != null) {
                        inputFieldEmail.value = result.d.Email;
                    }

                    emailCell.appendChild(inputFieldEmail);

                    var phoneRow = table.insertRow(-1);

                    phoneRow.insertCell(-1);

                    var phoneHdrCell = phoneRow.insertCell(-1);

                    phoneHdrCell.innerHTML = "Phone";

                    var phoneCell = phoneRow.insertCell(-1);

                    phoneCell.colSpan = '2';

                    var inputFieldPhone = document.createElement('input');
                    inputFieldPhone.id = 'Phone';
                    inputFieldPhone.style = "padding: 1px; type='text' width: 100%";

                    if (result.d.Phone != null) {
                        inputFieldPhone.value = result.d.Phone;
                    }

                    phoneCell.appendChild(inputFieldPhone);
                     
                    var pricesRentalRow = table.insertRow(-1);

                    var pricesRowHdr = pricesRentalRow.insertCell(-1);

                    pricesRowHdr.innerHTML = '<b>Price</b>';

                    var pricesRentalHdrCell = pricesRentalRow.insertCell(-1);

                    pricesRentalHdrCell.innerHTML = 'Rental';

                    var pricesRentalCell = pricesRentalRow.insertCell(-1);

                    pricesRentalCell.innerHTML = '$' + result.d.Price;

                    var pricesDeliveryRow = table.insertRow(-1);

                    pricesDeliveryRow.insertCell(-1);
                      
                    var calendar = document.getElementById('calendar');
                     
                    for (var d = 0; d < calendar.dayCells.length; d++) {

                        var dateCell = calendar.dayCells[d];
                         
                        dateCell.onclick = function () {
                             
                            selectedDateCell = this;
                             
                            InitializeDayPartSelection();

                        };
                    }

                    for (var d = 0; d < result.d.AvailableDates.length; d++) {

                        var availability = result.d.AvailableDates[d];

                        var dateCell = document.getElementById(availability.date);

                        dateCell.AvailableDayPartString = availability.AvailableDayPartString;

                        if (dateCell == null) {
                            alert("datecell " + availability.date + "is null");
                        }
                        else {
                            SetDateCellColor(dateCell);
                        }
                         
                    }
                    if (result.d.Message != null) {

                        alert(result.d.Message);
                         
                    }
                },
                failure: function (response) {

                    var timeSlotsTable = document.getElementById('calendar');

                    while (timeSlotsTable.firstChild) {
                        timeSlotsTable.removeChild(timeSlotsTable.firstChild);
                    }

                    var headerRow = timeSlotsTable.insertRow(-1);

                    var selectHdrCell = headerRow.insertCell(-1)

                    selectHdrCell.innerHTML = response;
                }
            });

        }
        var GetWithTwoNumbers = function (number) {
            return (number < 10 ? '0' : '') + number;
        }
        var GetDatestring = function (date) {

            var month = date.getMonth() + 1;

            var day = date.getDate();

            var dateString = date.getFullYear() + "-" + GetWithTwoNumbers(month) + "-" + GetWithTwoNumbers(day);

            return dateString;
        }
        var UpdateCalendar = function (direction) {

            ChangeMonth('calendar', direction);

            GetBikesAvailability(false);
        }
          
        var SetDateCellColor = function (dateCell) {

            if (dateCell == null) {
                return;
            }
            dateCell.classList.remove("gradgreenwhite");
            dateCell.classList.remove("gradwhitegreen");
            dateCell.classList.remove("gradgreen");

            dateCell.classList.remove('gradwhitered');
            dateCell.classList.remove('gradredwhite');
            dateCell.classList.remove('gradred');

            var isSelectedDateCell = selectedDateCell == dateCell;
            
            if (dateCell.AvailableDayPartString.includes('Day')) {
                if (isSelectedDateCell) {
                    if (dateCell.SelectedDayPart == "Afternoon" ||
                        dateCell.SelectedDayPart == "Evening") {
                        dateCell.classList.add("gradwhitegreen");
                    }
                    else if (dateCell.SelectedDayPart == "Morning") {
                        dateCell.classList.add("gradgreenwhite");
                    }
                    else {
                        dateCell.classList.add("gradgreen");
                    }
                    
                }
            }
            else if (dateCell.AvailableDayPartString.includes('Morning')) {
                if (isSelectedDateCell) {
                    dateCell.classList.add("gradgreenred")
                }
                else {
                    dateCell.classList.add("gradwhitered");
                }
            }
            else if (dateCell.AvailableDayPartString.includes('Afternoon') ||
                dateCell.AvailableDayPartString.includes('Evening')) {

                if (isSelectedDateCell) {
                    dateCell.classList.add("gradredgreen");
                }
                else {
                    dateCell.classList.add("gradredwhite");
                }
            }
            else if(dateCell.AvailableDayPartString==""){
                 dateCell.classList.add("gradred");
            }
        }


        $(document).ready(function () {

            InitializeCalendar('calendar');

            GetBikesAvailability(false);
             
        });

        var HandleSelectMorningAfterNoonRadioSelection = function (selectedDayPart)
        {
            selectedDateCell.SelectedDayPart = selectedDayPart;

            SetDateCellColor(selectedDateCell);

            document.getElementById('selectMorningAfternoon').style.display = 'none';

            GetBikesAvailability(false);
        }



    </script>


    <table class="centered_div" id="selectMorningAfternoon" style="background-color: gray; visibility: collapse">

        
        <tr id="dayPartMorning">
            <td>
                <input id="cbdayPartMorning" name="dayPart" type="radio" onchange="HandleSelectMorningAfterNoonRadioSelection('Morning')" /></td>
            <td>Morning (9:00 am to 2:00 pm)</td>
        </tr>

        <tr id="dayPartAfternoon">
            <td>
                <input id="cbdayPartAfternoon" name="dayPart" type="radio" onchange="HandleSelectMorningAfterNoonRadioSelection('Afternoon')" /></td>
            <td>Afternoon (2:00 pm to 7:00 pm)</td>
        </tr>
        <tr id="dayPartEvening">
            <td>
                <input id="cbdayPartEvening" name="dayPart" type="radio" onchange="HandleSelectMorningAfterNoonRadioSelection('Evening')" /></td>
            <td>Evening (4:00 pm to dusk)</td>
        </tr>
        <tr id="dayPartDay">
            <td>
                <input id="cbdayPartDay" name="dayPart" type="radio" onchange="HandleSelectMorningAfterNoonRadioSelection('Day')" /></td>
            <td>Full day (9:00 am to 7:00 pm)</td>
        </tr>
         

    </table>

    <div class="wrap">

        <div class="one50">
            <h2>Preferences and Information</h2>
            <table id="informationAndPreferencesTable"></table>

        </div>

        <div class="one50">
            <h2>Calendar</h2>

            <table>
                <tr>
                    <td>
                        <input value="<<" type="button" onclick="UpdateCalendar('previous')" />
                    </td>
                    <td>
                        <div id="month"></div>
                    </td>
                    <td>
                        <input value=">>" type="button" onclick="UpdateCalendar('next')" />
                    </td>
                </tr>
            </table>

            <table id="calendar"></table>

            <input type="button" value="Book!" style="min-width: 200px; margin: 0px; color: yellow; width: 50px; background-color: red" onclick="MakeReservation()" />
        </div>

    </div>




</asp:Content>
