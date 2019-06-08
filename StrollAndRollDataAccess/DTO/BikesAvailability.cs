using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StrollAndRollDataAccess
{
    public class BikesAvailability
    {
        public List<DateSelection> DateSelection { get; set; }

        public DisplayTime[] AvailableDates { get; set; }

        public InventoryGroup[] Inventory { get; set; }

        public AppointmentPrices AppointmentPrices { get; set; }

        public string Message { get; set; }

        public string Name { get; set; }

        public string Email { get; set; }

        public string Phone { get; set; }

        public string DropoffLocation { get; set; }

        public bool DeliveryRequested { get; set; }

        public BikesAvailability(bool deliveryRequested,
            string dropoffLocation,
            List<DateSelection> dateSelection,
            string name,
            string email,
            string phone)
        {
            DeliveryRequested = deliveryRequested;

            DropoffLocation = dropoffLocation;

            DateSelection = dateSelection;

            if (name != null)
            {
                Name = name.ToString();
            }
            if (email != null)
            {
                Email = email.ToString();
            }
            if (phone != null)
            {
                Phone = phone.ToString();
            }

        }

    }
}
