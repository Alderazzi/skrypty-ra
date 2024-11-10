function ra.core.add_order(str, stime)
  if ra.tmp.orders_pre ~= nil and string.len(ra.tmp.orders_pre) > 0 then
    local order_content = ra.tmp.orders_pre
    
    local order_amount = tonumber(scripts.string_to_liczebnik[string.lower(str)])    
    if order_amount == nil then
      order_amount = 1
    end
    local mod = 1
    if stime == 1 then
      mod = 24
    end
    local order_timestamp = os.time() + (order_amount * mod * 120)
    local loc_id = tostring(amap.curr.id)
    ra.tmp.orders[loc_id] = {}
    ra.tmp.orders[loc_id]["area"] = amap.curr.area
    ra.tmp.orders[loc_id]["endtime"] = tostring(order_timestamp)
    ra.tmp.orders[loc_id]["content"] = order_content
    
    ra.core.save_orders_data()
  end
end

function ra.alias.send_orders_dc()
  ra.core.rebuild_orders()
  local output = "\nDostepne zamowienia dla:\n"
  local order_endtime = ""
  if table.size(ra.orders) > 0 then
    for k, v in spairs(ra.orders) do
      order_endtime = os.date('%d.%m.%Y %H:%M', v["endtime"])
      output = output.." + "..v["content"].." - "..v["area"].." [id: "..v["loca_id"].."] - Wazne do "..order_endtime.."\n"
    end
    ra.core.add_order_text_dc(output, ra.dc_webhook_zlecenia)
  else
    cecho("\n<yellow>Brak zapisanych zamowien.\n")
  end
  
end

function ra.core.add_order_text_dc(notify, url)
  local user = "ra scripts"
  local date = os.time()
  if gmcp ~= nil and gmcp.char ~= nil and gmcp.char.info ~= nil and gmcp.char.info.name ~= nil then
    user = gmcp.char.info.name
  end

  local content = "\nCzas lokalny gracza: "..tostring(os.date('%Y-%m-%d %H:%M',date)).." [UTC "..tostring(os.date('!%Y-%m-%d %H:%M',date)).."] ("..string.title(tostring(user))..")\n"
  content = content..notify

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

function ra.core.rebuild_orders()
  local raw_orders = ra.tmp.orders
  local orders = {}
  local now = getEpoch()
  for k, v in pairs(raw_orders) do
    if tonumber(v["endtime"]) > now then
      local key = v["endtime"].."_"..k
      orders[key] = {}
      orders[key]["loca_id"] = k
      orders[key]["endtime"] = tonumber(v["endtime"])
      orders[key]["area"] = v["area"]
      orders[key]["content"] = v["content"]
    end
  end
  table.sort(orders)
  ra.orders = orders
end

function ra.core.delete_order(loc_id)
  local arr = ra.orders
  for k,v in pairs(arr) do
    if tonumber(v["loca_id"]) == tonumber(loc_id) then
      ra.orders[k] = nil
      ra.tmp.orders[loc_id] = nil
      ra.core.rebuild_orders()
      ra.core.save_orders_data()
      break
    end
  end
end

function ra.alias.show_orders_info()
  ra.core.rebuild_orders()
  if ra.orders == nil or table.size(ra.orders) == 0 then
    cecho("\n<yellow>Brak zapisanych zamowien.\n")
    return
  end
  cecho("\n\t<yellow>Dostepne zamowienia dla:\n")
  local arr = ra.orders
  local color = "GhostWhite"
  
  local time_step_colors = {} -- <1h czerwony 1-8h zolty >8h zielony
  time_step_colors[1*60*60] = "red"
  time_step_colors[8*60*60] = "yellow"
  
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
  
  local function get_color_by_difftime(diff)
    for k,v in pairsByKeys(time_step_colors) do
      if diff < k then
        return v
      end
    end
    return "green"
  end
  
  for k, v in spairs(arr) do
     local loc_id = v["loca_id"]
     local loc_area = v["area"]
     local order_endtime = os.date('%d.%m.%Y %H:%M', v["endtime"])
     local order_content = v["content"]
     local col = get_color_by_difftime((tonumber(v["endtime"]) - getEpoch()))
     
     cecho("\n <MediumSeaGreen> - "..order_content.." - <"..color..">"..loc_area.." [id: ")
     cechoLink("<dodger_blue>"..loc_id, [[expandAlias("/prowadz ]] .. loc_id .. [[")]], "/prowadz "..loc_id, true)
     cecho(" <"..color..">] - Wazne do <"..col..">"..order_endtime)
     cechoLink(" -><light_slate_blue> usun z listy", 
      function () 
        ra.core.delete_order(loc_id) 
        ra.alias.show_orders_info() end, 
      "Usun wpis z listy zamowien."..loc_id, 
      true)
  end
 cecho("\n\n")
 scripts.utils.bind_functional_call(function() ra.alias.send_orders_dc() end, "Dodaj wpis o zamowieniach na DC Alderazzi.", false)
end

function ra.core.save_orders_data()
  local data = ra.tmp.orders
  local path = ra.orders_json_file_path
  local file = io.open(path, "w")
  file:write(yajl.to_string(data))
  file:close()
  if ra.debug then
    scripts:print_log("Zapisano lokalnie liste zamowien:")
    display(data)
  end
end

function ra.core.read_orders_data()
  if io.exists(ra.orders_json_file_path) then
    local data = scripts.utils:read_json(ra.orders_json_file_path)  
    ra.tmp.orders = data
    if ra.debug then
      scripts:print_log("Zaladowano lokalna liste zamowien:") 
      display("json", data)
    end
  end  
end