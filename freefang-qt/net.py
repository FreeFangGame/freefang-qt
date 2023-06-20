import struct

def send_packet(packet, con):
	leng = struct.pack("<I", len(packet))
	con.sendall(leng + packet.encode())
