using StrollAndRollDataAccess;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using static Bikeadelic.Book;

namespace Bikeadelic
{
    public partial class Calendar : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        [WebMethod]
        public static ReturnContentWrapper<DisplayTime[]>
           GetCalendarEvents(string date)
        {
            ReturnContentWrapper<DisplayTime[]> returnContent =
                new ReturnContentWrapper<DisplayTime[]>();
              
            List<DisplayTime> availableDates
                = new List<DisplayTime>();

            int yr = Convert.ToInt32(date.Substring(0, 4));

            int month = Convert.ToInt32(date.Substring(5, 2));

            DateTime runningDate = new DateTime(yr, month, 1);
             
            while (runningDate.DayOfWeek != DayOfWeek.Sunday)
            {
                runningDate = runningDate.AddDays(-1);
            }

            DateTime oneMonthLater = runningDate.AddMonths(1);

            while (oneMonthLater.DayOfWeek != DayOfWeek.Saturday)
            {
                oneMonthLater = oneMonthLater.AddDays(1);
            }

            while (runningDate < oneMonthLater)
            {
                availableDates.Add(new DisplayTime(runningDate) { IsOtherMonth = runningDate.Month==5});

                runningDate = runningDate.AddDays(1);
            }

            returnContent.Content = availableDates.ToArray();
             
            return returnContent;
        }
    }
}