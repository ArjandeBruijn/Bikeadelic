using StrollAndRollDataAccess;
using System;
using System.Web.Services;

namespace Bikeadelic
{
    public partial class Gallery : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        [WebMethod]
        public static PhotoLink[] GetPhotoLinks()
        {
            PhotoLink[] photos = DatabaseOperations.GetPhotoLinks();

            return photos;
        }
    }
}