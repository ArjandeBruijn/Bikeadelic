using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StrollAndRollDataAccess
{
    public class Event
    {
        public string ID { get; set; }

        public DayPartSelection.DayPart DayPart { get; set; }

        public DateTime Date { get; set; }

        public string Label { get; set; }
    }
}
