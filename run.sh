#python -m SimpleHTTPServer 8111
python -c "import socket,SocketServer,CGIHTTPServer;SocketServer.TCPServer.address_family=socket.AF_INET6;CGIHTTPServer.test()" 8111
