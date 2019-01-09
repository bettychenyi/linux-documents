## Introduction

In many web service situations, we will see two basic concepts: ```SOAP``` and ```REST```. 
Actually, they can't be compared directly, since SOAP is a protocol and the REST is an architectural style or design principle (is **-not-** a protocol).

## SOAP

SOAP means ```"Simple Object Access Protocol"``` - so it is a **network protocol**,
which provides one solution of the message type/skeleton for client/server to transfer data.
SOAP protocol is based on ```HTTP``` protocol. The HTTP payload **must** be ```XML``` based message which is called ```"Envelop"```. 
The SOAP envelop has two parts: the ```header``` and the ```body```.
Below is an exmaple of a SOAP message:

```
POST /GetAddress HTTP/1.0
Host: www.xyz.org
Content-Type: text/xml; charset = utf-8
Content-Length: nnn

<?xml version = "1.0"?>
<SOAP-ENV:Envelope
   xmlns:SOAP-ENV = "http://www.w3.org/2001/12/soap-envelope"
   SOAP-ENV:encodingStyle = "http://www.w3.org/2001/12/soap-encoding">

   <SOAP-ENV:Body xmlns:m = "http://www.xyz.org/quotations">
      <m:GetQuotation>
         <m:QuotationsName>Bettychenyi</m:QuotationsName>
      </m:GetQuotation>
   </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
```

### REST


REST means ```"REpresentational State Transfer"```, which is a style of the web service API design. 
The key of this architectural desing is ```"stateless"```, 
what this means is that: the web server is stateless because it will not store any session/transaction states. 
In another word, the necessary state to handle the request is contained within the request itself, 
whether as part of the URI, query-string parameters, body, or headers. 

For ```RESTful``` API calls, each client request to the server requires that its state be fully represented in its request URL. 
The server must be able to completely understand the client request without using any server context or server session state. 
It follows that all state must be kept on the client and communicate with servier via its URL.

The **opposite** concept of the "stateless" is "stateful". ```Stateful``` would mean that the server stores some states, 
for example, session information to identify a user over multiple subsequent requests. 
If the session is valid, the requests would succeed; if the session has been validated in previous call, 
then the next call will succeed as the server keeps the state and knows that.

For the above user authentication exmaple, if this is ```Stateless``` or ```RESTful``` API design, 
then, the user authentication will be included in the request URL, for exmaple, as a ```token``` (for example JSON web token or oAuth). 
This token would be sent with each request (usually in the request headers). 
This removes the need for servers to keep session data, 
which affects scalability since moving to multiple servers otherwise requires sharing of session data.

Last, REST APIs payload could be XML, or JSON. Below is a message from an OpenStack API call. 

(**Note:** The ```OpenStack Compute API``` only supports ```JSON``` request and response formats, with a mime-type of ```application/json```. 
As there is only one supported content type, all content is assumed to be application/json in both request and response formats. 
But, The ```OpenStack Block Storage API``` supports both the ```JSON``` and ```XML``` data serialization formats. 
The request format is specified using the ```Content-Type``` header.)

```
GET /v2.1/214412/images HTTP/1.1
Host: servers.api.openstack.org
X-Auth-Token: eaaafd18-0fed-4b3a-81b4-663c99ec1cbb

{
    "server": {
        "name": "server-test-1",
        "imageRef": "b5660a6e-4b46-4be3-9707-6b47221b454f",
        "flavorRef": "2",
        "max_count": 1,
        "min_count": 1,
        "networks": [
            {
                "uuid": "d32019d3-bc6e-4319-9c1d-6722fc136a22"
            }
        ],
        "security_groups": [
            {
                "name": "default"
            },
            {
                "name": "another-secgroup-name"
            }
        ]
    }
}
```
