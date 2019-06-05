using System;
using System.Net;
using System.Net.Mail;
namespace SendEmail
{
    public static class EmailSender
    {
        static string mailHost = "mail.bikeadelic-rentals.com";
        static string postMasterAddress = "postmaster@bikeadelic-rentals.com";

        public static string MessageAtSuccessfullySentEmail = "Message Successfully Sent";

        public static string Send(string receiverAddress, string subject, string messageText)
        {
            try
            {
                MailMessage message = new MailMessage();
                message.From = new MailAddress(postMasterAddress);
                message.To.Add(receiverAddress);

                //set the content
                message.Subject = subject;
                message.Body = messageText;

                //send the message
                SmtpClient smtp = new SmtpClient(mailHost);
                NetworkCredential Credentials = new NetworkCredential(postMasterAddress, "G0dverd0mme!");
                smtp.Credentials = Credentials;
                smtp.Send(message);
            }
            catch(Exception e)
            {
                return e.Message;
            }
            return MessageAtSuccessfullySentEmail;
        }

    }
}
