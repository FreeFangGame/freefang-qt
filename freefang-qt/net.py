import struct

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
