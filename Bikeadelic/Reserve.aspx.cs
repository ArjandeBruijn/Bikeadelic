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
            List<DateSelection> dateSelection,
            string name,
            string email,
            string phone,
            bool deliveryRequested,
            string dropoffLocation,
           string startDate,
           string endDate
           )
        {
            DateTime startD = GetDateFromJavaScriptDate(startDate);

            DateTime endD = GetDateFromJavaScriptDate(endDate);

            BikesAvailability bikesAvailability =
                DatabaseOperations.GetBikesAvailability(inventoryGroups,
                name, email, phone, deliveryRequested, dropoffLocation,
                    startD, endD, dateSelection);

            return bikesAvailability;

        }
       
        [WebMethod]
        public static BikesAvailability MakeReservation(
            List<InventoryGroup> inventoryGroups,
            List<DateSelection> dateSelection,
             string name,
            string email,
            string phone,
            bool deliveryRequested,
            string dropoffLocation
           )
        {
            BikesAvailability bikesAvailability 
                = DatabaseOperations.MakeReservation(inventoryGroups,
              name,
             email,
             phone,
             deliveryRequested,
             dropoffLocation,
             dateSelection);

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