using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Controls;

namespace StrollAndRollDesktopApp
{
    class RemoveQuestionaireResultTableItem: TabItem
    {
        public RemoveQuestionaireResultTableItem()
          
        {
            base.Header = "Delete questionaire";

            Content = new RemoveQuestionaire();
        }
    }
}
