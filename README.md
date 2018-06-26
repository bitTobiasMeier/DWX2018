# DWX 2018 : Microservices mit Azure Service Fabric
Beispielprojekt zu meinem Vortrags bei der Developer Week 2018 vom 25.06.2018. Weitere Informationen in meinem Blog unter https://blog.bridging-it.de/author/Tobias.Meier 

Die Anwendung enthält zwei Services, beide in .Net Core 2.0 geschrieben: Der Gateway-Service ist Stateless und er MenuCardService Statefull. Zur Kommunikation werden sowohl .Net Remoting als auch Http verwendet.

Die Anwendung kann sowohl in einem Windows-Cluster als auch im lokalen Linux-Cluster betrieben werden.

Für ein Deployment nach Linux bitte zuerst das Bash-Script "./build.sh" und anschließend "./install.sh" aufrufen.
Weitere Infos in Kürze in meinem Blog unter https://blog.bridging-it.de/author/Tobias.Meier 

