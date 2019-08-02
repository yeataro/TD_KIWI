import json

with open('icons.json') as json_data:
    data = json.load(json_data)

    tsv = 'name\tchr\ttag\n'
    tags = []
    cont = 0
    for element in data: 
        try:
            tag = element['tags'][0]
        except IndexError:
            tag = "(No Tag " + str(int(cont/100)).zfill(2) + ")"
            cont += 1

        newline = element['name']+"\t"+"0x"+element['codepoint']+"\t"+tag+"\n"
        #print(newline)
        tags.append(tag)
        tsv = tsv+newline

print(tsv)
tags = set(tags)
tags = list(tags)
taglist = ""


for Tlist in tags:
    taglist = Tlist+"\n"+taglist

print(taglist)
print(tags)

with open('iconlist.tsv','w') as outputf:
    outputf.write(tsv)
with open('tags.tsv','w') as outputf:
    outputf.write(taglist)
with open('tags.txt','w') as outputf:
    outputf.write(str(tags))