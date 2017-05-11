import psycopg2 as pg
import json
import getpass
import os

def menu(choices):
    choices = dict(enumerate(choices,1))
    choices[0]='exit'
    choice=''
    while choice not in choices:
        for key,value in choices.items():
            print(key,'-',value)
        choice = int(input('> '))
    return choices[choice]

def print_query(cur):
    rowformat = lambda xs : ' | '.join('{!s:^22}'.format(x) for x in xs)
    schema = [col[0] for col in cur.description]
    print(rowformat(schema))
    print('-'*len(rowformat(schema)))
    for row in cur:
        print(rowformat(row))

def visualizza(cur):
    query = 'select * from spese'
    cur.execute(query)
    print_query(cur)

def inserisci(cur):
    query = 'INSERT INTO spese (data,voce,importo) VALUES (%s,%s,%s)'
    rawvalues = datetime.dateinput('data: '), input('voce: '), input('importo: ')
    cur.execute(query,rawvalues)
    print_query(cur)

def rimuovi(cur):
    pass

def login(path='/tmp/tmp.json'):
    if os.path.exists(path):
        with open(path) as f:
            tmpdb = json.loads(f.read())
        user = tmpdb['user']
        passw = tmpdb['passw']
    else:
        user = input('user: ')
        passw = getpass.getpass('pass: ')
        tmpdb = {'user':user, 'passw':passw}
        with open(path,'w') as f:
            f.write(json.dumps(tmpdb))
    return user,passw

user, passw = login()
with pg.connect(database=user, user=user, password=passw, host='dbserver.scienze.univr.it') as conn:
    with conn:
        with conn.cursor() as cur:
            choices = {'view':visualizza,'add':inserisci,'rm':rimuovi}
            while True:
                choose = menu(choices.keys())
                if choose not in choices:
                    break
                choices[choose](cur)
print(':-)')
