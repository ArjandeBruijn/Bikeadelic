using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Controls;

namespace StrollAndRollDesktopApp
{
    public class TableTabItem : TabItem
    {
         
        public TableTabItem(string header, string selectSql)
        {
            Header = header;
             
            ScrollAndRollDatabaseTable tableControl = new ScrollAndRollDatabaseTable(selectSql);

            Content = tableControl;
              
        }
        public void RefreshData()
        {
            ((ScrollAndRollDatabaseTable)Content).RefreshData();
        }
    }
}
