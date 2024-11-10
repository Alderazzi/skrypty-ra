function ra.core.marge_enymylists()
  table.sort(ra.enemylist)
  ra.enemylist = table.n_union(scripts.people.enemy_people, ra.enemylist)
  ra.core.load_enemylist_from_files()
  table.sort(ra.enemylist)
  scripts.people.enemy_people = ra.enemylist
end

function ra.alias.show_enemy_list()
  cecho("\n<yellow> Twoi obecni wrogowie (ze starej listy) to:")
  cecho("<tomato> "..table.concat(scripts.people.enemy_people, ", ").."\n")
end

function ra.alias.reload_data()
  ra.core.marge_enymylists()
  scripts.people:starter()
  ra.alias.show_enemy_list()
end

function ra.alias.download_ra_data()
  --ra.core:download_all_data()
  ra.core:kdownload_all_data()
  if ra.debug then
    scripts:print_log("Pobieram dane online kluczodajek.")
  end
end


function ra.core.load_enemylist_from_files()
  if io.exists(ra.enemylist_file_path) then
    local s = ""
    local file = io.open(ra.enemylist_file_path, "r")
    if file then
      local s = file:read("*a")
      file:close()
      local t = string.split(string.trim(s), "\n")
      local input = {}
      for k,v in pairs(t) do
        local ll = string.split(string.trim(v), ",")
        for k1,v1 in pairs(ll) do
          if string.len(string.trim(v1)) > 0 then
            table.insert(input, string.trim(v1))
          end
        end
      end
      table.sort(input)
      ra.enemylist = table.n_union(input, ra.enemylist)
      if ra.debug then
        scripts:print_log("Przeladowano liste online wrogow rodziny.")
      end
    end
  else
    local filec = io.open(getMudletHomeDir() .. "/lista_wrogow.txt", "w")
    filec:close()
  end
  if io.exists(getMudletHomeDir() .. "/lista_wrogow.txt") then
    local s = ""
    local file = io.open(getMudletHomeDir() .. "/lista_wrogow.txt", "r")
    if file then
      local s = file:read("*a")
      file:close()
      local t = string.split(string.trim(s), "\n")
      local input = {}
      for k,v in pairs(t) do
        local ll = string.split(string.trim(v), ",")
        for k1,v1 in pairs(ll) do
          if string.len(string.trim(v1)) > 0 then
            table.insert(input, string.trim(v1))
          end
        end
      end
      table.sort(input)
      ra.enemylist = table.n_union(input, ra.enemylist)
      if ra.debug then
        scripts:print_log("Przeladowano lokalna liste wrogow rodziny.")
      end
    end
  else
    local filec = io.open(getMudletHomeDir() .. "/lista_wrogow.txt", "w")
    filec:close()
  end
  
end

function ra.core:download_all_data()
    ra.core.download_all_data_coroutine_id = nil
    if not mudlet.supports.coroutines then
        return
    end
    ra.core.download_all_data_coroutine_id = coroutine.create(ra.core.process_download_all_data)
    coroutine.resume(ra.core.download_all_data_coroutine_id)
end

function ra.core:process_download_all_data()
    scripts.utils.data_downloader:start_file_downloader(ra.enemylist_url, ra.enemylist_file_path, ra_enemylist_data_downloaded, "json")
    coroutine.yield()
    ra.core.download_all_data_coroutine_id = nil
end

function ra_enemylist_data_downloaded(resume_coroutine_id, decoded_data)
    coroutine.resume(resume_coroutine_id)
    coroutine.resume(ra.core.download_all_data_coroutine_id)
end