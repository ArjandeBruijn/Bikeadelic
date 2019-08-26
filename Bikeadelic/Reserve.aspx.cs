using StrollAndRollDataAccess;
using System;
using System.Collections.Generic;
using System.Web.Services;

namespace Bikeadelic
{
    public partial class Book : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        private static DateTime GetDateFromJavaScriptDate(string javascriptDate)
        {
           
            if (javascriptDate.Length == 10)
            {
                return DatabaseOperations.GetDateFromDateString(javascriptDate);
            }
            else
            {
                int year = Convert.ToInt32(javascriptDate.Substring(0, 4));

                int month = Convert.ToInt32(javascriptDate.Substring(5, 2));

                int day = Convert.ToInt32(javascriptDate.Substring(8, 2));

                DateTime date = new DateTime(year, month, day);

                return date;
            }
             
            
        }

        [WebMethod]
        public static SelectableDayPartOptions GetSelectableDayPartOptions(string date)
        {
            DateTime ddate = GetDateFromJavaScriptDate(date);

            SelectableDayPartOptions selectableDayPartOptions = DatabaseOperations.GetSelectableDayPartOptions(ddate);

            return selectableDayPartOptions;
        }

        [WebMethod]
        public static BikesAvailability
           GetBikesAvailability(
            bool makeReservation,
            InventoryGroup[] inventoryGroups,
            string selectedDate,
            string selectedDayPart,
            string name,
            string email,
            string phone,
            string startDate,
            string endDate
           )
        {
            DateTime startD = GetDateFromJavaScriptDate(startDate);

            DateTime endD = GetDateFromJavaScriptDate(endDate);

            DateSelection dateSelection = null;

            if (selectedDate != null && selectedDayPart != null)
            {
                dateSelection= new DateSelection()
                {
                    DayPart= selectedDayPart,
                    Date = selectedDate  
                };
            }
            string message  = null;

            if (makeReservation)
            {
                message = DatabaseOperations.MakeReservation(inventoryGroups, name, email, phone, dateSelection);

                foreach (InventoryGroup group in inventoryGroups)
                {
                    group.Wanted = 0;
                }
                
            }

            

            BikesAvailability bikesAvailability =
                DatabaseOperations.GetBikesAvailability(inventoryGroups,
                name, email, phone,  startD, endD, dateSelection);

            bikesAvailability.Message = message;

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