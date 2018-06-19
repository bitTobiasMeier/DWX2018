using System;
using System.Threading;
using System.Threading.Tasks;
using Microsoft.ServiceFabric.Services.Communication.Client;

namespace GatewayService.Utilities
{
    public class HttpCommunicationClientFactory : CommunicationClientFactoryBase<HttpCommunicationClient>,
        IHttpCommunicationClientFactory
    {
        protected override bool ValidateClient(HttpCommunicationClient client)
        {
            return true;
        }

        protected override bool ValidateClient(string endpoint, HttpCommunicationClient client)
        {
            return true;
        }

        protected override Task<HttpCommunicationClient> CreateClientAsync(string endpoint,
            CancellationToken cancellationToken)
        {
            Uri endpointUri = CreateEndpointUri(endpoint);
            return Task.FromResult(new HttpCommunicationClient(endpointUri, TimeSpan.FromSeconds(120)));
        }

        protected override void AbortClient(HttpCommunicationClient client)
        {

        }

        private Uri CreateEndpointUri(string endpoint)
        {
            if (string.IsNullOrEmpty(endpoint))
                throw new ArgumentNullException(nameof(endpoint));


            if (!endpoint.EndsWith("/"))
            {
                endpoint = endpoint + "/";
            }

            endpoint = endpoint.Replace("+", "localhost");

            if (!endpoint.Contains("://"))
            {
                endpoint = "http://" + endpoint;
            }

            return new Uri(endpoint, UriKind.Absolute);

        }
    }
}