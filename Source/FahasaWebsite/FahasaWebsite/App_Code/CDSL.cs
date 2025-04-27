using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace FahasaWebsite.App_Code
{
    public class CDSL
    {

        public CDSL() { }

        public string chuoiketnoi = ConfigurationManager.ConnectionStrings["FahasaDB"].ConnectionString.Trim();

        public DataTable GetData(string sql)
        {
            SqlConnection cnn = new SqlConnection(chuoiketnoi);
            try
            {
                SqlDataAdapter sqlDa = new SqlDataAdapter(sql, cnn);
                DataTable dt = new DataTable();
                sqlDa.Fill(dt);
                return dt;
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }
    }
}