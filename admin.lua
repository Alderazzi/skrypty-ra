function ra.alias.reinstall_plugin()
  ra.core.uninstall_plugin()
  tempTimer(10, [[ ra.core.install_plugin() ]]) 
end

function ra.core.install_plugin()
  expandAlias("/zainstaluj_plugin https://skrypty-ra.s3.eu-west-1.amazonaws.com/arkadia-ra.zip")
end

function ra.core.uninstall_plugin() 
  expandAlias("/odinstaluj_plugin arkadia-ra")
end

function compareVersions(v1, v2)
  local pattern = "%d+"
  local iter1 = v1:gmatch(pattern)
  local iter2 = v2:gmatch(pattern)
  
  while true do
      local num1 = iter1()
      local num2 = iter2()
      
      if not num1 and not num2 then return 0 end      -- versions are equal
      if not num1 then return -1 end                  -- v1 is shorter (older)
      if not num2 then return 1 end                   -- v2 is shorter (older)
      
      num1 = tonumber(num1)
      num2 = tonumber(num2)
      
      if num1 > num2 then return 1 end
      if num1 < num2 then return -1 end
  end
end

function ra.core.check_plugin_update(show)
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

  local f = ra.download_files.plugin.target_file
  if io.exists(f) then
    local file_content = scripts.utils:read_json(f)
    ra.tmp.plugin_version = file_content["version"]
    ra.tmp.changelog = file_content["changelog"]
    if tonumber(ra.version) < tonumber(ra.tmp.plugin_version) then
      scripts:print_log_nobr("Dostepna jest nowa wersja pluginu 'arkadia-ra' ("..ra.version.." < "..ra.tmp.plugin_version.."). Wpisz ")
      scripts:print_url("<CadetBlue>/ra_przeinstaluj_plugin", "ra.alias.reinstall_plugin()", "/ra_przeinstaluj_plugin")
      cecho("<tomato> zeby zaktualizowac.")
      cecho("\n<SlateGray>Niektore wersje sa testowe i moga zawierac bledy, wiecej informacji znajdziesz na discordzie <light_blue>#skrypty -> #aktualizacje.")
      cecho("\n<SlateGray>Bledy zglaszaj na <light_blue>#skrypty")
      cecho("\n<SlateGray>Changelog:\n")
      for k,v in spairs(ra.tmp.changelog) do
        if compareVersions(k, ra.version) > 0 then
          cecho("\n<SlateGray>"..k)
          cecho("\n<SlateGray>"..v)
        end
      end
      cecho("\n\n")
    else
      if show then
        scripts:print_log("Brak nowej wersji pluginu 'arkadia-ra' (obecnie uzywana wersja to "..ra.version..")")
      end
    end
    if ra.debug then
      scripts:print_log("Odczytano informacje o dostepnej wersji pluginu arkadia-ra "..f)
    end
  end  
end

function ra.core.login_pwd() 
   local data = {
  }
  if ra_login_pwd ~= nil and ra_login_role ~= nil then
    data = {
      role = ra_login_role,
      password = ansi2string(dec(ra_login_pwd))
    }
  else
    scripts:print_log("Nie masz ustawionych danych autoryzacji online. Zobacz /ra_pomoc aby sprawdzic jak je ustawic.")
  end
  local header = {
     ["Content-Type"] = "application/json",
  }
  
  if ra.debug then
    scripts:print_log("Autoryzacja dostepu do danych online.")
  end
  ra.core.postJSON(ra.ra_login_page,data,header)
end

function ra.core.postJSON(url,dataTable,headerTable)
  if scripts.event_handlers["sysPostHttpDone"] then
      killAnonymousEventHandler(scripts.event_handlers["sysPostHttpDone"])
  end
  if scripts.event_handlers["sysPostHttpError"] then
      killAnonymousEventHandler(scripts.event_handlers["sysPostHttpError"])
  end
  
  local data = dataTable or {text = "hello world"}
  local header = headerTable or {["Content-Type"] = "application/json"}
  
  scripts.event_handlers["sysPostHttpDone"] = registerAnonymousEventHandler('sysPostHttpDone', ra_core_decode_token, true)
  scripts.event_handlers["sysPostHttpError"] = registerAnonymousEventHandler('sysPostHttpError', function(event, response, rurl)
     scripts:print_log("Logowanie sie nie powiodlo. Sprawdz dane do autoryzacji dostepu online.")
      if rurl == url then echo(response) else return true end
    end, true)
    
    postHTTP(yajl.to_string(data), url, header)
end

function ra_core_decode_token(event, response, rurl)
  local resp = yajl.to_value(rurl)
  ra.tmp.page_response = rurl
  if resp ~= nil and resp["data"] ~= nil and resp["data"]["token"] ~= nil then
    ra.tmp.ra_login_token = resp["data"]["token"]
  end
  ra.tmp.ra_login_timestamp = os.time(os.date("*t"))
  if ra.debug then
    scripts:print_log("Zaktualizowano dostep do danych online.")
  end
end

function ra.alias.set_login_data(role, pwd)

  if exists("ra_config", "script") == 0 then
    permScript("ra_config", "", [[ra_login_role = "]]..role..[["
ra_login_pwd = "]]..enc(pwd)..[["]])
    scripts:print_log("Ustawiono dane do autoryzacji dostepu online w skrypcie 'ra_config'.")
    enableScript("ra_config")
  else
    scripts:print_log("Dane do autoryzacji online sa juz zapisane w skrypcie 'ra_config'.")
  end
end

function ra.alias.reset_login_data(role, pwd)

  if exists("ra_config", "script") ~= 0 then
    setScript("ra_config", [[ra_login_role = "]]..role..[["
ra_login_pwd = "]]..enc(pwd)..[["]])
    scripts:print_log("Nadpisano dane do autoryzacji dostepu online w skrypcie 'ra_config'.")
    enableScript("ra_config")
  else
    ra.alias.set_login_data(role, pwd)
  end
end

function ra.core.token_islive()
  local now_timestamp = os.time(os.date("*t"))
  if ( ra.tmp.ra_login_timestamp + ra.ra_login_timeout ) < now_timestamp then
    return false
  else
    return true
  end
end

function ra.core.refresh_token()
  if ra.core.token_islive() == false then
    ra.core.login_pwd()   
  end
  tempTimer(ra.ra_login_timeout, [[ ra.core.refresh_token() ]])
end