<%@ Page Title="Bikes" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Bikes.aspx.cs" Inherits="Bikeadelic.Bikes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">


    <script type="text/javascript">
         
        $(document).ready(function () {

            $.ajax({
                type: "POST",
                async: true,
                data: '{}',
                url: "Bikes.aspx/GetActiveBikes",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {

                    var bikesTable = document.getElementById("bikesTable");

                    var bikes = result.d;

                    var wrapDiv = null;

                    for (var b = 0; b < bikes.length; b++) {

                        if (wrapDiv == null) {

                            wrapDiv = document.createElement("div");

                            wrapDiv.classList += "wrap";
                        }

                        var bikeItemDiv = document.createElement("div");

                        bikeItemDiv.bikeItem = bikes[b];
                         
                        bikeItemDiv.classList += "one33";

                        bikeItemDiv.style.margin = "5px 5px 5px 5px";
                         
                        wrapDiv.appendChild(bikeItemDiv);

                        var titleDiv = document.createElement("div");

                        titleDiv.style.width = "100%";

                        titleDiv.innerHTML="<b>" + bikeItemDiv.bikeItem.Name + "</b>" ;

                        bikeItemDiv.appendChild(titleDiv);

                        var img = document.createElement("img");

                        img.style.width = "100%";

                        img.src = bikeItemDiv.bikeItem.PictureUrl;

                        bikeItemDiv.appendChild(img);

                        var divText = document.createElement("div");

                        bikeItemDiv.appendChild(divText);

                        divText.innerHTML = bikeItemDiv.bikeItem.Description;

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

    </script>

    <div id="rowPrototype" style="visibility: hidden">
    </div>

    <div id="bikesTable" onclick="ShowDisplayTableHideBikesTable()"></div>

     



</asp:Content>
