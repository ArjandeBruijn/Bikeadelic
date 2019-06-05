using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StrollAndRollDesktopApp
{
    public class IsSelectedByTable
    {
        public event EventHandler<bool> OnSelectedChanged;

        private bool _isSelected =false;

        public string TableName { get; set; }
        public bool IsSelected
        {
            get => _isSelected;
            set {
                _isSelected = value;

                OnSelectedChanged(this, value);
            }
        }
    }
}
