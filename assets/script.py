import os
import xlrd as readxl
import xlwt as writexl
import wikipedia as wiki
import re

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
            # write to excel file
            countriessheet.write(row, col, row)
            countriessheet.write(row, col + 1, searchresult[0])
            countriessheet.write(row, col + 2, country['flag'])
            countriessheet.write(row, col + 3, summary)
            row += 1
        except:
            fail.append(country)
        # print progress
        percentage += 1
    for country in fail:
        countriessheet.write(row, col, row)
        countriessheet.write(row, col + 1, country['name'])
        countriessheet.write(row, col + 2, country['flag'])
        row += 1
    wb.save(location)


def getcountries():
    countries = []
    for filename in os.listdir(f"{os.path.curdir}/images"):
        if filename.endswith('.png'):
            newcountry = {
                'description': '',
                'flag': f'assets/images/{filename}',
                'name': filename[8:len(filename)-4].replace('-', ' ')
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
        description = sheet.cell(row, 3).value.replace('\'', '\'\'')
        description = re.sub(r' \([^\(\)]*?\)', '', description)
        description = re.sub(r' \([^\(\)]*?\)', '', description)
        query += f"""
INSERT INTO country(name, flag, ratio, description)
VALUES ('{sheet.cell(row, 1).value}', '{sheet.cell(row, 2).value}', 100, '{description}');
        """
    with open('text.txt', 'w', encoding='utf-8') as f:
        f.write(query)

if __name__ == "__main__":
    parseinsertquery()
    # cutparagraphs()
