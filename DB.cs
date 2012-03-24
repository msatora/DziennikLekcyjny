using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using MySql.Data.MySqlClient;

namespace DziennikLekcyjny
{
    class DB
    {
        // Zmienna statyczna. Inicjalizowana jednokrotnie za pomocą Loggera.
        private static MySqlConnection m_Polaczenie = null;
        private MySqlCommand m_Polecenie;

        //****************************************************************************
        /* Otworzenie połączenia wykonywane jest jednokrotne w całym programie
         * Każda klasa operująca na bazie (poza Loggerem) tworzy jedynie obiekt
         * bazy danych który jest już gotowy do działania, a wywołanie metody
         * OtworzPolaczenie jest zbędne, a nawet zabronione!
         */
        public bool OtworzPolaczenie(string danePolaczenia)
        //****************************************************************************
        {
            if (m_Polaczenie != null)
            {
                m_Polaczenie.Close();
            }
            else
            {
                m_Polaczenie = new MySqlConnection(danePolaczenia);
            }

            try
            {
                m_Polaczenie.Open();
            }
            catch (Exception)
            {
                return false;
            }

            return true;
        }

        //*****************************************************************************
        /* Metoda otrzymuje zapytanie SELECT (standard SQL) w postaci string'a.
         * Na jego bazie generuje zbiór danych - obiektową tabelę na której
         * możemy operować zapytaniami LINQ. W przypadku niepowodzenia zwraca NULL.
         */
        public System.Data.DataTable WykonajPolecenieSelect(String text)
        //*****************************************************************************
        {
            try
            {
                m_Polecenie = new MySqlCommand(text, m_Polaczenie);
                return m_Polecenie.ExecuteReader().GetSchemaTable();
            }
            catch (Exception)
            {
                return null;
            }
        }
    }
}
