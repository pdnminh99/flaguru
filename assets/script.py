import os
import xlrd as readxl
import xlwt as writexl
import wikipedia as wiki
import re
import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore
import datetime

# 1) Europe
# 2) Asia
# 3) Africa
# 4) Australia
# 5) North America
# 6) South America
# 7) EuropeAsia

def initFirebaseData():
    cred = credentials.Certificate('./google-services.json')
    firebase_admin.initialize_app(cred)
    db = firestore.client()
    map = {
        1: 'Europe',
        2: 'Asia',
        3: 'Africa',
        4: 'Australia and Ocenia',
        5: 'North America',
        6: 'South America',
        7: 'Europe and Asia',
    }
    wb = readxl.open_workbook('countries.xls')
    sheet = wb.sheet_by_index(0)
    doc_ref = db.collection('countries')
    id = 1291
    for row in range(0, 197):
        id = 1291 + row
        name = sheet.cell(row, 1).value
        flag = sheet.cell(row, 3).value
        contintent = map[int(sheet.cell(row, 4).value)]
        doc_ref.document(f'{id}').set({
            'name': name,
            'continent': contintent,
            'callcounter': 0,
            'correctcounter': 0,
            'ratio': 0,
            'recentupdatedate': datetime.datetime.now(),
        })



# def parseYMLformat():
#     f = open('text.txt', 'w')
#     for filename in os.listdir(os.path.curdir):
#         if filename.endswith('.png'):
#             f.write(f'   - assets/images/{filename}')


# def parseInsertQueries():
#     f = open('text.txt', 'w')
#     for filename in os.listdir(f"{os.path.curdir}/images"):
#         if filename.endswith('.png'):
#             extractedName = filename[8:len(filename)-4].replace('-', ' ')
#             f.write(
#                 f"INSERT INTO country(name, flag, ratio, description) VALUES('{extractedName}', 'assets/images/{filename}', 100, '{extractedName} is a country of ...');\n")


def search(countries):
    # for excel
    location = f"{os.path.curdir}/countries.xls"
    # regular calculations
    percentage = 0
    data = {}
    row = 0
    col = 0
    wb = writexl.Workbook()
    countriessheet = wb.add_sheet('countries')
    searchresult = ['']
    summary = ''
    fail = []
    for country in countries:
        # writeCountryDescriptionToText(country, result)
        os.system('cls')
        print(f'Collecting {searchresult[0]} data\nSUMMARY: {summary[:50]}')
        print("progress: {:.1f}% completed".format(
            (percentage/len(countries))*100))
        try:
            searchresult = wiki.search(country['name'])
            summary = wiki.summary(searchresult[0]).split('\n')[0]
            # filtering
            summary = re.sub(r' \([^\(\)]*?\)', '', summary)
            summary = re.sub(r' \([^\(\)]*?\)', '', summary)
            summary = re.sub(r' \([^\(\)]*?\)', '', summary)
            summary = re.sub(r' \([^\(\)]*?\)', '', summary)
            summary = re.sub(r' \([^\(\)]*?\)', '', summary)
            # write to excel file
            countriessheet.write(row, col, row)
            countriessheet.write(row, col + 1, country['name'])
            countriessheet.write(row, col + 2, summary)
            countriessheet.write(row, col + 3, country['flag'])
            countriessheet.write(row, col + 4, country['continent'])
            row += 1
        except:
            fail.append(country)
        # print progress
        percentage += 1
    for country in fail:
        countriessheet.write(row, col, row)
        countriessheet.write(row, col + 1, country['name'])
        countriessheet.write(row, col + 3, country['flag'])
        countriessheet.write(row, col + 4, country['continent'])
        row += 1
    wb.save(location)

def getcountries():
    countries = []
    # get European countries.
    for filename in os.listdir(f"{os.path.curdir}/images/Europe"):
        if filename.endswith('.png'):
            newcountry = {
                'description': '',
                'flag': f'assets/images/Europe/{filename}',
                'name': filename[8:len(filename)-4].replace('-', ' '),
                'continent': 1,
            }
            countries.append(newcountry)
    # get Asia countries.
    for filename in os.listdir(f"{os.path.curdir}/images/Asia"):
        if filename.endswith('.png'):
            newcountry = {
                'description': '',
                'flag': f'assets/images/Asia/{filename}',
                'name': filename[8:len(filename)-4].replace('-', ' '),
                'continent': 2,
            }
            countries.append(newcountry)
    # get Africa countries.
    for filename in os.listdir(f"{os.path.curdir}/images/Africa"):
        if filename.endswith('.png'):
            newcountry = {
                'description': '',
                'flag': f'assets/images/Africa/{filename}',
                'name': filename[8:len(filename)-4].replace('-', ' '),
                'continent': 3,
            }
            countries.append(newcountry)
    # get Australia and Oceania countries.
    for filename in os.listdir(f"{os.path.curdir}/images/AustraliaOceania"):
        if filename.endswith('.png'):
            newcountry = {
                'description': '',
                'flag': f'assets/images/AustraliaOceania/{filename}',
                'name': filename[8:len(filename)-4].replace('-', ' '),
                'continent': 4,
            }
            countries.append(newcountry)
    # get NA countries.
    for filename in os.listdir(f"{os.path.curdir}/images/NorthAmerica"):
        if filename.endswith('.png'):
            newcountry = {
                'description': '',
                'flag': f'assets/images/NorthAmerica/{filename}',
                'name': filename[8:len(filename)-4].replace('-', ' '),
                'continent': 5,
            }
            countries.append(newcountry)
    # get SA countries.
    for filename in os.listdir(f"{os.path.curdir}/images/SouthAmerica"):
        if filename.endswith('.png'):
            newcountry = {
                'description': '',
                'flag': f'assets/images/SouthAmerica/{filename}',
                'name': filename[8:len(filename)-4].replace('-', ' '),
                'continent': 6,
            }
            countries.append(newcountry)
    return countries

def writeCountryDescriptionToText(name, description):
    textfile = open(f'descriptions/{name}.txt', 'w')
    textfile.write(description)
    textfile.close()

def parseinsertquery():
    wb = readxl.open_workbook('countries.xls')
    sheet = wb.sheet_by_index(0)
    query = ''
    for row in range(0, 197):
        description = sheet.cell(row, 2).value.replace('\'', '\'\'')
        # description = re.sub(r' \([^\(\)]*?\)', '', description)
        # description = re.sub(r' \([^\(\)]*?\)', '', description)
        # description = re.sub(r' \([^\(\)]*?\)', '', description)
        # description = re.sub(r' \([^\(\)]*?\)', '', description)
        # description = re.sub(r' \([^\(\)]*?\)', '', description)
        query += f"""
INSERT INTO country(name, flag, description, callcounter, correctcounter, chances, continent)
VALUES ('{sheet.cell(row, 1).value}', '{sheet.cell(row, 3).value}', '{description}', 0, 0, 0, {int(sheet.cell(row, 4).value)});
        """
    with open('text.txt', 'w', encoding='utf-8') as f:
        f.write(query)


if __name__ == "__main__":
    # countries = getcountries()
    # for i in range(0, len(countries)):
    #     counter = 0
    #     for country in countries:
    #         if countries[i]['name'] == country['name']:
    #             counter += 1
    #     if counter > 1:
    #         print(countries[i])

    # search(countries)
    #parseinsertquery()
    initFirebaseData()
    # cutparagraphs()
