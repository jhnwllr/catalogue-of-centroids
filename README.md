![](https://raw.githubusercontent.com/jhnwllr/catalogue-of-centroids/master/point_map.jpg)

**Catalogue of Centroids** aims to aggregate centroids from various sources for use in labeling/flagging geo-referenced biodiversity occurrence records.

The main idea is to gather from sources most often used during retrospective geo-referencing of museum collections.

The main data file is `centroids.tsv`. 

## Current Sources 

[CoordinateCleaner](https://github.com/ropensci/CoordinateCleaner) - [x] iso2 places - [x] ADM1
[geoLocate](https://www.geo-locate.org/) - [x] iso2 places - [ ] ADM1
[Getty Thesaurus of Geographic Names (TGN)]  (https://www.getty.edu/research/tools/vocabularies/tgn/) - [x] iso2 places - [ ] ADM1
[geoNames](https://www.geonames.org/) - [x] iso2 places
- [x] ADM1
[Australia](https://www.ga.gov.au/scientific-topics/national-location-information/dimensions/centre-of-australia-states-territoriess) <br>
- [x] iso2 place

## Types of centroids  

1. **PCLI** (places with an iso-code)
2. **ADM1** (provinces,states,gadm1)

## centroids.tsv data dictionary 

**iso3** : ISO 3166-1 alpha-3 <br>
**iso2** : ISO 3166-1 alpha-2 <br>
**gadm1** : GADM level one code <br>
**gbif_name** : GBIF standardized name of locality/iso place <br>
**type** : one of "PCLI" (places with an iso-code),"ADM1" (provinces,states,gadm1) <br>
**area_sqkm** : The approximate area of the centroid's polygon. Do not take this too literally. <br>
**decimal_longitude** : longitude of centroid (WGS84) <br>
**decimal_latitude** : latitude of centroid (WGS84) <br>
**source_locality_name** : the name given by the source <br>
**source_reference** : link to the source <br>
**source** : CoordinateCleaner, geoLocate, TGN, GeoNames, Australia <br>

## Statistics v0.0.1

There are **9,619 distinct lat-lon points** in `centroids.tsv`. 

Here is how the lat-lon points break down by type. 

|type | distinct_points|
|:----|---------------:|
|ADM1 |            8516|
|PCLI |             784|

Here is how the lat-lon points break down by type and source.

|source            |type | distinct_points|
|:-----------------|:----|---------------:|
|CoordinateCleaner |ADM1 |            4645|
|GeoNames          |ADM1 |            3871|
|CoordinateCleaner |PCLI |             384|
|geoLocate         |PCLI |             276|
|TGN               |PCLI |             244|
|GeoNames          |PCLI |             193|
|Australia         |PCLI |               6|

Here is a table of **PCLI** type centroids. 

|iso2 |gbif_name                        | distinct_points|
|:----|:--------------------------------|---------------:|
|IT   |Italy                            |              10|
|AU   |Australia                        |               9|
|LU   |Grand Duchy of Luxembourg        |               8|
|BG   |Bulgaria                         |               6|
|BN   |Brunei                           |               6|
|CH   |Switzerland                      |               6|
|DJ   |Djibouti                         |               6|
|ES   |Spain                            |               6|
|FR   |France                           |               6|
|SI   |Slovenia                         |               6|
|TW   |Taiwan                           |               6|
|AT   |Austria                          |               5|
|BB   |Barbados                         |               5|
|BH   |Bahrain                          |               5|
|DM   |Dominica                         |               5|
|HR   |Croatia                          |               5|
|HT   |Haiti                            |               5|
|KM   |Comores                          |               5|
|LB   |Lebanon                          |               5|
|MA   |Morocco                          |               5|
|MD   |Moldova                          |               5|
|MK   |Macedonia                        |               5|
|ML   |Mali                             |               5|
|MU   |Republic of Mauritius            |               5|
|MX   |Mexico                           |               5|
|NR   |Nauru                            |               5|
|RS   |Serbia                           |               5|
|SG   |Singapore                        |               5|
|SK   |Slovakia                         |               5|
|TG   |Togo                             |               5|
|TL   |East Timor                       |               5|
|ZW   |Zimbabwe                         |               5|
|AD   |Andorra                          |               4|
|AI   |Anguilla                         |               4|
|AW   |Aruba                            |               4|
|BA   |Bosnia and Herzegovina           |               4|
|BE   |Belgium                          |               4|
|BM   |Bermuda                          |               4|
|BS   |Bahamas                          |               4|
|CA   |Canada                           |               4|
|CD   |Democratic Republic of the Congo |               4|
|CN   |China                            |               4|
|CO   |Colombia                         |               4|
|CU   |Cuba                             |               4|
|CW   |Curaçao                          |               4|
|CZ   |Czech Republic                   |               4|
|DO   |Dominican Republic               |               4|
|ET   |Ethiopia                         |               4|
|GD   |Grenada                          |               4|
|GE   |Georgia                          |               4|
|GH   |Ghana                            |               4|
|GN   |Guinea                           |               4|
|GT   |Guatemala                        |               4|
|JM   |Jamaica                          |               4|
|KN   |Saint Kitts and Nevis            |               4|
|KW   |Kuwait                           |               4|
|KZ   |Kazakhstan                       |               4|
|LC   |Saint Lucia                      |               4|
|LT   |Lithuania                        |               4|
|LY   |Libya                            |               4|
|ME   |Montenegro                       |               4|
|MT   |Malta                            |               4|
|NE   |Niger                            |               4|
|NU   |Niue                             |               4|
|OM   |Oman                             |               4|
|PY   |Paraguay                         |               4|
|SC   |Seychelles                       |               4|
|SO   |Federal Republic of Somalia      |               4|
|SV   |El Salvador                      |               4|
|TM   |Turkmenistan                     |               4|
|UG   |Uganda                           |               4|
|US   |United States                    |               4|
|UZ   |Uzbekistan                       |               4|
|VC   |Saint Vincent and the Grenadines |               4|
|VN   |Vietnam                          |               4|
|WS   |Samoa                            |               4|
|AE   |United Arab Emirates             |               3|
|AF   |Afghanistan                      |               3|
|AM   |Armenia                          |               3|
|AQ   |Antarctica                       |               3|
|AS   |American Samoa                   |               3|
|BF   |Burkina Faso                     |               3|
|BR   |Brazil                           |               3|
|BV   |Bouvet                           |               3|
|BZ   |Belize                           |               3|
|CC   |Cocos Islands                    |               3|
|CG   |Republic of the Congo            |               3|
|CI   |Ivory Coast                      |               3|
|CK   |Cook Islands                     |               3|
|CL   |Chile                            |               3|
|CM   |Cameroon                         |               3|
|CX   |Christmas Island                 |               3|
|DE   |Germany                          |               3|
|EC   |Ecuador                          |               3|
|FJ   |Fiji                             |               3|
|FM   |Micronesia                       |               3|
|GB   |United Kingdom                   |               3|
|GG   |Guernsey                         |               3|
|GM   |Gambia                           |               3|
|GP   |Guadeloupe                       |               3|
|GQ   |Equatorial Guinea                |               3|
|GU   |Guam                             |               3|
|HK   |Hong Kong                        |               3|
|HM   |Heard and McDonald Islands       |               3|
|ID   |Indonesia                        |               3|
|IE   |Ireland                          |               3|
|IM   |Isle of Man                      |               3|
|IN   |India                            |               3|
|JE   |Jersey                           |               3|
|JO   |Jordan                           |               3|
|JP   |Japan                            |               3|
|KG   |Kyrgyzstan                       |               3|
|KI   |Gilbert Islands                  |               3|
|KR   |South Korea                      |               3|
|KY   |Cayman Islands                   |               3|
|LA   |Laos                             |               3|
|LK   |Sri Lanka                        |               3|
|LR   |Liberia                          |               3|
|LS   |Lesotho                          |               3|
|MH   |Marshall Islands                 |               3|
|MM   |Myanmar                          |               3|
|MN   |Mongolia                         |               3|
|MP   |Northern Mariana Islands         |               3|
|MQ   |Martinique                       |               3|
|MR   |Mauritania                       |               3|
|MV   |Maldives                         |               3|
|NF   |Norfolk Island                   |               3|
|NI   |Nicaragua                        |               3|
|NL   |Netherlands                      |               3|
|NZ   |New Zealand                      |               3|
|PE   |Peru                             |               3|
|PH   |Philippines                      |               3|
|PM   |Saint-Pierre and Miquelon        |               3|
|PN   |Pitcairn                         |               3|
|PT   |Portugal                         |               3|
|PW   |Palau                            |               3|
|RU   |Russia                           |               3|
|SD   |Sudan                            |               3|
|SN   |Senegal                          |               3|
|TC   |Turks and Caicos Islands         |               3|
|TH   |Thailand                         |               3|
|TJ   |Tajikistan                       |               3|
|TK   |Tokelau                          |               3|
|TV   |Tuvalu                           |               3|
|VU   |Vanuatu                          |               3|
|YE   |Yemen                            |               3|
|ZA   |South Africa                     |               3|
|ZM   |Zambia                           |               3|
|AG   |Antigua and Barbuda              |               2|
|AL   |Albania                          |               2|
|AO   |Angola                           |               2|
|AR   |Argentina                        |               2|
|AX   |Åland Islands                    |               2|
|AZ   |Azerbaijan                       |               2|
|BD   |Bangladesh                       |               2|
|BI   |Burundi                          |               2|
|BJ   |Benin                            |               2|
|BL   |Saint-Barthélemy                 |               2|
|BO   |Bolivia                          |               2|
|BT   |Bhutan                           |               2|
|BW   |Botswana                         |               2|
|BY   |Belarus                          |               2|
|CF   |Central African Republic         |               2|
|CR   |Costa Rica                       |               2|
|CV   |Cape Verde                       |               2|
|CY   |Cyprus                           |               2|
|DK   |Denmark                          |               2|
|DZ   |Algeria                          |               2|
|EE   |Estonia                          |               2|
|EG   |Egypt                            |               2|
|ER   |Eritrea                          |               2|
|FI   |Finland                          |               2|
|FO   |Faeroe                           |               2|
|GA   |Gabon                            |               2|
|GF   |French Guiana                    |               2|
|GL   |Greenland                        |               2|
|GR   |Greece                           |               2|
|GW   |Guinea-Bissau                    |               2|
|GY   |Guyana                           |               2|
|HN   |Honduras                         |               2|
|HU   |Hungary                          |               2|
|IL   |Israel                           |               2|
|IQ   |Iraq                             |               2|
|IR   |Iran                             |               2|
|IS   |Iceland                          |               2|
|KE   |Kenya                            |               2|
|KH   |Cambodia                         |               2|
|KP   |North Korea                      |               2|
|LV   |Latvia                           |               2|
|MG   |Madagascar                       |               2|
|MS   |Montserrat                       |               2|
|MW   |Malawi                           |               2|
|MY   |Malaysia                         |               2|
|MZ   |Mozambique                       |               2|
|NC   |New Caledonia                    |               2|
|NG   |Nigeria                          |               2|
|NO   |Norway                           |               2|
|NP   |Nepal                            |               2|
|PA   |Panama                           |               2|
|PF   |French Polynesia                 |               2|
|PG   |Papua New Guinea                 |               2|
|PK   |Pakistan                         |               2|
|PL   |Poland                           |               2|
|PR   |Puerto Rico                      |               2|
|QA   |Qatar                            |               2|
|RE   |Réunion                          |               2|
|RO   |Romania                          |               2|
|RW   |Rwanda                           |               2|
|SA   |Saudi Arabia                     |               2|
|SB   |Solomon Islands                  |               2|
|SE   |Sweden                           |               2|
|SH   |Saint Helena                     |               2|
|SJ   |Svalbard                         |               2|
|SL   |Sierra Leone                     |               2|
|SR   |Suriname                         |               2|
|SS   |South Sudan                      |               2|
|ST   |Sao Tome and Principe            |               2|
|SY   |Syria                            |               2|
|SZ   |Swaziland                        |               2|
|TD   |Chad                             |               2|
|TN   |Tunisia                          |               2|
|TO   |Tonga                            |               2|
|TR   |Turkey                           |               2|
|TT   |Trinidad and Tobago              |               2|
|TZ   |Tanzania                         |               2|
|UA   |Ukraine                          |               2|
|UY   |Uruguay                          |               2|
|VE   |Venezuela                        |               2|
|VG   |British Virgin Islands           |               2|
|VI   |United States Virgin Islands     |               2|
|WF   |Wallis and Futuna                |               2|
|XK   |Kosovo                           |               2|
|BQ   |Bonaire                          |               1|
|KI   |Phoenix Group                    |               1|
|MC   |Monaco                           |               1|
|TF   |Amsterdam and Saint Paul Islands |               1|
|TF   |Bassas da India                  |               1|
|TF   |Kerguélen                        |               1|
|UM   |Jarvis Island                    |               1|
|UM   |Johnston Atoll                   |               1|
|VA   |Vatican City                     |               1|