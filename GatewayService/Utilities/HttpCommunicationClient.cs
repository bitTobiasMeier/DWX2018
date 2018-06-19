using System;
using System.Fabric;
using System.Net.Http;
using Microsoft.ServiceFabric.Services.Communication.Client;

namespace GatewayService.Utilities
{

    public class HttpCommunicationClient : ICommunicationClient
    {
        public ResolvedServicePartition ResolvedServicePartition { get; set; }

        public string ListenerName { get; set; }

        public ResolvedServiceEndpoint Endpoint { get; set; }

        public HttpClient HttpClient { get; }

        public HttpCommunicationClient(Uri baseAddress, TimeSpan operationTimeout)
        {
            HttpClientHandler clientHandler = new HttpClientHandler
            {
                AllowAutoRedirect = false
            };

            HttpClient = new HttpClient(clientHandler)
            {
                BaseAddress = baseAddress,
                Timeout = operationTimeout
            };
        }
    }
}