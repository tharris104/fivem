---------------------------------------------------
---------------------------------------------------
---------------------------------------------------

-- todo: options menu (mysql)
-- todo: vehicle tracker (mysql) that removes old spawn

-- Vehicle mod refrence:
-- https://docs.fivem.net/natives/?_0x6AF0636DDEDCB6DD

-- F3 (170)
-- F5 (166)
-- F6 (167)
-- F7 (168)

local keybind = 170 -- default 170: F3
local licenseplatename = 'NEMESIS104'

---------------------------------------------------
---------------------------------------------------
---------------------------------------------------

menus = {
    ['Police Cars'] = {
        { name = 'Lamborghini Aventador', spawncode = 'nm_avent' },
        { name = 'Lamborghini Superleggera', spawncode = 'oplp570' },
        { name = 'Dodge Charger Hellcat', spawncode = 'HellcatRed' },
        { name = 'Police 1', spawncode = 'police' },
        { name = 'Police 2', spawncode = 'police2' },
        { name = 'Police 3', spawncode = 'police3' },
        { name = 'Police 4 Undercover', spawncode = 'police4' },
        { name = 'FBI', spawncode = 'fbi' },
        { name = 'FBI SUV', spawncode = 'fbi2' },
        { name = 'Fire Truck', spawncode = 'firetruck' },
        { name = 'FBI', spawncode = 'fbi' },
        { name = 'Police Maverick', spawncode = 'polmav' },
        { name = 'Riot Response Vehicle', spawncode = 'riot' },
        { name = 'Sheriff', spawncode = 'sheriff' },
    },
    ['Real Cars'] = {
        { name = 'AstonMartinOne77', spawncode = 'one77' },
        { name = 'AstonMartinVanquish', spawncode = 'ast' },
        { name = 'AudiA6', spawncode = 'a615' },
        { name = 'AudiR8', spawncode = 'ar8lb' },
        { name = 'BentleyContinentalGT', spawncode = 'contgt13' },
        { name = 'BmwM3E30', spawncode = 'm3e30' },
        { name = 'BugattiChiron', spawncode = '2017chiron' },
        { name = 'BugattiChiron', spawncode = '2019chiron' },
        { name = 'BugattiVeyron', spawncode = 'BUGATTI' },
        { name = 'ChevroletChevelleSS454', spawncode = 'CHEVELLESS' },
        { name = 'ChevroletCorvetteC7', spawncode = 'C7' },
        { name = 'DodgeChargerSRT', spawncode = '16charger' },
        { name = 'DodgeViperSRT', spawncode = 'Viper' },
        { name = 'DodgeViperSRT', spawncode = 'Acr' },
        { name = 'FerrariF12', spawncode = 'berlinetta' },
        { name = 'FerrariF40', spawncode = 'f40' },
        { name = 'FerrariF80', spawncode = 'f80' },
        { name = 'FerrariLaFerrari', spawncode = 'laferrari' },
        { name = 'FordGT2005', spawncode = 'FGT' },
        { name = 'FordGT2017', spawncode = 'gt17' },
        { name = 'FordMustangGT1965', spawncode = 'mustang65' },
        { name = 'FordMustangGT2015', spawncode = 'MGT' },
        { name = 'FordMustangHoonicorn', spawncode = 'fordh' },
        { name = 'HondaCivicTypeR', spawncode = 'EK9' },
        { name = 'HondaNSX', spawncode = 'filthynsx' },
        { name = 'KoenigseggAgeraR', spawncode = 'acsr' },
        { name = 'LamborghiniGallardoLP560', spawncode = '2013LP560' },
        { name = 'MazdaRX7Veilside', spawncode = 'rx7veilside' },
        { name = 'McLarenF1', spawncode = 'f1' },
        { name = 'McLarenP1', spawncode = 'p1' },
        { name = 'MercedesC63', spawncode = 'c63coupe' },
        { name = 'MercedesG65', spawncode = 'g65' },
        { name = 'MercedesSLS', spawncode = 'sls' },
        { name = 'MiniCooperS', spawncode = 'cooper15' },
        { name = 'MitsubishiEvoIX', spawncode = 'evo9' },
        { name = 'Nissan370Z', spawncode = '370z' },
        { name = 'NissanGTR', spawncode = 'gtr' },
        { name = 'NissanSkyline', spawncode = 'Skyline' },
        { name = 'Porsche918Spyder', spawncode = '918' },
        { name = 'PorscheCayenneTurboS', spawncode = 'cayenne' },
        { name = 'PorscheGT2RS', spawncode = 'GT2RS' },
        { name = 'RollsRoycePhantom', spawncode = 'DZSB' },
        { name = 'ShelbyGT500', spawncode = 'eleanor' },
        { name = 'SubaruWRXSTI', spawncode = 'subwrx' },
        { name = 'ToyotaSupraJZA80', spawncode = 'jza80' },
    },
    ['Muscle'] = {
        { name = 'Gauntlet', spawncode = 'gauntlet' },
        { name = 'Gauntlet2', spawncode = 'gauntlet2' },
        { name = 'Dominator2', spawncode = 'dominator2' },
        { name = 'Dominator', spawncode = 'dominator' },
        { name = 'Dukes2', spawncode = 'dukes2' },
        { name = 'Hotknife', spawncode = 'hotknife' },
        { name = 'Ruiner2', spawncode = 'ruiner2' },
        { name = 'SabreGT', spawncode = 'sabregt2' },
        { name = 'Vigero', spawncode = 'vigero' },
    },
    ['Sports'] = {
        { name = 'Banshee2', spawncode = 'Banshee2' },
        { name = 'Buffalo3', spawncode = 'Buffalo3' },
        { name = 'Comet3', spawncode = 'Comet3' },
        { name = 'Elegy2', spawncode = 'Elegy2' },
        { name = 'Feltzer2', spawncode = 'Feltzer2' },
        { name = 'Infernus2', spawncode = 'Infernus2' },
        { name = 'Kuruma Armored', spawncode = 'Kuruma2' },
        { name = 'RapidGT', spawncode = 'RapidGT' },
        { name = 'Ruston Convertible', spawncode = 'Ruston' },
        { name = 'Verlierer2', spawncode = 'Verlierer2' },
    },
    ['Super'] = {
        { name = 'Bullet', spawncode = 'Bullet' },
        { name = 'Cheetah', spawncode = 'Cheetah' },
        { name = 'GP1', spawncode = 'GP1' },
        { name = 'FMJ', spawncode = 'FMJ' },
        { name = 'Infernus', spawncode = 'infernus' },
        { name = 'RE7B', spawncode = 'RE7B' },
        { name = 'Nero2', spawncode = 'Nero2' },
        { name = 'Penetrator', spawncode = 'Penetrator' },
        { name = 'Prototipo', spawncode = 'Prototipo' },
        { name = 'Sheava', spawncode = 'Sheava' },
        { name = 'Tempesta', spawncode = 'Tempesta' },
        { name = 'Turismo2', spawncode = 'Turismo2' },
        { name = 'Tyrus', spawncode = 'Tyrus' },
        { name = 'Zentorno', spawncode = 'Zentorno' },
    },
    ['Boats'] = {
        { name = 'Dinghy2', spawncode = 'Dinghy2' },
        { name = 'Jet Ski', spawncode = 'Seashark2' },
        { name = 'Sailboat', spawncode = 'Marquis' },
        { name = 'Speeder2', spawncode = 'Speeder2' },
        { name = 'Squalo', spawncode = 'Squalo' },
        { name = 'Toro2', spawncode = 'Toro2' },
    },
    ['Planes'] = {
        { name = 'Besra', spawncode = 'Besra' },
        { name = 'Duster', spawncode = 'Duster' },
        { name = 'Hydra', spawncode = 'Hydra' },
        { name = 'Lazer', spawncode = 'Lazer' },
        { name = 'Luxor2', spawncode = 'Luxor2' },
        { name = 'Mammatus', spawncode = 'Mammatus' },
        { name = 'Stunt', spawncode = 'Stunt' },
        { name = 'Titan', spawncode = 'Titan' },
        { name = 'Velum2', spawncode = 'Velum2' },
    },
    ['Motorcycles'] = {
        { name = 'Akuma', spawncode = 'Akuma' },
        { name = 'Avarus', spawncode = 'Avarus' },
        { name = 'Bagger', spawncode = 'Bagger' },
        { name = 'Bati', spawncode = 'Bati' },
        { name = 'Bati2', spawncode = 'Bati2' },
        { name = 'BF400', spawncode = 'BF400' },
        { name = 'Blazer4', spawncode = 'Blazer4' },
        { name = 'CarbonRS', spawncode = 'CarbonRS' },
        { name = 'Chimera', spawncode = 'Chimera' },
        { name = 'Cliffhanger', spawncode = 'Cliffhanger' },
        { name = 'Daemon', spawncode = 'Daemon' },
        { name = 'Daemon2', spawncode = 'Daemon2' },
        { name = 'Defiler', spawncode = 'Defiler' },
        { name = 'Double', spawncode = 'Double' },
        { name = 'Enduro', spawncode = 'Enduro' },
        { name = 'Esskey', spawncode = 'Esskey' },
        { name = 'Fcr', spawncode = 'Fcr' },
        { name = 'Fcr2', spawncode = 'Fcr2' },
        { name = 'Gargoyle', spawncode = 'Gargoyle' },
        { name = 'Hakuchou', spawncode = 'Hakuchou' },
        { name = 'Hakuchou2', spawncode = 'Hakuchou2' },
        { name = 'Hexer', spawncode = 'Hexer' },
        { name = 'Innovation', spawncode = 'Innovation' },
        { name = 'Lectro', spawncode = 'Lectro' },
        { name = 'Manchez', spawncode = 'Manchez' },
        { name = 'Nemesis', spawncode = 'Nemesis' },
        { name = 'Nightblade', spawncode = 'Nightblade' },
        { name = 'Oppressor', spawncode = 'Oppressor' },
        { name = 'Oppressor2', spawncode = 'Oppressor2' },
        { name = 'PCJ', spawncode = 'PCJ' },
        { name = 'Ratbike', spawncode = 'Ratbike' },
        { name = 'Ruffian', spawncode = 'Ruffian' },
        { name = 'Sanchez', spawncode = 'Sanchez' },
        { name = 'Sanchez2', spawncode = 'Sanchez2' },
        { name = 'Sanctus', spawncode = 'Sanctus' },
        { name = 'Shotaro', spawncode = 'Shotaro' },
        { name = 'Sovereign', spawncode = 'Sovereign' },
        { name = 'Thrust', spawncode = 'Thrust' },
        { name = 'Vader', spawncode = 'Vader' },
        { name = 'Vindicator', spawncode = 'Vindicator' },
        { name = 'Vortex', spawncode = 'Vortex' },
        { name = 'Wolfsbane', spawncode = 'Wolfsbane' },
        { name = 'Zombiea', spawncode = 'Zombiea' },
        { name = 'Zombieb', spawncode = 'Zombieb' },
    },
    ['Helicopters'] = {
        { name = 'Annihilator', spawncode = 'Annihilator' },
        { name = 'Buzzard', spawncode = 'Buzzard' },
        { name = 'Buzzard2', spawncode = 'Buzzard2' },
        { name = 'Cargobob', spawncode = 'Cargobob' },
        { name = 'Cargobob2', spawncode = 'Cargobob2' },
        { name = 'Cargobob3', spawncode = 'Cargobob3' },
        { name = 'Cargobob4', spawncode = 'Cargobob4' },
        { name = 'Frogger', spawncode = 'Frogger' },
        { name = 'Frogger2', spawncode = 'Frogger2' },
        { name = 'Maverick', spawncode = 'Maverick' },
        { name = 'Savage', spawncode = 'Savage' },
        { name = 'Skylift', spawncode = 'Skylift' },
        { name = 'Supervolito', spawncode = 'Supervolito' },
        { name = 'Supervolito2', spawncode = 'Supervolito2' },
        { name = 'Swift', spawncode = 'Swift' },
        { name = 'Swift2', spawncode = 'Swift2' },
        { name = 'Valkyrie', spawncode = 'Valkyrie' },
        { name = 'Valkyrie2', spawncode = 'Valkyrie2' },
        { name = 'Volatus', spawncode = 'Volatus' },
    },
    ['Real Planes'] = {
        { name = '14-bis Oiseau De Proie', spawncode = 'odp14' },
        { name = 'A-10A Thunderbolt II', spawncode = 'aa10' },
        { name = 'A-10A Thunderbolt II Fairchild Republic', spawncode = 'af10' },
        { name = 'AC-130U Spooky II Gunship', spawncode = 'ac130' },
        { name = 'Air Force One Boeing VC-25A', spawncode = 'afo' },
        { name = 'Air Force Two Boeing VC-32A', spawncode = 'aft' },
        { name = 'Airbus A320-200', spawncode = 'a320' },
        { name = 'Airbus A380-800', spawncode = 'a380' },
        { name = 'Amphibious Armed Cargo Plane', spawncode = 'heliplane' },
        { name = 'Amphibious Plane', spawncode = 'amphi' },
        { name = 'AN-2 Duster', spawncode = 'an2' },
        { name = 'AT-26 Impala Xavante ARG', spawncode = 'at26' },
        { name = 'AV-8B McDonnell Douglas Harrier II', spawncode = 'av8' },
        { name = 'B-25 Bomber', spawncode = 'b25' },
        { name = 'B-2A Spirit Bomber', spawncode = 'spirit' },
        { name = 'Boeing 707-300', spawncode = 'b707' },
        { name = 'Boeing 727-200', spawncode = 'b727' },
        { name = 'Boeing 747-100', spawncode = 'b7471' },
        { name = 'Boeing 747 Transaero', spawncode = 'b747' },
        { name = 'Boeing 747 Space Shuttle Carrier', spawncode = 'sca' },
        { name = 'Boeing 757-200', spawncode = 'b757' },
        { name = 'Boeing 777-200ER', spawncode = 'b777' },
        { name = 'Boeing E3 Sentry AWACS', spawncode = 'bes3' },
        { name = 'Boeing KC-767', spawncode = 'b767' },
        { name = 'C-130H Hercules', spawncode = 'ch130' },
        { name = 'C-130T Philippine Air Force', spawncode = 'c130' },
        { name = 'C-5M Super Galaxy', spawncode = 'galaxy' },
        { name = 'C17A Globemaster III', spawncode = 'globe' },
        { name = 'Cessna 208 Caravan FedEx', spawncode = 'c208' },
        { name = 'CF-18A Hornet Royal Canadian Air Force', spawncode = 'cf18' },
        { name = 'Chengdu J-10S Dual Seater Chinese Airforce', spawncode = 'cj10' },
        { name = 'Chengdu J-20 Model BF4', spawncode = 'cj20' },
        { name = 'Concorde', spawncode = 'conc' },
        { name = 'CV-22B Osprey', spawncode = 'osprey' },
        { name = 'Dassault Mirage 2000-5', spawncode = 'dm5' },
        { name = 'Dassault Mirage 2000-N Black', spawncode = 'dmnb' },
        { name = 'Dassault Mirage III Israeli Air Force', spawncode = 'dm3' },
        { name = 'Dassault Rafale Navy', spawncode = 'draf' },
        { name = 'E-2D Hawkeye', spawncode = 'ehd2' },
        { name = 'EA-18G Growler Electronic Warfare Jet', spawncode = 'ea18' },
        { name = 'EMB-145 Delta', spawncode = 'e145d' },
        { name = 'EMB-145 US AirWays Express', spawncode = 'e145' },
        { name = 'EMB-175 Air France', spawncode = 'e175' },
        { name = 'EMB-175 US AirWays Express 400th', spawncode = 'e175us' },
        { name = 'EMB-190 Air Canada', spawncode = 'e190' },
        { name = 'EMB-190 Azul Brazilian', spawncode = 'e190a' },
        { name = 'EMB-312 Tucano AFA', spawncode = 'emba' },
        { name = 'EMB-312 Tucano FAB', spawncode = 'embf' },
        { name = 'EMB-314 A-29B Super Tucano House', spawncode = 'ah29' },
        { name = 'EMB-326 Embraer PACAU', spawncode = 'embp' },
        { name = 'Embraer EMB-110 Bandeirante House', spawncode = 'emb110' },
        { name = 'Embraer EMB-111 Bandeirulha (Chilean Air Force)', spawncode = 'emb111' },
        { name = 'Embraer 120 House', spawncode = 'emb120' },
        { name = 'Embraer 145 R-99 FAB by CANAL EMBRAER GTA (e145f) *Embraer 145 MB', spawncode = 'e145m' },
        { name = 'Embraer A-1 AMX International', spawncode = 'amx' },
        { name = 'Embraer A-29B Squadron of Smoke', spawncode = 'ab29' },
        { name = 'Embraer A-29B Super Tucano US Factory', spawncode = 'au29' },
        { name = 'Embraer A-27T Tucano', spawncode = 'at27' },
        { name = 'Embraer KC-390 AFB', spawncode = 'e390' },
        { name = 'Embraer KC-390 FedEX', spawncode = 'ef390' },
        { name = 'Embraer Phenom 100 Executive', spawncode = 'ep100' },
        { name = 'Eurofighter Typhoon Air Force Germany', spawncode = 'eurot' },
        { name = 'F-14D Grumman Super Tomcat', spawncode = 'gf14' },
        { name = 'F-14D Super Tomcat Redux', spawncode = 'f14' },
        { name = 'F-15C Eagle', spawncode = 'f15' },
        { name = 'F-16C Aerobatic RNAF', spawncode = 'fc16' },
        { name = 'F-16C Aerobatic Thunderbirds', spawncode = 'fa16' },
        { name = 'F-16C Block 52+', spawncode = 'fb16' },
        { name = 'F-16C Fighting Falcon', spawncode = 'f16' },
        { name = 'F-16XL USA', spawncode = 'f16xl' },
        { name = 'F-22 Raptor', spawncode = 'ff22' },
        { name = 'F-22 Raptor', spawncode = 'f22' },
        { name = 'F-35B Lightning II [VTOL]', spawncode = 'vtol' },
        { name = 'F-117 Lockheed Nighthawk', spawncode = 'f117' },
        { name = 'F A-18C Hornet', spawncode = 'fa18' },
        { name = 'F A-18C Hornet Blue Angels US Navy Displ', spawncode = 'fab18' },
        { name = 'Fokker Dr.I Red Baron Battlefield 1', spawncode = 'fokk' },
        { name = 'Gripen NG Brazilian', spawncode = 'gripen' },
        { name = 'Grumman S-2 Tracker US Navy', spawncode = 'grs2' },
        { name = 'Grumman Seaplane', spawncode = 'grumman' },
        { name = 'Icon A5 Camo Plane', spawncode = 'icon5' },
        { name = 'Icon A5 Sport Plane', spawncode = 'ico5s' },
        { name = 'J-10A SY Aerobatic Team', spawncode = 'j10' },
        { name = 'J-15A Shenyang Flying Shark Carrier', spawncode = 'j15a' },
        { name = 'J-20 WeiLong Fighter Jet', spawncode = 'j20' },
        { name = 'J-31 Gryfalcon Fighter Jet', spawncode = 'j31' },
        { name = 'J-31B Gryfalcon Carrier Fighter', spawncode = 'j31b' },
        { name = 'JF-17 Thunder Block 1', spawncode = 'jf17' },
        { name = 'KJ2000-Beriev A-50 AWE&C Pakistan', spawncode = 'kj2000' },
        { name = 'Macchi M33', spawncode = 'macchi' },
        { name = 'McD KC10A Extender Refueling', spawncode = 'kc10' },
        { name = 'McDonnell Douglas DC-9-15', spawncode = 'dc9' },
        { name = 'McDonnell Douglas DC-10-30', spawncode = 'dc10' },
        { name = 'McDonnell Douglas DC-10-30F Freighter', spawncode = 'dc10f' },
        { name = 'McDonnell Douglas F-4 Phantom II', spawncode = 'mdf4' },
        { name = 'McDonnell Douglas MD-80', spawncode = 'md80' },
        { name = 'Messerschmitt BF-109 E3', spawncode = 'mesbf' },
        { name = 'MiG-15 Mikoyan-Gurevich', spawncode = 'mig15' },
        { name = 'MiG-21 F7P Mikoyan-Gurevich', spawncode = 'mfp7' },
        { name = 'MiG-21 F7PG Mikoyan-Gurevich', spawncode = 'mfpg7' },
        { name = 'MiG-21 J7III Mikoyan-Gurevich', spawncode = 'mj73' },
        { name = 'MiG-21 J7P Mikoyan-Gurevich', spawncode = 'mjp7' },
        { name = 'MiG-21 J7PG Mikoyan-Gurevich', spawncode = 'mjpg7' },
        { name = 'MiG-21 Mikoyan-Gurevich', spawncode = 'mig21' },
        { name = 'MiG-29 Mikoyan-Gurevich [Fulcrum]', spawncode = 'mig29' },
        { name = 'Northrop F-5E Tiger II FAB', spawncode = 'nf5e' },
        { name = 'P-47D Thunderbolt', spawncode = 'p47' },
        { name = 'P-51D Mustang', spawncode = 'pmust' },
        { name = 'PBY5 Catalina Seaplane', spawncode = 'catalina' },
        { name = 'Predator MQ-1 Drone', spawncode = 'pmq1' },
        { name = 'Predator MQ-9 Reaper UAV', spawncode = 'mq9' },
        { name = 'Robin DR-400', spawncode = 'rdr400' },
        { name = 'Saab 2000 Carrier', spawncode = 'saab2' },
        { name = 'Saab Erieye AEW&C', spawncode = 'erieye' },
        { name = 'SR-71A Blackbird', spawncode = 'sr71' },
        { name = 'SU-24M', spawncode = 'su24' },
        { name = 'SU-25', spawncode = 'su25' },
        { name = 'SU-33', spawncode = 'su33' },
        { name = 'SU-34', spawncode = 'su34' },
        { name = 'Sukhoi SU-30 MKK', spawncode = 'su30' },
        { name = 'Sukhoi SU-30 Russian', spawncode = 'sur30' },
        { name = 'Sukhoi T-50 PAK FA', spawncode = 'st50' },
        { name = 'U-2R Dragon Lady Spyplane', spawncode = 'u2r' },
        { name = 'U-2S Dragon Lady Spyplane', spawncode = 'u2s' },
        { name = 'Wing Loong Drone HQ', spawncode = 'wl1' },
        { name = 'XB-70 Valkyrie Bomber', spawncode = 'xb70' },
        { name = 'YF-12A Interceptor', spawncode = 'yf12' },
        { name = 'YF-23 Northrop McDonnell Douglas', spawncode = 'yf23' },
        { name = 'Motojet Hexer', spawncode = 'mjhex' },
        { name = 'Motojet V2', spawncode = 'motojet' },
        { name = 'Avatar AT-99 Scorpion', spawncode = 'scorpion' },
        { name = 'Avatar SA-2 Samson Sec Ops', spawncode = 'samson' },
        { name = 'Avatar SA-2 Samson Trudy Chacon', spawncode = 'trudy' },
        { name = 'S.H.I.E.L.D. Helicarrier For Titan', spawncode = 'helicar' },
        { name = 'Star Fox Arwing', spawncode = 'arwing' },
        { name = 'Star Fox Great Fox', spawncode = 'greatfox' },
        { name = 'Star Wars Millenium Falcon', spawncode = 'swmil' },
        { name = 'Star Wars Tie Interceptor', spawncode = 'swtie' },
        { name = 'Star Wars Tydirium Imperial Shuttle', spawncode = 'swtyd' },
        { name = 'Star Wars X-Wing [Hydra]', spawncode = 'xwing' },
    },
    ['Off-Road'] = {
        { name = 'Bifta', spawncode = 'Bifta' },
        { name = 'Blazer', spawncode = 'Blazer' },
        { name = 'Blazer2', spawncode = 'Blazer2' },
        { name = 'Blazer3', spawncode = 'Blazer3' },
        { name = 'Blazer4', spawncode = 'Blazer4' },
        { name = 'Blazer5', spawncode = 'Blazer5' },
        { name = 'Bodhi2', spawncode = 'Bodhi2' },
        { name = 'Brawler', spawncode = 'Brawler' },
        { name = 'Dune', spawncode = 'Dune' },
        { name = 'Marshall', spawncode = 'Marshall' },
        { name = 'Monster', spawncode = 'Monster' },
        { name = 'Nightshark', spawncode = 'Nightshark' },
        { name = 'Sandking', spawncode = 'Sandking' },
        { name = 'Sandking2', spawncode = 'Sandking2' },
        { name = 'TrophyTruck', spawncode = 'TrophyTruck' },
        { name = 'TrophyTruck2', spawncode = 'TrophyTruck2' },
    },
    ['Utility'] = {
        { name = 'Caddy', spawncode = 'Caddy' },
        { name = 'Caddy2', spawncode = 'Caddy2' },
        { name = 'Caddy3', spawncode = 'Caddy3' },
        { name = 'Mower', spawncode = 'Mower' },
        { name = 'Sadler', spawncode = 'Sadler' },
        { name = 'TowTruck', spawncode = 'TowTruck' },
        { name = 'TowTruck2', spawncode = 'TowTruck2' },
        { name = 'Tractor', spawncode = 'Tractor' },
        { name = 'Tractor2', spawncode = 'Tractor2' },
        { name = 'Tractor3', spawncode = 'Tractor3' },
    },
    ['Zombie Cars'] = {
        { name = 'Boxville5', spawncode = 'Boxville5' },
        { name = 'Insurgent', spawncode = 'Insurgent' },
        { name = 'Insurgent2', spawncode = 'Insurgent2' },
        { name = 'Insurgent3', spawncode = 'Insurgent3' },
        { name = 'Limo2', spawncode = 'Limo2' },
        { name = 'Rumpo3', spawncode = 'Rumpo3' },
        { name = 'Technical', spawncode = 'Technical' },
        { name = 'Technical2', spawncode = 'Technical2' },
        { name = 'Technical3', spawncode = 'Technical3' },
    },
}

---------------------------------------------------
---------------------------------------------------
---------------------------------------------------

_menuPool = NativeUI.CreatePool()
mainMenu = NativeUI.CreateMenu("Spawner Menu", "~g~Choose your catagory", 1430, 0)
_menuPool:Add(mainMenu)
mainMenu.SetMenuWidthOffset(50);
function initMenu(menu)
    table.sort(menus)
    for Name, Category in pairs(menus) do
        local doncatagory = _menuPool:AddSubMenu(menu, Name, '', true)
        for _, Vehicle in pairs(Category) do
            local donvehicles = NativeUI.CreateItem(Vehicle.name, '')
            doncatagory:AddItem(donvehicles)
            donvehicles.Activated = function(ParentMenu, SelectedItem)
                spawn(Vehicle.spawncode)
            end
        end
    end
end

initMenu(mainMenu)
_menuPool:RefreshIndex() 
_menuPool:MouseControlsEnabled (false)
_menuPool:MouseEdgeEnabled (false)
_menuPool:ControlDisablingEnabled(false)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        _menuPool:ProcessMenus()
        if IsControlJustPressed(1, keybind) then
            mainMenu:Visible(not mainMenu:Visible())
        end
    end
end)

function ShowNotification(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end

function spawn(car)
    -- show error and return if car does not exist
    if not IsModelInCdimage(car) or not IsModelAVehicle(car) then
        ShowNotification("~r~Cannot spawn " .. car .. "!")
        return
    end

    -- remove current vehicle if player in vehicle (also consider attempting to enter)
    if IsPedInAnyVehicle(GetPlayerPed(-1), true) then
	-- also considers last vehicle if not in one
        local delvehin = GetVehiclePedIsIn(GetPlayerPed(-1), true)
        local delvehtrying = GetVehiclePedIsTryingToEnter(GetPlayerPed(-1))
        local delvehenter = GetVehiclePedIsEntering(GetPlayerPed(-1))
        local delvehusing = GetVehiclePedIsUsing(GetPlayerPed(-1))
        DeleteVehicle(delvehin)
        DeleteVehicle(delvehtrying)
        DeleteVehicle(delvehenter)
        DeleteVehicle(delvehusing)
    end

    -- get player coordinates
    local coords = GetEntityCoords(GetPlayerPed(-1))

    -- request vehicle
    RequestModel(car)

    -- wait for the model to load
    while not HasModelLoaded(car) do
        Wait(500)
    end

    -- create the car instance based on player location
    local veh = CreateVehicle(car, coords.x, coords.y, coords.z, GetEntityHeading(GetPlayerPed(-1)), true, false)

    -- move ped into car
    SetPedIntoVehicle(GetPlayerPed(-1), veh, -1)

    -- give the vehicle back to the game (this'll make the game decide when to despawn the vehicle)
    --SetEntityAsNoLongerNeeded(veh)

    -- release the model
    SetModelAsNoLongerNeeded(car)

    -- custom license plate
    SetVehicleNumberPlateText(veh, licenseplatename)

    -- enable vehicle mods
    SetVehicleModKit(veh, 0)

    -- install best spoiler if available
    local bestspoiler = GetNumVehicleMods(veh, 0)-1
    if bestspoiler then
        SetVehicleMod(veh, 0, bestspoiler, false)
    end

    -- install EMS Upgrade, Level 4
    local bestengine = GetNumVehicleMods(veh, 11)-1
    if bestengine then
        SetVehicleMod(veh, 11, bestengine, false)
    end

    -- install Race Brakes
    local bestbrakes = GetNumVehicleMods(veh, 12)-1
    if bestbrakes then
        SetVehicleMod(veh, 12, bestbrakes, false)
    end

    -- install Race Transmission
    local bestgearbox = GetNumVehicleMods(veh, 13)-1
    if bestgearbox then
        SetVehicleMod(veh, 13, bestgearbox, false)
    end

    -- install Street Suspension
    SetVehicleMod(veh, 15, 1, false)

    -- install max armor
    local bestarmor = GetNumVehicleMods(veh, 16)-1
    if bestarmor then
        SetVehicleMod(veh, 16, bestarmor, false)
    end

    -- install turbo
    ToggleVehicleMod(veh, 18, true)

    -- install neon kit
    -- 0=left, 1=right, 2=front, 3=back
    SetVehicleNeonLightEnabled(veh, 0, true)
    SetVehicleNeonLightEnabled(veh, 1, true)
    SetVehicleNeonLightEnabled(veh, 2, true)
    SetVehicleNeonLightEnabled(veh, 3, true)
    SetVehicleNeonLightsColour(veh, 255, 1, 1)

    -- add white HID headlights (stock is -1, white is 0)
    ToggleVehicleMod(veh, 22, true)
    SetVehicleXenonLightsColour(veh, 0)

    -- fresh car wash, nobody wants to spawn a dirty car
    SetVehicleDirtLevel(veh, 0.0)

    -- play ambient sirens
    --DistantCopCarSirens(true)

    -- show notification of car and close
    ShowNotification("~g~Spawned " .. car .. "!")
    _menuPool:CloseAllMenus()
    return veh
end
