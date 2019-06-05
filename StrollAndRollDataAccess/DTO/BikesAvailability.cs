using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StrollAndRollDataAccess
{
    public class BikesAvailability
    {
        public DisplayTime[] AvailableDates { get; set; }

        public InventoryGroup[] Inventory { get; set; }

        public AppointmentPrices AppointmentPrices { get; set; }

        public string Message { get; set; }

        public string Name { get; set; }

        public string Email { get; set; }

        public string Phone { get; set; }
         

    }
}
