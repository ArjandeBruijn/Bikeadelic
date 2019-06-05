using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace StrollAndRollDataAccess
{
    public class Bike
    {
        public string Id { get; set; }

        public string Name { get; set; }

        public string PictureUrl { get; set; }

        public string GifUrl { get; set; }

        public string VideoUrl { get; set; }

        public int DisplayOrder { get; set; }

        public string Description { get; set; }
    }
}