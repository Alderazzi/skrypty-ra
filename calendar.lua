ra.calendar = {
  
  domain = "gdziestam", -- domena muda, w ktorej sie znajdujemy
  json_file_path = getMudletHomeDir() .. "/calendar_ra.json", -- plik gdzie zapisuje ofsety czasu dla domen
  gamehour_real_time = 120, -- czas trwania godziny na mudzie w sekundach
  
  imperial  = {
    settings = {
      name = "Kalendarz imperialny",
      domain = "imperial",
      days_in_year = 400,
      year_time = 1151880, -- w sekundach, ilosc dni w roku - 1 dzien (120sec) => ostatni dzien roku konczy sie 120 sek przed nowym rokiem
      -- definicja dni poczatakowych konkretnych czesci kalendarza imperium, zazwyczaj to dzien roku kiedy rozpoczyna sie dany miesiac albo dni specjalne
      first_day_of_calparts = {
        ["Hexentag"] = 1, ["Nachhexen"] = 2, ["Jahrdrung"] = 34, ["Mitterfruhl"] = 67, ["Pflugzeit"] = 68, ["Sigmarszeit"] = 101, ["Sommerzeit"] = 134, ["Sonnenstill"] = 167, ["Vorgeheim"] = 168,
        ["Geheimnistag"] = 201, ["Nachgeheim"] = 202, ["Erntezeit"] = 234, ["Mitterherbst"] = 267, ["Brauzeit"] = 268, ["Kaltezeit"] = 301, ["Ulrichszeit"] = 334, ["Mondstill"] = 367, ["Vorhexen"] = 368,  
      },
      -- ustawienia dni roku i ich godzin kiedy rozpocznyna sie dany event
      search_times = {
        {day=1, hour=17,   desc="Leci pyl:           ", color="dodger_blue", type="special_imperial"}, -- Hexennacht
        
        {day=1, hour=17,   desc="Poczatek pelni:     ", color="powder_blue", type="full_moon_imperial"},
        {day=2, hour=8,    desc="Koniec pelni:       ", color="powder_blue", type="full_moon_imperial"},
        
        {day=14, hour=17,  desc="Poczatek nowiu:     ", color="slate_blue", type="new_moon_imperial"},
        {day=15, hour=8,   desc="Koniec nowiu:       ", color="slate_blue", type="new_moon_imperial"},
        
        {day=26, hour=17,  desc="Poczatek pelni:     ", color="powder_blue", type="full_moon_imperial"},
        {day=27, hour=8,   desc="Koniec pelni:       ", color="powder_blue", type="full_moon_imperial"},
        
        {day=39, hour=18,  desc="Poczatek nowiu:     ", color="slate_blue", type="new_moon_imperial"},
        {day=40, hour=7,   desc="Koniec nowiu:       ", color="slate_blue", type="new_moon_imperial"},
        
        {day=51, hour=18,  desc="Poczatek pelni:     ", color="powder_blue", type="full_moon_imperial"},
        {day=52, hour=7,   desc="Koniec pelni:       ", color="powder_blue", type="full_moon_imperial"},
        
        {day=64, hour=18,  desc="Poczatek nowiu:     ", color="slate_blue", type="new_moon_imperial"},
        {day=65, hour=7,   desc="Koniec nowiu:       ", color="slate_blue", type="new_moon_imperial"},
        
        {day=76, hour=19,  desc="Poczatek pelni:     ", color="powder_blue", type="full_moon_imperial"},
        {day=77, hour=6,   desc="Koniec pelni:       ", color="powder_blue", type="full_moon_imperial"},
        
        {day=89, hour=19,  desc="Poczatek nowiu:     ", color="slate_blue", type="new_moon_imperial"},
        {day=90, hour=6,   desc="Koniec nowiu:       ", color="slate_blue", type="new_moon_imperial"},

        {day=102, hour=21, desc="Poczatek pelni:     ", color="powder_blue", type="full_moon_imperial"},
        {day=103, hour=5,  desc="Koniec pelni:       ", color="powder_blue", type="full_moon_imperial"},
        
        {day=114, hour=20, desc="Poczatek nowiu:     ", color="slate_blue", type="new_moon_imperial"},
        {day=115, hour=5,  desc="Koniec nowiu:       ", color="slate_blue", type="new_moon_imperial"},

        {day=126, hour=20, desc="Poczatek pelni:     ", color="powder_blue", type="full_moon_imperial"},
        {day=127, hour=5,  desc="Koniec pelni:       ", color="powder_blue", type="full_moon_imperial"},
        
        {day=139, hour=21, desc="Poczatek nowiu:     ", color="slate_blue", type="new_moon_imperial"},
        {day=140, hour=5,  desc="Koniec nowiu:       ", color="slate_blue", type="new_moon_imperial"},

        {day=151, hour=21, desc="Poczatek pelni:     ", color="powder_blue", type="full_moon_imperial"},
        {day=152, hour=5,  desc="Koniec pelni:       ", color="powder_blue", type="full_moon_imperial"},
        
        {day=164, hour=21, desc="Poczatek nowiu:     ", color="slate_blue", type="new_moon_imperial"},
        {day=165, hour=5,  desc="Koniec nowiu:       ", color="slate_blue", type="new_moon_imperial"},

        {day=176, hour=22, desc="Poczatek pelni:     ", color="powder_blue", type="full_moon_imperial"},
        {day=177, hour=4,  desc="Koniec pelni:       ", color="powder_blue", type="full_moon_imperial"},
        
        {day=189, hour=22, desc="Poczatek nowiu:     ", color="slate_blue", type="new_moon_imperial"},
        {day=190, hour=4,  desc="Koniec nowiu:       ", color="slate_blue", type="new_moon_imperial"},
 
        {day=201, hour=17, desc="Leci pyl:           ", color="dodger_blue", type="special_imperial"},
  
        {day=202, hour=20, desc="Poczatek pelni:     ", color="powder_blue", type="full_moon_imperial"},
        {day=203, hour=5,  desc="Koniec pelni:       ", color="powder_blue", type="full_moon_imperial"},
       
        {day=214, hour=20, desc="Poczatek nowiu:     ", color="slate_blue", type="new_moon_imperial"},
        {day=215, hour=5,  desc="Koniec nowiu:       ", color="slate_blue", type="new_moon_imperial"},

        {day=227, hour=20, desc="Poczatek pelni:     ", color="powder_blue", type="full_moon_imperial"},
        {day=228, hour=5,  desc="Koniec pelni:       ", color="powder_blue", type="full_moon_imperial"},
        
        {day=239, hour=20, desc="Poczatek nowiu:     ", color="slate_blue", type="new_moon_imperial"},
        {day=240, hour=5,  desc="Koniec nowiu:       ", color="slate_blue", type="new_moon_imperial"},

        {day=251, hour=20, desc="Poczatek pelni:     ", color="powder_blue", type="full_moon_imperial"},
        {day=252, hour=5,  desc="Koniec pelni:       ", color="powder_blue", type="full_moon_imperial"},
        
        {day=253, hour=20, desc="Leci pyl:           ", color="dodger_blue", type="special_imperial"},
        
        {day=264, hour=20, desc="Poczatek nowiu:     ", color="slate_blue", type="new_moon_imperial"},
        {day=265, hour=5,  desc="Koniec nowiu:       ", color="slate_blue", type="new_moon_imperial"},

        {day=276, hour=19, desc="Poczatek pelni:     ", color="powder_blue", type="full_moon_imperial"},
        {day=277, hour=6,  desc="Koniec pelni:       ", color="powder_blue", type="full_moon_imperial"},
        
        {day=278, hour=19, desc="Leci pyl:           ", color="dodger_blue", type="special_imperial"},
        
        {day=289, hour=19, desc="Poczatek nowiu:     ", color="slate_blue", type="new_moon_imperial"},
        {day=290, hour=6,  desc="Koniec nowiu:       ", color="slate_blue", type="new_moon_imperial"},


        {day=301, hour=18, desc="Poczatek pelni:     ", color="powder_blue", type="full_moon_imperial"}, -- Kaltezeit 301
        {day=302, hour=6,  desc="Koniec pelni:       ", color="powder_blue", type="full_moon_imperial"},
        
        {day=314, hour=18, desc="Poczatek nowiu:     ", color="slate_blue", type="new_moon_imperial"},
        {day=315, hour=6,  desc="Koniec nowiu:       ", color="slate_blue", type="new_moon_imperial"},

        {day=326, hour=18, desc="Leci pyl:           ", color="dodger_blue", type="special_imperial"},

        {day=326, hour=18, desc="Poczatek pelni:     ", color="powder_blue", type="full_moon_imperial"},
        {day=327, hour=6,  desc="Koniec pelni:       ", color="powder_blue", type="full_moon_imperial"},
        
        -- Ulrichszeit 334
        {day=339, hour=17, desc="Poczatek nowiu:     ", color="slate_blue", type="new_moon_imperial"},
        {day=340, hour=7,  desc="Koniec nowiu:       ", color="slate_blue", type="new_moon_imperial"},

        {day=351, hour=17, desc="Poczatek pelni:     ", color="powder_blue", type="full_moon_imperial"},
        {day=352, hour=7,  desc="Koniec pelni:       ", color="powder_blue", type="full_moon_imperial"},
        
        {day=364, hour=17, desc="Poczatek nowiu:     ", color="slate_blue", type="new_moon_imperial"},
        {day=365, hour=7,  desc="Koniec nowiu:       ", color="slate_blue", type="new_moon_imperial"},

        {day=376, hour=16, desc="Poczatek pelni:     ", color="powder_blue", type="full_moon_imperial"},
        {day=377, hour=8,  desc="Koniec pelni:       ", color="powder_blue", type="full_moon_imperial"},
        
        {day=389, hour=16, desc="Poczatek nowiu:     ", color="slate_blue", type="new_moon_imperial"},
        {day=390, hour=8,  desc="Koniec nowiu:       ", color="slate_blue", type="new_moon_imperial"},
      
        -- pory roku
        {day=18, hour=0,   desc="Poczatek wiosny:    ", color="green", type="season_imperial"},
        {day=118, hour=0,  desc="Poczatek lata:      ", color="yellow", type="season_imperial"},
        {day=218, hour=0,  desc="Poczatek jesieni:   ", color="brown", type="season_imperial"},
        {day=319, hour=0,  desc="Poczatek zimy:      ", color="white", type="season_imperial"},
      },
    },
    -- definicja danych tworzonych dynamicznie
    data = {
      offset = 0,       -- narzut czasu realnego
      precision = 119,  -- dokladnosc czasu realnego na podstawie informacji z muda
      template = {},    -- uniwesalny kalendarz domeny
      calendar = {},    -- kalandarz domeny po uwzglednieniu narzutu czasu realnego
      results = {},     -- wyliczone informacje o szukanych punktach czasowych
    },
  },
  
  ishtar = {
    settings = {
      name = "Kalnedarz ishtar",
      domain = "ishtar",
      days_in_year = 360,
      year_time = 1036680,  -- w sekundach, ilosc dni w roku - 1 dzien (120sec) => ostatni dzien roku konczy sie 120 sek przed nowym rokiem
      -- definicja dni poczatakowych konkretnych czesci kalendarza ishtar, zazwyczaj to dzien roku kiedy rozpoczyna sie dany miesiac
      first_day_of_calparts = {
        ["Yule"] = 1, ["Imbaelk"] = 46, ["Birke"] = 91, ["Blathe"] = 136, ["Feainn"] = 181, ["Lammas"] = 226, ["Velen"] = 271, ["Saovine"] = 316,
      },
      -- ustawienia dni roku i ich godzin kiedy rozpocznyna sie dany event
      
      --    ilosc dni od dnia roku  do dnia roku  wschod  zachod  
      -- Yule  45  1 46  8 16  zima
      -- Imbaelk 45  46  91  7 18  
      -- Birke 45  91  136 6 19  wiosna
      -- Blathe  45  136 181 5 21  
      -- Feainn  45  181 226 4 20  lato
      -- Lammas  45  226 271 5 20  
      -- Velen 45  271 316 7 18  jesien
      -- Saovine 45  316 361 6 17  
      
      
      search_times = {
        {day=1, hour=0,    desc="Poczatek zimy:      ", color="white", type="season_ishtar"},
        {day=1, hour=0,    desc="Przesilenie zimowe: ", color="white", type="solstice_ishtar"},
        {day=1, hour=0,    desc="Ryboludzie:         ", color="white", type="fishman_ishtar"},    
        
        {day=4, hour=0,    desc="Poczatek pelni:     ", color="powder_blue", type="full_moon_ishtar"},
        {day=6, hour=0,    desc="Koniec pelni:       ", color="powder_blue", type="full_moon_ishtar"},

        {day=4, hour=2,    desc="Szpiedzy wychodza:  ", color="chocolate", type="spy_ishtar"},
        {day=4, hour=8,    desc="Szpiedzy znikaja:   ", color="chocolate", type="spy_ishtar"},
        {day=7, hour=22,   desc="Szpiedzy wychodza:  ", color="chocolate", type="spy_ishtar"},
        {day=8, hour=8,    desc="Szpiedzy znikaja:   ", color="chocolate", type="spy_ishtar"},

        {day=28, hour=0,   desc="Poczatek pelni:     ", color="powder_blue", type="full_moon_ishtar"},
        {day=30, hour=0,   desc="Koniec pelni:       ", color="powder_blue", type="full_moon_ishtar"},

        {day=28, hour=2,   desc="Szpiedzy wychodza:  ", color="chocolate", type="spy_ishtar"},
        {day=28, hour=8,   desc="Szpiedzy znikaja:   ", color="chocolate", type="spy_ishtar"},
        {day=31, hour=22,  desc="Szpiedzy wychodza:  ", color="chocolate", type="spy_ishtar"},
        {day=32, hour=8,   desc="Szpiedzy znikaja:   ", color="chocolate", type="spy_ishtar"},
        
        {day=52, hour=0,   desc="Poczatek pelni:     ", color="powder_blue", type="full_moon_ishtar"},
        {day=54, hour=0,   desc="Koniec pelni:       ", color="powder_blue", type="full_moon_ishtar"},

        {day=52, hour=2,   desc="Szpiedzy wychodza:  ", color="chocolate", type="spy_ishtar"},
        {day=52, hour=7,   desc="Szpiedzy znikaja:   ", color="chocolate", type="spy_ishtar"},
        {day=55, hour=22,  desc="Szpiedzy wychodza:  ", color="chocolate", type="spy_ishtar"},
        {day=56, hour=7,   desc="Szpiedzy znikaja:   ", color="chocolate", type="spy_ishtar"},
        
        {day=76, hour=0,   desc="Poczatek pelni:     ", color="powder_blue", type="full_moon_ishtar"},
        {day=78, hour=0,   desc="Koniec pelni:       ", color="powder_blue", type="full_moon_ishtar"},

        {day=76, hour=2,   desc="Szpiedzy wychodza:  ", color="chocolate", type="spy_ishtar"},
        {day=76, hour=7,   desc="Szpiedzy znikaja:   ", color="chocolate", type="spy_ishtar"},
        {day=79, hour=22,  desc="Szpiedzy wychodza:  ", color="chocolate", type="spy_ishtar"},
        {day=80, hour=7,   desc="Szpiedzy znikaja:   ", color="chocolate", type="spy_ishtar"},

        {day=91, hour=0,   desc="Poczatek wiosny:    ", color="green", type="season_ishtar"},
        {day=91, hour=0,   desc="Rownonoc wiosenna:  ", color="green", type="equinox_ishtar"},
        {day=91, hour=0,   desc="Ryboludzie:         ", color="green", type="fishman_ishtar"},
        
        {day=100, hour=0,  desc="Poczatek pelni:     ", color="powder_blue", type="full_moon_ishtar"},        
        {day=102, hour=0,  desc="Koniec pelni:       ", color="powder_blue", type="full_moon_ishtar"},

        {day=100, hour=2,  desc="Szpiedzy wychodza:  ", color="chocolate", type="spy_ishtar"},
        {day=100, hour=6,  desc="Szpiedzy znikaja:   ", color="chocolate", type="spy_ishtar"},
        {day=103, hour=22, desc="Szpiedzy wychodza:  ", color="chocolate", type="spy_ishtar"},
        {day=104, hour=6,  desc="Szpiedzy znikaja:   ", color="chocolate", type="spy_ishtar"},
        
        {day=124, hour=0,  desc="Poczatek pelni:     ", color="powder_blue", type="full_moon_ishtar"},
        {day=126, hour=0,  desc="Koniec pelni:       ", color="powder_blue", type="full_moon_ishtar"},

        {day=124, hour=2,  desc="Szpiedzy wychodza:  ", color="chocolate", type="spy_ishtar"},
        {day=124, hour=6,  desc="Szpiedzy znikaja:   ", color="chocolate", type="spy_ishtar"},
        {day=127, hour=22, desc="Szpiedzy wychodza:  ", color="chocolate", type="spy_ishtar"},
        {day=128, hour=6,  desc="Szpiedzy znikaja:   ", color="chocolate", type="spy_ishtar"},
        
        {day=148, hour=0,  desc="Poczatek pelni:     ", color="powder_blue", type="full_moon_ishtar"},
        {day=150, hour=0,  desc="Koniec pelni:       ", color="powder_blue", type="full_moon_ishtar"},

        {day=148, hour=2,  desc="Szpiedzy wychodza:  ", color="chocolate", type="spy_ishtar"},
        {day=148, hour=5,  desc="Szpiedzy znikaja:   ", color="chocolate", type="spy_ishtar"},
        {day=151, hour=22, desc="Szpiedzy wychodza:  ", color="chocolate", type="spy_ishtar"},
        {day=152, hour=5,  desc="Szpiedzy znikaja:   ", color="chocolate", type="spy_ishtar"},
        
        {day=172, hour=0,  desc="Poczatek pelni:     ", color="powder_blue", type="full_moon_ishtar"},
        {day=174, hour=0,  desc="Koniec pelni:       ", color="powder_blue", type="full_moon_ishtar"},

        {day=172, hour=2,  desc="Szpiedzy wychodza:  ", color="chocolate", type="spy_ishtar"},
        {day=172, hour=5,  desc="Szpiedzy znikaja:   ", color="chocolate", type="spy_ishtar"},
        {day=175, hour=22, desc="Szpiedzy wychodza:  ", color="chocolate", type="spy_ishtar"},
        {day=176, hour=5,  desc="Szpiedzy znikaja:   ", color="chocolate", type="spy_ishtar"},

        {day=181, hour=0,  desc="Poczatek lata:      ", color="yellow", type="season_ishtar"},
        {day=181, hour=0,  desc="Przesilenie letnie: ", color="yellow", type="solstice_ishtar"},
        {day=181, hour=0,  desc="Ryboludzie:         ", color="yellow", type="fishman_ishtar"},
        
        {day=196, hour=0,  desc="Poczatek pelni:     ", color="powder_blue", type="full_moon_ishtar"},
        {day=198, hour=0,  desc="Koniec pelni:       ", color="powder_blue", type="full_moon_ishtar"},

        {day=196, hour=2,  desc="Szpiedzy wychodza:  ", color="chocolate", type="spy_ishtar"},
        {day=196, hour=4,  desc="Szpiedzy znikaja:   ", color="chocolate", type="spy_ishtar"},
        {day=199, hour=22, desc="Szpiedzy wychodza:  ", color="chocolate", type="spy_ishtar"},
        {day=200, hour=4,  desc="Szpiedzy znikaja:   ", color="chocolate", type="spy_ishtar"},
        
        {day=220, hour=0,  desc="Poczatek pelni:     ", color="powder_blue", type="full_moon_ishtar"},
        {day=224, hour=0,  desc="Koniec pelni:       ", color="powder_blue", type="full_moon_ishtar"},

        {day=220, hour=2,  desc="Szpiedzy wychodza:  ", color="chocolate", type="spy_ishtar"},
        {day=220, hour=4,  desc="Szpiedzy znikaja:   ", color="chocolate", type="spy_ishtar"},
        {day=225, hour=22, desc="Szpiedzy wychodza:  ", color="chocolate", type="spy_ishtar"},
        {day=226, hour=5,  desc="Szpiedzy znikaja:   ", color="chocolate", type="spy_ishtar"},
        
        {day=244, hour=0,  desc="Poczatek pelni:     ", color="powder_blue", type="full_moon_ishtar"},
        {day=246, hour=0,  desc="Koniec pelni:       ", color="powder_blue", type="full_moon_ishtar"},

        {day=244, hour=2,  desc="Szpiedzy wychodza:  ", color="chocolate", type="spy_ishtar"},
        {day=244, hour=5,  desc="Szpiedzy znikaja:   ", color="chocolate", type="spy_ishtar"},
        {day=247, hour=22, desc="Szpiedzy wychodza:  ", color="chocolate", type="spy_ishtar"},
        {day=248, hour=5,  desc="Szpiedzy znikaja:   ", color="chocolate", type="spy_ishtar"},
        
        {day=268, hour=0,  desc="Poczatek pelni:     ", color="powder_blue", type="full_moon_ishtar"},
        {day=270, hour=0,  desc="Koniec pelni:       ", color="powder_blue", type="full_moon_ishtar"},

        {day=268, hour=2,  desc="Szpiedzy wychodza:  ", color="chocolate", type="spy_ishtar"},
        {day=268, hour=5,  desc="Szpiedzy znikaja:   ", color="chocolate", type="spy_ishtar"},

        {day=271, hour=0,  desc="Poczatek jesieni:   ", color="brown", type="season_ishtar"},
        {day=271, hour=0,  desc="Rownonoc jesienna:  ", color="brown", type="equinox_ishtar"},
        {day=271, hour=0,  desc="Ryboludzie:         ", color="brown", type="fishman_ishtar"},

        {day=271, hour=22, desc="Szpiedzy wychodza:  ", color="chocolate", type="spy_ishtar"},
        {day=272, hour=7,  desc="Szpiedzy znikaja:   ", color="chocolate", type="spy_ishtar"},

        {day=292, hour=0,  desc="Poczatek pelni:     ", color="powder_blue", type="full_moon_ishtar"},
        {day=294, hour=0,  desc="Koniec pelni:       ", color="powder_blue", type="full_moon_ishtar"},

        {day=292, hour=2,  desc="Szpiedzy wychodza:  ", color="chocolate", type="spy_ishtar"},
        {day=292, hour=7,  desc="Szpiedzy znikaja:   ", color="chocolate", type="spy_ishtar"},
        {day=295, hour=22, desc="Szpiedzy wychodza:  ", color="chocolate", type="spy_ishtar"},
        {day=296, hour=7,  desc="Szpiedzy znikaja:   ", color="chocolate", type="spy_ishtar"},

        {day=315, hour=18, desc="Leci pyl:           ", color="dodger_blue", type="special_ishtar"},
        
        {day=316, hour=0,  desc="Poczatek pelni:     ", color="powder_blue", type="full_moon_ishtar"},
        {day=318, hour=0,  desc="Koniec pelni:       ", color="powder_blue", type="full_moon_ishtar"},

        {day=316, hour=2,  desc="Szpiedzy wychodza:  ", color="chocolate", type="spy_ishtar"},
        {day=316, hour=6,  desc="Szpiedzy znikaja:   ", color="chocolate", type="spy_ishtar"},
        {day=319, hour=22, desc="Szpiedzy wychodza:  ", color="chocolate", type="spy_ishtar"},
        {day=320, hour=6,  desc="Szpiedzy znikaja:   ", color="chocolate", type="spy_ishtar"},
        
        {day=340, hour=0,  desc="Poczatek pelni:     ", color="powder_blue", type="full_moon_ishtar"},
        {day=342, hour=0,  desc="Koniec pelni:       ", color="powder_blue", type="full_moon_ishtar"},

        {day=340, hour=2,  desc="Szpiedzy wychodza:  ", color="chocolate", type="spy_ishtar"},
        {day=340, hour=6,  desc="Szpiedzy znikaja:   ", color="chocolate", type="spy_ishtar"},
        {day=343, hour=22, desc="Szpiedzy wychodza:  ", color="chocolate", type="spy_ishtar"},
        {day=344, hour=6,  desc="Szpiedzy znikaja:   ", color="chocolate", type="spy_ishtar"},
        
      },
    },

    data = {
      offset = 0,       -- narzut czasu realnego
      precision = 119,  -- dokladnosc czasu realnego na podstawie informacji z muda
      template = {},    -- uniwesalny kalendarz domeny
      calendar = {},    -- kalandarz domeny po uwzglednieniu narzutu czasu realnego
      results = {},     -- wyliczone informacje o szukanych punktach czasowych
    },
    
  },
  
  -- rozpoznanie liczby po stringu (godzina, dzien miesiaca)
  string2int = {
    ["pierwszy"] = 1,
    ["pierwsza"] = 1,
    ["drugi"] = 2,
    ["druga"] = 2,
    ["trzeci"] = 3,
    ["trzecia"] = 3,
    ["czwarty"] = 4,
    ["czwarta"] = 4,
    ["piaty"] = 5,
    ["piata"] = 5,
    ["szosty"] = 6,
    ["szosta"] = 6,
    ["siodmy"] = 7,
    ["siodma"] = 7,
    ["osmy"] = 8,
    ["osma"] = 8,
    ["dziewiaty"] = 9,
    ["dziewiata"] = 9,
    ["dziesiaty"] = 10,
    ["dziesiata"] = 10,
    ["jedenasty"] = 11,
    ["jedenasta"] = 11,
    ["dwunasty"] = 12,
    ["dwunasta"] = 12,
    ["trzynasty"] = 13,
    ["trzynasta"] = 13,
    ["czternasty"] = 14,
    ["czternasta"] = 14,
    ["pietnasty"] = 15,
    ["szesnasty"] = 16,
    ["siedemnasty"] = 17,
    ["osiemnasty"] = 18,
    ["dziewietnasty"] = 19,
    ["dwudziesty"] = 20,
    ["dwudziesty pierwszy"] = 21,
    ["dwudziesty drugi"] = 22,
    ["dwudziesty trzeci"] = 23,
    ["dwudziesty czwarty"] = 24,
    ["dwudziesty piaty"] = 25,
    ["dwudziesty szosty"] = 26,
    ["dwudziesty siodmy"] = 27,
    ["dwudziesty osmy"] = 28,
    ["dwudziesty dziewiaty"] = 29,
    ["trzydziesty"] = 30,
    ["trzydziesty pierwszy"] = 31,
    ["trzydziesty drugi"] = 32,
    ["trzydziesty trzeci"] = 33,
    ["trzydziesty czwarty"] = 34,
    ["trzydziesty piaty"] = 35,
    ["trzydziesty szosty"] = 36,
    ["trzydziesty siodmy"] = 37,
    ["trzydziesty osmy"] = 38,
    ["trzydziesty dziewiaty"] = 39,
    ["czterdziesty"] = 40,
    ["czterdziesty pierwszy"] = 41,
    ["czterdziesty drugi"] = 42,
    ["czterdziesty trzeci"] = 43,
    ["czterdziesty czwarty"] = 44,
    ["czterdziesty piaty"] = 45,
  },
}

-- zwroc sufix domeny po typie filtra
function ra.calendar.get_prefix(type)
  local arr = string.split(type, "_")
  local str = ""
  if arr[#arr] == "imperial" then
    str = "[Imperium] "
  elseif arr[#arr] == "ishtar" then
    str = "[Ishtar  ] "
  end
  return str
end

-- zwroc true jesli filtr zawiera suffix tylko jednej domeny, inaczej false
function ra.calendar.check_filters(filters)
  local f = ra.calendar.get_prefix(filters[1])
  for k,v in pairs(filters) do
    if f ~= ra.calendar.get_prefix(v) then
      return false
    end
  end
  return true
end

-- stworz tablice danych kalendarza timestamp,dzien_roku,godzina
-- jesli jest podany offset to dodaj go to timestampa
function ra.calendar.create_calendar(calendar, offset)
  local timestamp = offset
  local type = ""
  if offset == nil then
    if ra.debug then
      scripts:print_log("Blad w narzutu kalendarza: "..calendar["settings"]["name"].." -> "..offset) 
    end  
    return calendar
  end

  if offset == 0 then
    type = "template"
  elseif offset > 0 then
    type = "calendar"
  end
  if string.len(type) > 0 then
    calendar["data"][type] = {}
    for i=1,tonumber(calendar["settings"]["days_in_year"]) do
      calendar["data"][type][i] = {}
      for j=0,23 do
        calendar["data"][type][i][j] = timestamp
        timestamp = timestamp + ra.calendar.gamehour_real_time
      end
    end
    if offset > 0 then
      calendar["data"]["offset"] = offset
      calendar = ra.calendar.reload_calendar(calendar)
    end
  else
    if ra.debug then
      scripts:print_log("Blad w narzutu kalendarza: "..calendar["settings"]["name"].." -> "..offset) 
    end  
  end
  return calendar
end

-- zaktualizuj dynamiczne dane, czyli zbuduj nowy kalendarz z timestampem czasu rzeczywistego
-- funkcja uruchamiana jest przy wywolaniu komendy "czas"
-- dokladnosc pomiaru ustawiana jest na max blad pomiaru czyli 119 sek
function ra.calendar.refresh_calendar(calendar, d, h)
  calendar["data"]["offset"] = getEpoch() - calendar["data"]["template"][d][h]
  calendar = ra.calendar.create_calendar(calendar, calendar["data"]["offset"])
  ra.calendar.domain = calendar.settings.domain
  ra.calendar.save_local_time_data(calendar)
  return ra.calendar.reload_calendar(calendar)
end

-- przeladuj timestampy szukanych eventow
function ra.calendar.reload_calendar(calendar)
  local function fill_time(a, b, add)
    if a < b then
      return fill_time(a + add, b, add)
    else
      return a
    end
  end
  if table.size(calendar["data"]["calendar"]) > 0 then
    calendar["data"]["results"] = {}
    local t = 0
    local et = getEpoch()
    local day = 0
    for k, v in pairs(calendar["settings"]["search_times"]) do
      day = tonumber(v["day"]) -- - 1
      --if day <= 0 then
      --  day = calendar["settings"]["days_in_year"] - 1
      --end
      t = calendar["data"]["calendar"][day][v["hour"]]
      if t < et then
        t = fill_time(t, et, calendar["settings"]["year_time"])
      end
      table.insert(calendar["data"]["results"], { desc = v["desc"], timestamp = t, color = v["color"], type = v["type"], precision = calendar["data"]["precision"], 
                   game_date = "("..ra.calendar.get_gamedate(calendar, day, v["hour"])..")"} )
    end
  else
    if ra.debug then
      scripts:print_log("Blad w przeladowaniu kalendarza: "..calendar["settings"]["name"]) 
    end  
  end
  return calendar
  
end

-- zwraca czas gry kalendarza na podstawie podanego czasu rzeczywistego w danej domenie
function ra.calendar.get_game_time(timestamp, domain)
  if timestamp == nil then
    timestamp = getEpoch()
  end
  timestamp = tonumber(timestamp)
  if domain == nil then
    domain = ra.calendar.domain
  end
  if ra.calendar[domain] == nil or ra.calendar[domain].data == nil then
    return ""
  end
  
  --display(timestamp, domain)
  local cal = ra.calendar.create_calendar(ra.calendar[domain], ra.calendar[domain].data.offset)
  local tmp = {}
  local checked_time = false
  for a,v in pairs(cal.data.calendar) do
    for b,t in pairs(v) do
      if t >= timestamp then
        checked_time = true
      end
      tmp[t] = a.."_"..b
    end
  end
  
  local t = timestamp
  if not checked_time then
    t = timestamp - ra.calendar[domain].data.offset
  end
  
  local r = {}
  
  local function pairsByKeys (t, f)
    local a = {}
    for n in pairs(t) do table.insert(a, n) end
    table.sort(a, f)
    local i = 0      -- iterator variable
    local iter = function ()   -- iterator function
      i = i + 1
      if a[i] == nil then return nil
      else return a[i], t[a[i]]
      end
    end
    return iter
  end
     
  for k,v in pairsByKeys(tmp) do
    if k >= timestamp then
      break
    end
    r = string.split(v, "_")
  end
  if table.size(r) > 1 then
    return ra.calendar.get_gamedate(cal, r[1], r[2])
  else
    return ""
  end
end

function ra.calendar.get_events_results()
  if table.size(ra.calendar.imperial.data.calendar) > 0 then
    ra.calendar.imperial = ra.calendar.reload_calendar(ra.calendar.imperial)
  end
  if table.size(ra.calendar.ishtar.data.calendar) > 0 then
    ra.calendar.ishtar = ra.calendar.reload_calendar(ra.calendar.ishtar)
  end
  
  local function comp(a, b)
    if a["timestamp"] < b["timestamp"] then
      return true
    end
    return false
  end
  
  local union = {}
  
  if table.size(ra.calendar.imperial.data.calendar) > 0 and table.size(ra.calendar.ishtar.data.calendar) > 0 then
    union = table.n_union(ra.calendar.imperial.data.results, ra.calendar.ishtar.data.results)
  elseif table.size(ra.calendar.imperial.data.calendar) > 0 then
    union = ra.calendar.imperial.data.results
  elseif table.size(ra.calendar.ishtar.data.calendar) > 0 then
    union = ra.calendar.ishtar.data.results
  end

--  if table.size(ra.calendar.imperial.data.results) == 0 then
--    cecho("<tomato>Brak informacji o czasie w Imperium. Sprobuj uzyc komendy 'czas'.\n\n")
--  end
--  if table.size(ra.calendar.ishtar.data.results) == 0 then
--    cecho("<tomato>Brak informacji o czasie w Ishtar. Sprobuj uzyc komendy 'czas'.\n\n")
--  end
 
  table.sort(union, comp)
  return union
end

function ra.calendar.resttime(time)
 --display("resttime", time)
  local ret = ""
  if time > 0 then
    local days = math.floor(time/86400)
    local remaining = time % 86400
    local hours = math.floor(remaining/3600)
    remaining = remaining % 3600
    local minutes = math.floor(remaining/60)
    remaining = remaining % 60
    local seconds = math.floor(remaining)
    
    if days > 0 then
      ret = days.."d "..hours.."h "..minutes.."m "..seconds.."s"
    elseif days == 0 and hours > 0 then
      ret = hours.."h "..minutes.."m "..seconds.."s"
    elseif days == 0 and hours == 0 and minutes > 0 then
      ret = minutes.."m "..seconds.."s"
    elseif days == 0 and hours == 0 and minutes == 0 then
      ret = seconds.."s"
    end
  end
  return ret
end

-- wyswietl wynik wyliczonych eventoe na podstawie typow z filtra w nastepnych in_real_days dniach rzeczywistych
function ra.calendar.show_calendar_results(filters, in_real_days)
  local now = getEpoch()

  local time = 0
  local t = 0
  local desc_type = ra.calendar.check_filters(filters)
  if in_real_days ~= nil then
    time = in_real_days * 24 * 60 * 60
  end
  local union = ra.calendar.get_events_results()
  local c = "<wheat>"
  for k, v in pairs(union) do
    if v["precision"] == 0 then
      c = "<gold>"
    else
      c = "<wheat>"
    end
    if filters == nil or table.contains(filters, v["type"]) then
      t = v["timestamp"]-now
      if time > 0 then
        if t <= time then
          if desc_type then
            cecho("<"..v["color"]..">"..v["desc"].." "..os.date('%d.%m.%Y %H:%M:%S', v["timestamp"]).." <yellow>-> "..c.."za "..ra.calendar.resttime(t).." <gray>"..v["game_date"].."\n")
          else
            cecho("<"..v["color"]..">"..ra.calendar.get_prefix(v["type"])..v["desc"].." "..os.date('%d.%m.%Y %H:%M:%S', v["timestamp"]).." <yellow>-> "..c.."za "..ra.calendar.resttime(t).." <gray>"..v["game_date"].."\n")
          end
        end
      else
        if desc_type then
          cecho("<"..v["color"]..">"..v["desc"].." "..os.date('%d.%m.%Y %H:%M:%S', v["timestamp"]).." <yellow>-> "..c.."za "..ra.calendar.resttime(t).." <gray>"..v["game_date"].."\n")
        else
          cecho("<"..v["color"]..">"..ra.calendar.get_prefix(v["type"])..v["desc"].." "..os.date('%d.%m.%Y %H:%M:%S', v["timestamp"]).." <yellow>-> "..c.."za "..ra.calendar.resttime(t).." <gray>"..v["game_date"].."\n")
        end
      end
    end
  end  
end

-- zapisuje offesty czasu rzeczywistego w lokalnym jsonie
function ra.calendar.save_local_time_data()
  local data = {
    imperial_offset = ra.calendar["imperial"]["data"]["offset"], 
    ishtar_offset = ra.calendar["ishtar"]["data"]["offset"], 
  }
  
  local path = ra.calendar.json_file_path
  local file = io.open(path, "w")
  file:write(yajl.to_string(data))
  file:close()
  if ra.debug then
    scripts:print_log("Zapisano lokalny narzut czasow kalendarzy:")
    display(data)
  end
end

-- odczytuje offesy zapisane lokalnie i generuje z tego dynamiczne dane kalendarza
function ra.calendar.read_local_time_data()
  if io.exists(ra.calendar.json_file_path) then
    local data = scripts.utils:read_json(ra.calendar.json_file_path)    
    if data["imperial_offset"] ~= nil and tonumber(data["imperial_offset"]) > 0 then
      ra.calendar.imperial = ra.calendar.create_calendar(ra.calendar.imperial, data["imperial_offset"])
    end
    if data["ishtar_offset"] ~= nil and tonumber(data["ishtar_offset"]) > 0 then
      ra.calendar.ishtar = ra.calendar.create_calendar(ra.calendar.ishtar, data["ishtar_offset"])
    end
    
    if ra.debug then
      scripts:print_log("Zaladowano lokalny narzut czasow kalendarzy.") 
      display("json", data)
    end
  end  
end

-- inicjalizuje kalendarze domen przy starcie mudleta
function ra.calendar.init()
  ra.calendar.imperial = ra.calendar.create_calendar(ra.calendar.imperial, 0)
  ra.calendar.ishtar = ra.calendar.create_calendar(ra.calendar.ishtar, 0)
  ra.calendar.read_local_time_data()
  ra.calendar.init_gmcp()
end

-- definicja handlerow pod gmcp
function ra.calendar.init_gmcp()
  if scripts.event_handlers["ra_calendar_time"] then
    killAnonymousEventHandler(scripts.event_handlers["ra_calendar_time"])
  end
  scripts.event_handlers["ra_calendar_time"] = registerAnonymousEventHandler("gmcp.room.time", ra.calendar.handle_gmcp_time)
  if scripts.event_handlers["ra_calendar_domain"] then
    killAnonymousEventHandler(scripts.event_handlers["ra_calendar_domain"])
  end
  scripts.event_handlers["ra_calendar_domain"] = registerAnonymousEventHandler("gmcp.room.info.map", ra.calendar.handle_gmcp_domain)
end

-- redefiniuje dynamiczne dane przy zmianie wchodu/zachodu dnia arkowego
-- poprawia timestamp na podstawie gmcp
function ra.calendar.handle_gmcp_time()
  local timestamp = getEpoch()
  if ra.calendar.domain == "ishtar" and ra.calendar.ishtar.data.precision > 0 then
    ra.calendar.update_calendar_by_precision(ra.calendar.ishtar, timestamp)
  elseif ra.calendar.domain == "imperial" and ra.calendar.imperial.data.precision > 0 then
    ra.calendar.update_calendar_by_precision(ra.calendar.imperial, timestamp)
  else
    if ra.debug then
      scripts:print_log("Zmiana czasu w nieznanej domenie: "..ra.calendar.domain) 
    end
  end
end

-- ustawia domene na podstawie zmieny lokacji w danej domenie
function ra.calendar.handle_gmcp_domain()
  if gmcp ~= nil and gmcp.char ~= nil and gmcp.char.info ~= nil and gmcp.char.info.map ~= nil then
    if gmcp.room.info.map ~= nil then
      if gmcp.room.info.map.domain == "Imperium" then
        ra.calendar.domain = "imperial"
      end
      if gmcp.room.info.map.domain == "Ishtar" then
        ra.calendar.domain = "ishtar"
      end
    end
  end
end

-- aktualizuje dane dynamiczne kalendarza na podstawie zmiany czasu (wschod/zachod) w grze
function ra.calendar.update_calendar_by_precision(calendar, timestamp)
  local diff = 0
  calendar.data.precision = 0
  for d,v in pairs(calendar["data"]["calendar"]) do
    for h,t in pairs(v) do
      diff = timestamp - t
      if diff == 0 or (diff > 0 and diff < ra.calendar.gamehour_real_time) then
        if ra.debug then
          scripts:print_log("Poprawiono dokladnosc pomiaru kalendarza do 0 sekund: "..calendar.settings.name) 
        end       
        ra.calendar.refresh_calendar(calendar, d, h)
      end
    end
  end
  if ra.debug then
    scripts:print_log("update_calendar_by_precision") 
  end  
end

-- zwraca dzien miesiaca kalendarza domeny na podstawie dnia roku (danej domeny)
function ra.calendar.get_monthday(calendar, day)
  local c = {}
  for k,v in pairs(calendar["settings"]["first_day_of_calparts"]) do
    table.insert(c, { month=k, start=v })
  end
  local function comp(a,b)    
    return a["start"] > b["start"]
  end
  table.sort(c, comp)
  
  local next_month_start = 0
  local month_start = calendar["settings"]["days_in_year"]
  local tmp = false
  local month = "nieznany1"
  local next_month = "nieznany2"

  for _,v in ipairs(c) do
    if calendar["settings"]["first_day_of_calparts"][v["month"]] == day then
      return {day=1, month=v["month"]}
    end
    if tmp then
      next_month_start = v["start"]-1
      next_month = v["month"]
      tmp = false
      break
    end
    if v["start"] <= day then
      month = v["month"]
      month_start = (v["start"]-1)
      tmp = true
    end
  end
  local ret = day-month_start
  --display({day=ret, month=month})
  return {day=ret, month=month}
  
end

-- zwraca string dnia/godziny kalendarza danej domeny na podstawie dnia roku kalendarza domeny
function ra.calendar.get_gamedate(calendar, ds, h)
  local dd = ra.calendar.get_monthday(calendar, tonumber(ds))
  return dd["day"]..". "..dd["month"].." o "..h..":00 ["..ds.."]"
end

function ra.calendar.get_gametimes4notify()
  local now = getEpoch()
  local imp_time = ra.calendar.get_game_time(now, "imperial")
  local ish_time = ra.calendar.get_game_time(now, "ishtar")
  local ret = {}
  ret["timestamp"] = -1
  ret["color"] = "grey"
  ret["prefix"] = "Czas w domenach: "
  ret["desc"] = imp_time.." "..ish_time
  return ret
end

function ra.calendar.get_calendar_notify(time_out, time_in)
  local data = ra.calendar.get_events_results()
  local now = getEpoch()

  local post_time = now - ra.window_time_out * 60
  local pre_time = now + ra.window_time_in * 60
  
  if time_out ~= nil and time_in ~= nil then
    post_time = now - (time_out * 60)
    pre_time = now + (time_in * 60)
  end
  
  local ret = {}
  local c = ""
  for k,v in pairs(data) do
    if v["timestamp"] > post_time and v["timestamp"] < pre_time then
      if v["precision"] == 0 then
        c = "<gold>"
      else
        c = "<wheat>"
      end
      v["desc_color"] = c
      v["prefix"] = ra.calendar.get_prefix(v["type"])
      v["resttime"] = ra.calendar.resttime(v["timestamp"]-now)
      table.insert(ret, v)
    end
  end
  
  local function comp(a, b)
    if a["timestamp"] < b["timestamp"] then
      return true
    end
    return false
  end

  table.sort(ret, comp)
  return ret  
end

function ra.calendar.add_calendar_dc(in_real_days)
  local notify = ra.calendar.get_calendar_notify(0, (tonumber(in_real_days)*24*60))
  
  local user = "ra scripts"
  if gmcp ~= nil and gmcp.char ~= nil and gmcp.char.info ~= nil and gmcp.char.info.name ~= nil then
    user = gmcp.char.info.name
  end

  local content = "By *"..user.."*\n\n"
  local url = ra.dc_webhook_kalendarz

  for k, v in pairs(notify) do
    content = content..v["prefix"].." "..v["desc"].." "..os.date('%d.%m.%Y %H:%M:%S', v["timestamp"]).."\n"
  end    

  local data = {
   content = content,
   user = "Benicjo"
  }
   
  local header = {
     ["Content-Type"] = "application/json",
  }

  --display(url,data,header)
  
  ra.core.postJSON(url,data,header)
  scripts:print_log("Uaktualniono kalendarz na DC Alderazzi.")

end
