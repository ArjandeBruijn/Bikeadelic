<%@ Page Title="Gallery" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Gallery.aspx.cs" Inherits="Bikeadelic.Gallery" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <script type="text/javascript">

        $(document).ready(function () {

            $.ajax({
                type: "POST",
                async: true,
                url: "Gallery.aspx/GetPhotoLinks",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: '{}',
                success: function (result) {

                    for (var i = 0; i < result.d.length; i++) {

                        var photoLink = result.d[i];

                        var smallWidth = "25%";
                        var largeWidth = "100%";

                        var img = document.createElement("img");
                        img.style.width = smallWidth;
                        img.style.margin = "5px 5px 5px 5px";
                        img.src = photoLink.Link;

                        img.onclick = function () {
                            var clickedImageIsLarge = this.style.width =
                                (this.style.width == largeWidth);

                            $('#imagesDiv').children('img')
                                .each(function () {
                                    this.style.width = smallWidth;
                                });

                            clickedImageIsLarge ?
                                this.style.width = smallWidth :
                                this.style.width = largeWidth;

                        };

                        var src = document.getElementById("imagesDiv");

                        src.appendChild(img);

                    }


                },
                failure: function (response) {

                }
            });

        });


    </script>

    <div id="imagesDiv"></div>

</asp:Content>
