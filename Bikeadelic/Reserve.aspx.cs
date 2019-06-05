using Newtonsoft.Json;
using SendEmail;
using StrollAndRollDataAccess;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Services;
using System.Web.UI.WebControls;

namespace Bikeadelic
{
    public partial class Book : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        private static DateTime GetDateFromJavaScriptDate(string javascriptDate)
        {

            int year = Convert.ToInt32(javascriptDate.Substring(0, 4));

            int month = Convert.ToInt32(javascriptDate.Substring(5, 2));

            int day = Convert.ToInt32(javascriptDate.Substring(8, 2));

            DateTime date = new DateTime(year, month, day);

            return date;
        }
        
        [WebMethod]
        public static BikesAvailability
           GetBikesAvailability(List<InventoryGroup> inventoryGroups,
            object name,
            object email,
            object phone,
            string dropoffLocation,
           string startDate,
           string endDate,
           List<DateSelection> dateSelection)
        {
            DateTime startD = GetDateFromJavaScriptDate(startDate);

            DateTime endD = GetDateFromJavaScriptDate(endDate);

            BikesAvailability bikesAvailability =
                DatabaseOperations.GetBikesAvailability(inventoryGroups,
                name, email, phone, dropoffLocation,
                    startD, endD, dateSelection);

            return bikesAvailability;

        }
  
        [WebMethod]
        public static BikesAvailability MakeReservation(
            List<InventoryGroup> inventoryGroups,
             string name,
            string email,
            string phoneNumber,
            string dropoffLocation,
            List<DateSelection> dateSelection 
           )
        {
            BikesAvailability bikesAvailability = new BikesAvailability();

            bikesAvailability.Message = "An unexpected error occured";

            if (string.IsNullOrEmpty(dropoffLocation))
            {
                bikesAvailability.Message = "Please enter dropoff location";
                return bikesAvailability;
            }
            else if (string.IsNullOrEmpty(name.Trim()))
            {
                bikesAvailability.Message = "Please enter your name";
                return bikesAvailability;
            }
            else if (string.IsNullOrEmpty(email.Trim()))
            {
                bikesAvailability.Message = "Please enter your email";
                return bikesAvailability;
            }
            else if (email.Trim().Count(c => c == '.') != 1 ||
                email.Trim().Count(c => c == '@') != 1)
            {
                bikesAvailability.Message = "Please enter a valid email address";
                return bikesAvailability;
            }
            else if (string.IsNullOrEmpty(phoneNumber.Trim()))
            {
                bikesAvailability.Message = "Please enter your phone number";
                return bikesAvailability;
            }
            else if (phoneNumber.Count(x => Char.IsDigit(x)) != 10 &&
                phoneNumber.Count(x => Char.IsDigit(x)) != 7)
            {
                bikesAvailability.Message = "Please enter a valid phone number. The form excepts 7 (Fort Collins number) or 10 digits";
                return bikesAvailability;
            }
            else if (dateSelection == null || dateSelection.Any() == false)
            {
                bikesAvailability.Message = "Please select at least one date";
                return bikesAvailability;
            }
            else if (inventoryGroups.All(g => g.Wanted == 0)) {
                bikesAvailability.Message = "Please select some bikes";
                return bikesAvailability;
            }
            string id = string.Empty;

            foreach (DateSelection dateSelectionInstance in dateSelection)
            { 
                  
                id = DatabaseOperations.InsertAppointment
                        (dateSelectionInstance, dropoffLocation.ToString(), name.ToString(), email.ToString(), phoneNumber.ToString());

                DatabaseOperations.AddBikeBookings(id, inventoryGroups);

            }
            bikesAvailability.Message = "Booking was successfully entered into the database";

            List<string> messageLines = new List<string>();

            messageLines.Add($"Id: '{id}'");
            messageLines.Add($"name: {name}");
            messageLines.Add($"email: {email}");
            messageLines.Add($"phone: {phoneNumber}");
            messageLines.Add($"Drop off location: {dropoffLocation}");

            foreach (DateSelection dateSelectionInstance in dateSelection)
            {
                messageLines.Add($"{dateSelectionInstance.Date} {dateSelectionInstance.DayPart}");
            }

            messageLines.Add($"Bikes:");
            foreach (InventoryGroup inventoryGroup in inventoryGroups)
            {
                if (inventoryGroup.Wanted > 0) {
                    messageLines.Add($"{inventoryGroup.Name}: {inventoryGroup.Model}");
                }
            }

            string renderedFullMessage = messageLines.Aggregate((i, j) => i + "\n" + j);

            string msg1 = EmailSender.Send("amgdebruijn@gmail.com", $"Reservation", renderedFullMessage);

            if (msg1 == EmailSender.MessageAtSuccessfullySentEmail)
            {
                bikesAvailability.Message += $" Email successfully sent to bikeadelic";
            }
            else bikesAvailability.Message += $" Unable to sent email to bikeadelic";

            if (string.IsNullOrEmpty(email.ToString()) == false)
            {
                string rentedBikesMessagePart =
                    inventoryGroups.Where(g=> g.Wanted>0)
                    .Select((kvpi, kvpj) => $"{ kvpi.Wanted}  { kvpi.Name}")
                    .Aggregate((i,j) => $"{i} and {j}");

                string daySelectionPartMessage =
                    dateSelection.Select(d => $"{d.Date} for the {d.DayPart}").
                    Aggregate((i, j) => $"{i} and {j}");

                string GetDropOffTimeByDayPart(string dayPart)
                {
                    return new Dictionary<string, string>
                    {
                        {DayPart.Morning.ToString().ToLower(), "9.00AM" },
                        {DayPart.Afternoon.ToString().ToLower(), "2.00PM" },
                         {DayPart.Day.ToString().ToLower(), "9.00AM" }
                    }[dayPart];
                }

                string dropOffTimePartMessage
                    = dateSelection.Select(d => d.DayPart)
                    .Distinct().Select(daypart => $"{GetDropOffTimeByDayPart(daypart)} for the {daypart}")
                    .Aggregate((i,j) => $"{i} and {j}");

                string customerMessage = $"Dear {name} \n\n" +
                    $"Thank you for your reservation of {rentedBikesMessagePart}. \n\n" +
                    $"We have you down for {daySelectionPartMessage}. \n\n" +
                    $"We plan to drop the bikes off at {dropoffLocation} at {dropOffTimePartMessage}. \n\n" + 
                    $"We will contact you at {email} or {phoneNumber} to confirm.\n\n"+
                    $"Thank you for your business and looking forward to meet you.\n\n" +
                    $"Arjan de Bruijn and Allison Shaw";
                      
                string msg2 = EmailSender.Send(email.ToString(), $"Your reservation", customerMessage);

                if (msg2 == EmailSender.MessageAtSuccessfullySentEmail)
                {
                    bikesAvailability.Message += $" Email successfully sent to {email.ToString()}";
                }
                else bikesAvailability.Message += $" Unable to sent email to {email.ToString()}";
            }
            else
            {
                bikesAvailability.Message += " no email sent to customer, no address provided";
            }

            return bikesAvailability;
        }

        

        private static List<string> GetRequestedBikesAsFlatList(Dictionary<string, int> requestedBikesDict)
        {
            List<string> requestedBikesList = new List<string>();

            foreach (var kvp in requestedBikesDict)
            {
                for (int c = 0; c < kvp.Value; c++)
                {
                    requestedBikesList.Add(kvp.Key);
                }
            }

            return requestedBikesList;
        }

        protected void Button1_Click(object sender, EventArgs e)
        {

        }
    }
}