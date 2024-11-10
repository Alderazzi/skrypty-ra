Carriage = Carriage or {
  tmp = {
    engine = {},
    name = "",
    drive_on = false,
    starttime = 0,
    house_id = "",
  },
  
  system = {
    config = {
      file_path = getMudletHomeDir() .. "/carrige_data.json",
      debug = false,
      speed_accuracy_level = 10, -- ilosc pomiarow szybkosci
      speed_accuracy = 2, -- doklanosc pomiaru szybkosci: ilosc miejsc po przecinku
      show_speed = true,
    },
    
    data = {
      caution_time = 6, -- waznosc pelnej kaucji w godzinach
      -- informacje o wozowniach
      houses = {
        ["8555"] = {
          cost = {
            price = 25,
            coution = 100,
            save_caution = 25,          
          },
          types = {
            ["lekki woz"] = {
              speed = 0,
              capacity = 0,
            },
            ["ciezki woz"] = {
              speed = 0,
              capacity = 0,
            },
          },
        },      
      },
      
      roadblockade = {}, -- blokady drogowe
      carriges = {},  -- informacje o wynajetych pojazdach
    },    
  }, 
}

function Carriage:init()
  amap.walk_mode_to_prefix = { "", "przemknij ", "przemknij z druzyna ", "jedz na " }
  Carriage:read()
end

function Carriage.add(name)
  
  local key = name
  local time = os.time()
  Carriage.system.data.carriges[key] = {}
  Carriage.system.data.carriges[key]["starttime"] = Carriage.tmp.starttime
  Carriage.system.data.carriges[key]["caution_time"] = Carriage.tmp.starttime + (Carriage.system.data.caution_time * 60 * 60)
  Carriage.system.data.carriges[key]["house_id"] = Carriage.tmp.house_id
  Carriage.system.data.carriges[key]["short_desc"] = name
  Carriage.system.data.carriges[key]["parking"] = Carriage.tmp.house_id
  Carriage.system.data.carriges[key]["max_speed"] = 0
  Carriage.tmp.name = name
  if Carriage.system.config.debug then
    scripts:print_log("Dodano informacje o "..name) 
  end
end

function Carriage.set(name, param, args)
  Carriage.system.data.carriges[name][param] = args
end

function Carriage.clear()
  Carriage.system.data.carriges = {}
  Carriage:save()
end

function Carriage.get(name, param)
  if param == nil then
    return Carriage.system.data.carriges[name]
  end
  return Carriage.system.data.carriges[name][param]
end

function Carriage:remove(name)
  Carriage.system.data.carriges[name] = nil
end

function Carriage:debuging(boolean)
  Carriage.system.config.debug = boolean
end

function Carriage:update_speed()
  if table.size(Carriage.tmp.engine) >= Carriage.system.config.speed_accuracy_level then
    for k,v in spairs(Carriage.tmp.engine) do
      Carriage.tmp.engine[k] = nil
      break
    end
  end
  local time = getEpoch()
  Carriage.tmp.engine[time] = time
end

function Carriage:restart_engine()
  Carriage.tmp.engine = {}
end

function Carriage.get_speed()
  local function round(x, n)
      return tonumber(string.format("%." .. n .. "f", x))
  end

  if table.size(Carriage.tmp.engine) > 0 then
    local speed = 0
    local speed_sum = 0
    local time = 0
    for k,v in spairs(Carriage.tmp.engine, function(t,a,b) return t[a] > t[b] end) do
      if time > 0 then
        speed = time - v
        speed_sum = speed_sum + speed
      end
      time = v      
    end
    local ret = round((60) / (speed_sum / (table.size(Carriage.tmp.engine) - 1)), Carriage.system.config.speed_accuracy)
    if tonumber(Carriage.get(Carriage.tmp.name, "max_speed")) < ret then
      Carriage.set(Carriage.tmp.name, "max_speed", ret)
    end
    return ret
  end
  return 0
end

function Carriage.getin(name)
  Carriage.tmp.name = name
  if Carriage.get(name) == nil then
    Carriage.add(name)
  end
  Carriage.restart_engine()
  Carriage.roadblockades_on()
  Carriage:save()
end

function Carriage.getout()
  Carriage.set(Carriage.tmp.name, "parking", tostring(amap.curr.id))
  Carriage.restart_engine()
  Carriage.tmp.drive_on = false
  Carriage.roadblockades_off()
  Carriage:save()
end

function Carriage.onship()
  local cmd = "wem;"
  if #ateam.objs > 0 then
    ateam:parse_objects_data() 
    local my_team = {}
    for k, v in pairs(gmcp.objects.nums) do
      if ateam.objs[v]["team"] and not ateam.objs[v]["team_leader"] then
        table.insert(my_team, v)
      end
    end
    if table.size(my_team) > 0 then
      for k, v in pairs(my_team) do
        cmd = cmd.."kup bilet;daj bilet ob_"..v..";"
      end
    end
  end
  return cmd.."kup bilet;wjedz na statek;wlm"
end

function Carriage.set_roadblockade(name, ids)
  if table.size(Carriage.system.data.roadblockade[name]) > 0 then
    for _, id in pairs(Carriage.system.data.roadblockade[name]) do
      lockRoom(tonumber(id), false)
    end
  end
  Carriage.system.data.roadblockade[name] = ids
  if table.size(Carriage.system.data.roadblockade[name]) > 0 then
    for _, id in pairs(Carriage.system.data.roadblockade[name]) do
      lockRoom(tonumber(id), true)
    end
  end  
end

function Carriage.remove_roadblockade(name)
  if table.size(Carriage.system.data.roadblockade[name]) > 0 then
    for _, id in pairs(Carriage.system.data.roadblockade[name]) do
      lockRoom(tonumber(id), false)
    end
  end
  Carriage.system.data.roadblockade[name] = nil
end

function Carriage.roadblockades_on()
  if table.size(Carriage.system.data.roadblockade) > 0 then
    for k, v in pairs(Carriage.system.data.roadblockade) do
      for _,id in pairs(v) do
        lockRoom(tonumber(id), true)
      end
      if Carriage.system.config.debug then
        cecho("\n<yellow>Dodano blokady drog na mapach kartograficznych w rejonie <ivory>"..k.." <tomato>("..table.concat(v, ', ')..")\n")
      end
    end
  end
end

function Carriage.roadblockades_off()
  if table.size(Carriage.system.data.roadblockade) > 0 then
    for k, v in pairs(Carriage.system.data.roadblockade) do
      for _,id in pairs(v) do
        lockRoom(tonumber(id), false)
      end
      if Carriage.system.config.debug then
        cecho("\n<yellow>Usunieto blokady drog z map kartograficznych rejonu <ivory>"..k.." <green>("..table.concat(v, ', ')..")\n")
      end
    end
  end
end

function Carriage.roadblockades_check()
  if table.size(Carriage.system.data.roadblockade) > 0 then
    local color = ""
    for k, v in pairs(Carriage.system.data.roadblockade) do
      cecho("\n<yellow>Stan blokad drogowych <ivory>"..k.."\n")
      for kk,id in pairs(v) do
        if roomLocked(id) then
          color = "tomato"
        else
          color = "green"
        end
        cecho("<"..color.."> - "..id.." : "..tostring(roomLocked(id)).."\n")
      end
    end
  end
end

function Carriage.show_roadblockades()
  if table.size(Carriage.system.data.roadblockade) > 0 then
    local s = ""
    cecho("\n<yellow>Znane blokady drogowe:\n")
    for k, v in pairs(Carriage.system.data.roadblockade) do
      cecho(" - <ivory>\""..k.."\", <green>{"..table.concat(v, ', ').."} ")
      s = "/lua Carriage.set_roadblockade(\""..k.."\", {"..table.concat(v, ', ').."})"
      cechoLink("<dodger_blue>zmien", [[printCmdLine(']]..tostring(s)..[[')]], "Carriage.set_roadblockade", true)
      cecho("\n")      
    end
  end
end

function Carriage:show_current_carrige_starttime()
  local data = Carriage.get(Carriage.tmp.name)
  if tonumber(data["starttime"]) > 0 then
    cecho("\n<yellow> - data wypozyczenia <white>"..os.date('%Y.%m.%d %H:%M:%S', data["starttime"]).."<yellow> w ")
    local get_str = "/prowadz "..data["house_id"]
    cechoLink("<light_slate_blue>"..data["house_id"], function () expandAlias(get_str) end, get_str, true)
  end
end

function Carriage:show_current_carrige_parking()
  if amap.walk_mode ~= 4 then
    local data = Carriage.get(Carriage.tmp.name)
    cecho("\n<yellow> - parkuje w ")
    local get_str = "/prowadz "..data["parking"]
    cechoLink("<light_slate_blue>"..data["parking"], function () expandAlias(get_str) end, get_str, true)
  end
end

function Carriage:show_current_carrige_caution_info() 
  local data = Carriage.get(Carriage.tmp.name)
  if tonumber(data["caution_time"]) > 100000 then
    cecho("\n<yellow> - data waznosci kaucji <white>"..os.date('%Y.%m.%d %H:%M:%S', data["caution_time"]).."")
  end
end
  
function Carriage:show_current_carrige_speed_info() 
  local data = Carriage.get(Carriage.tmp.name)
  cecho("\n<yellow> - maksymalna osiagnieta szybkosc <white>"..data["max_speed"].." l/m")
  if speedWalkPath ~= nil and #speedWalkPath > 1 and amap.walk_mode == 4 then
    local speed = Carriage.get_speed()
    local mtime = math.floor(#speedWalkPath / speed)
    cecho("\n<yellow> - przy aktualnym tepie jazdy dojedziesz do celu za ok. <white>"..mtime.." <yellow>min")
  end
end

function Carriage:show_current_carrige()
  if string.len(Carriage.tmp.name) == 0 then
    cecho("\n<yellow> Brak informacje o uzywanych pojazdach.\n")
    return 1
  end
  cecho("\n<yellow> Informacje o aktualnie uzywanym <tomato>"..Carriage.tmp.name)
  Carriage:show_current_carrige_parking()
  Carriage:show_current_carrige_caution_info()
  Carriage:show_current_carrige_speed_info() 
  Carriage:show_current_carrige_starttime()
  cecho("\n")
  cechoLink("\n<light_slate_blue> Usun informacje o posiadanych wozach.", function () Carriage.clear() end, "Usun liste wozow.", true)
  cecho("\n\n")

end

function Carriage:show_carrige_houses()
  local data = Carriage.system.data.houses
  if table.size(data) > 0 then
    cecho("\n<yellow> Informacje o znanych wozowniach:")
    for k, v in pairs(data) do
      cecho("\n\n  + "..getRoomName(k).." (")
      local get_str = "/prowadz "..tostring(k)
      cechoLink("<light_slate_blue>"..tostring(k), function () expandAlias(get_str) end, get_str, true)
      cecho("), wartosc kaucji po terminie "..v["cost"]["save_caution"])
      for p,t in pairs(v["types"]) do
        cecho("\n<white>   - "..p.."<ansiLightBlack> szybkosc "..t["speed"].." l/m, pojemnosc "..t["capacity"].." g" )
      end
    end
    cecho("\n")
  end
end

function Carriage:show_extended_carriges_info()
  Carriage:show_current_carrige()
  Carriage.show_roadblockades()
  Carriage.roadblockades_check()
  Carriage:show_carrige_houses()
  cecho("\n")
  if Carriage.system.config.show_speed then
    cechoLink("\n<light_slate_blue> Wylacz pokazywanie szybkosci jazdy.", 
      function () 
        cecho("\n<yellow>Pokazywanie szybkosci wozu zostalo wylaczone.\n")
        Carriage.system.config.show_speed = false end, 
      "Wylacz pokazywanie szybkosci.", 
      true)
    cecho("\n")
  else
    cechoLink("\n<light_slate_blue> Wlacz pokazywanie szybkosci jazdy.", 
      function () 
        cecho("\n<yellow>Pokazywanie szybkosci wozu zostalo wlaczone.\n")
        Carriage.system.config.show_speed = true end, 
      "Wlacz pokazywanie szybkosci.", 
      true)
    cecho("\n")
  end
  if table.size(Carriage.system.data.roadblockade) > 0 then
    cechoLink("\n<light_slate_blue> Wylacz blokady drogowe.", 
      function () 
        Carriage.roadblockades_off()
        Carriage.roadblockades_check() end, 
      "Wylacz blokady drogowe.", 
      true)
    cecho("\n")
    cechoLink("\n<light_slate_blue> Wlacz blokady drogowe.", 
      function () 
        Carriage.roadblockades_on()
        Carriage.roadblockades_check() end, 
      "Wlacz blokady drogowe.", 
      true)
    cecho("\n")
  end
  if Carriage.system.config.debug then
    cechoLink("\n<light_slate_blue> Wylacz debugowanie skryptow obslugi pojazdow.", 
      function () 
        cecho("\n<yellow>Debugowanie skryptow obslugi pojazdow zostalo wylaczone.\n")
        Carriage.system.config.debug = false end, 
      "Wylacz debugowanie skryptow obslugi pojazdow.", 
      true)
    cecho("\n\n")
  else
    cechoLink("\n<light_slate_blue> Wlacz debugowanie skryptow obslugi pojazdow.", 
      function () 
        cecho("\n<yellow>Debugowanie skryptow obslugi pojazdow zostalo wlaczone.\n")
        Carriage.system.config.debug = true end, 
      "Wlacz debugowanie skryptow obslugi pojazdow.", 
      true)
    cecho("\n\n")
  end
    
end

function Carriage:save()
  local data = Carriage.system
  local path = Carriage.system.config.file_path
  local file = io.open(path, "w")
  file:write(yajl.to_string(data))
  file:close()
  if Carriage.system.config.debug then
    scripts:print_log("Zapisano informacje o pojazdach:")
    --display(data)
  end
end

function Carriage:read()
  local path = Carriage.system.config.file_path
  if io.exists(path) then
    local data = scripts.utils:read_json(path)  
    Carriage.system = data
    if Carriage.system.config.debug then
      scripts:print_log("Zaladowano informacje o pojazdach:") 
      --display("json", data)
    end
  end  
end

function trigger_plugins_zwracasz_pojazd()
  local name = matches[2].." "..matches[3]
  --display(name)
  trigger_plugins_zsiadasz_z_pojazdu()
  Carriage.tmp = {
    engine = {},
    name = "",
    drive_on = false,
    starttime = 0,
    house_id = "",
  }
  Carriage.remove(name)
end

function trigger_plugins_wypozyczasz_pojazd()
  Carriage.tmp = {
    engine = {},
    name = "",
    drive_on = false,
    starttime = os.time(),
    house_id = tostring(amap.curr.id),
  }  
end

function trigger_plugins_wsiadasz_na_pojazd()
  if amap.walk_mode ~= 4 and ateam.team ~= nil then
    if table.size(ateam.team) == 1 or ateam:is_leader() == true then
      cecho("\n\n<yellow>Obsluga pojazdu: <red>ON\n")
      amap.walk_mode = 4
      if table.size(matches) > 2 then
        local name = matches[3].." "..matches[4]
        --display(name)
        if string.len(Carriage.tmp.name) == 0 then
          Carriage.add(name)
        end
        Carriage.getin(name)
      end
    end
  end
end

function trigger_plugins_zsiadasz_z_pojazdu()
  if amap.walk_mode_to_prefix[4] and amap.walk_mode == 4 then
    cecho("\n\n<yellow>Obsluga pojazdu: <red>OFF\n")
    amap.walk_mode = 1
    Carriage.getout()
  end
end

function trigger_plugins_jedziesz_pojazdem()
  if Carriage.system.config.show_speed then
    Carriage.update_speed()
    local speed = Carriage.get_speed()
    local name =  matches[3]
    local mask = " z szybkoscia "..speed.." l/m"
    if speed > 0 then
      selectString(name, 1)
      replace(name ..  mask, true)
      fg("ansiLightBlack")
      deselect()
      selectString(mask, 1)
      fg("white")
      deselect()
    end
  end
  Carriage.tmp.drive_on = true
end

function trigger_plugins_pojazd_sie_zatrzymuje()
  Carriage.tmp.drive_on = false
  Carriage.restart_engine()
end

function trigger_func_skrypty_misc_ships_ships_wszyscy_na_poklad()
  local cmd = "wem;kup bilet;wsiadz na statek;wlm"
  if amap.walk_mode == 4 then
    cmd = Carriage.onship()
  end
  scripts.utils.bind_ship(cmd, false, false)
end

function trigger_func_skrypty_misc_ships_ships_tratwa_prom()
  local cmd = "wem;kup bilet;wsiadz na statek;wlm"
  if amap.walk_mode == 4 then
    cmd = Carriage.onship()
  end
  scripts.utils.bind_ship(cmd, false, false)
end

function trigger_func_skrypty_misc_ships_ships_mozna_wysiadac()
  local cmd = "zejdz ze statku"
  if amap.walk_mode == 4 then
    cmd = "zjedz ze statku"
  end
  scripts.utils.bind_ship(cmd, true, false)
end

function trigger_func_skrypty_misc_ships_ships_prom()
  local cmd = "wem;kup bilet;wsiadz na statek;wlm"
  if amap.walk_mode == 4 then
    cmd = Carriage.onship()
  end
  scripts.utils.bind_ship(cmd, false, false)
end

function trigger_func_skrypty_misc_ships_ships_statki()
  local cmd = "wem;kup bilet;wsiadz na statek;wlm"
  if amap.walk_mode == 4 then
    cmd = Carriage.onship()
  end  
  scripts.utils.bind_ship(cmd, false, true)
end

Carriage:init()