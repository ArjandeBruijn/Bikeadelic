using StrollAndRollDataAccess;
using System;
using System.Web.Services;
namespace Bikeadelic
{
    public partial class Bikes : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        [WebMethod]
        public static Bike[] GetActiveBikes()
        {
            return DatabaseOperations.GetActiveBikes();
        }
    }
}