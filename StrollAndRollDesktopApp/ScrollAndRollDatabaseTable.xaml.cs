using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using StrollAndRollDataAccess;

namespace StrollAndRollDesktopApp
{
    /// <summary>
    /// Interaction logic for ScrollAndRollDatabaseTable.xaml
    /// </summary>
    public partial class ScrollAndRollDatabaseTable : UserControl
    {

        private string _selectSql;

        public ScrollAndRollDatabaseTable(string selectSql)
        {
            InitializeComponent();

            _selectSql = selectSql;

            RefreshData();
        }

        public void RefreshData()
        {
            try
            {
                DataContext = DatabaseOperations.GetTableData(_selectSql);
            }
            catch (System.Exception e)
            {
                throw e;
            }

            
        }


        private void Button_Click(object sender, RoutedEventArgs e)
        {
            string sql = sqlStringText.Text;

            sql = sql.Replace("newguid", Guid.NewGuid().ToString());

            Exception exc = DatabaseOperations.ExecuteNonQuery(sql);

            if (exc != null)
            {
                string result = exc.Message;

                SqlResultTextBlock.Text = result;
            }
             
            RefreshData();
        }
    }
}
