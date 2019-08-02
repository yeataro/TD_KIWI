import json

with open('icons.json') as json_data:
    data = json.load(json_data)
    for element in data: 
        del(element['path'] )
        del(element['id'] )
        del(element['author'] )
        del(element['version'] )
with open('icons_out.json','w') as outputf:
    json.dump(data,outputf,indent=4, sort_keys=True)