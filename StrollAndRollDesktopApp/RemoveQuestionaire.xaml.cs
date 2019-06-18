using StrollAndRollDataAccess;
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

namespace StrollAndRollDesktopApp
{
    /// <summary>
    /// Interaction logic for RemoveQuestionaire.xaml
    /// </summary>
    public partial class RemoveQuestionaire : UserControl
    {
        public class DataModel
        {
            public string QuestionaireId { get; set; }
        }
         

        public RemoveQuestionaire()
        {
            InitializeComponent();

            DataContext = new DataModel();
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            string questionaireId = ((DataModel)DataContext).QuestionaireId;

            string[] sqls = new string[]
            {
                $"delete from {TableNames.QuestionaireAgeSelection} where {ColumnNames.QuestionaireId} = '{questionaireId}'",
                $"delete from {TableNames.QuestionaireBikePreferenceSelection} where {ColumnNames.QuestionaireId} = '{questionaireId}'",
                $"delete from {TableNames.QuestionaireAnswers} where id = '{questionaireId}'",
            };

            foreach (string sql in sqls)
            {
                DatabaseOperations.ExecuteNonQuery(sql);
            }
            
        }
    }
}
