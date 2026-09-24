import fitz, sys, csv, re
src, out = sys.argv[1], sys.argv[2]
KEYS = {'data element':'element','description':'description','conformance':'conformance','cardinality':'cardinality','values':'values','guidance':'guidance'}
doc = fitz.open(src)
idre = re.compile(r'^(\d+(?:\.\d+)+|\d+\.\d+|\d+)\.?\s+(.*)$', re.S)
elements=[]; cur=None
norm = lambda s: re.sub(r'\s+',' ',s or '').strip()
for pno in range(len(doc)):
    page = doc[pno]
    tabs = page.find_tables()
    for t in tabs.tables:
        data = t.extract()
        cols = None
        for ri,row in enumerate(t.rows):
            texts = [norm(x) for x in data[ri]]
            lower = [x.lower() for x in texts]
            if 'description' in lower and ('conformance' in lower or 'cardinality' in lower):
                cols = []
                for ci,c in enumerate(row.cells):
                    if c and texts[ci].lower() in KEYS: cols.append(((c[0]+c[2])/2, KEYS[texts[ci].lower()]))
                continue
            if not cols: continue
            rec={}
            for ci,c in enumerate(row.cells):
                if not c or not texts[ci]: continue
                xc=(c[0]+c[2])/2
                key=min(cols,key=lambda k:abs(k[0]-xc))[1]
                rec[key]=(rec.get(key,'')+' '+texts[ci]).strip()
            if not rec or set(rec.values())<= {'P','D','P D'}: continue
            m = idre.match(rec.get('element',''))
            if m and ('conformance' in rec or 'description' in rec):
                cur={'page':pno+1,'id':m.group(1),'element':m.group(2)}
                for k in ['description','conformance','cardinality','values','guidance']: cur[k]=rec.get(k,'')
                elements.append(cur)
            elif cur:
                for k,v in rec.items():
                    if v in ('P','D','P D'): continue
                    cur[k]=(cur.get(k,'')+' '+v).strip()
for e in elements:
    name=e['element']
    e['pd']=''.join(t for t in ['P','D'] if re.search(r'(^|\s)'+t+r'(\s|$)',name))
    e['auto']='#' if '#' in name else ''
    e['element']=re.sub(r'(\s+[PD])+\s*$','',re.sub(r'#','',name)).strip()
    e['element']=re.sub(r'\s+[PD](\s+[PD])*\s+',' ',e['element'])
    e['cardinality']=re.sub(r'\s','',e['cardinality'].replace('…','..'))
    e['values']=e['values'].replace('Alpha- numeric','Alpha-numeric')
with open(out,'w',newline='',encoding='utf-8') as f:
    w=csv.DictWriter(f,fieldnames=['id','element','pd','auto','conformance','cardinality','values','description','guidance','page'])
    w.writeheader()
    for e in elements: w.writerow({k:e.get(k,'') for k in w.fieldnames})
print(len(elements))
