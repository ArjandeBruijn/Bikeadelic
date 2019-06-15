using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace StrollAndRollDataAccess
{
    public class Appointment  
    {
        
        public string Id { get; set; }

        public DateTime Date { get; set; }

        public DayPartSelection.DayPart DayPart { get; set; }

        public List<BikeBooking> BikeBookings { get; set; }

        public bool DayPartOverlaps(DayPartSelection.DayPart dayPart)
        {
            return dayPart == DayPartSelection.DayPart.Day ||
                DayPart == DayPartSelection.DayPart.Day  ||
                DayPart== dayPart;
        }

        public override string ToString()
        {
            return $"{Date} - {DayPart}";
        }
    }

}