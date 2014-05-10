In this project I'm exploring/testing/benchmarking different methods for real time communication.

The first method I'm exploring is periodic pull request to the server. This method isn't actual real time, but tries to simulate a constant communication between server and client, in such way that the user doesn't notice the difference.

I won't be considering authentication/authorization, only request processing, DB quering and network times.

I'll be using RubyOnRails as server technology and JS+jQuery for the client. The results should extrapolate to other server technologies.

Enjoy!

Periodic Pull
=====================

We first have to define the frecuency of the polling. Of course, the more frecuent the polling, the closer we get to real time, but it also increases the load on the server. We need to balance the frecuency and the server load, taking in consideration the latency between the client and the server.

I'm initially supposing a 300ms latency ( which is average in my ISP ). So, I'm initially setting the frecuency to 1000ms. Let's see how this evolves.

For this method, the server will be exposing a simple REST service that return the messages after a given timestamp. The client will store the timestamp recieved by the server so we don't have clock issues, and use it to query the server. 

Of course, a messaging system isn't very helpful if we don't have some sort of identification for the clients (users), so the client will first request an ID from the server to identify itself.

Push / Long Polling Connections
=========================

WebSockets
=========================