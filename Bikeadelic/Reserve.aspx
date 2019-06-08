<%@ Page Title="Reserve" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Reserve.aspx.cs" Inherits="Bikeadelic.Book" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <script src="Calendar.js"></script>

    <script type="text/javascript">

        var InventoryGroups = null;

        var ClearSelectedDates = function () {

            var calendar = document.getElementById('calendar');

            for (var d = 0; d < calendar.dayCells.length; d++) {

                var dayCell = calendar.dayCells[d];

                dayCell.classList.remove('gradgreen');

                dayCell.classList.remove('gradwhitegreen');

                dayCell.classList.remove('gradgreenwhite');

            }

        }
         
        var InitializeDayPartSelection = function () {

             
            if (selectedDateCell.classList.contains('gradred')) {
                return;
            }

            document.getElementById('selectMorningAfternoon').style.display = '';
            document.getElementById('selectMorningAfternoon').style.visibility = 'visible';

            document.getElementById('dayPartDay').style.visibility = 'visible';
            document.getElementById('dayPartAfternoon').style.visibility = 'visible';
            document.getElementById('dayPartMorning').style.visibility = 'visible';

            document.getElementById('cbdayPartclear').checked = '';
            document.getElementById('cbdayPartAfternoon').checked = '';
            document.getElementById('cbdayPartDay').checked = '';
            document.getElementById('dayPartMorning').checked = '';

            var dayAbbr = selectedDateCell.DayOfTheWeek;

            var isWeekDay = dayAbbr != 'Sat' && dayAbbr != 'Sun';

            if (selectedDateCell != null) {
                if (selectedDateCell.classList.contains('gradwhitered') ||
                    selectedDateCell.classList.contains('gradredwhite')) {

                    document.getElementById('dayPartDay').style.visibility = 'collapse';

                }
                if (selectedDateCell.classList.contains('gradwhitered')
                    || isWeekDay) {

                    document.getElementById('dayPartAfternoon').style.visibility = 'collapse';

                }
                if (selectedDateCell.classList.contains('gradredwhite')
                    || isWeekDay) {

                    document.getElementById('dayPartMorning').style.visibility = 'collapse';
                }
                if (selectedDateCell.classList.contains('gradgreen')) {
                    document.getElementById('dayPartDay').style.visibility = 'collapse';
                }
                else if (selectedDateCell.classList.contains('gradwhitegreen')) {
                    document.getElementById('dayPartAfternoon').style.visibility = 'collapse';
                }
                else if (selectedDateCell.classList.contains('gradgreenwhite')) {
                    document.getElementById('dayPartMorning').style.visibility = 'collapse';
                }

            }
              
        }
        var GetCellSelection = function (dateCell) {

            for (var s = 0; s < selection.length; s++) {

                if (selection[s].date == dateCell.id) {

                    SelectDayPart(dateCell, selection[s].dayPart);
                }

            }
        }
        var UpdateInventoryGroup = function (id, value) {

            var bikeId  = id.split("_")[0];

            var modelId  = id.split("_")[1];

            for (var ig = 0; ig < InventoryGroups.length; ig++) {
 
                var inventoryGroup = InventoryGroups[ig];

                if (inventoryGroup.BikeId == bikeId && inventoryGroup.ModelId == modelId)
                {
                    inventoryGroup.Wanted = value;
                }

            }

        }
        var GetBikeAvailabilityInfo = function () {

            var name = document.getElementById("Name") != null ?
                document.getElementById("Name").value : null;

            var email = document.getElementById("Email") != null ?
                document.getElementById("Email").value :
                null;

            var phone = document.getElementById("Phone") != null ?
                document.getElementById("Phone").value :
                null;

            var selectionOrNull = selection.length > 0 ?
                selection :
                null;
             
            var dropoffLocation = document.getElementById("dropOffLocationTextArea") != null ?
                document.getElementById("dropOffLocationTextArea").value : null;

            var deliveryRequested = document.getElementById("deliveryOptionSelect") == null ?
                false : document.getElementById("deliveryOptionSelect").value =='dropoff';

            var data = JSON.stringify({
                inventoryGroups: InventoryGroups,
                dateSelection: selectionOrNull,
                name: name,
                email: email,
                phone: phone,
                deliveryRequested:deliveryRequested,
                dropoffLocation: dropoffLocation,
                startDate: calendar.firstDay,
                endDate: calendar.lastDay
            });

            return data;

        }
        var homeAddress = "515 Cowan Street 80524 Fort Collins, CO";

        var GetReservationInfo = function () {

            var name = document.getElementById("Name") != null ?
                document.getElementById("Name").value : null;

            var email = document.getElementById("Email") != null ?
                document.getElementById("Email").value :
                null;

            var phone = document.getElementById("Phone") != null ?
                document.getElementById("Phone").value :
                null;

            var selectionOrNull = selection.length > 0 ?
                selection :
                null;
             
            var dropoffLocation = document.getElementById("dropOffLocationTextArea") != null ?
                document.getElementById("dropOffLocationTextArea").value : null;

            var deliveryRequested = document.getElementById("deliveryOptionSelect") != null ?
                document.getElementById("deliveryOptionSelect").value =='dropoff' : null;
             
            var data = JSON.stringify({
                inventoryGroups: InventoryGroups,
                dateSelection: selectionOrNull,
                name: name,
                email: email,
                phone: phone,
                deliveryRequested: deliveryRequested,
                dropoffLocation: dropoffLocation
            });

            return data;
        }

        var MakeReservation = function () {
              
            var data = GetReservationInfo();

            $.ajax({
                type: "POST",
                async: true,
                url: "Reserve.aspx/MakeReservation",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: data,
                success: function (result) {

                    alert(result.d.Message);
                     
                    GetBikesAvailability();
                },
                failure: function (response) {

                    alert(result.d.Message);

                    GetBikesAvailability();
                }
            });


        }
        var GetBikesAvailability = function () {

            var data = GetBikeAvailabilityInfo();
             
            $.ajax({
                type: "POST",
                async: true,
                url: "Reserve.aspx/GetBikesAvailability",
                data: data,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {
                     
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

                        countCell.innerHTML = " <input style='padding: 1px;' id = " + inventoryGroup.BikeId + "_"+ inventoryGroup.ModelId +" type='number' value = " + inventoryGroup.Wanted + " min = 0 onchange= 'UpdateInventoryGroup(id, value); GetBikesAvailability();' max=" + inventoryGroup.Available + " />";

                        row.insertCell(-1);
                    }
                     
                    var dropOffRow = table.insertRow(-1);

                    var whereHdrCell = dropOffRow.insertCell(-1);

                    whereHdrCell.innerHTML = "<b>Where</b>"

                    var dropDownPicupCell = dropOffRow.insertCell(-1);

                    var selectDropDown = document.createElement('select');

                    selectDropDown.id = "deliveryOptionSelect";

                    var optionPickup = document.createElement('option');

                    optionPickup.value = 'pickup';

                    optionPickup.text = 'Pick Up';

                    selectDropDown.appendChild(optionPickup);

                    var optionDropOff = document.createElement('option');

                    optionDropOff.value = 'dropoff';

                    optionDropOff.text = 'Delivery';

                    selectDropDown.appendChild(optionDropOff);

                    dropDownPicupCell.appendChild(selectDropDown);

                    var ApplyPickupDropoffSelection = function (selectDropDown) {

                        var value = selectDropDown.selectedOptions[0].value;

                        var dropOffTextArea = document.getElementById('dropOffLocationTextArea');

                        if (value == 'pickup') {
                            dropOffTextArea.value = homeAddress;
                            dropOffTextArea.disabled = true;
                        }
                        else if (value == 'dropoff') {
                            dropOffTextArea.value = "";
                            dropOffTextArea.disabled = false;
                        }
                        if (result.d.DropoffLocation != null) {
                            dropOffTextArea.value = result.d.DropoffLocation;
                        }
                        if (result.d.DeliveryRequested ==true) {
                            selectDropDown.value = 'dropoff';
                        }
                    }

                    selectDropDown.onchange = function () {
                        ApplyPickupDropoffSelection(this);
                    }


                    var dropOffCell = dropOffRow.insertCell(-1);

                    dropOffCell.colSpan = "2";

                    var dropOffTextArea = document.createElement("textarea");
                    dropOffTextArea.id = "dropOffLocationTextArea";

                    dropOffTextArea.style.padding = "1px";
                    dropOffTextArea.style.width = "100%"
                    dropOffTextArea.style.height = '100px';
                    dropOffCell.appendChild(dropOffTextArea);

                    ApplyPickupDropoffSelection(selectDropDown);

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

                    pricesRentalCell.innerHTML =  '$' +result.d.AppointmentPrices.Rental;

                    var pricesDeliveryRow = table.insertRow(-1);

                    pricesDeliveryRow.insertCell(-1);
                     
                    var pricesDeliveryHdrCell = pricesDeliveryRow.insertCell(-1);

                    pricesDeliveryHdrCell.innerHTML = 'Delivery';
                     
                    var pricesDeliveryCell = pricesDeliveryRow.insertCell(-1);

                    pricesDeliveryCell.innerHTML = '$' +result.d.AppointmentPrices.Delivery;

                    var pricesTotalRow = table.insertRow(-1);

                    pricesTotalRow.insertCell(-1);

                    var pricesTotalRowHdr = pricesTotalRow.insertCell(-1);

                    pricesTotalRowHdr.innerHTML = 'Total';

                    var pricesTotalCell = pricesTotalRow.insertCell(-1);

                    pricesTotalCell.innerHTML = '$' + result.d.AppointmentPrices.Total;
                     
                    selectedDateCell = null;

                    var calendar = document.getElementById('calendar');

                    if (result.d.Message != null) {

                        var headerRow = calendar.insertRow(-1);

                        var selectHdrCell = headerRow.insertCell(-1)

                        selectHdrCell.innerHTML = result.d.Message;

                        return;
                    }
                    if (result.d.DateSelection != null)
                    {
                        selection = result.d.DateSelection;
                    }
                     
                    for (var d = 0; d < calendar.dayCells.length; d++) {

                        var dateCell = calendar.dayCells[d];

                        dateCell.classList.remove("gradwhitered");
                        dateCell.classList.remove("gradredwhite");
                        dateCell.classList.remove("gradred");
                        
                        if (selection != null)
                        {
                            for (var s = 0; s < selection.length; s++)
                            {
                                var sel = selection[s];

                                if (sel.date == dateCell.date)
                                {
                                    SelectDayPart(dateCell, selection.dayPart);
                                }
                             
                            }
                        }
                         
                        dateCell.onclick = function () {

                            selectedDateCell = this;

                            InitializeDayPartSelection();

                        };
                    }

                    for (var d = 0; d < result.d.AvailableDates.length; d++) {

                        var availability = result.d.AvailableDates[d];

                        var dateCell = document.getElementById(availability.date);

                        if (dateCell == null) {
                            alert("datecell " + availability.date + "is null");
                        }
                        else {
                            if (availability.AvailableDayPartString == 'None') {
                                dateCell.classList.remove("gradgreen");
                                dateCell.classList.add("gradred");
                            }
                            else if (availability.AvailableDayPartString == 'Morning') {
                                dateCell.classList.remove("gradwhitegreen");
                                dateCell.classList.add("gradwhitered");
                            }
                            else if (availability.AvailableDayPartString == 'Afternoon') {
                                dateCell.classList.remove("gradgreenwhite");
                                dateCell.classList.add("gradredwhite");
                            }
                        }


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

            GetBikesAvailability();
        }

        var selection = [];

        var SelectDayPartAddToCollection = function (dateCell, dayPart) {


            SelectDayPart(dateCell, dayPart);


            if (dayPart == 'clear') {

                var newSelection = [];

                for (var s = 0; s < selection.length; s++) {

                    if (selection[s].date != dateCell.date.date) {

                        newSelection.push(selection[l]);
                    }
                }
                selection = newSelection;

            }
            else {
                selection.push({ Date: dateCell.id, DayPart: dayPart });
            }

            GetBikesAvailability();
             
        }

        var SelectDayPart = function (dateCell, dayPart) {

            if (dateCell == null) {
                return;
            }
            dateCell.classList.remove("gradgreenwhite");
            dateCell.classList.remove("gradwhitegreen");
            dateCell.classList.remove("gradgreen");

            if (dayPart == 'morning') {
                if (dateCell.classList.contains('gradwhitered')) {

                    dateCell.classList.remove('gradwhitered');
                    dateCell.classList.add("gradgreenred");

                }
                else {
                    dateCell.classList.add("gradgreenwhite")
                }

            }
            if (dayPart == 'afternoon') {

                if (dateCell.classList.contains('gradredwhite')) {

                    dateCell.classList.remove('gradredwhite');
                    dateCell.classList.add("gradredgreen");
                }
                else {

                    dateCell.classList.add("gradwhitegreen");
                }

            }
            if (dayPart == 'day') {

                dateCell.classList.add("gradgreen");

            }
            document.getElementById('selectMorningAfternoon').style.display = 'none';
        }
         

        $(document).ready(function () {

            InitializeCalendar('calendar');

            GetBikesAvailability();
             

        });

       


    </script>


    <table class="centered_div" id="selectMorningAfternoon" style="background-color: gray; visibility: collapse">


        <tr id="dayPartMorning">
            <td>
                <input id="cbdayPartMorning" name="dayPart" type="radio" onchange="SelectDayPartAddToCollection(selectedDateCell, 'morning')" /></td>
            <td>Morning (9:00 am to 2:00 pm)</td>
        </tr>
        <tr id="dayPartAfternoon">
            <td>
                <input id="cbdayPartAfternoon" name="dayPart" type="radio" onchange="SelectDayPartAddToCollection(selectedDateCell,'afternoon')" /></td>
            <td>Afternoon (2:00 pm to 7:00 pm)</td>
        </tr>
        <tr id="dayPartDay">
            <td>
                <input id="cbdayPartDay" name="dayPart" type="radio" onchange="SelectDayPartAddToCollection(selectedDateCell,'day')" /></td>
            <td>Full day (9:00 am to 7:00 pm)</td>
        </tr>

        <tr id="dayPartClear">
            <td>
                <input id="cbdayPartclear" name="dayPart" type="radio" onchange="SelectDayPartAddToCollection(selectedDateCell,'clear')" /></td>
            <td><i>Clear</i></td>
        </tr>


    </table>

    <div class="wrap">

        <div class="one50">
            <h2>Preferences and Information</h2>
            <table  id ="informationAndPreferencesTable"></table>
            
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
