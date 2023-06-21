import json
from types import SimpleNamespace


def json_to_object(data): # Turn json data into an object
	return json.loads(data, object_hook=lambda d: SimpleNamespace(**d))
	
def object_to_json(obj):
	return json.dumps(obj.__dict__)

def packet_to_message(packet):
	obj = json_to_object(packet)
	
	
