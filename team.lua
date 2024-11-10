-- zwraca tablice z ids ludzi w druzynie bedacych na lokacji
function ra.core.get_team_ids_on_location()
  local r = {}
  for k, v in pairs(ateam.team) do
    if type(v) == "number" and table_has_value(gmcp.objects.nums, v) then
      table.insert(r, v)
    end
  end
  return r
end


function ra.alias.give_gold(g)
  local x = tonumber(g)
  local i = 0
  local t = ""
  for k, v in pairs(ateam.team) do
    t = table_has_value(gmcp.objects.nums, v)
    if t ~= false then
      if type(v) == "number" and t then
        if x == 1 then
          i = 1
          send("daj 1 zlota monete ob_"..v)
        elseif x > 1 and x < 5 then
          i = 1
          send("daj "..x.." zlote monety ob_"..v)
        elseif x > 4 then
          i = 1
          send("daj "..x.." zlotych monet ob_"..v)
        else
          cecho("\n <yellow>He? Ile chcesz dac? \n")
        end
      else
        cecho("\n <yellow>Cos poszlo nie tak...\n\n")
        display(t, gmcp.objects.nums, ateam.team)
      end
    end
  end
  if i == 0 then
    cecho("\n <yellow>Chcesz dac datek na tileanskie sieroty?\n\n")
  end
end

-- wlacza sprawdzanie plaszczy
function ra.alias.enable_coat_checker()
  ra.tmp.coat_checker = true
  ra.core.enable_coat_checker()
  ra.tmp.coat_counter = 0
  ra.tmp.peoples_in_coat = {}
  ra.tmp.peoples_off_coat = {}
end

-- wylacza sprawdzanie plaszczy
function ra.alias.disable_coat_checker()
  ra.tmp.coat_checker = false
  ra.tmp.coat_counter = 0
  ra.core.print_coats_info()
  ra.core.disable_coat_checker()
  ra.tmp.peoples_in_coat = {}
  ra.tmp.peoples_off_coat = {}
  --display("wylaczone sprawdzanie plaszczy")
end

-- aktywuje handler do sprawdzania plaszczy 
function ra.core.enable_coat_checker()
  ra.tmp.coat_checker = true
  if scripts.event_handlers["ra_core_coat"] then
      killAnonymousEventHandler(scripts.event_handlers["ra_core_coat"])
  end
  scripts.event_handlers["ra_core_coat"] = registerAnonymousEventHandler("gmcp.gmcp_msgs", ra.core.check_coat)
end

-- deaktywuje handler do sprawdzania plaszczy 
function ra.core.disable_coat_checker()
  ra.tmp.coat_checker = false
  if scripts.event_handlers["ra_core_coat"] then
      killAnonymousEventHandler(scripts.event_handlers["ra_core_coat"])
  end
end

-- sprawdza czy obejrzany npc ma plaszcz
function ra.core.check_coat()
  if ra.tmp.coat_checker == true and gmcp.gmcp_msgs.type == "object.long" then
    local t = string.split(ansi2string(dec(gmcp.gmcp_msgs.text)), "\n")
    if ra.core.have_coat(t) == false then
      table.insert(ra.tmp.peoples_off_coat, ra.core.get_name(t))
    else  
      table.insert(ra.tmp.peoples_in_coat, ra.core.get_name(t))
    end    
  end
end

-- wyswietla stan plaszczy druzyny
function ra.core.print_coats_info()
  if table.size(ra.tmp.peoples_in_coat) > 0 then
    local str = table.concat(ra.tmp.peoples_in_coat, ", ")
    cecho("\n<deep_sky_blue>Z kapturem: "..str.."\n")
  end
  if table.size(ra.tmp.peoples_off_coat) > 0 then
    local str = table.concat(ra.tmp.peoples_off_coat, ", ")
    cecho("\n<deep_sky_blue>Bez kaptura: "..str.."\n")
    if gmcp.char.info.race == "ogr" then
      scripts.utils.bind_functional("powiedz Otulom se plascym.", false)
    else
      scripts.utils.bind_functional("powiedz Otulcie sie plaszczem.", false)
    end
  end
end

function ra.core.get_name(strings_arr)
  local aa = string.split(strings_arr[2], " ")
  return aa[1]
end

-- sprawdza tablice z opisem (gracza) czy ma zalozony kaptur
function ra.core.have_coat(strings_arr)
  local team_on_loc = ra.core.get_team_ids_on_location()
  
  if ra.tmp.coat_counter > table.size(team_on_loc) then
    --ra.core.print_coats_info()
    --ra.alias.disable_coat_checker()
    return false
  end
      
  ra.tmp.coat_counter = ra.tmp.coat_counter + 1
  for k,v in pairs(strings_arr) do
    if string.match(v, "Jest szczelnie otulon") ~= nil then
      return true
    end    
    if string.match(v, "skryta pod eterycznym kapturem twarz") ~= nil then
      return true
    end    
    if string.match(v, "Jestes szczelnie") ~= nil then
      return true
    end
    if string.match(v, "Twa skryta pod eterycznym kapturem twarz") ~= nil then
      return true
    end   
    if string.match(v, "Nie zauwazasz niczego takiego.") ~= nil then
    --  ra.core.print_coats_info()
    --  ra.alias.disable_coat_checker()
      return false
    end    
  end
  return false
end