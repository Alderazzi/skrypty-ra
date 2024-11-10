function ra.core.show_enabling_switch_releasing_guards()
  cecho("\n")
  cechoLink("<dodger_blue>-> KLIKNIJ TUTAJ aby WYLACZYC wspomaganie zaslon dla znakow RA.", [[expandAlias("/zaslon-")]], "/zaslon-", true)   
  cecho("\n\n")

end

function ra.core.read_enemylist_from_files()
  local f = ra.download_files.enemies.target_file
  if io.exists(f) then
    ra.tmp.enemies = scripts.utils:read_json(f)
    if ra.debug then
      scripts:print_log("Odczytano liste wrogow rodziny: "..f)
    end
  end
end

function ra.core.marge_yours_enymylists()
  local enemylist = table.n_union(scripts.people.enemy_people, ra.core.get_ra_enemies())
  table.sort(enemylist)
  scripts.people.enemy_people = enemylist
  if ra.debug then
    scripts:print_log("Zintegrowano lokalna liste wrogow z lista wrogow rodziny.")
  end
end

function ra.alias.disable_enemy_handling()
  scripts.people.enemy_people = {}
  scripts:print_log("Obsluga wrogow zostala wylaczona.")
end

function ra.core.get_ra_enemies()
  local arr = {}
  if table.size(ra.tmp.enemies) then
    for k,v in ipairs(ra.tmp.enemies) do
      table.insert(arr, v["name"])
    end
  end
  return arr
end

function ra.core.lcstr(color, str, fill_char, to_len)
  str = " "..str.." "
  local l = to_len - string.len(str)
  local l_l = 0
  local l_r = l - l_l
  local s = "<grey>"..string.rep(fill_char, l_l)..color..str.."<grey>"..string.rep(fill_char, l_r)
  return s
end

-- wyswietlanie list

function ra.alias.show_ra_enemies()
  if table.size(ra.tmp.enemies) == 0 then
    scripts:print_log("Lista wrogow rodziny wydaje sie nie zaladowana. Sprubuje ja zaladowac... po zaladowaniu powtorz komende.")
    ra.core.read_enemylist_from_files()
    return
  end
  local col1_len = 16
  local col2_len = 35
  local col3_len = 13
  local col4_len = 8
  local col5_len = 13
  local col6_len = 21
  local sum_line_len = col1_len + 1 + col2_len + 1 + col3_len + 1 + col4_len + 1 + col5_len + 1 + col6_len
  
  cecho("\n<white>"..string.title("Obecna lista wrogow rodziny:\n"))
  cecho("\n"..string.rep("-",sum_line_len))
  ra.core.print_enemy_line("<yellow>", "Imie", col1_len, "Opis", col2_len, "Profesja", col3_len, "Gildia", col4_len, "Bron", col5_len, "Poziom", col6_len)
  cecho("\n"..string.rep("-",sum_line_len))
  for k,v in ipairs(ra.tmp.enemies) do
    ra.core.print_enemy_line("<orange>", v["name"], col1_len, v["short"], col2_len, v["profession"], col3_len, v["guild"], col4_len, v["weapon"], col5_len, v["level"], col6_len)
  end
  cecho("\n"..string.rep("-",sum_line_len).."\n\n")

end

function ra.alias.show_ra_enemies_short()
  local s = table.size(ra.tmp.enemies)
  if s == 0 then
    scripts:print_log("Lista wrogow rodziny wydaje sie nie zaladowana. Sprubuje ja zaladowac... po zaladowaniu powtorz komende.")
    ra.core.read_enemylist_from_files()
    return
  end
  local e = "<yellow>Obecni wrogowie rodziny to: <tomato>"
  for k,v in ipairs(ra.tmp.enemies) do
    e = e..v["name"]
    if k < s then
      e = e..", "
    end
  end
  cecho("\n"..e.."\n\n")
end

-- pokazuje skrocona liste wszystkich twoich wrogow
function ra.alias.show_enemies_short()
  local e = "<yellow>Twoi obecni wrogowie to: <tomato>"
  local s = table.size(scripts.people.enemy_people)
  for k,v in ipairs(scripts.people.enemy_people) do
    e = e..v
    if k < s then
      e = e..", "
    end
  end
  cecho("\n"..e.."\n\n")
end


function ra.core.print_enemy_line(color, col1, col1_len, col2, col2_len, col3, col3_len, col4, col4_len, col5, col5_len, col6, col6_len)
  cecho("\n<grey>|"..ra.core.lcstr(color, col1, " ", col1_len))
  cecho("<grey>|"..ra.core.lcstr(color, col2, " ", col2_len))  
  cecho("<grey>|"..ra.core.lcstr(color, col4, " ", col4_len))
  cecho("<grey>|"..ra.core.lcstr(color, col5, " ", col5_len))
  cecho("<grey>|"..ra.core.lcstr(color, col6, " ", col6_len))  
end