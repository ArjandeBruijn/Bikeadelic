using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StrollAndRollDataAccess
{
    public class DateTimeUtils
    {
        public string MonthName(DateTime dateTime)
        {
            string monthName = dateTime.ToString("MMMM", CultureInfo.InvariantCulture);

            return monthName;
        }
        public string GetDateString(DateTime dateTime)
        {
            return dateTime.ToString("MM/dd/yyyy");
        }
        public string GetTimeString(DateTime dateTime)
        {
            return $"{dateTime.ToString("hh:mm")} {(dateTime.Hour > 12 ? "PM" : "AM")}";
        }
        public DateTime GetDateTimeFromTimeStringWithSeconds(string timeString)
        {
            int h = Convert.ToInt32(timeString.Substring(0, 2));
            int min = Convert.ToInt32(timeString.Substring(3, 2));

            DateTime dateTime = DateTime.MinValue.AddHours(h).AddMinutes(min);

            return dateTime;
        }
        public DateTime GetDateTimeFromTimeString(string timeString)
        {
            return GetDateTimeFromTimeString(DateTime.MinValue, timeString);
        }
        public DateTime GetDateTimeFromTimeString(DateTime date, string timeString)
        {
            int hour = Convert.ToInt32(timeString.Substring(0, 2))
                + (timeString.Contains("PM") ? 12 : 0);

            int minutes = Convert.ToInt32(timeString.Substring(3, 2));

            return new DateTime(date.Year, date.Month, date.Day, hour, minutes, 0);
        }
         
         
    }
}
