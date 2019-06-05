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

        public DayPart DayPart { get; set; }

        public List<BikeBooking> BikeBookings { get; set; }

        public override string ToString()
        {
            return $"{Date} - {DayPart}";
        }
    }

}