import psycopg2 as pg
import json

#def menu(choices):
#    choice = ''
#    while choice not in range(len(choices)):
#        for i,x in enumerate(choices):
#            print(i,'-',x)
#        choice = int(input('> '))

def visualizza(cur):
    query = 'select * from spese'
    cur.execute(query)
    print(' | '.join(str(x) for x in cur.description))
    for row in cur:
        print(' | '.join('%20s'%str(x) for x in row))

with open('/tmp/config.json') as f:
    config = json.loads(f.read())
with pg.connect(**config) as conn:
    with conn.cursor() as cur:
        #query = 'insert into spese values (%s'
        #query_params = ()
        #cur.execute(query,query_params)
        visualizza(cur)
print(':-)')
