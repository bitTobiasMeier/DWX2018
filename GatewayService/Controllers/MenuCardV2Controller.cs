using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using GatewayService.Utilities;
using Microsoft.AspNetCore.Mvc;
using Microsoft.ServiceFabric.Services.Client;
using Microsoft.ServiceFabric.Services.Communication.Client;

namespace GatewayService.Controllers
{
    
    [Route("api/[controller]")]
    public class MenuCardV2Controller : Controller
    {
        private readonly IHttpCommunicationClientFactory _clientFactory;

        public MenuCardV2Controller(IHttpCommunicationClientFactory clientFactory)
        {
            _clientFactory = clientFactory;
        }

        [HttpGet("{id}")]
        public async Task<MenuData> Get(int id)
        {
            var proxy = CreateProxy();
            return await proxy.InvokeWithRetry(async x =>
                {
                    var client = new MenuCardClient(x.HttpClient);
                    return await client.GetAsync(id);
                }
            );
        }

        [HttpGet()]
        public async Task<IEnumerable<MenuData>> GetAll()
        {
            var proxy = CreateProxy();
            return await proxy.InvokeWithRetry(async x =>
            {
                var client = new MenuCardClient(x.HttpClient);
                return await client.GetAllAsync();
            }
            );
        }

        [HttpPost]
        public async Task<MenuData> Post([FromBody] MenuData value)
        {
            var proxy = CreateProxy();
            return await proxy.InvokeWithRetry(async x =>
                {
                    var client = new MenuCardClient(x.HttpClient);
                    return await client.PostAsync(value);
                }
            );
        }

        private ServicePartitionClient<HttpCommunicationClient> CreateProxy()
        {
            var client = new ServicePartitionClient<HttpCommunicationClient>(
                _clientFactory,
                new Uri("fabric:/DWX2018/MenuCardService"), new ServicePartitionKey(0)
            );
            return client;
        }
    }
}