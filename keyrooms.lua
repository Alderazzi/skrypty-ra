--[
--  {
--    "id": "1",
--    "name": "Bracia w Ebino",
--    "mapId": 5344,
--    "respawnTime": 3,
--    "description": "Chodza po ulicach miasta, ok. 3 osoby"
--  },
--  {
--    "id": "2",
--    "name": "Khelor",
--    "mapId": 24730,
--    "respawnTime": 24,
--    "description": "ok. 4 osoby"
--  },

function ra.alias.kdownload_ra_data()
  ra.core:kdownload_all_data()
  if ra.debug then
    scripts:print_log("Pobieram dane online kluczodajek.")
  end
end

function ra.alias.upload_ra_data()
  ra.core:upload_all_data()
  if ra.debug then
    scripts:print_log("Wysylam lokalne dane kluczodajek do serwera.")
  end
end

function ra.core:upload_all_data()
  scripts:print_log("Wrzuc monete...")
end

function ra.alias.change_keyroom(input)
  local data = string.split(input, "#")
  local id = tostring(data[1])
  ra.core.change_keyroom_value(id, "name", tostring(data[2]))
  ra.core.change_keyroom_value(id, "mapId", tostring(data[3]))
  ra.core.change_keyroom_value(id, "respawnTime", tostring(data[4]))
  ra.core.change_keyroom_value(id, "description", tostring(data[5]))
  ra.core.save_keyrooms_in_file()
end

function ra.alias.delete_local_keyroom_file()
  if io.exists(ra.keyrooms_json_file_path.."_tmp") then
    os.remove(ra.keyrooms_json_file_path.."_tmp")
    scripts:print_log("Usunieto plik: "..ra.keyrooms_json_file_path.."_tmp")
  end
end

function ra.alias.add_keyroom(input)
  local data = string.split(input, "#")
  local id = tostring(ra.core.get_maxid_keyroom())
  local arr = {} 
  arr["id"] = id
  arr["name"] = tostring(data[1])
  arr["mapId"] = tonumber(data[2])
  arr["respawnTime"] = tonumber(data[3])
  arr["description"] = tostring(data[4])
  
  table.insert(ra.keyrooms, arr) 
  ra.core.save_keyrooms_in_file()
end

function ra.core.save_keyrooms_in_file()
  local path = ra.keyrooms_json_file_path.."_tmp"
  local file = io.open(path, "w")
  file:write(yajl.to_string(ra.keyrooms))
  file:close()
  scripts:print_log("Zapisano lokalnie dane kluczodajek.")
end

function ra.core.change_keyroom_value(ids, key, value)
  local id = tostring(ids)
  for k,v in pairs(ra.keyrooms) do
    for k2,v2 in pairs(v) do
      if k2 == "id" and v2 == id then
        ra.keyrooms[k][key] = value
      end
    end
  end
end

function ra.core.get_maxid_keyroom()
  local ret = 0
  for k,v in pairs(ra.keyrooms) do
    for k2,v2 in pairs(v) do
      if k2 == "id" and tonumber(v2) > ret then
        ret = tonumber(v2)
      end
    end
  end
  return ret + 1
end

function ra.core.get_keyroom_by_id(idd)
  local id = tostring(idd)
  for k,v in pairs(ra.keyrooms) do
    for k2,v2 in pairs(v) do
      if k2 == "id" and v2 == id then
        return ra.keyrooms[k]
      end
    end
  end
end

function ra.core.load_keyrooms_from_files()
  if io.exists(ra.keyrooms_json_file_path.."_tmp") then
    ra.core.load_keyrooms_from_local_file() 
    ra.keyrooms = ra.keyrooms_local
  elseif io.exists(ra.keyrooms_json_file_path) then
    ra.core.load_keyrooms_from_server_file()
    ra.keyrooms = ra.keyrooms_server
  end  
end

function ra.core.load_keyrooms_from_local_file()
  if io.exists(ra.keyrooms_json_file_path.."_tmp") then
    ra.keyrooms_local = scripts.utils:read_json(ra.keyrooms_json_file_path.."_tmp")    
    if ra.debug then
      scripts:print_log("Zaladowano lokalna liste kluczodajek.")  
    end
  end  
end

function ra.core.load_keyrooms_from_server_file()
  if io.exists(ra.keyrooms_json_file_path) then
    ra.keyrooms_server = scripts.utils:read_json(ra.keyrooms_json_file_path)
    if ra.debug then
      scripts:print_log("Zaladowano liste kluczodajek z serwera.")
    end
  end  
end

function ra.core.print_keyrooms(maxsteps)
  ra.core.load_keyrooms_from_files()
  if maxsteps == nil then
    maxsteps = ra.maxsteps
  end
  local curr_id = amap.curr.id
  local prev_id = curr_id
  
  cecho("\n<white>"..string.title("Kluczodajki w odleglosci "..maxsteps.." krokow:\n"))
  local ret = {}
  for k,v in pairs(ra.keyrooms) do
    ra.core.make_keyroom_red(v["mapId"])
    
    
    
    local path_cost = amap.db:calculate_path_cost(curr_id, v["mapId"])
    if path_cost <= maxsteps then
      ret[v["mapId"]] = {path_cost, getRoomName(v["mapId"]), v["respawnTime"], v["name"], v["description"], v["id"]}
    end
  end
  
  local col1_len = 8
  local col2_len = 11
  local col3_len = 27
  local col4_len = 10
  local col5_len = 25
  local col6_len = 40
  --local sum_line_len = col1_len + 1 + col2_len + 1 + col3_len + 1 + col4_len + 1 + col5_len + 1 + col6_len
  local sum_line_len = col1_len + 1 + col2_len + 1 + col4_len + 1 + col5_len + 1 + col6_len
  
  cecho("\n"..string.rep("-",sum_line_len))
  ra.core.print_line("<yellow>", "Nummer", col1_len, "Odleglosc", col2_len, "ID", col3_len, "Resp (h)", col4_len, "Kluczodajka", col5_len, "Uwagi", col6_len, id)
  cecho("\n"..string.rep("-",sum_line_len))
  local cc = 1
  for k,v in spairs(ret, function(t,a,b) return t[a][1] < t[b][1] end) do
    prev_id = tonumber(k)
    ra.core.print_line("<green>", tonumber(k), col1_len, v[1], col2_len, v[2], col3_len, v[3], col4_len, v[4], col5_len, v[5], col6_len, v[6])
    cc = cc + 1
  end
  cecho("\n"..string.rep("-",sum_line_len).."\n")
end



function ra.core.ccstr(color, str, fill_char, to_len)
  str = " "..str.." "
  local l = to_len - string.len(str)
  local l_l = math.floor(l / 2)
  local l_r = l - l_l
  local s = "<grey>"..string.rep(fill_char, l_l)..color..str.."<grey>"..string.rep(fill_char, l_r)
  return s
end

function ra.core.print_edit_keyroom(arr)
  ra.core.help_edit_keyroom_value() 
  local s = ""
  if table.size(arr) > 0 then
    s = "/edytuj_kluczodajke "..arr["id"].."#"..arr["name"].."#"..arr["mapId"].."#"..arr["respawnTime"].."#"..arr["description"]
  end
  printCmdLine(tostring(s))
end

function ra.core.help_edit_keyroom_value()
  cecho("\n<yellow>/edytuj_kluczodajke id#name#mapId#respawnTime#description\n<grey>Przyklad: ")
  cecho("<yellow>/edytuj_kluczodajke 2#Khelor#24730#24#ok. 4 osoby\n\n")
end

function ra.core.print_line(color, col1, col1_len, col2, col2_len, col3, col3_len, col4, col4_len, col5, col5_len, col6, col6_len, id)
  if type(col1) == "number" then
    local get_str = "/prowadz "..col1
    
    cecho("\n<grey>|")
    cechoLink(ra.core.lcstr("<light_slate_blue>", col1, " ", col1_len), function () expandAlias(get_str) end, get_str, true) 
  else    
    cecho("\n<grey>|"..ra.core.lcstr(color, col1, " ", col1_len))
  end
  
  cecho("<grey>|"..ra.core.lcstr(color, col2, " ", col2_len))  
  
  cecho("<grey>|"..ra.core.lcstr(color, col4, " ", col4_len))
  if type(col1) == "number" then
    local cols = ra.core.get_keyroom_by_id(id)
    cechoLink("<grey>|"..ra.core.lcstr("<light_slate_blue>", col5, " ", col5_len), function () ra.core.print_edit_keyroom(cols) end, "/edytuj_kluczodajke", true)
  else
    cecho("<grey>|"..ra.core.lcstr(color, col5, " ", col5_len))  
  end
  
  cecho("<grey>|"..ra.core.lcstr(color, col6, " ", col6_len))
  
end

function ra.core:kdownload_all_data()
    ra.core.kdownload_all_data_coroutine_id = nil
    if not mudlet.supports.coroutines then
        return
    end
    ra.core.kdownload_all_data_coroutine_id = coroutine.create(ra.core.kprocess_download_all_data)
    coroutine.resume(ra.core.kdownload_all_data_coroutine_id)
end

function ra.core:kprocess_download_all_data()
    scripts.utils.data_downloader:start_file_downloader(ra.keyrooms_json_url, ra.keyrooms_json_file_path, ra_keyrooms_data_downloaded, "json")
    coroutine.yield()
    ra.core.kdownload_all_data_coroutine_id = nil
end

function ra_keyrooms_data_downloaded(resume_coroutine_id, decoded_data)
    coroutine.resume(resume_coroutine_id)
    coroutine.resume(ra.core.kdownload_all_data_coroutine_id)
end

