using SendEmail;
using System;
using System.Collections.Generic;
using System.Web.Services;
using System.Web.UI;
namespace Bikeadelic
{
    public partial class Contact : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        [WebMethod]
        public static string SendContactEmail(string firstName,
            string lastName, string message, string emailAddress, string phoneNumber)
        {

            List<string> fullMessageLines = new List<string>();

            fullMessageLines.Add($"Contact message from {firstName} {lastName}");
            fullMessageLines.Add($"Email: {emailAddress}");
            fullMessageLines.Add($"Phone  {phoneNumber}");
            fullMessageLines.Add($"Message {message} ");

            string renderedFullMessage = String.Join("\n", fullMessageLines.ToArray());

            string subject = $"Message from {firstName} {lastName} sent through contact page";

            string returnMessage = EmailSender.SendToBikeadelics(subject, renderedFullMessage);

            //string returnMessage = $"Email successfully sent to {emailAddress}";

            return returnMessage;
        }
    }
}