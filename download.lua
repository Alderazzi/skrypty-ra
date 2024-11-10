function ra.core.download_all_online_data()
  ra.tmp.download_all_online_data_coroutine_id = nil
  if not mudlet.supports.coroutines then
      return
  end
  ra.tmp.download_all_online_data_coroutine_id = coroutine.create(ra.core.process_download_all_online_data)
  coroutine.resume(ra.tmp.download_all_online_data_coroutine_id)
end

function ra.core.process_download_all_online_data()
  for k,v in pairs(ra.download_files) do
    if v["active"] == true then
      if ra.debug then
        scripts:print_log("Zaczynam pobierac dane online: "..v["name"])
      end
      if k == "plugin" then
        ra.core.get_url(ra.download_plugin_domain..v["source"])
      else
        ra.core.get_url(ra.download_domain..v["source"])
      end
      coroutine.yield()
    end
  end
  ra.tmp.download_all_online_data_coroutine_id = nil
end

function ra.core.download_drops_online_data()
  ra.tmp.download_all_online_data_coroutine_id = nil
  if not mudlet.supports.coroutines then
      return
  end
  ra.tmp.download_all_online_data_coroutine_id = coroutine.create(ra.core.process_download_drops_online_data)
  coroutine.resume(ra.tmp.download_all_online_data_coroutine_id)
  ra.core.read_keygivers_from_files()
  tempTimer(ra.download_drops_int, [[ ra.core.download_drops_online_data() ]]) 
end

function ra.core.process_download_drops_online_data()
  if ra.debug then
    scripts:print_log("Zaczynam pobierac dane online: "..ra.download_files.keygivers_drops["name"])
  end
  ra.core.get_url(ra.download_domain..ra.download_files.keygivers_drops["source"])
  coroutine.yield()
  ra.tmp.download_all_online_data_coroutine_id = nil
end

function ra_core_check_download(event, response, rurl)
  --display(event, response, rurl, scripts.event_handlers)
  if event == "sysGetHttpDone" then
    if ra.debug then
      scripts:print_log("Udalo sie pobrac dane z "..response)
    end
    ra.core.save2json_file(event, response, rurl)
  elseif event == "sysGetHttpError" then
    scripts:print_log("Nie udalo sie pobrac danych: "..response)
  else
    scripts:print_log("Pojawil sie jakis nieznany event.")
    display(event, response, rurl)
  end
  coroutine.resume(ra.tmp.download_all_online_data_coroutine_id)
end

function ra.core.getJSON(url, headerTable)
  if scripts.event_handlers["ra_sysGetHttpDone"] then
      killAnonymousEventHandler(scripts.event_handlers["ra_sysGetHttpDone"])
  end
  if scripts.event_handlers["ra_sysGetHttpError"] then
      killAnonymousEventHandler(scripts.event_handlers["ra_sysGetHttpError"])
  end
  local header = headerTable or {["Content-Type"] = "application/json"}

  if string.find(url, "s3.eu-west-1") then
    header = false
  end

  scripts.event_handlers["ra_sysGetHttpDone"] = registerAnonymousEventHandler('sysGetHttpDone', ra_core_check_download, true)
  scripts.event_handlers["ra_sysGetHttpError"] = registerAnonymousEventHandler('sysGetHttpError', ra_core_check_download, true)
  getHTTP(url, header)
end

function ra.core.get_url(url)
  local token = ra.tmp.ra_login_token
  local header = {
    ["Content-Type"] = "application/json"
  }
  
  ra.core.getJSON(url, header)
end

function ra.core.save2json_file(event, response, rurl)
  local data = nil
  local id = nil
  for k,v in pairs(ra.download_files) do
    if ra.download_domain..v["source"] == response or ra.download_plugin_domain..v["source"] == response then
      data = v
      id = k
    end
  end

  local ja = yajl.to_value(rurl)
  local json = ja["data"][data["table"]]
  local path = data["target_file"]
  
  local file = io.open(path, "w")
  file:write(yajl.to_string(json))
  file:close()
  ra.download_files[id]["downloaded"] = true
  if ra.debug then
    scripts:print_log("Zapisano "..data["name"].." do pliku "..path)
  end
end