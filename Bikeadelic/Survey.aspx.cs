using StrollAndRollDataAccess;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Bikeadelic
{
    public partial class Questionaire : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }


        [WebMethod]
        public static string SubmitQuestionaire
            (string WhereDoYouHangOutOnline,
            string FavoritePlacesToHangOutAroundTown,
            string HowLikelyAreYouToRentAWeirdBike,
            string WhyWouldYouOrWouldntYouBeInterested,
            string AreOurPricesWithinYourBudget,
            string WhatDoYouDislikeAboutOurWebsite,
            string DeliverOrPickUp,
            string WhereWouldYouLikeToRide,
            string HowManyHoursWouldYouLikeTheBike,
            string Ageselectiontable,
            string BikeSelectionResults,
            string  EmailAddress,
            string HowManyTimesAYearEmail
            )
        {
            Dictionary<string, int> ageselectiontable
               = new System.Web.Script.Serialization.JavaScriptSerializer()
               .Deserialize<Dictionary<string, string>>(Ageselectiontable)
               .ToDictionary(kvp => kvp.Key, kvp => kvp.Value == "" ? 0 : Convert.ToInt32(kvp.Value))
               .Where(kvp => kvp.Value > 0).ToDictionary(kvp => kvp.Key, kvp => kvp.Value);
              
            string bikeSelectionResult
                = BikeSelectionResults.Substring(BikeSelectionResults.IndexOf("[") + 1, BikeSelectionResults.IndexOf("]") - BikeSelectionResults.IndexOf("[") - 1)
                .Replace(",\",\"", ",").Replace("\"", "");

            List<string> bikeSelectionResultArr = 
                bikeSelectionResult.Split(',')
                .Where(s=> s.Length>0)
                .Where(s => s.Split(':')[1] =="true")
                .Select(s => s.Split(':')[0].Replace("check_", ""))
                .ToList();

            return DatabaseOperations.SubmitQuestionaire(WhereDoYouHangOutOnline,
                FavoritePlacesToHangOutAroundTown,
                HowLikelyAreYouToRentAWeirdBike,
                WhyWouldYouOrWouldntYouBeInterested,
                AreOurPricesWithinYourBudget,
                WhatDoYouDislikeAboutOurWebsite,
                DeliverOrPickUp,
                WhereWouldYouLikeToRide,
                HowManyHoursWouldYouLikeTheBike,
                ageselectiontable,
                bikeSelectionResultArr,
                EmailAddress,
                HowManyTimesAYearEmail);
        }
        [WebMethod]
        public static Bike[] GetBikes()
        {
            return DatabaseOperations.GetBikes();
        }
    }
}