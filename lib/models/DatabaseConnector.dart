import 'package:flaguru/models/Country.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseConnector {
  Future<Database> _connectSQLite() async {
    String path = join(await getDatabasesPath(), 'country.db');
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) async {
        var sqlite = await db.rawQuery(
            "SELECT name FROM sqlite_master WHERE type='table' AND name='country';");
        if (sqlite.toList().length == 0) {
          print("No table country found.");
          await db.execute(
            "CREATE TABLE country(id INTEGER PRIMARY KEY, name TEXT, flag TEXT)",
          );
        }
        var data = await db.rawQuery('SELECT * FROM country');
        var countries = data.toList();
        print("There are total ${countries.length} countries in database.");
        if (countries.length == 0) {
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(0, 'Afghanistan', 'assets/images/flag-of-Afghanistan.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(1, 'Albania', 'assets/images/flag-of-Albania.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(2, 'Algeria', 'assets/images/flag-of-Algeria.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(3, 'Andorra', 'assets/images/flag-of-Andorra.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(4, 'Angola', 'assets/images/flag-of-Angola.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(5, 'Antigua', 'assets/images/flag-of-Antigua.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(6, 'Argentina', 'assets/images/flag-of-Argentina.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(7, 'Armenia', 'assets/images/flag-of-Armenia.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(8, 'Australia', 'assets/images/flag-of-Australia.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(9, 'Austria', 'assets/images/flag-of-Austria.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(10, 'Azerbaijan', 'assets/images/flag-of-Azerbaijan.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(11, 'Bahamas', 'assets/images/flag-of-Bahamas.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(12, 'Bahrain', 'assets/images/flag-of-Bahrain.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(13, 'Bangladesh', 'assets/images/flag-of-Bangladesh.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(14, 'Barbados', 'assets/images/flag-of-Barbados.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(15, 'Belarus', 'assets/images/flag-of-Belarus.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(16, 'Belgium', 'assets/images/flag-of-Belgium.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(17, 'Belize', 'assets/images/flag-of-Belize.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(18, 'Benin', 'assets/images/flag-of-Benin.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(19, 'Bhutan', 'assets/images/flag-of-Bhutan.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(20, 'Bolivia', 'assets/images/flag-of-Bolivia.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(21, 'Bosnia-Herzegovina', 'assets/images/flag-of-Bosnia-Herzegovina.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(22, 'Botswana', 'assets/images/flag-of-Botswana.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(23, 'Brazil', 'assets/images/flag-of-Brazil.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(24, 'Brunei', 'assets/images/flag-of-Brunei.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(25, 'Bulgaria', 'assets/images/flag-of-Bulgaria.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(26, 'Burkina-Faso', 'assets/images/flag-of-Burkina-Faso.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(27, 'Burundi', 'assets/images/flag-of-Burundi.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(28, 'Cabo-Verde', 'assets/images/flag-of-Cabo-Verde.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(29, 'Cambodia', 'assets/images/flag-of-Cambodia.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(30, 'Cameroon', 'assets/images/flag-of-Cameroon.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(31, 'Canada', 'assets/images/flag-of-Canada.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(32, 'Central-African-Republic', 'assets/images/flag-of-Central-African-Republic.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(33, 'Chad', 'assets/images/flag-of-Chad.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(34, 'Chile', 'assets/images/flag-of-Chile.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(35, 'China', 'assets/images/flag-of-China.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(36, 'Colombia', 'assets/images/flag-of-Colombia.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(37, 'Comoros', 'assets/images/flag-of-Comoros.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(38, 'Congo-Democratic-Republic-of', 'assets/images/flag-of-Congo-Democratic-Republic-of.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(39, 'Congo', 'assets/images/flag-of-Congo.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(40, 'Costa-Rica', 'assets/images/flag-of-Costa-Rica.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(41, 'Cote-d-Ivoire', 'assets/images/flag-of-Cote-d-Ivoire.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(42, 'Croatia', 'assets/images/flag-of-Croatia.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(43, 'Cuba', 'assets/images/flag-of-Cuba.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(44, 'Cyprus', 'assets/images/flag-of-Cyprus.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(45, 'Czech-Republic', 'assets/images/flag-of-Czech-Republic.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(46, 'Denmark', 'assets/images/flag-of-Denmark.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(47, 'Djibouti', 'assets/images/flag-of-Djibouti.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(48, 'Dominica', 'assets/images/flag-of-Dominica.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(49, 'Dominican-Republic', 'assets/images/flag-of-Dominican-Republic.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(50, 'Ecuador', 'assets/images/flag-of-Ecuador.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(51, 'Egypt', 'assets/images/flag-of-Egypt.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(52, 'El-Salvador', 'assets/images/flag-of-El-Salvador.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(53, 'Equatorial-Guinea', 'assets/images/flag-of-Equatorial-Guinea.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(54, 'Eritrea', 'assets/images/flag-of-Eritrea.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(55, 'Estonia', 'assets/images/flag-of-Estonia.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(56, 'Eswatini', 'assets/images/flag-of-Eswatini.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(57, 'Ethiopia', 'assets/images/flag-of-Ethiopia.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(58, 'Fiji', 'assets/images/flag-of-Fiji.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(59, 'Finland', 'assets/images/flag-of-Finland.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(60, 'France', 'assets/images/flag-of-France.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(61, 'Gabon', 'assets/images/flag-of-Gabon.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(62, 'Gambia', 'assets/images/flag-of-Gambia.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(63, 'Georgia', 'assets/images/flag-of-Georgia.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(64, 'Germany', 'assets/images/flag-of-Germany.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(65, 'Ghana', 'assets/images/flag-of-Ghana.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(66, 'Greece', 'assets/images/flag-of-Greece.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(67, 'Grenada', 'assets/images/flag-of-Grenada.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(68, 'Guatemala', 'assets/images/flag-of-Guatemala.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(69, 'Guinea-Bissau', 'assets/images/flag-of-Guinea-Bissau.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(70, 'Guinea', 'assets/images/flag-of-Guinea.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(71, 'Guyana', 'assets/images/flag-of-Guyana.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(72, 'Haiti', 'assets/images/flag-of-Haiti.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(73, 'Honduras', 'assets/images/flag-of-Honduras.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(74, 'Hungary', 'assets/images/flag-of-Hungary.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(75, 'Iceland', 'assets/images/flag-of-Iceland.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(76, 'India', 'assets/images/flag-of-India.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(77, 'Indonesia', 'assets/images/flag-of-Indonesia.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(78, 'Iran', 'assets/images/flag-of-Iran.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(79, 'Iraq', 'assets/images/flag-of-Iraq.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(80, 'Ireland', 'assets/images/flag-of-Ireland.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(81, 'Israel', 'assets/images/flag-of-Israel.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(82, 'Italy', 'assets/images/flag-of-Italy.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(83, 'Jamaica', 'assets/images/flag-of-Jamaica.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(84, 'Japan', 'assets/images/flag-of-Japan.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(85, 'Jordan', 'assets/images/flag-of-Jordan.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(86, 'Kazakhstan', 'assets/images/flag-of-Kazakhstan.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(87, 'Kenya', 'assets/images/flag-of-Kenya.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(88, 'Kiribati', 'assets/images/flag-of-Kiribati.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(89, 'Korea-North', 'assets/images/flag-of-Korea-North.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(90, 'Korea-South', 'assets/images/flag-of-Korea-South.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(91, 'Kosovo', 'assets/images/flag-of-Kosovo.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(92, 'Kuwait', 'assets/images/flag-of-Kuwait.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(93, 'Kyrgyzstan', 'assets/images/flag-of-Kyrgyzstan.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(94, 'Laos', 'assets/images/flag-of-Laos.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(95, 'Latvia', 'assets/images/flag-of-Latvia.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(96, 'Lebanon', 'assets/images/flag-of-Lebanon.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(97, 'Lesotho', 'assets/images/flag-of-Lesotho.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(98, 'Liberia', 'assets/images/flag-of-Liberia.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(99, 'Libya', 'assets/images/flag-of-Libya.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(100, 'Liechtenstein', 'assets/images/flag-of-Liechtenstein.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(101, 'Lithuania', 'assets/images/flag-of-Lithuania.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(102, 'Luxembourg', 'assets/images/flag-of-Luxembourg.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(103, 'Madagascar', 'assets/images/flag-of-Madagascar.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(104, 'Malawi', 'assets/images/flag-of-Malawi.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(105, 'Malaysia', 'assets/images/flag-of-Malaysia.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(106, 'Maldives', 'assets/images/flag-of-Maldives.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(107, 'Mali', 'assets/images/flag-of-Mali.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(108, 'Malta', 'assets/images/flag-of-Malta.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(109, 'Marshall-Islands', 'assets/images/flag-of-Marshall-Islands.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(110, 'Mauritania', 'assets/images/flag-of-Mauritania.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(111, 'Mauritius', 'assets/images/flag-of-Mauritius.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(112, 'Mexico', 'assets/images/flag-of-Mexico.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(113, 'Micronesia', 'assets/images/flag-of-Micronesia.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(114, 'Moldova', 'assets/images/flag-of-Moldova.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(115, 'Monaco', 'assets/images/flag-of-Monaco.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(116, 'Mongolia', 'assets/images/flag-of-Mongolia.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(117, 'Montenegro', 'assets/images/flag-of-Montenegro.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(118, 'Morocco', 'assets/images/flag-of-Morocco.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(119, 'Mozambique', 'assets/images/flag-of-Mozambique.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(120, 'Myanmar', 'assets/images/flag-of-Myanmar.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(121, 'Namibia', 'assets/images/flag-of-Namibia.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(122, 'Nauru', 'assets/images/flag-of-Nauru.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(123, 'Nepal', 'assets/images/flag-of-Nepal.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(124, 'Netherlands', 'assets/images/flag-of-Netherlands.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(125, 'New-Zealand', 'assets/images/flag-of-New-Zealand.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(126, 'Nicaragua', 'assets/images/flag-of-Nicaragua.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(127, 'Niger', 'assets/images/flag-of-Niger.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(128, 'Nigeria', 'assets/images/flag-of-Nigeria.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(129, 'North-Macedonia', 'assets/images/flag-of-North-Macedonia.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(130, 'Norway', 'assets/images/flag-of-Norway.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(131, 'Oman', 'assets/images/flag-of-Oman.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(132, 'Pakistan', 'assets/images/flag-of-Pakistan.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(133, 'Palau', 'assets/images/flag-of-Palau.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(134, 'Palestine', 'assets/images/flag-of-Palestine.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(135, 'Panama', 'assets/images/flag-of-Panama.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(136, 'Papua-New-Guinea', 'assets/images/flag-of-Papua-New-Guinea.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(137, 'Paraguay', 'assets/images/flag-of-Paraguay.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(138, 'Peru', 'assets/images/flag-of-Peru.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(139, 'Philippines', 'assets/images/flag-of-Philippines.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(140, 'Poland', 'assets/images/flag-of-Poland.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(141, 'Portugal', 'assets/images/flag-of-Portugal.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(142, 'Qatar', 'assets/images/flag-of-Qatar.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(143, 'Romania', 'assets/images/flag-of-Romania.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(144, 'Russia', 'assets/images/flag-of-Russia.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(145, 'Rwanda', 'assets/images/flag-of-Rwanda.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(146, 'Samoa', 'assets/images/flag-of-Samoa.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(147, 'San-Marino', 'assets/images/flag-of-San-Marino.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(148, 'Sao-Tome-and-Principe', 'assets/images/flag-of-Sao-Tome-and-Principe.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(149, 'Saudi-Arabia', 'assets/images/flag-of-Saudi-Arabia.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(150, 'Senegal', 'assets/images/flag-of-Senegal.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(151, 'Serbia', 'assets/images/flag-of-Serbia.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(152, 'Seychelles', 'assets/images/flag-of-Seychelles.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(153, 'Sierra-Leone', 'assets/images/flag-of-Sierra-Leone.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(154, 'Singapore', 'assets/images/flag-of-Singapore.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(155, 'Slovakia', 'assets/images/flag-of-Slovakia.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(156, 'Slovenia', 'assets/images/flag-of-Slovenia.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(157, 'Solomon-Islands', 'assets/images/flag-of-Solomon-Islands.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(158, 'Somalia', 'assets/images/flag-of-Somalia.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(159, 'South-Africa', 'assets/images/flag-of-South-Africa.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(160, 'South-Sudan', 'assets/images/flag-of-South-Sudan.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(161, 'Spain', 'assets/images/flag-of-Spain.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(162, 'Sri-Lanka', 'assets/images/flag-of-Sri-Lanka.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(163, 'St-Kitts-Nevis', 'assets/images/flag-of-St-Kitts-Nevis.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(164, 'St-Lucia', 'assets/images/flag-of-St-Lucia.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(165, 'St-Vincent-the-Grenadines', 'assets/images/flag-of-St-Vincent-the-Grenadines.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(166, 'Sudan', 'assets/images/flag-of-Sudan.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(167, 'Suriname', 'assets/images/flag-of-Suriname.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(168, 'Sweden', 'assets/images/flag-of-Sweden.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(169, 'Switzerland', 'assets/images/flag-of-Switzerland.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(170, 'Syria', 'assets/images/flag-of-Syria.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(171, 'Taiwan', 'assets/images/flag-of-Taiwan.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(172, 'Tajikistan', 'assets/images/flag-of-Tajikistan.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(173, 'Tanzania', 'assets/images/flag-of-Tanzania.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(174, 'Thailand', 'assets/images/flag-of-Thailand.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(175, 'Timor-Leste', 'assets/images/flag-of-Timor-Leste.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(176, 'Togo', 'assets/images/flag-of-Togo.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(177, 'Tonga', 'assets/images/flag-of-Tonga.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(178, 'Trinidad-and-Tobago', 'assets/images/flag-of-Trinidad-and-Tobago.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(179, 'Tunisia', 'assets/images/flag-of-Tunisia.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(180, 'Turkey', 'assets/images/flag-of-Turkey.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(181, 'Turkmenistan', 'assets/images/flag-of-Turkmenistan.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(182, 'Tuvalu', 'assets/images/flag-of-Tuvalu.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(183, 'Uganda', 'assets/images/flag-of-Uganda.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(184, 'Ukraine', 'assets/images/flag-of-Ukraine.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(185, 'United-Arab-Emirates', 'assets/images/flag-of-United-Arab-Emirates.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(186, 'United-Kingdom', 'assets/images/flag-of-United-Kingdom.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(187, 'United-States-of-America', 'assets/images/flag-of-United-States-of-America.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(188, 'Uruguay', 'assets/images/flag-of-Uruguay.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(189, 'Uzbekistan', 'assets/images/flag-of-Uzbekistan.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(190, 'Vanuatu', 'assets/images/flag-of-Vanuatu.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(191, 'Vatican-City', 'assets/images/flag-of-Vatican-City.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(192, 'Venezuela', 'assets/images/flag-of-Venezuela.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(193, 'Vietnam', 'assets/images/flag-of-Vietnam.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(194, 'Yemen', 'assets/images/flag-of-Yemen.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(195, 'Zambia', 'assets/images/flag-of-Zambia.png')");
          await db.rawInsert(
              "INSERT INTO country(id, name, flag) VALUES(196, 'Zimbabwe', 'assets/images/flag-of-Zimbabwe.png')");
        }
        print("There are ${countries.length} countries in database.");
      },
      onCreate: (db, version) async {
        await db.execute(
          "CREATE TABLE country(id INTEGER PRIMARY KEY, name TEXT, flag TEXT)",
        );
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(0, 'Afghanistan', 'assets/images/flag-of-Afghanistan.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(1, 'Albania', 'assets/images/flag-of-Albania.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(2, 'Algeria', 'assets/images/flag-of-Algeria.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(3, 'Andorra', 'assets/images/flag-of-Andorra.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(4, 'Angola', 'assets/images/flag-of-Angola.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(5, 'Antigua', 'assets/images/flag-of-Antigua.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(6, 'Argentina', 'assets/images/flag-of-Argentina.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(7, 'Armenia', 'assets/images/flag-of-Armenia.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(8, 'Australia', 'assets/images/flag-of-Australia.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(9, 'Austria', 'assets/images/flag-of-Austria.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(10, 'Azerbaijan', 'assets/images/flag-of-Azerbaijan.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(11, 'Bahamas', 'assets/images/flag-of-Bahamas.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(12, 'Bahrain', 'assets/images/flag-of-Bahrain.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(13, 'Bangladesh', 'assets/images/flag-of-Bangladesh.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(14, 'Barbados', 'assets/images/flag-of-Barbados.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(15, 'Belarus', 'assets/images/flag-of-Belarus.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(16, 'Belgium', 'assets/images/flag-of-Belgium.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(17, 'Belize', 'assets/images/flag-of-Belize.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(18, 'Benin', 'assets/images/flag-of-Benin.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(19, 'Bhutan', 'assets/images/flag-of-Bhutan.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(20, 'Bolivia', 'assets/images/flag-of-Bolivia.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(21, 'Bosnia-Herzegovina', 'assets/images/flag-of-Bosnia-Herzegovina.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(22, 'Botswana', 'assets/images/flag-of-Botswana.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(23, 'Brazil', 'assets/images/flag-of-Brazil.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(24, 'Brunei', 'assets/images/flag-of-Brunei.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(25, 'Bulgaria', 'assets/images/flag-of-Bulgaria.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(26, 'Burkina-Faso', 'assets/images/flag-of-Burkina-Faso.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(27, 'Burundi', 'assets/images/flag-of-Burundi.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(28, 'Cabo-Verde', 'assets/images/flag-of-Cabo-Verde.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(29, 'Cambodia', 'assets/images/flag-of-Cambodia.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(30, 'Cameroon', 'assets/images/flag-of-Cameroon.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(31, 'Canada', 'assets/images/flag-of-Canada.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(32, 'Central-African-Republic', 'assets/images/flag-of-Central-African-Republic.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(33, 'Chad', 'assets/images/flag-of-Chad.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(34, 'Chile', 'assets/images/flag-of-Chile.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(35, 'China', 'assets/images/flag-of-China.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(36, 'Colombia', 'assets/images/flag-of-Colombia.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(37, 'Comoros', 'assets/images/flag-of-Comoros.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(38, 'Congo-Democratic-Republic-of', 'assets/images/flag-of-Congo-Democratic-Republic-of.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(39, 'Congo', 'assets/images/flag-of-Congo.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(40, 'Costa-Rica', 'assets/images/flag-of-Costa-Rica.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(41, 'Cote-d-Ivoire', 'assets/images/flag-of-Cote-d-Ivoire.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(42, 'Croatia', 'assets/images/flag-of-Croatia.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(43, 'Cuba', 'assets/images/flag-of-Cuba.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(44, 'Cyprus', 'assets/images/flag-of-Cyprus.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(45, 'Czech-Republic', 'assets/images/flag-of-Czech-Republic.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(46, 'Denmark', 'assets/images/flag-of-Denmark.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(47, 'Djibouti', 'assets/images/flag-of-Djibouti.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(48, 'Dominica', 'assets/images/flag-of-Dominica.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(49, 'Dominican-Republic', 'assets/images/flag-of-Dominican-Republic.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(50, 'Ecuador', 'assets/images/flag-of-Ecuador.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(51, 'Egypt', 'assets/images/flag-of-Egypt.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(52, 'El-Salvador', 'assets/images/flag-of-El-Salvador.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(53, 'Equatorial-Guinea', 'assets/images/flag-of-Equatorial-Guinea.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(54, 'Eritrea', 'assets/images/flag-of-Eritrea.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(55, 'Estonia', 'assets/images/flag-of-Estonia.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(56, 'Eswatini', 'assets/images/flag-of-Eswatini.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(57, 'Ethiopia', 'assets/images/flag-of-Ethiopia.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(58, 'Fiji', 'assets/images/flag-of-Fiji.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(59, 'Finland', 'assets/images/flag-of-Finland.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(60, 'France', 'assets/images/flag-of-France.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(61, 'Gabon', 'assets/images/flag-of-Gabon.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(62, 'Gambia', 'assets/images/flag-of-Gambia.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(63, 'Georgia', 'assets/images/flag-of-Georgia.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(64, 'Germany', 'assets/images/flag-of-Germany.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(65, 'Ghana', 'assets/images/flag-of-Ghana.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(66, 'Greece', 'assets/images/flag-of-Greece.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(67, 'Grenada', 'assets/images/flag-of-Grenada.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(68, 'Guatemala', 'assets/images/flag-of-Guatemala.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(69, 'Guinea-Bissau', 'assets/images/flag-of-Guinea-Bissau.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(70, 'Guinea', 'assets/images/flag-of-Guinea.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(71, 'Guyana', 'assets/images/flag-of-Guyana.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(72, 'Haiti', 'assets/images/flag-of-Haiti.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(73, 'Honduras', 'assets/images/flag-of-Honduras.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(74, 'Hungary', 'assets/images/flag-of-Hungary.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(75, 'Iceland', 'assets/images/flag-of-Iceland.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(76, 'India', 'assets/images/flag-of-India.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(77, 'Indonesia', 'assets/images/flag-of-Indonesia.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(78, 'Iran', 'assets/images/flag-of-Iran.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(79, 'Iraq', 'assets/images/flag-of-Iraq.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(80, 'Ireland', 'assets/images/flag-of-Ireland.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(81, 'Israel', 'assets/images/flag-of-Israel.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(82, 'Italy', 'assets/images/flag-of-Italy.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(83, 'Jamaica', 'assets/images/flag-of-Jamaica.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(84, 'Japan', 'assets/images/flag-of-Japan.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(85, 'Jordan', 'assets/images/flag-of-Jordan.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(86, 'Kazakhstan', 'assets/images/flag-of-Kazakhstan.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(87, 'Kenya', 'assets/images/flag-of-Kenya.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(88, 'Kiribati', 'assets/images/flag-of-Kiribati.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(89, 'Korea-North', 'assets/images/flag-of-Korea-North.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(90, 'Korea-South', 'assets/images/flag-of-Korea-South.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(91, 'Kosovo', 'assets/images/flag-of-Kosovo.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(92, 'Kuwait', 'assets/images/flag-of-Kuwait.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(93, 'Kyrgyzstan', 'assets/images/flag-of-Kyrgyzstan.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(94, 'Laos', 'assets/images/flag-of-Laos.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(95, 'Latvia', 'assets/images/flag-of-Latvia.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(96, 'Lebanon', 'assets/images/flag-of-Lebanon.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(97, 'Lesotho', 'assets/images/flag-of-Lesotho.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(98, 'Liberia', 'assets/images/flag-of-Liberia.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(99, 'Libya', 'assets/images/flag-of-Libya.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(100, 'Liechtenstein', 'assets/images/flag-of-Liechtenstein.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(101, 'Lithuania', 'assets/images/flag-of-Lithuania.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(102, 'Luxembourg', 'assets/images/flag-of-Luxembourg.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(103, 'Madagascar', 'assets/images/flag-of-Madagascar.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(104, 'Malawi', 'assets/images/flag-of-Malawi.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(105, 'Malaysia', 'assets/images/flag-of-Malaysia.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(106, 'Maldives', 'assets/images/flag-of-Maldives.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(107, 'Mali', 'assets/images/flag-of-Mali.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(108, 'Malta', 'assets/images/flag-of-Malta.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(109, 'Marshall-Islands', 'assets/images/flag-of-Marshall-Islands.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(110, 'Mauritania', 'assets/images/flag-of-Mauritania.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(111, 'Mauritius', 'assets/images/flag-of-Mauritius.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(112, 'Mexico', 'assets/images/flag-of-Mexico.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(113, 'Micronesia', 'assets/images/flag-of-Micronesia.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(114, 'Moldova', 'assets/images/flag-of-Moldova.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(115, 'Monaco', 'assets/images/flag-of-Monaco.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(116, 'Mongolia', 'assets/images/flag-of-Mongolia.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(117, 'Montenegro', 'assets/images/flag-of-Montenegro.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(118, 'Morocco', 'assets/images/flag-of-Morocco.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(119, 'Mozambique', 'assets/images/flag-of-Mozambique.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(120, 'Myanmar', 'assets/images/flag-of-Myanmar.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(121, 'Namibia', 'assets/images/flag-of-Namibia.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(122, 'Nauru', 'assets/images/flag-of-Nauru.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(123, 'Nepal', 'assets/images/flag-of-Nepal.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(124, 'Netherlands', 'assets/images/flag-of-Netherlands.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(125, 'New-Zealand', 'assets/images/flag-of-New-Zealand.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(126, 'Nicaragua', 'assets/images/flag-of-Nicaragua.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(127, 'Niger', 'assets/images/flag-of-Niger.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(128, 'Nigeria', 'assets/images/flag-of-Nigeria.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(129, 'North-Macedonia', 'assets/images/flag-of-North-Macedonia.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(130, 'Norway', 'assets/images/flag-of-Norway.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(131, 'Oman', 'assets/images/flag-of-Oman.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(132, 'Pakistan', 'assets/images/flag-of-Pakistan.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(133, 'Palau', 'assets/images/flag-of-Palau.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(134, 'Palestine', 'assets/images/flag-of-Palestine.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(135, 'Panama', 'assets/images/flag-of-Panama.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(136, 'Papua-New-Guinea', 'assets/images/flag-of-Papua-New-Guinea.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(137, 'Paraguay', 'assets/images/flag-of-Paraguay.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(138, 'Peru', 'assets/images/flag-of-Peru.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(139, 'Philippines', 'assets/images/flag-of-Philippines.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(140, 'Poland', 'assets/images/flag-of-Poland.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(141, 'Portugal', 'assets/images/flag-of-Portugal.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(142, 'Qatar', 'assets/images/flag-of-Qatar.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(143, 'Romania', 'assets/images/flag-of-Romania.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(144, 'Russia', 'assets/images/flag-of-Russia.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(145, 'Rwanda', 'assets/images/flag-of-Rwanda.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(146, 'Samoa', 'assets/images/flag-of-Samoa.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(147, 'San-Marino', 'assets/images/flag-of-San-Marino.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(148, 'Sao-Tome-and-Principe', 'assets/images/flag-of-Sao-Tome-and-Principe.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(149, 'Saudi-Arabia', 'assets/images/flag-of-Saudi-Arabia.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(150, 'Senegal', 'assets/images/flag-of-Senegal.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(151, 'Serbia', 'assets/images/flag-of-Serbia.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(152, 'Seychelles', 'assets/images/flag-of-Seychelles.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(153, 'Sierra-Leone', 'assets/images/flag-of-Sierra-Leone.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(154, 'Singapore', 'assets/images/flag-of-Singapore.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(155, 'Slovakia', 'assets/images/flag-of-Slovakia.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(156, 'Slovenia', 'assets/images/flag-of-Slovenia.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(157, 'Solomon-Islands', 'assets/images/flag-of-Solomon-Islands.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(158, 'Somalia', 'assets/images/flag-of-Somalia.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(159, 'South-Africa', 'assets/images/flag-of-South-Africa.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(160, 'South-Sudan', 'assets/images/flag-of-South-Sudan.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(161, 'Spain', 'assets/images/flag-of-Spain.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(162, 'Sri-Lanka', 'assets/images/flag-of-Sri-Lanka.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(163, 'St-Kitts-Nevis', 'assets/images/flag-of-St-Kitts-Nevis.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(164, 'St-Lucia', 'assets/images/flag-of-St-Lucia.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(165, 'St-Vincent-the-Grenadines', 'assets/images/flag-of-St-Vincent-the-Grenadines.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(166, 'Sudan', 'assets/images/flag-of-Sudan.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(167, 'Suriname', 'assets/images/flag-of-Suriname.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(168, 'Sweden', 'assets/images/flag-of-Sweden.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(169, 'Switzerland', 'assets/images/flag-of-Switzerland.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(170, 'Syria', 'assets/images/flag-of-Syria.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(171, 'Taiwan', 'assets/images/flag-of-Taiwan.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(172, 'Tajikistan', 'assets/images/flag-of-Tajikistan.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(173, 'Tanzania', 'assets/images/flag-of-Tanzania.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(174, 'Thailand', 'assets/images/flag-of-Thailand.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(175, 'Timor-Leste', 'assets/images/flag-of-Timor-Leste.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(176, 'Togo', 'assets/images/flag-of-Togo.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(177, 'Tonga', 'assets/images/flag-of-Tonga.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(178, 'Trinidad-and-Tobago', 'assets/images/flag-of-Trinidad-and-Tobago.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(179, 'Tunisia', 'assets/images/flag-of-Tunisia.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(180, 'Turkey', 'assets/images/flag-of-Turkey.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(181, 'Turkmenistan', 'assets/images/flag-of-Turkmenistan.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(182, 'Tuvalu', 'assets/images/flag-of-Tuvalu.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(183, 'Uganda', 'assets/images/flag-of-Uganda.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(184, 'Ukraine', 'assets/images/flag-of-Ukraine.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(185, 'United-Arab-Emirates', 'assets/images/flag-of-United-Arab-Emirates.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(186, 'United-Kingdom', 'assets/images/flag-of-United-Kingdom.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(187, 'United-States-of-America', 'assets/images/flag-of-United-States-of-America.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(188, 'Uruguay', 'assets/images/flag-of-Uruguay.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(189, 'Uzbekistan', 'assets/images/flag-of-Uzbekistan.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(190, 'Vanuatu', 'assets/images/flag-of-Vanuatu.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(191, 'Vatican-City', 'assets/images/flag-of-Vatican-City.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(192, 'Venezuela', 'assets/images/flag-of-Venezuela.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(193, 'Vietnam', 'assets/images/flag-of-Vietnam.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(194, 'Yemen', 'assets/images/flag-of-Yemen.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(195, 'Zambia', 'assets/images/flag-of-Zambia.png')");
        await db.rawInsert(
            "INSERT INTO country(id, name, flag) VALUES(196, 'Zimbabwe', 'assets/images/flag-of-Zimbabwe.png')");
      },
    );
  }

  Future<List<Country>> collectCountries({count: 0}) async {
    var database = await this._connectSQLite();
    var maps = List<Map>();
    if (count == 0) {
      maps = await database.rawQuery("SELECT * FROM country");
    } else {
      maps = await database.rawQuery("SELECT * FROM country ORDER BY RANDOM() LIMIT $count");
    }
    var countries = List.generate(maps.length, (i) {
      return Country(
        id: maps[i]['id'].toString(),
        name: maps[i]['name'],
        flag: maps[i]['flag'],
        continent: maps[i]['continent'],
      );
    });
    await database.close();
    return countries;
  }

  Future<void> deleteAllData() async {
    var database = await this._connectSQLite();
    await database.rawDelete("DELETE FROM country");
  }
}
