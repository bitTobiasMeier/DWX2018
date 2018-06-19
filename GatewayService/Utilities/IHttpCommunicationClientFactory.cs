using Microsoft.ServiceFabric.Services.Communication.Client;

namespace GatewayService.Utilities
{
    public interface IHttpCommunicationClientFactory : ICommunicationClientFactory<HttpCommunicationClient>
    {

    }
}