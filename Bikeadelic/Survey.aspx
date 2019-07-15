<%@ Page Title="Questionaire" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Survey.aspx.cs" Inherits="Bikeadelic.Questionaire" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div style="width: 100%; height: 10%"></div>

    <div id ='largeImageDisplay'></div>

    <table id ="questionaireTable" style="width: 100%; margin: 15px 0px 0px 0px">

        <colgroup>
            <col span="1" style="width: 5%;">
            <col span="1" style="width: 40%;">
            <col span="1" style="width: 55%;">
        </colgroup>

        <tr>
            <td colspan="2"><b>Please tell us a little about yourself:</b>
            </td>
        </tr>

        <tr>
            <td></td>
            <td>Where do you hang out online?
            </td>
            <td>
                <input id="whereDoYouHangOutOnline" />
            </td>
        </tr>

        <tr>
            <td></td>
            <td>Favorite places to hang out around town?
            </td>
            <td>
                <input id="favoritePlacesToHangOutAroundTown" />
            </td>
        </tr>

        <tr>
            <td></td>
            <td>How likely are you to rent a weird bike?  
            </td>
            <td>
                <select id="HowLikelyAreYouToRentAWeirdBike">
                    <option>Please select...</option>
                    <option>never</option>
                    <option>perhaps…</option>
                    <option>maybe</option>
                    <option>likely</option>
                    <option>definitely!</option>
                </select>
            </td>
        </tr>

        <tr>
            <td></td>
            <td>Why would you or wouldn't you be interested?
            </td>
            <td>
                <input id="whyWouldYouOrWouldntYouBeInterested" />
            </td>
        </tr>

        <tr>
            <td></td>
            <td>Are our prices within your budget?
            </td>
            <td>
                <select id="AreOurPricesWithinYourBudget">
                    <option>Please select...</option>
                    <option>yes</option>
                    <option>no</option>
                </select>
            </td>
        </tr>

        <tr>
            <td colspan="2"><b>Your tastes:</b></td>
        </tr>

        <tr>
            <td></td>
            <td>What if anything do you dislike about our website? What would you change?
            </td>
            <td>
                <input id="whatDoYouDislikeAboutOurWebsite" />
            </td>
        </tr>

        <tr>
            <td></td>
            <td>Select the bikes that you would like to try out.
            </td>
            <td>
                <div style="border: 1px solid gray" id="bikesTable"></div>
            </td>
        </tr>

        <tr>
            <td colspan="2"><b>Desired arrangements:</b></td>
        </tr>
        <tr>
            <td></td>
            <td>Do you prefer to:
            </td>
            <td>
                <select id="deliverOrPickUp">
                    <option>Please select...</option>
                    <option>Have us bring the bike to you for a fee</option>
                    <option>Pick up the bike from us near Mulberry & Riverside</option>
                    <option>Pick it up from a park or brewery</option>
                    <option>Drop it off somewhere different from where you picked it up</option>
                </select>
            </td>
        </tr>

        <tr>
            <td></td>
            <td>Where would you like to ride?
            </td>
            <td>
                <select onchange="ShowTextFieldWhereWouldYouLikeToRide()" id="whereWouldYouLikeToRide">
                    <option>Please select...</option>
                    <option>Bike trails</option>
                    <option>Old town</option>
                    <option>CSU</option>
                    <option>Campus West</option>
                    <option>Parks</option>
                    <option>Other - please specify</option>
                </select>
            </td>
        </tr>

        <tr id="trAreaWhereToRide" style="display:none">
            <td></td>
            <td></td>
            <td>
                <textarea id="textAreaWhereToRide"  style="width:200px; height:100px" ></textarea>
            </td>
        </tr>

        <tr>
            <td></td>
            <td>How many hours would you like the bike for
            </td>
            <td>
                <select id ="howManyHoursWouldYouLikeTheBike">
                    <option>Please select...</option>
                    <option>0-2</option>
                    <option>2-4</option>
                    <option>4-6</option>
                    <option>6-8</option>
                    <option>>8</option>
                </select>
            </td>
        </tr>

        <tr>
            <td></td>
            <td colspan="4">How many  people would be in your party in each of the following age categories?
            </td>
        </tr>

        <tr>
            <td></td>
            <td></td>
            <td >
                <table  id ="ageselectiontable" class="ageSelectionTable" style="width:30%;  margin: 0px">
                    <colgroup>
                        <col span="1" style="width: 50%;">
                        <col span="1" style="width: 50%;">
                    </colgroup>
                    <tr>
                        <td>0-1</td>
                        <td>
                            <input min="0", id = 'ageselectiontable0_1', style="min-width: 0%; width:50px" type="number" />
                        </td>
                    </tr>
                    <tr>
                        <td>2-5</td>
                        <td>
                            <input id = 'ageselectiontable2_5', style="min-width: 0%; width:50px" type="number" /></td>
                    </tr>
                    <tr>
                        <td>6-10</td>
                        <td>
                            <input id = 'ageselectiontable6_10', style="min-width: 0%; width:50px" type="number" /></td>
                    </tr>
                    
                    <tr>
                        <td>11-15 </td>
                        <td>
                            <input id = 'ageselectiontable11_15' style="min-width: 0%; width:50px" type="number" /></td>
                    </tr>
                   
                    <tr>
                        <td>16-20 </td>
                        <td>
                            <input id = 'ageselectiontable16_20' style="min-width: 0%; width:50px" type="number"/></td>
                    </tr>
                    <tr>
                        <td>21-35 </td>
                        <td>
                            <input id = 'ageselectiontable21_35' style="min-width: 0%; width:50px" type="number"/>
                        </td>
                    </tr>
                    <tr>
                        <td>36-50 </td>
                        <td>
                            <input id = 'ageselectiontable36_50' style="min-width: 0%; width:50px" type="number"/>
                        </td>
                    </tr>
                    <tr>
                        <td>>50 </td>
                        <td>
                            <input id = 'ageselectiontableOver_51' style="min-width: 0%; width:50px" type="number" /></td>
                    </tr>
                </table>
            </td>
        </tr>

        <tr>
            <td></td>
            <td>If you would like 50% off on a rental,
                or to hear about new bikes, events, 
                special offers, etc., please tell us your email.
            </td>
            <td>
                <input id ="emailAddress"/> 
            </td>
        </tr>
        
        <tr>
            <td></td>
            <td>Please indicate a frequency you would be interested to receive an email
            </td>
            <td>
                <select id ="HowManyTimesAYearEmail">
                    <option>Please select...</option>
                    <option>never (50% off ride only)</option>
                    <option>weekly</option>
                    <option>monthly</option>
                    <option>one or two times per year</option>
                </select>
            </td>
        </tr>

        <tr>
            <td colspan="4">
                <input value="Submit!" type="button" onclick="submitQuestionaire()" style="color: yellow; width: 100%; font-size: 35px; line-height: 2em; text-align: center; height: 80px; background-color: red" />
            </td>
        </tr>

    </table>



    <script type="text/javascript">

        var ShowTextFieldWhereWouldYouLikeToRide = function ()
        {
            var whereWouldYouLikeToRide = document.getElementById('whereWouldYouLikeToRide').value;

            var element = document.getElementById('trAreaWhereToRide');

            if (whereWouldYouLikeToRide == "Other - please specify") {

                element.style.display = '';
            }
            else {
                element.style.display = 'none';
            }
             
        }

        var bikeCheckBoxIds = [];

        $(document).ready(function () {

            $.ajax({
                type: "POST",
                async: true,
                data: '{}',
                url: "Survey.aspx/GetBikes",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {

                    var bikesTable = document.getElementById("bikesTable");

                    var bikes = result.d;

                    var wrapDiv = null;

                    for (var b = 0; b < bikes.length; b++) {
                         
                        if (bikes[b].Name == 'Karbike') continue;
                        if (bikes[b].Name == 'Burley Trailer') continue;
                        if (bikes[b].Name == 'Mini Penny Farthing') continue;
                         
                        if (wrapDiv == null) {

                            wrapDiv = document.createElement("div");

                            wrapDiv.classList += "wrap";
                        }

                        var bikeItemDiv = document.createElement("div");

                        bikeItemDiv.bikeItem = bikes[b];

                        bikeItemDiv.classList += "one33";

                        bikeItemDiv.style.margin = "5px 5px 5px 5px";

                        wrapDiv.appendChild(bikeItemDiv);

                        var headerDiv = document.createElement("div");

                        headerDiv.style.width = "100%";

                        var checkBoxId = "check_" + bikeItemDiv.bikeItem.Id;

                        bikeCheckBoxIds.push(checkBoxId);

                        headerDiv.innerHTML =
                            '<input type="checkbox" style =" min-width: 10%" id= "' + checkBoxId + '" name="check' + bikeItemDiv.bikeItem.Name + '"><label for="check' + bikeItemDiv.bikeItem.Name + '">' + bikeItemDiv.bikeItem.Name + '</label>';

                        bikeItemDiv.appendChild(headerDiv);

                        var img = document.createElement("img");

                        img.style.width = "100%";
                         
                        img.src = bikeItemDiv.bikeItem.PictureUrl;

                        img.onclick = function () {

                            var imgLarge = document.createElement("img");

                            imgLarge.onclick = function () {
                                this.parentElement.innerHTML = '';

                                var questionaireTable = document.getElementById('questionaireTable');

                                questionaireTable.style.display = '';

                            }

                            imgLarge.style.width = "100%";

                            imgLarge.src = this.src;

                            var largeImageDisplay =
                                document.getElementById('largeImageDisplay');

                            largeImageDisplay.appendChild(imgLarge);

                            var questionaireTable = document.getElementById('questionaireTable');

                            questionaireTable.style.display = 'none';
                             
                        };

                        bikeItemDiv.appendChild(img);

                        if (wrapDiv.children.length == 3 || b == bikes.length-1) {

                            bikesTable.appendChild(wrapDiv);

                            wrapDiv = null;
                        }
                        
                    }

                },
                failure: function (response) {

                }
            });

        });

        var submitQuestionaire = function () {

            var whereDoYouHangOutOnline = document.getElementById('whereDoYouHangOutOnline').value;

            var favoritePlacesToHangOutAroundTown = document.getElementById('favoritePlacesToHangOutAroundTown').value;

            var HowLikelyAreYouToRentAWeirdBike = document.getElementById('HowLikelyAreYouToRentAWeirdBike').value;

            var whyWouldYouOrWouldntYouBeInterested = document.getElementById('whyWouldYouOrWouldntYouBeInterested').value;

            var AreOurPricesWithinYourBudget = document.getElementById('AreOurPricesWithinYourBudget').value;

            var whatDoYouDislikeAboutOurWebsite = document.getElementById('whatDoYouDislikeAboutOurWebsite').value;

            var deliverOrPickUp = document.getElementById('deliverOrPickUp').value;

            var whereWouldYouLikeToRide = document.getElementById('whereWouldYouLikeToRide').value;

            if (whereWouldYouLikeToRide == "Other - please specify") {

                var textAreaWhereWouldYouLikeToRide =
                    document.getElementById('textAreaWhereToRide');

                whereWouldYouLikeToRide = textAreaWhereWouldYouLikeToRide.value;
            }
             
            var howManyHoursWouldYouLikeTheBike = document.getElementById('howManyHoursWouldYouLikeTheBike').value;

            var emailAddress = document.getElementById('emailAddress').value;
            
            var howManyTimesAYearEmail= document.getElementById('HowManyTimesAYearEmail').value;

            var ageselectiontable0_1 = document.getElementById('ageselectiontable0_1').value;

            var ageselectiontable2_5 = document.getElementById('ageselectiontable2_5').value;

            var ageselectiontable6_10 = document.getElementById('ageselectiontable6_10').value;

            var ageselectiontable11_15 = document.getElementById('ageselectiontable11_15').value;
             
            var ageselectiontable16_20 = document.getElementById('ageselectiontable16_20').value;

            var ageselectiontable21_35 = document.getElementById('ageselectiontable21_35').value;

            var ageselectiontable36_50 = document.getElementById('ageselectiontable36_50').value;

            var ageselectiontableOver_51 = document.getElementById('ageselectiontableOver_51').value;

             
            var ageselectiontable = JSON.stringify({
                AGE0TO1: ageselectiontable0_1,
                AGE2TO5: ageselectiontable2_5,
                AGE6TO10: ageselectiontable6_10,
                AGE11TO15: ageselectiontable11_15,
                AGE16TO20: ageselectiontable16_20,
                AGE21TO35: ageselectiontable21_35,
                AGE36TO50: ageselectiontable36_50,
                AGEOVER51: ageselectiontableOver_51
            });
             
            var jsonStrings = [];

            for (var id = 0; id < bikeCheckBoxIds.length; id++) {

                var checkBoxId = bikeCheckBoxIds[id];
                 
                var checkBox = document.getElementById(checkBoxId);

                if (checkBox != null) {
                    var value = checkBox.checked;
                     
                    if (id < bikeCheckBoxIds.length - 1) {
                        jsonStrings.push(checkBoxId + ":" + value + ",");
                    }
                    else {
                        jsonStrings.push(checkBoxId +":"+ value);
                    }
                }
                 
            }
            var bikeSelectionResults = JSON.stringify({
                jsonStrings
            });
             
            var jsonData = JSON.stringify({
                WhereDoYouHangOutOnline: whereDoYouHangOutOnline,
                FavoritePlacesToHangOutAroundTown: favoritePlacesToHangOutAroundTown,
                HowLikelyAreYouToRentAWeirdBike: HowLikelyAreYouToRentAWeirdBike,
                WhyWouldYouOrWouldntYouBeInterested: whyWouldYouOrWouldntYouBeInterested,
                AreOurPricesWithinYourBudget: AreOurPricesWithinYourBudget,
                WhatDoYouDislikeAboutOurWebsite: whatDoYouDislikeAboutOurWebsite,
                DeliverOrPickUp: deliverOrPickUp,
                WhereWouldYouLikeToRide: whereWouldYouLikeToRide,
                HowManyHoursWouldYouLikeTheBike: howManyHoursWouldYouLikeTheBike,
                Ageselectiontable: ageselectiontable,
                BikeSelectionResults: bikeSelectionResults,
                EmailAddress: emailAddress,
                HowManyTimesAYearEmail : howManyTimesAYearEmail
            });

            $.ajax({
                type: "POST",
                async: false,
                url: "Survey.aspx/SubmitQuestionaire",
                data: jsonData,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {

                    alert(result.d);

                },
                failure: function (result) {
                    alert(result.d);
                }


            });
        }
    </script>





</asp:Content>
