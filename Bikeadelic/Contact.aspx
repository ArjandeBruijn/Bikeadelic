<%@ Page Title="Contact" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="Bikeadelic.Contact" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
      
    <table style ="width:80%; margin:15px 0px 0px 0px" >
         
        <colgroup>
            <col span="1" style="width:20%;">
            <col span="1" style="width:80%;">
        </colgroup>

        <tr>
            <td  >
                <label for="firstName">First Name</label>
            </td>
            <td >
                <input type="text" style="min-width: 100%" id="firstName" name="firstName" placeholder="Your name.." />
            </td>
        </tr>

        <tr>
            <td  >
                <label for="lastName">Last Name</label>
            </td>
            <td >
                <input type="text" style="min-width: 100%" id="lastName" name="lastname" placeholder="Your last name..">
            </td>
        </tr>

        <tr>
            <td  >
                <label for="email">Email</label>
            </td>
            <td >
                <input type="text" style="min-width: 100%"; id="emailAddress" name="email" placeholder="Your email..">
            </td>
        </tr>

        <tr>
            <td  >
                <label for="phone">Phone Number</label>
            </td>
            <td >
                <input type="text" style="min-width: 100%" id="phoneNumber" name="phoneNumber" placeholder="Your phone.." />
            </td>
        </tr>

        <tr>
            <td  >
                <label for="Message">Message</label>
            </td>
            <td >
                <textarea id="Message" name="Message" placeholder="Write something.." style="height: 200px; min-width: 100%"></textarea>
            </td>
        </tr>

        <tr>
            <td  colspan="2">
                <div onclick="submitContactMessage()" style="color: yellow; width: 100%; font-size: 35px; line-height: 2em; text-align: center; height: 80px; background-color: red" >Submit!</div>
            </td>
        </tr>

    </table>



    <script type="text/javascript">

        var submitContactMessage = function () {

            var firstName = $('#firstName').val();
            var lastName = $('#lastName').val();
            var message = $('#Message').val();
            var emailAddress = $('#emailAddress').val();
            var phoneNumber = $('#phoneNumber').val();

            $.ajax({
                type: "POST",
                async: false,
                url: "Contact.aspx/SendContactEmail",
                data: '{firstName: "' + firstName + '" , lastName: "' + lastName + '", message: "' + message + '", emailAddress: "' + emailAddress + '", phoneNumber: "' + phoneNumber + '"}',
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
