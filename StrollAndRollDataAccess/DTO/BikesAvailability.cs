using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StrollAndRollDataAccess
{
    public class BikesAvailability
    {
        public DateSelection DateSelection { get; set; }

        public DisplayTime[] AvailableDates { get; set; }

        public InventoryGroup[] Inventory { get; set; }

        public double Price { get; set; }

        public string Message { get; set; }

        public string Name { get; set; }

        public string Email { get; set; }

        public string Phone { get; set; }
         
        public BikesAvailability(
            DateSelection dateSelection,
            string name,
            string email,
            string phone)
        {
              
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
