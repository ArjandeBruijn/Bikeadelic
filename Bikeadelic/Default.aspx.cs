using StrollAndRollDataAccess;
using System;
using System.Web.Services;
using System.Web.UI;
namespace Bikeadelic
{
    public partial class _Default : Page
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
        [WebMethod]
        public static string GetRandomQuote()
        {
            string quote = DatabaseOperations.GetRandomQuote();

            return quote;
        }
    }
}