import os

def parseYMLformat():
    f = open('text.txt', 'w')
    for filename in os.listdir(os.path.curdir):
        if filename.endswith('.png'):
            f.write(f'   - assets/images/{filename}')

def parseInsertQueries():
    f = open('text.txt', 'w')
    counter = 0
    for filename in os.listdir(f"{os.path.curdir}/images"):
        if filename.endswith('.png'):
            f.write(f"await db.rawInsert(\n\"INSERT INTO country(id, name, flag) VALUES({counter}, '{filename[8:len(filename) - 4]}', 'assets/images/{filename}')\"\n);\n")
            counter += 1

if __name__ == "__main__":
    parseInsertQueries()