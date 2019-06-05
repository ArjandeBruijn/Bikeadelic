using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace StrollAndRollDataAccess
{
    public class OpeningHours: TimeSlot
    {
        public string Id { get; set; }

        public DayOfWeek DayOfWeek { get; set; }
         
    }
}