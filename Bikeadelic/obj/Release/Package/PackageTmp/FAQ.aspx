<%@ Page Title="FAQ" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="FAQ.aspx.cs" Inherits="Bikeadelic.FAQ" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <script type="text/javascript">

        $(document).ready(function () {
             
            $.ajax({
                type: "POST",
                async: true,
                url: "FAQ.aspx/GetFrequentlyAskedQuestions",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: '{}',
                success: function (result) {

                    var questionColumnWidth = "30%";

                    var faqs = result.d;

                    while (faqTable.firstChild) {
                        faqTable.removeChild(faqTable.firstChild);
                    }
                     
                    var headerRow = faqTable.insertRow(-1);
                     
                    var questionHdrCell = headerRow.insertCell(-1)

                    questionHdrCell.innerHTML = "Question";

                    questionHdrCell.style.width = questionColumnWidth;

                    var answerHdrCell = headerRow.insertCell(-1)

                    answerHdrCell.innerHTML = "Answer";
                     
                    for (var f =0; f < faqs.length; f++) {

                        var faq = faqs[f];

                        var row  = faqTable.insertRow(-1);

                        var questionCell = row.insertCell(-1);
                         
                        questionCell.innerHTML =faq.Question;

                        questionCell.style.width = questionColumnWidth;

                        var answerCell = row.insertCell(-1);
                         
                        answerCell.innerHTML = faq.Answer;
                    }

                },
                failure: function (response) {


                }
            });

        });

    </script>
     
    <table id ="faqTable" style="margin-top:20px" class="columnBorderTable" />
         

</asp:Content>
