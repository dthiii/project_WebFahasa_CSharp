using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace FahasaWebsite.Models
{
    public class DiaChiModel
    {
        public class TinhThanh
        {
            public string MaTinh { get; set; }
            public string TenTinh { get; set; }
        }

        public class QuanHuyen
        {
            public string MaQuan { get; set; }
            public string TenQuan { get; set; }
            public string MaTinh { get; set; }
        }

        public class PhuongXa
        {
            public string MaPhuong { get; set; }
            public string TenPhuong { get; set; }
            public string MaQuan { get; set; }
        }
    }
}