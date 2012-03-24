using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using MySql.Data.MySqlClient;

namespace DziennikLekcyjny
{
    class Logger
    {
        MySqlConnection m_Polaczenie;
        MySqlConnectionStringBuilder m_DanePolaczenia;

        //**********************************************************************************
        public Logger(string serwer, string hasloDoBazy, string uzytkownik, uint port)
        //**********************************************************************************
        {
            m_DanePolaczenia = new MySqlConnectionStringBuilder();

            m_DanePolaczenia.Server   = serwer;
            m_DanePolaczenia.Password = hasloDoBazy;
            m_DanePolaczenia.UserID = uzytkownik;
            m_DanePolaczenia.Port  = port;
        }

        //**********************************************************************************
        ~Logger()
        //**********************************************************************************
        {
            ZamknijPolaczenie();
        }

        //**********************************************************************************
        public bool Loguj()
        //**********************************************************************************
        {
            ZamknijPolaczenie();

            try
            {
                m_Polaczenie = new MySqlConnection(m_DanePolaczenia.ToString());
                m_Polaczenie.Open();
            }
            catch (Exception)
            {
                return false;
            }
            
            return true;
        }

        //**********************************************************************************
        private void ZamknijPolaczenie()
        //**********************************************************************************
        {
            if (m_Polaczenie != null)
                m_Polaczenie.Close();
        }

    }
}
