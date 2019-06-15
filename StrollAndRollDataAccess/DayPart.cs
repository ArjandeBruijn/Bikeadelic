using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StrollAndRollDataAccess
{
    public static class DayPartSelection
    {
        public enum DayPart
        {
            Morning,
            Afternoon,
            Evening,
            Day
        }
        public static DayPart[] AllDayParts => Enum.GetValues(typeof(DayPart)).Cast<DayPart>().ToArray();

        public static DayPart GetDayPart(string dayPartString) {
            return AllDayParts.Single(d => d.ToString() == dayPartString);
        }

        public static DayPart[] GetAvailableDayParts(DateTime date)
        {
            if (date.Ticks< DateTime.Now.Ticks)
            {
                return new List<DayPart>().ToArray();
            }
            else if (date.DayOfWeek == DayOfWeek.Saturday || date.DayOfWeek == DayOfWeek.Sunday)
            {
                return new List<DayPart>(AllDayParts).ToArray();
            }
            else
            {
                return new List<DayPart>() { DayPart.Evening }.ToArray();
            }
        }

    }
    
}
