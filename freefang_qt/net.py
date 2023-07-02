import struct, ssl, socket

SERVER_TIMEOUT = 0.25

def send_packet(packet, con):
	leng = struct.pack("<I", len(packet))
	con.sendall(leng + packet.encode())
	
def readlength(con): # Read the length of the packet prepended to it
	unpack = con.recv(4) 
	leng = 0
	try:
		leng = struct.unpack("<I", unpack)[0]
		return leng
	except:
		return None
			
def read_packet(con):
	length = readlength(con)
	if not length:
		return None
	packet = con.recv(length).decode()
	if not packet:
		return None
	return packet

def connect_to_server(ip, port):
	try:
		# Try to connect with a normal verified SSL context
		sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
		sock.settimeout(SERVER_TIMEOUT)

		ctx = ssl.create_default_context()
		sock = ctx.wrap_socket(sock, server_hostname=ip)
		sock.connect((ip, int(port)))

	except ssl.SSLError: 
		# If an error is thrown due to the use of a self signed certificate create an unverified context
		# (This should be disabled by default or have a setting for it)
		sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
		sock.settimeout(SERVER_TIMEOUT)
			
		ctx = ssl._create_unverified_context()
		sock = ctx.wrap_socket(sock, server_hostname=ip)
		sock.connect((ip, int(port)))

	except TimeoutError: 
		# This would be caused by the server not being configured to use SSL and therefore not responding to SSL 
		# discussion, therefore connect without SSL.
		sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
		sock.settimeout(0.5)
		sock.connect((ip, int(port)))

	return sock
