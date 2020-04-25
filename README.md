![Logo](images/launcher-icon-android.png)

# FLAGURU

- Semester: 19.1A
- Subject: Practice Project A
- Topic: implement a national-flag quiz app for mobile devices.
- Initialize Date: Sep 25th, 2019 (old repos: https://github.com/pdnminh99/flaguru01), Oct 8th, 2019 (new repos: https://github.com/pdnminh99/flaguru)

## Contributors

1. Pham Do Nhat Minh (https://github.com/pdnminh99)
2. Pham Van Hieu (https://github.com/kai618)
3. Duong Gia Lac (https://github.com/LacDuongGia)
4. Truong Hoang Duy (https://github.com/truonghoangduy)
5. Nguyen Dang Cao (https://github.com/DangCao3659)

## Download Android installation file at:

https://drive.google.com/file/d/1kIGwDO9evZXn7RPy07j9PUvag1gQK63a/view?usp=sharing

## Data monitoring web-app for Flags classification at:

https://flaguru-35568.web.app/

## App screenshots

![GameplayScreen](/images/menu-screen.png)
![GameplayScreen](/images/Picture2.png)
![GameplayScreen](/images/Picture3.png)
![GameplayScreen](/images/Picture4.png)
![GameplayScreen](/images/Picture5.png)
![GameplayScreen](/images/Picture6.png)
![GameplayScreen](/images/Picture7.png)

## App system diagram

![System diagram](/images/Picture1.jpg)

## Flag classification strategy by Ratio

1. Drawbacks of traditional flags classification strategies.

- By marking each flag: Easy, but subjective.
- By location distance: Still subjective, depends on many other factors.

2. Function to calculate ratio that correct answer will occur.

Ratio = [ correct count / total call count ] * 100

- Flags start from ratio of Zero are considered as difficult.
- Flags start from ratio of 100 are considered as easy.
- Then flags start from the middle are considered as normal.
