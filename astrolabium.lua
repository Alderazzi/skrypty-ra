Astrolabium = Astrolabium or {
  race = "czlowiek",
  hour = -1,
  day = -1,
  constellation = {
    ["czlowiek"] = {
      ["wielki dab"] = "Zloty Smok",
      ["tartak"] = "Prawda",
      ["wilka"] = "Studia Wiedzy",
      ["dorodnego konia"] = "Wieszcz Dobrej Nowiny",
      ["scene z polowania"] = "Wlocznia",
      ["mlynskie kolo"] = "Dziki Wilk",
      ["skorpiona"] = "Dzban",
      ["rybe"] = "Siedem Koz",
      ["wage"] = "Srebrna Tarcza",
      ["bobra"] = "Dzwonnik",
      ["wscieklego psa"] = "Naga Luczniczka",
      ["barke"] = "Dziki Zubr",
      ["dzika"] = "Jednorozec",
      ["borsuka"] = "Kaplanka",
      ["farme"] = "Letnia Panna",
      --["borsuka"] = "Zimowa Panna", 
      ["drwala przy wyrebie"] = "Lisc Debu",
      ["ognisko"] = "Oko",
      ["miecz"] = "Wielka Kozica",
      ["rohatyne"] = "Bialy Kon",
    },
    ["gnom"] = {
      ["wulkan"] = "Zloty Smok",
      ["rurke"] = "Prawda",
      ["powywijany drucik"] = "Studia Wiedzy",
      ["tube"] = "Wieszcz Dobrej Nowiny",
      ["prosty trybik"] = "Wlocznia",
      ["mlynskie kolo"] = "Dziki Wilk", -- todo
      ["klepsydre"] = "Dzban",
      ["rybe"] = "Siedem Koz",          -- todo
      ["szmaragd"] = "Srebrna Tarcza",
      ["line"] = "Dzwonnik",
      ["gora"] = "Naga Luczniczka",
      ["mlot"] = "Dziki Zubr",
      ["zabiegana gnomke"] = "Jednorozec",
      ["borsuka"] = "Kaplanka",         -- todo
      ["soczewke"] = "Letnia Panna",
      ["borsuka"] = "Zimowa Panna",     
      ["skomplikowana machine"] = "Lisc Debu",
      ["ognisko"] = "Oko",              -- todo
      ["kompas"] = "Wielka Kozica",
      ["rohatyne"] = "Bialy Kon",       -- todo
    },
    ["polelf"] = {
      ["lisc"] = "Zloty Smok",
      ["flet"] = "Prawda",
      ["lire"] = "Studia Wiedzy",
      ["tube"] = "Wieszcz Dobrej Nowiny", -- todo
      ["prosty trybik"] = "Wlocznia",     -- todo
      ["mlynskie kolo"] = "Dziki Wilk",   -- todo
      ["szafir"] = "Dzban",
      ["rybe"] = "Siedem Koz",            -- todo
      ["driade"] = "Srebrna Tarcza",
      ["smukly luk"] = "Dzwonnik",
      ["jednorozca"] = "Naga Luczniczka",
      ["lesne jezioro"] = "Dziki Zubr",
      ["zgrabnego konia"] = "Jednorozec",
      ["oko"] = "Kaplanka",
      ["soczewke"] = "Letnia Panna",      -- todo
      ["orla"] = "Zimowa Panna",          
      ["prastary las"] = "Lisc Debu",
      ["ognisko"] = "Oko",                -- todo
      ["lutnie"] = "Wielka Kozica",
      ["rohatyne"] = "Bialy Kon",         -- todo
    },    
  },
  
  telescope = {
    curr_direction = "",
    direction_constellation = {
      polnoc = {}, poludnie = {}, wschod = {}, zachod = {}
    },
    cupola_open = true,
  },
}

function Astrolabium.init()
  Astrolabium.set_race()
  Astrolabium.hour = 8
  Astrolabium.day = 99
  
end

function Astrolabium.set_race()
  if gmcp == nil or gmcp.char == nil or gmcp.char.info == nil or gmcp.char.info.race == nil then
    Astrolabium.race = "czlowiek"
  else  
    Astrolabium.race = gmcp.char.info.race
  end
end

function Astrolabium.show_constellation()
  local directions = Astrolabium.telescope.direction_constellation
  local data = {}
  local str = ""
  for k,v in pairs(directions) do
    if table.size(v) > 0 then
      str = "\n<PaleGreen>Gwiazdozbiory w kierunku <yellow>"..string.upper(k).."<grey>: <violet_red>"
      data = {}
      for k1,v1 in pairs(v) do
        table.insert(data, v1)
      end
      cecho(str..table.concat(data, ", "))
    end
  end
end

function Astrolabium.telescope.set_curr_direction(direction)
  Astrolabium.telescope.curr_direction = direction
end

function Astrolabium.set_constellation(direction, name)
  table.insert(Astrolabium.telescope.direction_constellation[direction], name)
end

function Astrolabium.execute_set_astrolabium()
  for direction,constellations in pairs(Astrolabium.telescope.direction_constellation) do
    for _,constellation in pairs(constellations) do
      send("ustaw gwiazdozbior "..constellation.." na astrolabium na "..direction)
    end
  end
end

function Astrolabium.initiate_check_directions()
  Astrolabium.set_race()
  local get_str = "/prowadz i64dd8ee7d"
  Astrolabium.telescope.direction_constellation = {}
  if amap.curr.internal_id ~= "i64dd8ee7d" then
    cecho("\n<tomato>Nie jestes na odpowiedniej lokacji ")
    cechoLink("<light_slate_blue>i64dd8ee7d", function () expandAlias(get_str) end, get_str, true)
    cecho("\n")
    return
  end
  Astrolabium.coroutine_id = nil
  if not mudlet.supports.coroutines then
      return
  end
  Astrolabium.coroutine_id = coroutine.create(Astrolabium.check_directions_by_telescope)
  coroutine.resume(Astrolabium.coroutine_id)
end

--[[
function Astrolabium.check_cupola()
  local function check_cupola()
    if Astrolabium.telescope.cupola_open then
      Astrolabium.coroutine_id = coroutine.create(Astrolabium.check_directions_by_telescope)
      coroutine.resume(Astrolabium.coroutine_id)
    end
  end
  send("ob kopule")
  coroutine.yield()
  check_cupola()
  send("krec korba w prawo")
  coroutine.yield()
  check_cupola()
  send("krec korba w lewo")
  coroutine.yield()
  check_cupola() 
end
]]--

function Astrolabium.check_directions_by_telescope()
  if gmcp.room.time.daylight == true then
    cecho("\n<tomato>Moze jednak poczekaj az zajdzie slonce...")
    return
  end
-- Chwilowe pogorszenie pogody sprawia jednak, ze nie udalo ci sie dostrzec zadnego gwiazdozbioru.
  send("wejdz na podest")
  coroutine.yield()
  send("obroc teleskop na polnoc")
  coroutine.yield()
  send("popatrz przez teleskop")
  coroutine.yield()
  send("obroc teleskop na wschod")
  coroutine.yield()
  send("popatrz przez teleskop")
  coroutine.yield()
  send("obroc teleskop na poludnie")
  coroutine.yield()
  send("popatrz przez teleskop")
  coroutine.yield()
  send("obroc teleskop na zachod")
  coroutine.yield()
  send("popatrz przez teleskop")
  coroutine.yield()
  send("zejdz z podestu")
  Astrolabium.coroutine_id = nil
  scripts:print_log("Ok, sprawdzilem gwiazdozbiory", true)
end

function trigger_rozpoznanie_kierunku_teleskopu()
  local direction = string.trim(matches[2])
  Astrolabium.telescope.set_curr_direction(direction)
end

function trigger_rozpoznanie_gwiazdozbiorow()
  local direction = Astrolabium.telescope.curr_direction
  Astrolabium.telescope.direction_constellation[direction] = {}
  
  for k,v in pairs(matches) do
    if k%2 == 0 then
      Astrolabium.set_constellation(direction, Astrolabium.constellation[Astrolabium.race][v])
    end
  end
  Astrolabium.show_constellation()
end

function trigger_rozpoznanie_dnia_astrolabium()
  Astrolabium.day = tonumber(matches[2])
  Astrolabium.display_date()
end

function trigger_rozpoznanie_godziny_astrolabium()
  Astrolabium.hour = tonumber(matches[2])
end

function Astrolabium.display_date()
  local function check_table_contains(table, arr)
    for _,v in pairs(table) do
      if v["desc"] == arr["desc"] and v["day"] == arr["day"] and v["hour"] == arr["hour"] then
        return true
      end
    end
    return false
  end
  local astro = {day=Astrolabium.day, hour=Astrolabium.hour, desc="Astrolabium:        ", color="gold", type="treasury_ishtar"}
  if not check_table_contains(ra.calendar.ishtar.settings.search_times, astro) then
    table.insert(ra.calendar.ishtar.settings.search_times, astro)
  end
  ra.calendar.ishtar = ra.calendar.reload_calendar(ra.calendar.ishtar)
  scripts:print_log("Termin wykonania astrolabium zostal dodany do eventow kalendarza.", true)
  ra.calendar.show_calendar_results({"treasury_ishtar"})
end

Astrolabium.init()

--[[
  ----N----
  W zenicie, na prawym skraju tej czesci niebosklonu, widnieje gwiazdozbior przypominajacy mlynskie kolo.
  W zenicie, na prawym skraju tej czesci niebosklonu, dostrzegasz gwiazdozbior przypominajacy skorpiona.
  Nad horyzontem, w lewej czesci nieba, widzisz gwiazdozbior przypominajacy rybe.
  
  ----N2----
  Wysoko nad horyzontem, na prawym skraju tej czesci niebosklonu, dostrzegasz gwiazdozbior przypominajacy bobra.
  Nad horyzontem, w centralnym punkcie obserwowanego nieba, widnieje gwiazdozbior przypominajacy wscieklego psa.
  Dosyc blisko zenitu, w centralnym punkcie obserwowanego nieba, w pelnej krasie widoczny jest gwiazdozbior przypominajacy wage poza tym w zenicie, 
  w centralnym punkcie obserwowanego nieba, dostrzegasz gwiazdozbior przypominajacy wielki dab.
  Prawie w zenicie, na lewym skraju tej czesci niebosklonu, widnieje gwiazdozbior przypominajacy mlynskie kolo.
  Nad horyzontem, w lewej czesci nieba, dostrzegasz gwiazdozbior przypominajacy skorpiona.

  ----E----
  Na linii horyzontu, w centralnym punkcie obserwowanego nieba, w pelnej krasie widoczny jest gwiazdozbior przypominajacy bobra.
  Tuz nad horyzontem, na lewym skraju tej czesci niebosklonu, widnieje gwiazdozbior przypominajacy wage oraz wysoko nad horyzontem, 
  na prawym skraju tej czesci niebosklonu, w pelnej krasie widoczny jest gwiazdozbior przypominajacy farme.

  ----E2----
  Prawie w zenicie, w centralnym punkcie obserwowanego nieba, dostrzegasz gwiazdozbior przypominajacy miecz.
  Tuz nad horyzontem, w centralnym punkcie obserwowanego nieba, dostrzegasz gwiazdozbior przypominajacy barke.

  ----S----
  Tuz nad horyzontem, w centralnym punkcie obserwowanego nieba, dostrzegasz gwiazdozbior przypominajacy drwala przy wyrebie.
  Wysoko nad horyzontem, w centralnym punkcie obserwowanego nieba, w pelnej krasie widoczny jest gwiazdozbior przypominajacy wilka.
  Dosyc blisko zenitu, w centralnym punkcie obserwowanego nieba, widzisz gwiazdozbior przypominajacy dorodnego konia.
  Nad horyzontem, w lewej czesci nieba, widzisz gwiazdozbior przypominajacy scene z polowania.
  
  ----W----
  W zenicie, w lewej czesci nieba, widzisz gwiazdozbior przypominajacy miecz.
  Prawie w zenicie, na lewym skraju tej czesci niebosklonu, dostrzegasz gwiazdozbior przypominajacy barke.
  
  ---- W2 ----
  Tuz nad horyzontem, w prawej czesci niebosklonu, w pelnej krasie widoczny jest gwiazdozbior przypominajacy wscieklego psa.
  Tuz nad horyzontem, w prawej czesci niebosklonu, widnieje gwiazdozbior przypominajacy wage natomiast tuz nad horyzontem, 
  w centralnym punkcie obserwowanego nieba, zauwazasz gwiazdozbior przypominajacy wielki dab. 
  Na linii horyzontu, w centralnym punkcie obserwowanego nieba, w pelnej krasie widoczny jest gwiazdozbior przypominajacy mlynskie kolo.
  Prawie w zenicie, na lewym skraju tej czesci niebosklonu, widnieje gwiazdozbior przypominajacy dzika.
  
  Prawie w zenicie, w centralnym punkcie obserwowanego nieba, widzisz gwiazdozbior przypominajacy drwala przy wyrebie. Przypomina ci sie
jednakowoz, ze jego nazwa to Lisc Debu. Tuz nad horyzontem, w centralnym punkcie obserwowanego nieba, widnieje gwiazdozbior 
przypominajacy wilka. Pamietasz, ze jego nazwa to Studnia Wiedzy. Na linii horyzontu, w centralnym punkcie obserwowanego nieba, widzisz 
gwiazdozbior przypominajacy dorodnego konia. Przypominasz sobie jednak, ze jego nazwa to Wieszcz Dobrej Nowiny.

/fake W zenicie, na prawym skraju tej czesci niebosklonu, widnieje gwiazdozbior przypominajacy mlynskie kolo. Pamietasz, ze jego nazwa to Zimowa Panna. W zenicie, na prawym skraju tej czesci niebosklonu, dostrzegasz gwiazdozbior przypominajacy skorpiona. Pamietasz, ze jego nazwa to Dzban. Nad horyzontem, w lewej czesci nieba, widzisz gwiazdozbior przypominajacy rybe. Wyszukujesz w zakamarkach pamieci, ze jego nazwa to Siedem Koz.
/fake Na linii horyzontu, w centralnym punkcie obserwowanego nieba, w pelnej krasie widoczny jest gwiazdozbior przypominajacy bobra. Pomimo niezgodnosci ksztaltu, wydaje ci sie, ze jego nazwa to Dzwonnik. Tuz nad horyzontem, na lewym skraju tej czesci niebosklonu, widnieje gwiazdozbior przypominajacy wage oraz wysoko nad horyzontem, na prawym skraju tej czesci niebosklonu, w pelnej krasie widoczny jest gwiazdozbior przypominajacy farme. Przypomina ci sie jednakowoz, ze jego nazwa to Letnia Panna.



function Astrolabium.telescope()
  -- Ogladanie nieba przez teleskop w ciagu dnia nie jest najlepszym pomyslem... Lepiej poczekaj z tym do zmierzchu.
obroc teleskop na polnoc
Przesuwasz jedno z pokretel i teleskop zaczyna sie obracac.

Teleskop przestaje sie obracac. Jest teraz skierowany na polnoc.
popatrz przez teleskop
Spogladasz przez teleskop skierowany obecnie na polnoc przypatrujac sie tej czesci nieba i probujesz przy obecnej pogodzie wypatrzec
jakies charakterystyczne ksztalty."n"
W zenicie, na prawym skraju tej czesci niebosklonu, widnieje gwiazdozbior przypominajacy mlynskie kolo. Pamietasz, ze jego nazwa to
Zimowa Panna. W zenicie, na prawym skraju tej czesci niebosklonu, dostrzegasz gwiazdozbior przypominajacy skorpiona. Pamietasz, ze jego 
nazwa to Dzban. Nad horyzontem, w lewej czesci nieba, widzisz gwiazdozbior przypominajacy rybe. Wyszukujesz w zakamarkach pamieci, ze 
jego nazwa to Siedem Koz.

obroc teleskop na wschod
Przesuwasz jedno z pokretel i teleskop zaczyna sie obracac.

Teleskop przestaje sie obracac. Jest teraz skierowany na wschod.
popatrz przez teleskop
Spogladasz przez teleskop skierowany obecnie na wschod przypatrujac sie tej czesci nieba i probujesz przy obecnej pogodzie wypatrzec
jakies charakterystyczne ksztalty."e"
Na linii horyzontu, w centralnym punkcie obserwowanego nieba, w pelnej krasie widoczny jest gwiazdozbior przypominajacy bobra. Pomimo
niezgodnosci ksztaltu, wydaje ci sie, ze jego nazwa to Dzwonnik. Tuz nad horyzontem, na lewym skraju tej czesci niebosklonu, widnieje 
gwiazdozbior przypominajacy wage oraz wysoko nad horyzontem, na prawym skraju tej czesci niebosklonu, w pelnej krasie widoczny jest 
gwiazdozbior przypominajacy farme. Przypomina ci sie jednakowoz, ze jego nazwa to Letnia Panna.

obroc teleskop na poludnie
Przesuwasz jedno z pokretel i teleskop zaczyna sie obracac.

Teleskop przestaje sie obracac. Jest teraz skierowany na poludnie.
popatrz przez teleskop
Spogladasz przez teleskop skierowany obecnie na poludnie przypatrujac sie tej czesci nieba i probujesz przy obecnej pogodzie wypatrzec
jakies charakterystyczne ksztalty."s"
Tuz nad horyzontem, w centralnym punkcie obserwowanego nieba, dostrzegasz gwiazdozbior przypominajacy drwala przy wyrebie. Przypominasz
sobie jednak, ze jego nazwa to Lisc Debu. Wysoko nad horyzontem, w centralnym punkcie obserwowanego nieba, w pelnej krasie widoczny 
jest gwiazdozbior przypominajacy wilka. Pomimo niezgodnosci ksztaltu, wydaje ci sie, ze jego nazwa to Studnia Wiedzy. Dosyc blisko 
zenitu, w centralnym punkcie obserwowanego nieba, widzisz gwiazdozbior przypominajacy dorodnego konia. Wyszukujesz w zakamarkach 
pamieci, ze jego nazwa to Wieszcz Dobrej Nowiny. Nad horyzontem, w lewej czesci nieba, widzisz gwiazdozbior przypominajacy scene z 
polowania. Wyszukujesz w zakamarkach pamieci, ze jego nazwa to Wlocznia.

obroc teleskop na zachod
Przesuwasz jedno z pokretel i teleskop zaczyna sie obracac.

Teleskop przestaje sie obracac. Jest teraz skierowany na zachod.
popatrz przez teleskop
Spogladasz przez teleskop skierowany obecnie na zachod przypatrujac sie tej czesci nieba i probujesz przy obecnej pogodzie wypatrzec
jakies charakterystyczne ksztalty."w"
W zenicie, w lewej czesci nieba, widzisz gwiazdozbior przypominajacy miecz. Wyszukujesz w zakamarkach pamieci, ze jego nazwa to Wielka
Kozica. Prawie w zenicie, na lewym skraju tej czesci niebosklonu, dostrzegasz gwiazdozbior przypominajacy barke.

Spogladasz przez teleskop skierowany obecnie na zachod przypatrujac sie tej czesci nieba i probujesz przy obecnej pogodzie wypatrzec
jakies charakterystyczne ksztalty."w"
Tuz nad horyzontem, w prawej czesci niebosklonu, w pelnej krasie widoczny jest gwiazdozbior przypominajacy wscieklego psa. Wyszukujesz
w zakamarkach pamieci, ze jego nazwa to Naga Luczniczka. Tuz nad horyzontem, w prawej czesci niebosklonu, widnieje gwiazdozbior 
przypominajacy wage natomiast tuz nad horyzontem, w centralnym punkcie obserwowanego nieba, zauwazasz gwiazdozbior przypominajacy 
wielki dab. Na linii horyzontu, w centralnym punkcie obserwowanego nieba, w pelnej krasie widoczny jest gwiazdozbior przypominajacy 
mlynskie kolo. Przypomina ci sie jednakowoz, ze jego nazwa to Zimowa Panna. Prawie w zenicie, na lewym skraju tej czesci niebosklonu, 
widnieje gwiazdozbior przypominajacy dzika. Uswiadamiasz sobie jednak, ze jego nazwa to Jednorozec.


Spogladasz przez teleskop skierowany obecnie na >polnoc< przypatrujac sie tej czesci nieba i probujesz przy obecnej pogodzie wypatrzec jakies charakterystyczne ksztalty.

Tuz nad horyzontem, w >prawej< czesci niebosklonu, w pelnej krasie widoczny jest gwiazdozbior przypominajacy wscieklego psa. >Wyszukujesz w zakamarkach pamieci, ze jego nazwa to Naga Luczniczka. 

Wysoko nad horyzontem, w >prawej czesci niebosklonu<, widzisz gwiazdozbior przypominajacy wage poza tym w zenicie, w centralnym punkcie obserwowanego nieba, dostrzegasz gwiazdozbior przypominajacy wielki dab. 

W zenicie, w centralnym punkcie obserwowanego nieba, widzisz gwiazdozbior przypominajacy mlynskie kolo. Pomimo niezgodnosci ksztaltu, wydaje ci sie, ze jego nazwa to Zimowa Panna. 
Wysoko nad horyzontem, w centralnym punkcie obserwowanego nieba, widzisz gwiazdozbior przypominajacy skorpiona. Uswiadamiasz sobie jednak, ze jego nazwa to Dzban. 

Tuz nad horyzontem, na lewym skraju tej czesci niebosklonu, dostrzegasz gwiazdozbior przypominajacy dzika. Przypominasz sobie jednak, ze jego nazwa to Jednorozec.


popatrz przez teleskop
Spogladasz przez teleskop skierowany obecnie na polnoc przypatrujac sie tej czesci nieba i probujesz przy obecnej pogodzie wypatrzec
jakies charakterystyczne ksztalty."n"
Wysoko nad horyzontem, na prawym skraju tej czesci niebosklonu, dostrzegasz gwiazdozbior przypominajacy bobra. Przypomina ci sie
jednakowoz, ze jego nazwa to Dzwonnik. Nad horyzontem, w centralnym punkcie obserwowanego nieba, widnieje gwiazdozbior przypominajacy 
wscieklego psa. Przypominasz sobie jednak, ze jego nazwa to Naga Luczniczka. Dosyc blisko zenitu, w centralnym punkcie obserwowanego 
nieba, w pelnej krasie widoczny jest gwiazdozbior przypominajacy wage poza tym w zenicie, w centralnym punkcie obserwowanego nieba, 
dostrzegasz gwiazdozbior przypominajacy wielki dab. Prawie w zenicie, na lewym skraju tej czesci niebosklonu, widnieje gwiazdozbior 
przypominajacy mlynskie kolo. Pamietasz, ze jego nazwa to Zimowa Panna. Nad horyzontem, w lewej czesci nieba, dostrzegasz gwiazdozbior 
przypominajacy skorpiona. Wyszukujesz w zakamarkach pamieci, ze jego nazwa to Dzban.

obroc teleskop na wschod
Przesuwasz jedno z pokretel i teleskop zaczyna sie obracac.

popatrz przez teleskop
Jestes nieco wyczerpany.
Musisz poczekac az teleskop skonczy sie obracac.

Teleskop przestaje sie obracac. Jest teraz skierowany na wschod.
popatrz przez teleskop
Spogladasz przez teleskop skierowany obecnie na wschod przypatrujac sie tej czesci nieba i probujesz przy obecnej pogodzie wypatrzec
jakies charakterystyczne ksztalty."e"
Na linii horyzontu, w centralnym punkcie obserwowanego nieba, w pelnej krasie widoczny jest gwiazdozbior przypominajacy farme.
Uswiadamiasz sobie jednak, ze jego nazwa to Letnia Panna. Tuz nad horyzontem, na prawym skraju tej czesci niebosklonu, zauwazasz 
gwiazdozbior przypominajacy dorodnego konia. Przypomina ci sie jednakowoz, ze jego nazwa to Wieszcz Dobrej Nowiny.

Jestes bardzo zmeczony.
obroc teleskop na poludnie
Przesuwasz jedno z pokretel i teleskop zaczyna sie obracac.

Teleskop przestaje sie obracac. Jest teraz skierowany na poludnie.
popatrz przez teleskop
Spogladasz przez teleskop skierowany obecnie na poludnie przypatrujac sie tej czesci nieba i probujesz przy obecnej pogodzie wypatrzec
jakies charakterystyczne ksztalty."s"
Prawie w zenicie, w centralnym punkcie obserwowanego nieba, dostrzegasz gwiazdozbior przypominajacy miecz. Pamietasz, ze jego nazwa to
Wielka Kozica. Tuz nad horyzontem, w centralnym punkcie obserwowanego nieba, dostrzegasz gwiazdozbior przypominajacy barke.

obroc teleskop na zachod
Przesuwasz jedno z pokretel i teleskop zaczyna sie obracac.

Jestes zmeczony.
Teleskop przestaje sie obracac. Jest teraz skierowany na zachod.
popatrz przez teleskop
Spogladasz przez teleskop skierowany obecnie na zachod przypatrujac sie tej czesci nieba i probujesz przy obecnej pogodzie wypatrzec
jakies charakterystyczne ksztalty."w"
Dosyc blisko zenitu, na prawym skraju tej czesci niebosklonu, widzisz gwiazdozbior przypominajacy mlynskie kolo. Wyszukujesz w
zakamarkach pamieci, ze jego nazwa to Zimowa Panna. Wysoko nad horyzontem, na lewym skraju tej czesci niebosklonu, zauwazasz 
gwiazdozbior przypominajacy tartak. Wyszukujesz w zakamarkach pamieci, ze jego nazwa to Prawda. Wysoko nad horyzontem, w prawej czesci 
niebosklonu, w pelnej krasie widoczny jest gwiazdozbior przypominajacy dzika. Uswiadamiasz sobie jednak, ze jego nazwa to Jednorozec.

/fake Zauwazasz astrolabium na zamknietej mosieznej skrzynce z astrolabium:
/fake Na astrolabium skladaja sie dwa duze pokretla oraz siedem koncentrycznych pierscieni.
/fake     Pokretlo podpisane GODZINA zostalo ustawione na wartosc 9.
/fake     Pokretlo podpisane DZIEN zostalo ustawione na wartosc 99.
/fake Pierscienie mozna ustawiac w pozycjach reprezentujacych rozne kierunki swiata oraz w dodatkowej umieszczonej pod wyraznie zaznaczona na astrolabium linia horyzontu. Kazdy jest podpisany nazwa gwiazdozbioru:
/fake     Pierscien podpisany Bialy Kon ustawiono na polnoc.
/fake     Pierscien podpisany Dziki Wilk ustawiono na polnoc.
/fake     Pierscien podpisany Dzwonnik ustawiono pod horyzontem.
/fake     Pierscien podpisany Siedem Koz ustawiono na polnoc.
/fake     Pierscien podpisany Wieszcz Dobrej Nowiny ustawiono na poludnie.
/fake     Pierscien podpisany Wlocznia ustawiono na polnoc.
/fake     Pierscien podpisany Zimowa Panna ustawiono na poludnie.


Zauwazasz astrolabium na zamknietej mosieznej skrzynce z astrolabium:
Na astrolabium skladaja sie dwa duze pokretla oraz siedem koncentrycznych pierscieni.

    Pokretlo podpisane GODZINA zostalo ustawione na wartosc 8.
    Pokretlo podpisane DZIEN zostalo ustawione na wartosc 99.

Pierscienie mozna ustawiac w pozycjach reprezentujacych rozne kierunki swiata oraz w dodatkowej umieszczonej pod wyraznie zaznaczona na astrolabium
linia horyzontu. Kazdy jest podpisany nazwa gwiazdozbioru:
    Pierscien podpisany Bialy Kon ustawiono na polnoc.
    Pierscien podpisany Dziki Wilk ustawiono na polnoc.
    Pierscien podpisany Dzwonnik ustawiono pod horyzontem.
    Pierscien podpisany Siedem Koz ustawiono na polnoc.
    Pierscien podpisany Wieszcz Dobrej Nowiny ustawiono na poludnie.
    Pierscien podpisany Wlocznia ustawiono na polnoc.
    Pierscien podpisany Zimowa Panna ustawiono na poludnie.
    
]]--

  -- Tuz nad horyzontem, w prawej czesci niebosklonu, w pelnej krasie widoczny jest gwiazdozbior przypominajacy wscieklego psa. Wyszukujesz w zakamarkach pamieci, ze jego nazwa to Naga Luczniczka.
  -- Wysoko nad horyzontem, w prawej czesci niebosklonu, widzisz gwiazdozbior przypominajacy wage poza tym w zenicie,
  -- W zenicie, w centralnym punkcie obserwowanego nieba, widzisz gwiazdozbior przypominajacy mlynskie kolo. Pomimo niezgodnosci ksztaltu, wydaje ci sie, ze jego nazwa to Zimowa Panna.



