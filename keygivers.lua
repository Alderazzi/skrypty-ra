function ra.core.read_keygivers_from_files()
  local f = ra.download_files.keygivers.target_file
  if io.exists(f) then
    ra.tmp.keygivers = scripts.utils:read_json(f)
    if ra.debug then
      scripts:print_log("Odczytano liste kluczodajek: "..f)
    end
  end
end

function ra.core.read_drops_from_files()
  local f = ra.download_files.keygivers_drops.target_file
  if io.exists(f) then
    ra.tmp.keygivers_drops = scripts.utils:read_json(f)
    if ra.debug then
      scripts:print_log("Odczytano liste dropow: "..f)
    end
  end
end

function ra.core.read_keys_from_files()
  local f = ra.download_files.keys.target_file
  if io.exists(f) then
    ra.tmp.keys = scripts.utils:read_json(f)
    if ra.debug then
      scripts:print_log("Odczytano liste kluczy: "..f)
    end
  end
end

function ra.core.print_drops(maxtime, next)
  ra.core.read_drops_from_files()
  if maxtime == nil then
    maxtime = ra.maxtime
  end
  local curr_id = amap.curr.id
  if next then
    cecho("\n<white>"..string.title("Kluczodajki dostepne w nastepnych "..maxtime.." h od teraz:\n"))
  else
    cecho("\n<white>"..string.title("Dropy z ostatnich "..maxtime.." h:\n"))
  end
  local ret = {}
  local date = ""
  local resp = 0
  local keygiver = ""
  local drops = 0
  
  for k,v in pairs(ra.tmp.keygivers_drops) do
    date = v["dropDate"]
    keygiver = v["keyGiver"]["name"]
    if type(v["drop"]) == "table" then
      drops = tostring(v["drop"]["name"])
    else
      drops = ""
    end
    if type(v["nextRespawnDate"]) == "number" then
      resp = v["nextRespawnDate"]
    else
      resp = 0
    end
    ret[k] = {date,resp,keygiver,drops}
  end
  
  if table.size(ret) == 0 then
    cecho("\n<white>"..string.title("Brak dostepnych informacji w zadanym czasie.\n"))
    return false
  end
  
  local col1_len = 18   -- czas dropu
  local col2_len = 18   -- nastepny resp
  local col3_len = 29   -- Kluczodajka
  local col4_len = 43   -- Dropy
  
  local sum_line_len = col1_len + 1 + col2_len + 1 + col3_len + 1 + col4_len + 1
  
  cecho("\n"..string.rep("-",sum_line_len))
  ra.core.print_kgd_line("<yellow>", "Data zabicia", col1_len, "Nast. Resp (h)", col2_len, "Kluczodajka", col3_len, "Drop", col4_len)
  cecho("\n"..string.rep("-",sum_line_len))
  local cc = 1
  
  if next then
    for k,v in spairs(ret, function(t,a,b) return t[a][2] < t[b][2] end) do
      if v[2] >= (getEpoch()-(24*60*60)) and v[2] <= (getEpoch()+(maxtime*60*60)) then
        local date = tostring(os.date('%d.%m.%Y %H:%M', tonumber(v[1])))
        local rdate = tostring(os.date('%d.%m.%Y %H:%M', tonumber(v[2])))
        ra.core.print_kgd_line("<green>", date, col1_len, rdate, col2_len, v[3], col3_len, v[4], col4_len)
      end
      cc = cc + 1
    end
  else
    for k,v in spairs(ret, function(t,a,b) return t[a][1] < t[b][1] end) do
      if v[1] <= getEpoch() and v[1] >= (getEpoch()-(maxtime*60*60)) then
        local date = tostring(os.date('%d.%m.%Y %H:%M', tonumber(v[1])))
        local rdate = tostring(os.date('%d.%m.%Y %H:%M', tonumber(v[2])))
        ra.core.print_kgd_line("<green>", date, col1_len, rdate, col2_len, v[3], col3_len, v[4], col4_len)
      end
      cc = cc + 1
    end
  end
  cecho("\n"..string.rep("-",sum_line_len).."\n")
end

function ra.core.get_drops_notify()
  local now = getEpoch()
  local pre_time = now-ra.window_notify_pre_time_keygivers
  local post_time = now+ra.window_notify_post_time_keygivers
  
  local ret = {}
  local tmp = {}
  local date = ""
  local resp = 0
  local keygiver = ""
  local drops = 0
  local time = 0
  
  if ra.tmp.keygivers_drops == nil or table.size(ra.tmp.keygivers_drops) == 0 then
    ra.core.read_drops_from_files()
    return ret
  end
  
  for k,v in pairs(ra.tmp.keygivers_drops) do
    tmp = {}
    date = v["dropDate"]
    keygiver = v["keyGiver"]["name"]
    if type(v["drop"]) == "table" then
      drops = tostring(v["drop"]["name"])
    else
      drops = ""
    end
    if type(v["nextRespawnDate"]) == "number" then
      resp = v["nextRespawnDate"]
    else
      resp = 0
    end
    if resp > 0 and resp > pre_time and resp < post_time then
      time = resp-now
      tmp["timestamp"] = resp
      tmp["prefix"] = keygiver
      tmp["desc"] = os.date('%d.%m.%Y %H:%M', date).." -> "..os.date('%d.%m.%Y %H:%M', resp)
      
      if time < 0 then
        tmp["time_prefix"] = "przed"
        tmp["color"] = "thistle"
        time = -time
      else
        tmp["time_prefix"] = "za"
        tmp["color"] = "lavender_blush"
      end     
      tmp["resttime"] = ra.calendar.resttime(time)
      table.insert(ret, tmp)
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

function ra.core.print_keygivers(params)
  local maxsteps = -1
  local search_str = ""
  
  if params == nil then
    maxsteps = ra.maxsteps
  else
    local n = string.match(params,"(%d+)")
    if not tonumber(n) then
      search_str = params
    else
      maxsteps = tonumber(n)
    end
  end
  
  ra.core.read_keygivers_from_files()
  local curr_id = amap.curr.id
  
  if string.len(search_str) > 0 then
    cecho("\n<white>"..string.title("Kluczodajki szukane po "..search_str.." :\n"))
  else
    cecho("\n<white>"..string.title("Kluczodajki w odleglosci "..maxsteps.." krokow:\n"))
  end
  local ret = {}
  local short = ""
  local name = ""
  local resp = 0
  local desc = ""
  local loc_id = 0
  local loc_name = ""
  local players = 1
  local path_cost = 0
  
  for k,v in pairs(ra.tmp.keygivers) do
    short = v["short"]
    name = v["name"]
    desc = v["description"]
    players = v["playersToComplete"]
    resp = v["respawnTime"]
    
    if string.len(search_str) > 0 then
      if string.findPattern(string.lower(short), search_str) or string.findPattern(string.lower(name), search_str) then
        for k1,v1 in pairs(v["locations"]) do
          loc_id = v1["locationId"]
          path_cost = amap.db:calculate_path_cost(curr_id, loc_id)
          if path_cost == nil then
            path_cost = -1
          end
          if type(resp) == "userdata" then
            resp = " "
          end
          loc_name = v1["name"]
          ret[loc_id] = {path_cost,resp,name,short,players,desc,loc_id,loc_name}
        end       
      end
    else
      for k1,v1 in pairs(v["locations"]) do
        loc_id = v1["locationId"]
        path_cost = amap.db:calculate_path_cost(curr_id, loc_id)
        if path_cost == nil then
          path_cost = -1
        end
        if type(resp) == "userdata" then
          resp = " "
        end
        if path_cost <= maxsteps  then          
          loc_name = v1["name"]
          ret[loc_id] = {path_cost,resp,name,short,players,desc,loc_id,loc_name}
        end
      end       
    end
  end

  local col1_len = 8    -- numer lokacji
  local col2_len = 11   -- odleglosc
  local col3_len = 5   -- resp
  local col4_len = 4   -- Osoby
  local col5_len = 29   -- nazwa kluczodajki
  local col6_len = 35   -- opis kluczodajki
  local col7_len = 15   -- uwagi
  local offset = 10     -- narzut na wybor innych lokacji
  
  local sum_line_len = col1_len + 1 + col2_len + 1 + col3_len + 1 + col4_len + 1 + col5_len + 1 + col6_len + 1 + col7_len + offset
  
  cecho("\n"..string.rep("-",sum_line_len))
  ra.core.print_kg_line("<yellow>", "Nummer", col1_len, "Odleglosc", col2_len, "h", col3_len, "#", col4_len, "Kluczodajka", col5_len, "Opis", col6_len, "Wskazowki", col7_len)
  cecho("\n"..string.rep("-",sum_line_len))
  local cc = 1
  for k,v in spairs(ret, function(t,a,b) return t[a][1] < t[b][1] end) do
    ra.core.color_keygivers_room(tonumber(k))
    ra.core.print_kg_line("<green>", tonumber(k), col1_len, v[1], col2_len, v[2], col3_len, v[5], col4_len, v[3], col5_len, v[4], col6_len, v[6], col7_len)
    cc = cc + 1
  end
  cecho("\n"..string.rep("-",sum_line_len).."\n")
end

function ra.core.print_kg_line(color, col1, col1_len, col2, col2_len, col3, col3_len, col4, col4_len, col5, col5_len, col6, col6_len, col7, col7_len)
  if type(col1) == "number" then
    col1 = tostring(col1)
    local get_str = "/prowadz "..col1
    cecho("\n<grey>|")
    cechoLink(ra.core.lcstr_kg("<light_slate_blue>", col1, " ", col1_len), function () expandAlias(get_str) end, get_str, true) 
  else    
    cecho("\n<grey>|"..ra.core.lcstr_kg(color, col1, " ", col1_len))
  end
  
  
  local ret = ra.core.generate_locs(col5)  
  if type(ret) == "table" and table.size(ret[1]) > 0 then
    cecho("<grey>| ")
    cechoPopup("<light_slate_blue>Wybierz ", ret[1], ret[2], true)
  else
    cecho("<grey>|"..ra.core.lcstr_kg("<yellow>", "Lokacje", " ", 8))  
  end
  
  cecho("<grey>|"..ra.core.lcstr_kg(color, tostring(col2), " ", col2_len))  
  cecho("<grey>|"..ra.core.lcstr_kg(color, tostring(col3), " ", col3_len))
  cecho("<grey>|"..ra.core.lcstr_kg(color, tostring(col4), " ", col4_len))
  cecho("<grey>|"..ra.core.lcstr_kg("<ansi_light_cyan>", tostring(col5), " ", col5_len))
  cecho("<grey>|"..ra.core.lcstr_kg("<MediumSeaGreen>", tostring(col6), " ", col6_len))
  
  if string.len(col7) <= 2 or col7 == "Uwagi" then
    cecho("<grey>|"..ra.core.lcstr_kg(color, tostring(col7), " ", col7_len))
  else
    cechoLink("<grey>|"..ra.core.lcstr_kg("<light_slate_blue>", "Najedz myszka", " ", col7_len), function () return "" end, col7, true)    
  end
end

function ra.core.print_kgd_line(color, col1, col1_len, col2, col2_len, col3, col3_len, col4, col4_len)
  cecho("\n<grey>|"..ra.core.lcstr_kg(color, col1, " ", col1_len))
  cecho("<grey>|"..ra.core.lcstr_kg("<ansi_light_cyan>", tostring(col2), " ", col2_len))  
  cecho("<grey>|"..ra.core.lcstr_kg(color, tostring(col3), " ", col3_len))
  cecho("<grey>|"..ra.core.lcstr_kg(color, tostring(col4), " ", col4_len))
end

function ra.core.print_kgk_line(color, col1, col1_len, col2, col2_len, col3, col3_len)
  cecho("\n<grey>|"..ra.core.lcstr_kg(color, col1, " ", col1_len))
  cecho("<grey>|"..ra.core.lcstr_kg(color, tostring(col2), " ", col2_len))
  cecho("<grey>|"..ra.core.lcstr_kg(color, tostring(col3), " ", col3_len))
end


function ra.core.lcstr_kg(color, str, fill_char, to_len)
  str = " "..str.." "
  local l = to_len - string.len(str)
  local l_l = 0
  local l_r = l - l_l
  local s = "<grey>"..string.rep(fill_char, l_l)..color..str.."<grey>"..string.rep(fill_char, l_r)
  return s
end

function ra.core.ccst_kg(color, str, fill_char, to_len)
  str = " "..str.." "
  local l = to_len - string.len(str)
  local l_l = math.floor(l / 2)
  local l_r = l - l_l
  local s = "<grey>"..string.rep(fill_char, l_l)..color..str.."<grey>"..string.rep(fill_char, l_r)
  return s
end

function ra.core.color_keygivers()
  ra.core.read_keygivers_from_files()
  for k,v in pairs(ra.tmp.keygivers) do
    if table.size(v["locations"]) > 0 then
      for k1,v1 in pairs(v["locations"]) do
        ra.core.color_keygivers_room(v1["locationId"])
      end
    end
  end  
end

function ra.core.color_keygivers_room(loc_id)
  local color = ra.keyroom_icon_color
  setRoomEnv(tonumber(loc_id), amap.color_table[color])
end

function ra.core.lcstr_kgs(color, str, fill_char, to_len)
  str = " "..str.." "
  local l = to_len - string.len(str)
  local l_l = 0
  local l_r = l - l_l
  local s = "<grey>"..string.rep(fill_char, l_l)..color..str.."<grey>"..string.rep(fill_char, l_r)
  return s
end

function ra.core.print_kgs_line(color, col1, col1_len, col2, col2_len, col3, col3_len, col4, col4_len, col5, col5_len, col6, col6_len, col7, col7_len)
  cecho("\n<grey>|"..ra.core.lcstr_kgs(color, col1, " ", col1_len))
  cecho("<grey>|"..ra.core.lcstr_kgs(color, tostring(col2), " ", col2_len))  
  
  local get_str = "/klucze_dodaj "..col1
  cecho("<grey>|")
  cechoLink(ra.core.lcstr_kgs("<light_slate_blue>", col3, " ", col3_len), function () expandAlias(get_str) end, get_str, true) 
  
  local ret = ra.core.generate_keys_adds(ra.tmp.keys, col1, col7)
  cecho("<grey>| ")
  cechoPopup("<light_slate_blue>Dodaj drop ", ret[1], ret[2], true)

  local get_str2 = "/klucze_dodaj "..col1.." <wlasna data>"
  cecho("<grey>|")
  cechoLink(ra.core.lcstr_kgs("<light_slate_blue>", col5, " ", col5_len), function () ra.core.print_add_keygivers_date(col1, "") end, get_str2, true) 
  
  ret = ra.core.generate_keys_adds_ext(ra.tmp.keys, col1, col7)
  cecho("<grey>| ")
  cechoPopup("<light_slate_blue>Dodaj drop + ", ret[1], ret[2], true)

end

function ra.core.generate_locs(keygiver) 
  local ret1 = {}
  local ret2 = {}
  for k,v in pairs(ra.tmp.keygivers) do
    if v["name"] == keygiver then
      if table.size(v["locations"]) > 0 then
        for k1,v1 in pairs(v["locations"]) do
          table.insert(ret1, v1["name"])
          table.insert(ret2, [[expandAlias("/prowadz ]] .. v1["locationId"] .. [[")]])
        end
      end
    end
  end
  return {ret2,ret1}
end

function ra.core.generate_keys_adds(keys, keygiver, domain) 
  local ret1 = {}
  local ret2 = {}
  for k,v in pairs(keys) do
    if v["domain"] == domain then
      table.insert(ret1, v["name"])
      table.insert(ret2, [[expandAlias("/klucze_dodaj ]] .. keygiver .. [[#]] .. v["name"] .. [[")]])
    end
  end
  return {ret2,ret1}
end

function ra.core.generate_keys_adds_ext(keys, keygiver, domain) 
  local ret1 = {}
  local ret2 = {}
  for k,v in pairs(keys) do
    if v["domain"] == domain then
      table.insert(ret1, v["name"])
      table.insert(ret2, [[ra.core.print_add_keygivers_date("]] .. keygiver..[[","]] .. v["name"] .. [[")]])
    end
  end
  return {ret2,ret1}
end

function ra.core.print_title_line(color, col1, col1_len, col2, col2_len, col3, col3_len, col4, col4_len, col5, col5_len, col6, col6_len)
  cecho("\n<grey>|"..ra.core.lcstr_kgs(color, col1, " ", col1_len))
  cecho("<grey>|"..ra.core.lcstr_kgs(color, col2, " ", col2_len))  
  cecho("<grey>|"..ra.core.lcstr_kgs(color, col3, " ", col3_len))
  cecho("<grey>|"..ra.core.lcstr_kgs(color, col4, " ", col4_len))
  cecho("<grey>|"..ra.core.lcstr_kgs(color, col5, " ", col5_len))
  cecho("<grey>|"..ra.core.lcstr_kgs(color, col6, " ", col6_len))
end

function ra.alias.add_keygivers_drop(data)
  --display("alias_data",data)
  local a = string.split(data, "#")
  local keygiver = ""
  local drop = ""
  local date = string.cut(getEpoch(), 10) -- defaltowy czas dodania now()
  local err = false
  
  if table.size(a) == 3 then
    keygiver = string.trim(a[1])
    drop = string.trim(a[2])
    if ra.core.check_date(a[3], true) == false then
      ra.core.help_add_keygivers()
      err = true
    else
      date = ra.core.check_date(a[3])  
    end
  elseif table.size(a) == 2 then
    keygiver = string.trim(a[1])
    if ra.core.check_date(a[2]) == false then
      drop = string.trim(a[2])     
    else
      date = ra.core.check_date(a[2], true)
      if not date then
        err = true
      end
    end
  else
    keygiver = string.trim(data)    
  end
  
  --display(date, keygiver, drop)
  if err == false then
    ra.core.add_keygivers_drop(date, keygiver, drop)
    ra.core.add_keygivers_drop_dc(date, keygiver, drop)
  end
end

function ra.core.check_date(str, help)
  local p="(%d+).(%d+).(%d+) (%d+):(%d+)"
  local year,month,day,hour,min=string.match(str,p)
  if year == nil or month == nil or day == nil or hour == nil or min == nil then
    if help then
      cecho("\n<tomato>Blad w formacie daty. Poprawny przyklad: 2023.07.31 20:19\n")
    end
    return false
  end
  local timestamp = os.time({year=year,month=month,day=day,hour=hour,min=min,sec=0})
  if timestamp > 0 then
    return timestamp
  end
  return false
end

function ra.core.add_keygivers_drop(date, keygiver, drop)
  --display("save input;",date, keygiver, drop)
  ra.core.read_keygivers_from_files()
  ra.core.read_keys_from_files()

  local ok = false
  if string.len(keygiver) > 0 and ra.core.check_keygiver(keygiver) then
    keygiver = ra.core.check_keygiver(keygiver)
    ok = true
  else
    scripts:print_log("Nie znaleziono kluczodajki o nazwie: "..keygiver)   
  end

  if ok and string.len(drop) > 0 then
    local d = ra.core.check_key(drop)
    if d then
      drop = d
      ok = true
    else
      scripts:print_log("Nie znaleziono dropu o nazwie: "..drop)
      ok = false
    end
  end
  
  if ok == false then
    return false
  end
  
  local url = ra.download_domain..ra.download_files["keygivers_drops"]["source"]
  local token = ra.tmp.ra_login_token
  local header = {
     ["Content-Type"] = "application/json",
     ["Authorization"] = "Bearer " .. token
  }
  local data = {
      keyGiver = keygiver,
      dropDate = tonumber(date),
  }
  if string.len(drop) > 0 then
    data["drop"] = drop
  end
  --display(url,data,header)
  ra.core.postJSON(url,data,header)
  scripts:print_log("Uaktualniono dropy na stronie Alderazzi.")
  tempTimer(6, [[ ra.core.download_all_online_data() ]])
end

function ra.core.add_keygivers_drop_dc(date, keygiver, drop)
  --display("dc input;",date, keygiver, drop)
  ra.core.read_keygivers_from_files()
  ra.core.read_keys_from_files()

  local ok = false
  if string.len(keygiver) > 0 and ra.core.check_keygiver(keygiver) then
    keygiver = ra.core.check_keygiver(keygiver)
    ok = true
  else
    scripts:print_log("Nie znaleziono kluczodajki o nazwie: "..keygiver)   
  end

  if ok and string.len(drop) > 0 then
    local d = ra.core.check_key(drop)
    if d then
      drop = d
      ok = true
    else
      scripts:print_log("Nie znaleziono dropu o nazwie: "..drop)
      ok = false
    end
  end
  
  if ok == false then
    return false
  end
  
  for k,v in pairs(ra.tmp.keygivers) do
    if v["id"] == keygiver then
      keygiver = v["name"]
    end
  end
  
  local content = ""
  
  local url = ra.dc_webhook_timery
  
  local user = "ra scripts"
  if gmcp ~= nil and gmcp.char ~= nil and gmcp.char.info ~= nil and gmcp.char.info.name ~= nil then
    user = gmcp.char.info.name
  end
  
  if string.len(drop) > 0 then
    for k,v in pairs(ra.tmp.keys) do
      if v["id"] == drop then
        local tres = ""
        if MagicKeys.keysList[v["name"]] == nil then
          tres = ""
        else
          tres = MagicKeys.keysList[v["name"]]
        end
        if string.len(tres) > 0 then
          drop = tostring(v["name"].." ("..tres..")")
        else
          drop = tostring(v["name"])
        end
      end
    end    
    content = drop.." - "..keygiver.." - "..tostring(os.date('%H:%M',date)).." ("..string.title(tostring(user))..")"
    url = ra.dc_webhook_magiken
  else
    content = keygiver.." - "..tostring(os.date('%H:%M',date)).." ("..string.title(tostring(user))..")"
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
  scripts:print_log("Uaktualniono dropy na DC Alderazzi.")
  
end

function ra.core.check_keygiver(keygiver)
  for k,v in pairs(ra.tmp.keygivers) do
    if keygiver == v["name"] then
      return v["id"]
    end
  end
  return false
end

function ra.core.check_key(key)
  for k,v in pairs(ra.tmp.keys) do
    if key == v["name"] then
      return v["id"]
    end
  end
  return false
end

function ra.core.print_add_keygivers(search_str)
  search_str = string.lower(search_str)
  local ret = {}
  local short = ""
  local name = ""
  local date = 0
  local domain = ""
  ra.core.read_keygivers_from_files()
  ra.core.read_keys_from_files()
  local c = 1
  
  for k,v in pairs(ra.tmp.keygivers) do
    short = v["short"]
    name = v["name"]
    domain = v["domain"]
    if string.findPattern(string.lower(short), search_str) or string.findPattern(string.lower(name), search_str) then
      ret[c] = {name,short,domain}
      c = c + 1 
    end
  end

  local col1_len = 29   -- Krotka nazwa kluczodajki
  local col2_len = 39   -- Opis kluczodajki
  local col3_len = 11   -- Dodanie bez dropu
  local col4_len = 12   -- Dodanie z dropem
  local col5_len = 12   -- Dodanie bez dropu i wlasnym czasem
  local col6_len = 13   -- Dodanie z dropem i wlasnym czasem
  local col7_len = 0    -- Domena
  
  local sum_line_len = col1_len + 1 + col2_len + 1 + col3_len + 1 + col4_len + 1 + col5_len + 1 + col6_len + 1 + col7_len  
  cecho("\n"..string.rep("-",sum_line_len))
  ra.core.print_title_line("<yellow>", "Kluczodajka", col1_len, "Opis", col2_len, "Bez dropu", col3_len, "Z dropem", col4_len, "Bez dropu+", col3_len, "Z dropem+", col4_len)
  cecho("\n"..string.rep("-",sum_line_len))
  for k,v in spairs(ret, function(t,a,b) return string.len(t[a][1]) < string.len(t[b][1]) end) do
    ra.core.print_kgs_line("<green>", v[1], col1_len, v[2], col2_len, "Dodaj", col3_len, "Dodaj", col4_len, "Dodaj +", col5_len, "Dodaj +", col6_len, v[3], col7_len)
  end
  cecho("\n"..string.rep("-",sum_line_len).."\n")  
end

function ra.core.print_add_keygivers_date(keygiver, drop)
  ra.core.help_add_keygivers()
  local s = "/klucze_dodaj "
  local date = getTime(true, "yyyy.MM.dd hh:mm")
  if string.len(keygiver) > 0 then
    s = s..keygiver.."#"
  end
  if string.len(drop) > 0 then
    s = s..drop.."#"
  end
  s = s..date
  
  printCmdLine(tostring(s))
end

function ra.core.print_keytimes(past_days)
  local ret = {}
  local key = ""
  local pastd = 0
  local domain = ""
  local now = getEpoch()
  local color = "<green>"
  local validity = 0
  ra.core.read_drops_from_files()
  ra.core.read_keys_from_files()
  local c = 1
  
  local function get_key_domain(name)
    for k,v in pairs(ra.tmp.keys) do
      if name == v["name"] then
        return v["domain"]
      end
    end
    return "nieznana domena"
  end
  
  local function check_validity(validity)
    local color
    if validity > 3 then
      color = "<grey>"
    elseif validity > 2 then
      color = "<green>"
     elseif validity > 1 then
      color = "<yellow>"
    elseif validity > 0 then
      color = "<orange>"
    else
      color = "<tomato>"
    end 
    return color
  end
  
  for k,v in pairs(ra.tmp.keygivers_drops) do
    if type(v["drop"]) == "table" then
      if MagicKeys.keysList[v["drop"]["name"]] then
        key = v["drop"]["name"].." ("..MagicKeys.keysList[v["drop"]["name"]]..")"
      else
        key = v["drop"]["name"]
      end
      domain = get_key_domain(v["drop"]["name"])
      validity = tonumber(v["dropDate"]) + (5*24*60*60)
      pastd = ((validity-now))/(24*60*60)
      if pastd > -past_days then
        color = check_validity(pastd)
        ret[c] = {validity, key, domain, color}
        c = c + 1
      end
    end
    
  end
  
  local col1_len = 75   -- Nazwa klucza
  local col2_len = 29   -- Data waznosci
  local col3_len = 10   -- Domena
  
  local sum_line_len = col1_len + 1 + col2_len + 1 + col3_len + 1 
  cecho("\n"..string.rep("-",sum_line_len))
  ra.core.print_kgk_line("<yellow>", "Klucz", col1_len, "Waznosc", col2_len, "Domena", col3_len)
  cecho("\n"..string.rep("-",sum_line_len))
  for k,v in spairs(ret, function(t,a,b) return t[a][1] < t[b][1] end) do
    ra.core.print_kgk_line(v[4], v[2], col1_len, tostring(os.date('%d.%m.%Y %H:%M', tonumber(v[1]))), col2_len, v[3], col3_len)
  end
  cecho("\n"..string.rep("-",sum_line_len).."\n")  
end

function ra.core.get_key_by_string(str)
  local key = str
  for k,v in pairs(ra.tmp.keygivers_drops) do
    if type(v["drop"]) == "table" then
      for k1,v1 in pairs(MagicKeys.keysList) do
        if k1 == str then
          key = str.." ("..MagicKeys.keysList[str]..")"
          return key
        end
      end
    end
  end
  return key
end

function ra.core.add_text_dc(notify, url)
  local user = "ra scripts"
  local date = string.cut(getEpoch(), 10)
  if gmcp ~= nil and gmcp.char ~= nil and gmcp.char.info ~= nil and gmcp.char.info.name ~= nil then
    user = gmcp.char.info.name
  end

  local content = ""
  content = content..notify.." - "..tostring(os.date('%H:%M',date)).." ("..string.title(tostring(user))..")\n"

  local data = {
   content = content,
   user = "Benicjo"
  }
   
  local header = {
     ["Content-Type"] = "application/json",
  }

  --display(url,data,header)
  
  ra.core.postJSON(url,data,header)
  scripts:print_log("Uaktualniono informacje na DC Alderazzi.")

end

