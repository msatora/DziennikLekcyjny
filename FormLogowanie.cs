using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace DziennikLekcyjny
{
    public partial class FormLogowanie : Form
    {
        private Logger m_Logger;

        //**********************************************************************************
        public FormLogowanie()
        //**********************************************************************************
        {
            InitializeComponent();
            textBox1.Text = Properties.Settings.Default.Uzytkownik;
            textBox3.Text = Properties.Settings.Default.AdresSerwera;
            textBox4.Text = Properties.Settings.Default.Port;
        }

        //**********************************************************************************
        private void Loguj_b_click(object sender, EventArgs e)
        //**********************************************************************************
        {
            if (SprawdzPoprawnoscDanych())
            {
                m_Logger = new Logger(textBox3.Text, textBox2.Text, textBox1.Text, uint.Parse(textBox4.Text));
                if (false == m_Logger.Loguj())
                    return;
            }       
        }

        //**********************************************************************************
        private bool SprawdzPoprawnoscDanych()
        //**********************************************************************************
        {
            if (textBox1.Text == String.Empty || textBox2.Text == String.Empty ||
                textBox3.Text == String.Empty || textBox4.Text == String.Empty)
            {
                MessageBox.Show("Nie podano wszystkich, wymaganych danych!", "Uwaga");
                return false;
            }

            try 
            {
                uint.Parse(textBox4.Text);
            }
            catch(Exception)
            {
                MessageBox.Show("Wartość w polu port jest niepoprawna!", "Uwaga");
                return false;
            }

            return true;
        }

        //**********************************************************************************
        private void Wyjdz_b_click(object sender, EventArgs e)
        //**********************************************************************************
        {
            Close();
        }
    }
}
