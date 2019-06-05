using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Controls;

namespace StrollAndRollDesktopApp
{
    class SelectTableTabItem: TabItem
    {
        TableSelectControl tableSelectControl;

        public event EventHandler<IsSelectedByTable> OnShowTableChanged;

        public SelectTableTabItem(string[] tableNames)
        {
            Header = "Select Tables";

            tableSelectControl = new TableSelectControl(tableNames);

            tableSelectControl.OnShowTableChanged += TableSelectControl_OnShowTableChanged;

            Content = tableSelectControl;
        }

        private void TableSelectControl_OnShowTableChanged(object sender, IsSelectedByTable e)
        {
            OnShowTableChanged(this, e);
        }
    }
}
