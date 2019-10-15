import os


def parseYMLformat():
    f = open('text.txt', 'w')
    for filename in os.listdir(os.path.curdir):
        if filename.endswith('.png'):
            f.write(f'   - assets/images/{filename}')


def parseInsertQueries():
    f = open('text.txt', 'w')
    for filename in os.listdir(f"{os.path.curdir}/images"):
        if filename.endswith('.png'):
            extractedName = filename[8:len(filename)-4].replace('-', ' ')
            f.write(
                f"INSERT INTO country(name, flag, ratio, description) VALUES('{extractedName}', 'assets/images/{filename}', 100, '{extractedName} is a country of ...');\n")


if __name__ == "__main__":
    parseInsertQueries()
