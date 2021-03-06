﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StrollAndRollDataAccess
{
    public class InventoryGroup
    {
        public int DisplayOrder { get; set; }

        public string Name { get; set;}

        public string Model { get; set; }

        public string BikeId { get; set; }

        public int Wanted { get; set; }

        public int Available { get; set; }

        public string ModelId { get; set; }

        public override string ToString()
        {
            return $"{Name} - {Model}: {Available}";
        }
        public InventoryGroup() { }

        public InventoryGroup(InventoryGroup inventory)
        {
            Name = inventory.Name;
            Model = inventory.Model;
            ModelId = inventory.ModelId;
            BikeId = inventory.BikeId;
            Wanted = inventory.Wanted;
            Available = inventory.Available;
        }
    }
}
