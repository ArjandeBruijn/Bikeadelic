using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StrollAndRollDataAccess
{
    public class DateSelection
    {
        public string DayPart { get; set; }
        public string Date { get; set; }

        public DayPartSelection.DayPart DayPartEnum
        {
            get
            {
                DayPartSelection.DayPart dayPart = DayPartSelection.GetDayPart(DayPart);
                return dayPart;
            }
        }
         
         
        public int Year
        {
            get
            {
                string yrString = Date.Substring(6,4);

                return Convert.ToInt32(yrString);
            }
        }
        public int Month
        {
            get
            {
                string moStr = Date.Substring(0, 2);

                return Convert.ToInt32(moStr);
            }
        }
        public int Day
        {
            get
            {
                string dayString = Date.Substring(3, 2);

                return Convert.ToInt32(dayString);
            }
        }

        public DateTime CSharpDayTime
        {
            get
            {
                return new DateTime(Year, Month, Day);
            }
        }

        public DayOfWeek DateDayOfTheWeek
        {
            get {
                return CSharpDayTime.DayOfWeek;
            }
        }

    }
}
