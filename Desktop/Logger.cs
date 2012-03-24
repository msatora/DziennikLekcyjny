using System;
using System.Collections.Generic;
using System.Linq;
using System.Data.Linq;
using System.Text;
using System.Data;

namespace DziennikLekcyjny
{
    class Logger
    {
        public enum PRACOWNIK { NAUCZYCIEL, WYCHOWAWCA, DYREKTOR };
        MySql.Data.MySqlClient.MySqlConnectionStringBuilder m_DanePolaczenia;
        private DB m_DB;
        

        //**********************************************************************************
        public Logger(string serwer, string nazwaBazy, string hasloDoBazy, string uzytkownik, uint port, PRACOWNIK pracownik)
        //**********************************************************************************
        {
            m_DanePolaczenia = new MySql.Data.MySqlClient.MySqlConnectionStringBuilder();

            m_DanePolaczenia.Server   = serwer;
            m_DanePolaczenia.Password = hasloDoBazy;
            m_DanePolaczenia.UserID = uzytkownik;
            m_DanePolaczenia.Port  = port;
            m_DanePolaczenia.Database = nazwaBazy;

            m_DB = new DB();
        }

        //**********************************************************************************
        public bool Loguj()
        //**********************************************************************************
        {
            try
            {
                m_DB.OtworzPolaczenie(m_DanePolaczenia.ToString());
            }
            catch (Exception)
            {
                return false;
            }
            
            return true;
        }
    }
}
