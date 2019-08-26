<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Calendar.aspx.cs" Inherits="Bikeadelic.Calendar" %>



<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <script src="Calendar.js"></script>

   <script>

       var GetCalendarEvents = function () {

            var calendar = document.getElementById('calendar');
             
            var json = JSON.stringify({ date: calendar.currentMonth });

            $.ajax({
                type: "POST",
                async: true,
                url: "Calendar.aspx/GetCalendarEvents",
                data: json,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {

                    ClearCalendar('calendar');

                    var dates = result.d.Content;

                    
                        
                },
                failure: function (response) {

                    alert(response.d);
                }
            });

        }


       var UpdateCalendar = function (direction) {

            ChangeMonth('calendar', direction);
            
            GetCalendarEvents();
        }

       $('document').ready(function () {

            InitializeCalendar('calendar');
             
        });


   </script>

    <br>
    <br>

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


</asp:Content>
