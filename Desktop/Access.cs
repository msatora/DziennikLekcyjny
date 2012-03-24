using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace DziennikLekcyjny
{
    class Access
    {
        public Access() { }

        public virtual Int32 ID { get; set; }
        public virtual String NAME { get; set; }
        public virtual String PASSWORD { get; set; }
        public virtual Int32 PERSONID { get; set; }
        public virtual Int32 ROLEID { get; set; }
    }
}
