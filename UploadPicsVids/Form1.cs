using Dropbox;
using Dropbox.Api.Sharing;
using StrollAndRollDataAccess;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace UploadPicsVids
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        
        private void LogMessage(string msg)
        {
            if (textboxFeedBack.Text.Length > 0)
            {
                textboxFeedBack.Text += Environment.NewLine;
            }
            textboxFeedBack.Text += msg;

            textboxFeedBack.SelectionStart = textboxFeedBack.Text.Length;

            textboxFeedBack.ScrollToCaret();
        }
        private async void Button1_Click(object sender, EventArgs e)
        {
            string accessToken = "Lzk0cOUr-BoAAAAAAABn1QgKontvLa2ma0vtCU24NTo9vEeBTeFSjiROUL5rY_6F";
            string appKey = "e7852uopirsqcja";
            string appSecret = "dvhf2ijy2z99ckg";

            if (openFileDialog1.ShowDialog() == DialogResult.OK)
            {
                foreach (string fileName in openFileDialog1.FileNames)
                {
                    LogMessage(fileName);
                     
                    Dropbox.DropboxClient client = new Dropbox.DropboxClient(appKey, appSecret);

                    if (Path.GetExtension(fileName) == ".mp4")
                    {
                        LogMessage($"Cannot process mp4 file {fileName}");

                        continue;
                    }

                    string fileNameOnDropbox = Path.GetFileName(fileName);

                    UploadFileRequest request = new UploadFileRequest(fileNameOnDropbox);

                    Image image = Image.FromFile(fileName);

                    using (MemoryStream stream = new MemoryStream())
                    {
                        image.Save(stream, image.RawFormat);

                        stream.Position = 0;

                        await client.UploadFileAsync(request, stream, accessToken);
                    }

                    using (var apiClient = new Dropbox.Api.DropboxClient(accessToken))
                    {

                        string fn = $"/{fileNameOnDropbox}";

                        ListSharedLinksResult sharedLinksResult = await apiClient.Sharing.ListSharedLinksAsync(new ListSharedLinksArg(fn));

                        string url = string.Empty;

                        if (sharedLinksResult.Links.Count > 0)
                        {
                            url = sharedLinksResult.Links[0].Url;
                        }
                        else
                        {
                            SharedLinkMetadata sharedLinkMetaData = await apiClient.Sharing.CreateSharedLinkWithSettingsAsync(fn);

                            url = sharedLinkMetaData.Url;

                            //DatabaseOperations.
                        }

                        textboxFeedBack.Text += $"Url = {url}";
                    }

                }

                 
            }

        }

    }
}
