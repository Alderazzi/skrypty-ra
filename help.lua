function ra.core.print_start_message()
    scripts:print_log("Uzywasz pluginu arkadia-ra, ver. " .. ra.version .. ". Pomoc dostepna w '/ra_pomoc'")
end

function ra.alias.print_help()
  local color1 = "<yellow>"
  local color2 = "<grey>"
  local color3 = "<dodger_blue>"
  local color4 = "<ansi_light_cyan>"
  
  cecho(color1.."\nArkadia - Skrypty Rodziny Alderazzi, wersja " .. string.sub(ra.version .. "   ", 0, 5) .. "\n")
  cecho(color1.."\nAliasy do kategorii pomocy pluginu:\n")

  cecho(" ")
  cechoLink(color3.."/ra_pomoc_aliasy", [[expandAlias("/ra_pomoc_aliasy")]], "/ra_pomoc_aliasy", true)   
  cecho(color2.." - dostepne aliasy uzytkowe\n")
  cecho(" ")
  cechoLink(color3.."/ra_pomoc_klucze", [[expandAlias("/ra_pomoc_klucze")]], "/ra_pomoc_klucze", true)   
  cecho(color2.." - dostepne aliasy dla kluczodajek\n")
  cecho(" ")
  cechoLink(color3.."/ra_pomoc_kupiec", [[expandAlias("/ra_pomoc_kupiec")]], "/ra_pomoc_kupiec", true)   
  cecho(color2.." - dostepne aliasy dla obslugi sprzedawania, monet, historii sprzedazy\n")
  cecho(" ")
  cechoLink(color3.."/ra_pomoc_ziola", [[expandAlias("/ra_pomoc_ziola")]], "/ra_pomoc_ziola", true)   
  cecho(color2.." - dostepne aliasy do obslugi ziol\n")
  cecho(" ")
  cechoLink(color3.."/ra_pomoc_admin", [[expandAlias("/ra_pomoc_admin")]], "/ra_pomoc_admin", true)   
  cecho(color2.." - dostepne aliasy administracyjne\n")
  cecho(" ")
  cechoLink(color3.."/ra_pomoc_czas", [[expandAlias("/ra_pomoc_czas")]], "/ra_pomoc_czas", true)   
  cecho(color2.." - dostepne aliasy o informacjach kalendarzy\n")
  cecho(" ")
  cechoLink(color3.."/baza_kamieni", [[expandAlias("/baza_kamieni")]], "/baza_kamieni", true)   
  cecho(color2.." - wyswietla liste znanych kamieni i ich wlasciwosci\n")
  cecho(" ")
  cechoLink(color3.."/baza_flakonikow", [[expandAlias("/baza_flakonikow")]], "/baza_flakonikow", true)   
  cecho(color2.." - wyswietla liste znanych magicznych flakonikow i ich wlasciwosci\n")
  cecho(" ")
  cechoLink(color3.."/ra_zlecenia", [[expandAlias("/ra_zlecenia")]], "/ra_zlecenia", true)   
  cecho(color2.." - wyswietla liste aktualnych zlecen\n")
  cecho(" ")
  cechoLink(color3.."/ra_zlecenia_dc", [[expandAlias("/ra_zlecenia_dc")]], "/ra_zlecenia_dc", true)   
  cecho(color2.." - wrzuca liste aktualnych zlecenna DC\n")
  cecho(" ")
  cechoLink(color3.."/ra_pomoc", [[expandAlias("/ra_pomoc")]], "/ra_pomoc", true)   
  cecho(color2.." - pomoc ktora czytasz\n")

  cecho(color1.."\nAliasy ogolne:\n")

  cecho(" ")
  cechoLink(color3.."/zapr", [[expandAlias("/zapr")]], "/zapr", true)   
  cecho(color2.." - zaprasza wszystkich na lokacji nie bedacych w druzynie\n")
  cecho(" ")
  cechoLink(color3.."/odloz_magie_ra", [[expandAlias("/odloz_magie_ra")]], "/odloz_magie_ra", true)   
  cecho(color2.." - odklada odpowiednia magie do odpowiedniej skrzyni\n")
  cecho(" ")
  cechoLink(color3.."/kup_bilety", [[expandAlias("/kup_bilety")]], "/kup_bilety", true)   
  cecho(color2.." - kupuje bilety dla czlonkow druzyny\n")
  cecho(color4.." , "..color2.." - uproszczenny alias do 'snprzekaz'. Przyklad ', wrog 1 ne' -> 'snprzekaz wrog, liczbe 1, polnocny-wschod'\n")
  
  cecho(color1.."\nAliasy do obslugi pluginu:\n")

  cecho(" ")
  cechoLink(color3.."/lpra", [[expandAlias("/zapr")]], "/lpra", true)   
  cecho(color2.." - recznie przeladowanie pluginu 'arkadia-ra'\n")
  cecho(" ")
  cechoLink(color3.."/ra_przeinstaluj_plugin", [[expandAlias("/ra_przeinstaluj_plugin")]], "/ra_przeinstaluj_plugin", true)   
  cecho(color2.." - odinstalowuje ten plugin i instaluje aktualna wersje\n")
  cecho(" ")
  cechoLink(color3.."/ra_sprawdz_aktualizacje", [[expandAlias("/ra_sprawdz_aktualizacje")]], "/ra_sprawdz_aktualizacje", true)   
  cecho(color2.." - reczne sprawdzanie czy jest dostepna nowa wersja skryptow ra\n")
  cecho(color4.." /ustaw_autoryzacje_ra <rola> <haslo> "..color2.." - ustawia dane autoryzacji online np. /ustaw_autoryzacje_ra Soldato test1234\n")
  cechoLink(color3.."/teleskop", [[expandAlias("/teleskop")]], "/teleskop", true)   
  cecho(color2.." - sprawdza gwiazdozbiory na lokacji z teleskopem u astronoma\n")
  cecho(" ")
  cechoLink(color3.."/ustaw_astrolabium", [[expandAlias("/ustaw_astrolabium")]], "/ustaw_astrolabium", true)   
  cecho(color2.." - ustawia astrolabium na podstawie danych zebranych z teleskopu\n")
  cecho(" ")
  
end

function ra.alias.print_help1()
  local color1 = "<yellow>"
  local color2 = "<grey>"
  local color3 = "<dodger_blue>"
  local color4 = "<ansi_light_cyan>"
  
  cecho(color1.."\nKolejne rozwiniecie kazdego aliasu:\n")

  cecho(" ")
  cechoLink(color3.."/jadalnia_ra", [[expandAlias("/jadalnia_ra")]], "/jadalnia_ra", true)   
  cecho(color2.." - jedzenie w jadalni\n")
  cecho(" ")
  cechoLink(color3.."/razm", [[expandAlias("/razm")]], "/razm", true)   
  cecho(color2.." - snprzekaze zmeczenie i pytanie Jesli ktos przekaze 'zmeczenie' i 'pytanie' to zbinduje 'snzmeczenie' na ']'\n")
  cecho(" ")
  cechoLink(color3.."/plaszcze", [[expandAlias("/plaszcze")]], "/plaszcze", true)   
  cecho(color2.." - sprawdza kto w druzynie bedacy na lokacji nie ma zalozonego kaptura\n")
  cecho(" ")
  cechoLink(color3.."/kup_bilety", [[expandAlias("/kup_bilety")]], "/kup_bilety", true)   
  cecho(color2.." - kupuje bilety dla czlonkow druzyny\n")
  cecho(" ")
  cechoLink(color3.."/zapr", [[expandAlias("/zapr")]], "/zapr", true)   
  cecho(color2.." - zaprasza wszystkich na lokacji nie bedacych w druzynie\n")
  cecho(" ")
  cechoLink(color3.."/odloz_magie_ra", [[expandAlias("/odloz_magie_ra")]], "/odloz_magie_ra", true)   
  cecho(color2.." - odklada odpowiednia magie do odpowiedniej skrzyni\n")
  cecho(" ")
  cechoLink(color3.."/woz-", [[expandAlias("/woz-")]], "/woz-", true)   
  cecho(color2.." - wylacza komendy do poruszania sie wozem\n")
  cecho(" ")
  cechoLink(color3.."/woz", [[expandAlias("/woz")]], "/woz", true)   
  cecho(color2.." - pokazuje aktualne informacje o wozie\n")
  cecho(" ")
  cechoLink(color3.."/woz", [[expandAlias("/woz+")]], "/woz+", true)   
  cecho(color2.." - pokazuje rozszerzone informacje o obsludze wozow\n")
  cecho(" ")
  cechoLink(color3.."/zaslon+", [[expandAlias("/zaslon+")]], "/zaslon+", true)   
  cecho(color2.." - wlacza puszczanie zaslon po rozkazach RA.\n")
  cecho(" ")
  cechoLink(color3.."/zaslon-", [[expandAlias("/zaslon-")]], "/zaslon-", true)   
  cecho(color2.." - wylacza puszczanie zaslon po rozkazach RA.\n")
  cecho(" ")
  cechoLink(color3.."/zaslon", [[expandAlias("/zaslon")]], "/zaslon", true)   
  cecho(color2.." - trzymanie zaslon\n")
  cecho(" ")
  cechoLink(color3.."/puszczaj", [[expandAlias("/puszczaj")]], "/puszczaj", true)   
  cecho(color2.." - puszczanie zaslon\n")
  cecho(" ")
  cechoLink(color3.."/got", [[expandAlias("/got")]], "/got", true)   
  cecho(color2.." - sprawdzanie gotowości teamu\n")
  cecho(color4.." /ddaj <cos_czlonkom_druzyny>"..color2.." - daje <cos> kazdemu czlonkowi druzyny\n")
  
  cecho(" ")  cechoLink(color3.."/ra_pomoc_aliasy", [[expandAlias("/ra_pomoc_aliasy")]], "/ra_pomoc_aliasy", true)   
  cecho(color2.." - pomoc ktora czytasz\n")
  
  cecho(color1.."\nPonadto:\n")
  
  cecho(color2.." - Bindowanie przejsc do naszych safe lockow (ebino, viadaza, varieno)\n")
  cecho(color2.." - Parsowanie bindow 'snprzekaz' - pod , - uproszczony alias do 'snprzekaz'\n")
  cecho(color2.." - Bindowanie pod ']' po tym jak ktos otuli sie plaszczem 'otul sie plaszczem'\n")
  cecho(color2.." - Po wejsciu do Benicja ']' to 'zapytaj benicja o obecnych'\n")
  cecho(color2.." - U kazdego sprzedawcy ze zleceniami ']' to 'zapytanie o prace'\n")
  cecho(color2.." - Pakowanie sprzetu ze zjaw do sarkofagow po zabiciu i po obejrzeniu sarkofagu branie sprzetu (na ']')\n")
  cecho(color2.." - Podpisywanie sarkofagow w Campogrotta po 'ob sarkofag'\n")
  cecho(color2.." - Rozbrajanie sarkofagu w Campogrotta po 'ob sarkofag'\n")
  cecho(color2.." - dodanie opisu dla dylizansow w Tileii\n")
  cecho(color2.." - rozszezona obsluga wozow\n")
  cecho(color2.." - wspomagana obsluga zlecen\n")
end

function ra.alias.print_help2()
  local color1 = "<yellow>"
  local color2 = "<grey>"
  local color3 = "<dodger_blue>"
  local color4 = "<ansi_light_cyan>"
  
  cecho(color1.."\nDostepne aliasy do obslugi ziol:\n")

  cecho(" ")
  cechoLink(color3.."/trad", [[expandAlias("/trad")]], "/trad", true)   
  cecho(color2.." - pokazuje ziola na trad, ktore mamy w woreczkach; klikajac na link mozna je uzyc\n")
  cecho(" ")
  cechoLink(color3.."/trad!", [[expandAlias("/trad!")]], "/trad!", true)   
  cecho(color2.." - pokazuje ziola na trad wlacznie z tymi, ktorych nie mamy w woreczkach; klikajac link mozna uzyc ziola\n")
  cecho(" ")
  cechoLink(color3.."/dolegliwosci", [[expandAlias("/dolegliwosci")]], "/dolegliwosci", true)   
  cecho(color2.." - pokazuje ziola na odtrucia, ktore mamy w woreczkach; klikajac na link mozna je uzyc\n")
  cecho(" ")
  cechoLink(color3.."/dolegliwosci!", [[expandAlias("/dolegliwosci!")]], "/dolegliwosci!", true)   
  cecho(color2.." - pokazuje ziola na odtrucia wlacznie z tymi, ktorych nie mamy w woreczkach; klikajac link mozna uzyc ziola\n")
  cecho(" ")
  cechoLink(color3.."/ra_pomoc_ziola", [[expandAlias("/ra_pomoc_ziola")]], "/ra_pomoc_ziola", true)   
  cecho(color2.." - pomoc ktora czytasz\n")
end

function ra.alias.print_help3()
  local color1 = "<yellow>"
  local color2 = "<grey>"
  local color3 = "<dodger_blue>"
  local color4 = "<ansi_light_cyan>"
  
  cecho(color1.."\nDostepne aliasy dla kluczodajek:\n")

  cecho(color4.." /wrog <tekst>"..color2.." - wysyla list do obecnych z miejscem spotkania do wsparcia, mozna dopisac dodatkowy tekst\n")
  cecho(color4.." /wrog2 <tekst>"..color2.." - wysyla list do obecnych z miejscem spotkania do wsparcia bez sygnatury, mozna dopisac dodatkowy tekst\n")
  
  cecho(" ")
  cechoLink(color3.."/ra_wrogowie_wylacz", [[expandAlias("/ra_wrogowie_wylacz")]], "/ra_wrogowie_wylacz", true)   
  cecho(color2.." - Wylacza obsluge wrogow. (Po restarcie mudleta/skryptow obsluga wrogow bedzie znowu aktywna.)\n")
  cecho(" ")
  cechoLink(color3.."/klucze", [[expandAlias("/klucze")]], "/klucze", true)   
  cecho(color2.." - pokazuje okoliczne kluczodajki i koloruje lokacje na ktorej moze byc kluczodajka\n")
  cecho(color4.." /klucze <odleglosc>"..color2.." - pokazuje kluczodajki w zadanej odleglosci i koloruje lokacje na ktorej moze byc kluczodajka\n")
  cecho(color4.." /klucze <tekst>"..color2.." - pokazuje kluczodajki z nazwa/opisem zabierajacy <tekst> i koloruje lokacje na ktorej moze byc kluczodajka\n")
  cecho(" ")
  cechoLink(color3.."/klucze!", [[expandAlias("/klucze!")]], "/klucze!", true)   
  cecho(color2.." - pokazuje wszystkie znane kluczodajki\n")
  cecho(" ")
  cechoLink(color3.."/klucze_zabici", [[expandAlias("/klucze_zabici")]], "/klucze_zabici", true)   
  cecho(color2.." - pokazuje dropy z ostatnich 24 godzin\n")
  cecho(" ")
  cechoLink(color3.."/klucze_zabici7", [[expandAlias("/klucze_zabici7")]], "/klucze_zabici7", true)   
  cecho(color2.." - pokazuje dropy z ostatnich 7 dni\n")
  cecho(color4.." /klucze_zabici <z ostatnich X h>"..color2.." - pokazuje dropy z ostatnich X godzin\n")
  cecho(" ")
  cechoLink(color3.."/klucze_nastepne", [[expandAlias("/klucze_nastepne")]], "/klucze_nastepne", true)   
  cecho(color2.." - pokazuje kluczodajki dostepne w nastapnych 24 godzinach od ostatnich 24 godzin\n")
  cecho(" ")
  cechoLink(color3.."/klucze_nastepne7", [[expandAlias("/klucze_nastepne7")]], "/klucze_nastepne7", true)   
  cecho(color2.." - pokazuje kluczodajki dostepne w nastepnych 7 dniach od ostatnich 24 godzin\n")
  cecho(color4.." /klucze_szukaj <kawalek nazwy kluczodajki>"..color2.." - pokazuje liste znalezionych kluczodajek i umozliia przez klikniecie dodanie czasu pojawienia odraz dropu\n")

  cecho(color4.." /klucze_dodaj <Nazwa kluczodajki>"..color2.." - dodaje wpis o wystapieniu kluczodajki na www, czas dodania to czas wodpalenia aliasu\n")
  cecho(color4.." /klucze_dodaj <Nazwa kluczodajki>#<data>"..color2.." - dodaje wpis o wystapieniu kluczodajki na www z wlasna data (np. 2023.07.31 20:19) do wpisania na prompcie.\n")
  cecho(color4.." /klucze_dodaj <Nazwa kluczodajki>#<Nazwa klucza>"..color2.." - dodaje wpis o wystapieniu kluczodajki na www i klucz (drop) jaki wypadl\n")
  cecho(color4.." /klucze_dodaj <Nazwa kluczodajki>#<Nazwa klucza>#<data>"..color2.." - dodaje wpis o wystapieniu kluczodajki na www i klucz (drop) jaki wypadl z wlasna data do wpisania na prompcie\n")

  cecho(" ")
  cechoLink(color3.."/klucze_lista", [[expandAlias("/klucze_lista")]], "/klucze_lista", true)   
  cecho(color2.." - pokazuje klucze z data waznosci + 1 dzien\n")
  cecho(color4.." /klucze_lista <X>"..color2.." - pokazuje klucze z data waznosci + X dni\n")


  cecho(color4.." /klucze_nastepne <w nastepnych X h>"..color2.." - pokazuje kluczodajki dostepne w nastepnych X godzinach od ostatnich 24 godzin\n")
--  cecho(color4.." /dodaj_kluczodajke <name#mapId#respawnTime#description>"..color2.." - dodaje kluczodajke do lokalnej listy\n")
--  cecho(color4.." /edytuj_kluczodajke <id#name#mapId#respawnTime#description>"..color2.." - edytuje lokalnie kluczodajke. Mozna kliknac na nazwe w liscie kluczodajek.\n")
  
  cecho(" ")
  cechoLink(color3.."/klucze_reset_kolorow", [[expandAlias("/klucze_reset_kolorow")]], "/klucze_reset_kolorow", true)   
  cecho(color2.." - przeladowuje mappera aktualnie dostepna mapa online i resetuje kolor ikon kluczodajek\n")
  
  cecho(" ")
  cechoLink(color3.."/ra_pomoc_klucze", [[expandAlias("/ra_pomoc_klucze")]], "/ra_pomoc_klucze", true)   
  cecho(color2.." - pomoc ktora czytasz\n")
end

function ra.alias.print_help4()
  local color1 = "<yellow>"
  local color2 = "<grey>"
  local color3 = "<dodger_blue>"
  local color4 = "<ansi_light_cyan>"
  
  cecho(color1.."\nDostepne aliasy dla obslugi monet i historii sprzedazy:\n")

  cecho(color4.." /ddajz <ile_zlotych_monet_czlonkom_druzyny>"..color2.." - daje X zlotych monet kazdemu czlonkowi druzyny\n")
  cecho(color4.." /mpokaz <ile procent>"..color2.." - pokazuje procent z ostatniej tranzakcji. Przyklad: /mpokaz 90\n")
  cecho(color4.." /mwloz <ile procent> <gdzie>"..color2.." - wklada procent z ostatniej tranzakcji do pojemnika. Przyklad:   /mwloz 10 do swojej sakiewki\n")
  cecho(color4.." /mustaw <ile procent>"..color2.." - Ustawia procent (np. koszty denominacji w banku) ktory bedzie odejmowalo przy pokazywaniu zdenominowanych monet sprzedazy czy wyceny towaru. Przyklad: /mustaw 5\n")
  cecho(" ")
  cechoLink(color3.."/musun_historie", [[expandAlias("/musun_historie")]], "/musun_historie", true)   
  cecho(color2.." - Czysci historie pieniedzy otrzymanych w ostatnich tranzakcjach\n")
  cecho(" ")
  cechoLink(color3.."/ra_pomoc_kupiec", [[expandAlias("/ra_pomoc_kupiec")]], "/ra_pomoc_kupiec", true)   
  cecho(color2.." - pomoc ktora czytasz\n")
end

function ra.alias.print_help5()
  local color1 = "<yellow>"
  local color2 = "<grey>"
  local color3 = "<dodger_blue>"
  local color4 = "<ansi_light_cyan>"
  
  cecho(color1.."\nDostepne aliasy administracyjne:\n")

  cecho(" ")
  cechoLink(color3.."/ra_pobierz_dane_online", [[expandAlias("/ra_pobierz_dane_online")]], "/ra_pobierz_dane_online", true)   
  cecho(color2.." - Pobiera dane rodziny dostepne online.\n")
  cecho(color4.." /ustaw_autoryzacje_ra <rola> <haslo>"..color2.." - ustawia dane autoryzacji online np. /ustaw_autoryzacje_ra Soldato test1234\n")
  cecho(color4.." /ustaw_autoryzacje_ra! <rola> <haslo>"..color2.." - nadpisuje dane autoryzacji online np. /ustaw_autoryzacje_ra! Soldato test1234\n")
  cecho(" ")
  cechoLink(color3.."/ra_pomoc_admin", [[expandAlias("/ra_pomoc_admin")]], "/ra_pomoc_admin", true)   
  cecho(color2.." - pomoc ktora czytasz\n")
end

function ra.alias.print_help6()
  local color1 = "<yellow>"
  local color2 = "<grey>"
  local color3 = "<dodger_blue>"
  local color4 = "<ansi_light_cyan>"
  
  cecho(color1.."\nDostepne aliasy o informacjach kalendarzy:\n")

  cecho(" ")
  cechoLink(color3.."/czas", [[expandAlias("/czas")]], "/czas", true)   
  cecho(color2.." - Pokazuje wszystkie dostepne wyliczenia czasow zwiazanych z gra w nastepnych 3 dniach RLT.\n")
  cecho(" ")
  cechoLink(color3.."/czas+", [[expandAlias("/czas+")]], "/czas+", true)   
  cecho(color2.." - Pokazuje wszystkie dostepne wyliczenia czasow zwiazanych z gra przez nastepny rok muda.\n")
  cecho(" ")
  cechoLink(color3.."/czas_dc", [[expandAlias("/czas_dc")]], "/czas_dc", true)   
  cecho(color2.." - Wrzuca wszystkie dostepne wyliczenia czasow zwiazanych z gra w nastepnych 2 dniach RLT na DC #kalendarz.\n")
  cecho(" ")
  cechoLink(color3.."/czas_imperium", [[expandAlias("/czas_imperium")]], "/czas_imperium", true)   
  cecho(color2.." - Pokazuje wszystkie dostepne wyliczenia czasow zwiazanych z gra w domenie Imperium w nastepnych 3 dniach RLT.\n")
  cecho(" ")
  cechoLink(color3.."/czas_imperium+", [[expandAlias("/czas_imperium+")]], "/czas_imperium+", true)   
  cecho(color2.." - Pokazuje wszystkie dostepne wyliczenia czasow zwiazanych z gra w domenie Imperium przez nastepny rok muda.\n")
  cecho(" ")
  cechoLink(color3.."/czas_ishtar", [[expandAlias("/czas_ishtar")]], "/czas_isthar", true)   
  cecho(color2.." - Pokazuje wszystkie dostepne wyliczenia czasow zwiazanych z gra w domenie Ishtar w nastepnych 3 dniach RLT.\n")
  cecho(" ")
  cechoLink(color3.."/czas_ishtar+", [[expandAlias("/czas_ishtar+")]], "/czas_isthar+", true)   
  cecho(color2.." - Pokazuje wszystkie dostepne wyliczenia czasow zwiazanych z gra.\n")
  cecho(" ")
  cechoLink(color3.."/now", [[expandAlias("/now")]], "/now", true)   
  cecho(color2.." - Pokazuje dostepne wyliczenia czasow nowiu na czas calego roku imperialnego w nastepnych 3 dniach RLT.\n")
  cecho(" ")
  cechoLink(color3.."/pory_roku", [[expandAlias("/pory_roku")]], "/pory_roku", true)   
  cecho(color2.." - Pokazuje dostepne wyliczenia czasow por w grze przez nastepn rok muda.\n")
  cecho(" ")
  cechoLink(color3.."/ra_pomoc_czas", [[expandAlias("/ra_pomoc_czas")]], "/ra_pomoc_czas", true)   
  cecho(color2.." - pomoc ktora czytasz\n")
end

function ra.core.help_add_keygivers()
  cecho("\n<yellow> Przyklady dodania dropu z wlasna data:\n")
  cecho("\n<green>  /klucze_dodaj <Nazwa kluczodajki>;<data> - dodaje wpis o wystapieniu kluczodajki na www z wlasna data (np. 2023.07.31 20:19) do zmiany na prompcie.")
  cecho("\n<green>  /klucze_dodaj <Nazwa kluczodajki>;<Nazwa klucza>;<data> - dodaje wpis o wystapieniu kluczodajki na www i klucz (drop) jaki wypadl z wlasna data do zmiany na prompcie\n\n")
end
