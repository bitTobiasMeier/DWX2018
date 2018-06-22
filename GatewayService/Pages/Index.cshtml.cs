using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace GatewayService.Pages
{
    public class IndexModel : PageModel
    {
        public string Location { get; set; }
        public void OnGet()
        {
            var url = this.HttpContext.Request.Host.Value;
            if (this.HttpContext.Request.IsHttps)
            {
                url = "https://" + url;
            }
            else
            {
                url = "http://" + url;
            }
            this.Location = url;
        }
    }
}