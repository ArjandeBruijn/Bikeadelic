using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StrollAndRollDataAccess
{
    public class AppointmentPrices
    {
        public double Rental { get; set; } = 0.0;
        public double Delivery { get; set; } = 0.0;
        public double Total { get; set; } = 0.0;

        public override string ToString()
        {
            return $"Rental: {Rental} - Delivery: {Delivery} - Total: {Total}";
        }
    }
}
