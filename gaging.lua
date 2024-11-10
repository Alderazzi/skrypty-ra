--- ZASLONY

function trigger_func_skrypty_ui_gags_color_color_zaslony_udane_zaslania_kogos()
  if scripts.gags:delete_line("zaslony_udane") then
      return
  end
  
  local ktoa = string.split(matches[3], " zrecznie")
  local atmp = string.split(ktoa[1], " ")
  local kto = ktoa[1]
  if table.size(atmp) > 1 then
    kto = atmp[table.size(atmp)]
  end
  local kogo = matches[4]
  local team = ra.core.check_name_in_team(kto)
  
  if kogo == "cie" then
    kogo = "ciebie"
  end 
  
  local przed = "toba"
  if table.size(matches) == 5 then
    przed = matches[5]
  end
  
  if team then -- udane zaslony druzyny
    creplaceLine("<" .. ra.colors["ktos_z_druzyny_zaslonil"].. ">\n\n[  ZASLANIA  ] " .. kto .. " -> " .. kogo .. " <- ".. przed.. ".\n\n\n")
  else  -- udane zaslony przeciwnikow
    if przed == "toba" then
      creplaceLine("<" .. ra.colors["ktos_z_przeciwnikow_zaslonil_przed_toba"] .. ">\n\n[  ZASLANIA  ] " .. kto .. " -> " .. kogo .. " <- ".. przed.. ".\n".."<" .. ra.colors["info_lamanie"] .. ">[  --------  ] NIE LAMAC!!!\n\n\n")
    else
      creplaceLine("<" .. ra.colors["ktos_z_przeciwnikow_zaslonil_przed_druzyna"] .. ">\n\n[  ZASLANIA  ] " .. kto .. " -> " .. kogo .. " <- ".. przed.. ".\n\n\n")
      scripts.utils.echobind("przelam obrone celu ataku", nil, "przelam obrone celu ataku", "break_attack_target", 0) -- bind na lamanie celu
    end    
  end     
  resetFormat()
end


function trigger_func_skrypty_ui_gags_color_color_zaslony_udane_zaslaniasz_ty()
  if scripts.gags:delete_line("zaslony_udane") then
    return
  end

  local kto = "Ty"
  local kogo = matches[3]
  local przed = matches[4]
  
  creplaceLine("<" .. ra.colors["twoja_udana_zaslona"] .. ">\n\n[ ZASLANIASZ ] " .. kto .. " -> " .. kogo .. " <- ".. przed.. ".\n\n\n")
  resetFormat()
end


function trigger_func_skrypty_ui_gags_color_color_zaslony_udane_wycofanie_za_ciebie()
  if scripts.gags:delete_line("zaslony_udane") then
    return
  end

  scripts.gags:gag_prefix(" WYC ZA CIE ", "zaslony_udane")
end

function trigger_func_skrypty_ui_gags_color_color_zaslony_udane_wycofanie_sie_ty()
  if scripts.gags:delete_line("zaslony_udane") then
    return
  end
  
  scripts.gags:gag_prefix(" WYCOFUJESZ ", "zaslony_udane")
end

function trigger_func_skrypty_ui_gags_color_color_zaslony_nieudane_nie_zaslaniasz_ty()
  if scripts.gags:delete_line("zaslony_nieudane") then
    return
  end
    
  local kto = "Ty"
  local kogo = matches[3]
  local przed = matches[4]    
     
  creplaceLine("\n\n<" .. ra.colors["twoja_nieudana_zaslona"] .. ">[N ZASLANIASZ] " .. kto .. " -> " .. kogo .. " <- ".. przed.. ".\n\n\n")
  resetFormat()
end

function trigger_func_skrypty_ui_gags_color_color_zaslony_nieudane_nie_zaslania_kogos()
  if scripts.gags:delete_line("zaslony_nieudane") then
    return
  end
  
  local ktoa = {}
  local kto = ""
  local kogo = ""
  local przed = ""
  
  if table.size(matches) == 3 then
    ktoa = string.split(matches[1], " probuje zaslonic ")
    kto = ktoa[1]
    ktoa = string.split(ktoa[2], " przed")
    kogo = ktoa[1]
    przed = "toba"
  else
    ktoa = string.split(matches[3], " zrecznie")
    kto = ktoa[1]
    kogo = matches[4]
    przed = matches[5]
  end
  
  if kogo == "cie" then
    kogo = "ciebie"
  end 
  
  local team = ra.core.check_name_in_team(kto)
      
  if team then
    creplaceLine("\n\n<" .. ra.colors["ktos_z_druzyny_niezaslonil"] .. ">[ N ZASLANIA ] " .. kto .. " -> " .. kogo .. " <- ".. przed.. ".\n\n\n")
  else
    creplaceLine("\n\n<" .. ra.colors["ktos_z_przeciwnikow_niezaslonil"] .. ">[ N ZASLANIA ] " .. kto .. " -> " .. kogo .. " <- ".. przed.. ".\n\n\n")
  end
  
  resetFormat()
end

function trigger_func_skrypty_ui_gags_color_color_zaslony_nieudane_nie_wycofanie_ty()
  if scripts.gags:delete_line("zaslony_nieudane") then
    return
  end
  local kto = "Ty"
     
  selectCurrentLine()
  local str_replace = "\n\n[ NIE WYCOFU ] "
  prefix(str_replace)
  if selectString(str_replace, 1) > -1 then
    fg(scripts.gag_colors["zaslony_nieudane"])
  end
  resetFormat()
end

--- WYTRACENIE

function trigger_func_skrypty_ui_gags_color_color_other_wytracenie_tobie()
  raiseEvent("playBeep")
  raiseEvent("weaponKnockedOff")
  raiseEvent("weapon_state", false)
  creplaceLine("\n\n<" .. ra.colors["wytracono_ci_bron"] .. ">[    BRON     ] " .. matches[2] .. "\n\n\n")
  resetFormat()
  scripts.ui:info_action_update("WYTRACENIE")
end
    
--- PRZELAMANIA

function trigger_func_skrypty_ui_gags_color_color_other_przelamanie()
  local kto = matches[3]
  local kogo = matches[4]
  local team = ra.core.check_name_in_team(kto)
  
  if team then
    creplaceLine("\n\n<" .. ra.colors["ktos_z_druzyny_przelamal"] .. ">[ KTOS LAMIE ] " .. kto .. " -> "..kogo..".\n\n\n")
  else
    creplaceLine("\n\n<" .. ra.colors["ktos_z_przeciwnikow_przelamal"] .. ">[ KTOS LAMIE ] " .. kto .. " -> "..kogo..".\n\n\n")
  end
  ateam:may_setup_broken_defense(matches[4])
  resetFormat()

  if team then
    scripts.utils.echobind("zabij cel ataku", nil, "zabij cel ataku", "attack_target", 0) --- bind na atakowanie celu
  end
end

function trigger_func_skrypty_ui_gags_color_color_other_przelamanie_ty()
  local kogo = matches[3]
  local kto = "Ty"
  local team = true
  
  creplaceLine("\n\n<" .. ra.colors["twoje_udane_przelamanie"] .. ">[ TY LAMIESZ ] " .. kto .. " -> "..kogo..".\n\n\n")
  ateam:may_setup_broken_defense(matches[3])
  resetFormat()
end

function trigger_func_skrypty_ui_gags_color_color_other_nie_przelamanie_ty()
  local a = string.split(matches[2], ",")
  local a2 = string.split(a[1], "Bezskutecznie rzucasz sie na ")
  local kogo = tostring(a2[2])
  local kto = "Ty"

  creplaceLine("\n\n<" .. ra.colors["twoje_nieudane_przelamanie"] .. ">[ N LAMIESZ  ] " .. kto .. " -> "..kogo..".\n\n\n")
  resetFormat()
end

function trigger_func_skrypty_ui_gags_color_color_other_nie_przelamanie()
  local a = string.split(matches[2], ",")
  local a2 = string.split(a[1], " rzuca sie na ")
  local kto = tostring(a2[1])   
  local team = ra.core.check_name_in_team(kto)
  local kogo = tostring(a2[2])
  
  if team then
    creplaceLine("\n\n<" .. ra.colors["ktos_z_druzyny_nieprzelamal"] .. ">[ NIE LAMIE  ] " .. kto .. " -> "..kogo..".\n\n\n")
  else
    creplaceLine("\n\n<" .. ra.colors["ktos_z_przeciwnikow_nieprzelamal"] .. ">[ NIE LAMIE  ] " .. kto .. " -> "..kogo..".\n\n\n")
  end
  resetFormat()
end



function ra.core.check_name_in_team(name)
  if ateam.team_names[name] == true or ateam.team_names[string.lower(name)] == true or string.lower(name) == "twoja" or string.lower(name) == "ty" then
    return true
  end
  return false
end

function ra.core.kill_bottle_triggers()
  if bottle_trigger_ids ~=nil then
    local arr = bottle_trigger_ids
    if not table.is_empty(arr) then
      for k, v in pairs(arr) do
         killTrigger(v)
      end
      if ra.debug then
        cecho("\n<yellow>Usunieto wyzwalacze do flakonikow ("..table.size(arr)..").\n") 
      end
    end
  end
end

bottle_trigger_ids = {}
bottle_info = {}

ra.core.kill_bottle_triggers()

bottle_info["bialy trojkatny flakonik"] = {"+reg mana", "dodger_blue"}
bottle_info["bialy kwadratowy flakonik"] = {"+reg mana", "dodger_blue"}
bottle_info["bialy pieciokatny flakonik"] = {"+reg mana", "dodger_blue"}
bottle_info["bialy szesciokatny flakonik"] = {"+reg mana", "dodger_blue"}
bottle_info["bialy okragly flakonik"] = {"+reg mana", "dodger_blue"}
bottle_info["bialy maly flakonik"] = {"+reg mana", "dodger_blue"}

bottle_info["srebrny trojkatny flakonik"] = {"+reg zmc", "LightGoldenrod"}
bottle_info["srebrny kwadratowy flakonik"] = {"+reg zmc", "LightGoldenrod"}
bottle_info["srebrny pieciokatny flakonik"] = {"+reg zmc", "LightGoldenrod"}
bottle_info["srebrny szesciokatny flakonik"] ={"+reg zmc", "LightGoldenrod"}
bottle_info["srebrny okragly flakonik"] = {"+reg zmc", "LightGoldenrod"}
bottle_info["srebrny maly flakonik"] = {"+reg zmc", "LightGoldenrod"}

bottle_info["puprpurowy trojkatny flakonik"] = {"+odp spaczen", "DarkSlateGray"}
bottle_info["puprpurowy kwadratowy flakonik"] = {"+odp spaczen", "DarkSlateGray"}
bottle_info["puprpurowy pieciokatny flakonik"] = {"+odp spaczen", "DarkSlateGray"}
bottle_info["puprpurowy szesciokatny flakonik"] = {"+odp spaczen", "DarkSlateGray"}
bottle_info["puprpurowy okragly flakonik"] = {"+odp spaczen", "DarkSlateGray"}
bottle_info["puprpurowy maly flakonik"] = {"+odp spaczen", "DarkSlateGray"}

bottle_info["niebieski trojkatny flakonik"] = {"+odtr", "LightGoldenrod"}
bottle_info["niebieski kwadratowy flakonik"] = {"+odtr", "LightGoldenrod"}
bottle_info["niebieski pieciokatny flakonik"] = {"+odtr", "LightGoldenrod"}
bottle_info["niebieski szesciokatny flakonik"] = {"+odtr", "LightGoldenrod"}
bottle_info["niebieski okragly flakonik"] = {"+odtr", "LightGoldenrod"}
bottle_info["niebieski maly flakonik"] = {"+odtr", "LightGoldenrod"}

bottle_info["czerwony trojkatny flakonik"] = {"+wyt", "ansi_light_cyan"}
bottle_info["czerwony kwadratowy flakonik"] = {"+wyt", "ansi_light_cyan"}
bottle_info["czerwony pieciokatny flakonik"] = {"+wyt", "ansi_light_cyan"}
bottle_info["czerwony szesciokatny flakonik"] = {"+wyt", "ansi_light_cyan"}
bottle_info["czerwony okragly flakonik"] = {"+wyt", "ansi_light_cyan"}
bottle_info["czerwony maly flakonik"] = {"+wyt", "ansi_light_cyan"}

bottle_info["zielony trojkatny flakonik"] = {"+zr [+2]", "orange_red"}
bottle_info["zielony kwadratowy flakonik"] = {"+zr [+2]", "orange_red"}
bottle_info["zielony pieciokatny flakonik"] = {"+zr [+2]", "orange_red"} 
bottle_info["zielony szesciokatny flakonik"] = {"+zr [+2]", "orange_red"}
bottle_info["zielony okragly flakonik"] = {"+zr [+2]", "orange_red"}
bottle_info["zielony maly flakonik"] = {"+zr [+2]", "orange_red"}

bottle_info["pomaranczowy trojkatny flakonik"] = {"+reg hp", "red"}
bottle_info["pomaranczowy kwadratowy flakonik"] = {"+reg hp", "red"}
bottle_info["pomaranczowy pieciokatny flakonik"] = {"+reg hp", "red"}
bottle_info["pomaranczowy szesciokatny flakonik"] = {"+reg hp", "red"}
bottle_info["pomaranczowy okragly flakonik"] = {"+reg hp", "red"}
bottle_info["pomaranczowy maly flakonik"] = {"+reg hp", "red"}

bottle_info["zolty trojkatny flakonik"] = {"+sila", "olive_drab"}
bottle_info["zolty kwadratowy flakonik"] = {"+sila", "olive_drab"}
bottle_info["zolty pieciokatny flakonik"] = {"+sila", "olive_drab"}
bottle_info["zolty szesciokatny flakonik"] = {"+sila", "olive_drab"}
bottle_info["zolty okragly flakonik"] = {"+sila", "olive_drab"}
bottle_info["zolty maly flakonik"] = {"+sila", "olive_drab"}

bottle_info["szmaragdowy trojkatny flakonik"] = {"+zimno", "deep_sky_blue"}
bottle_info["szmaragdowy kwadratowy flakonik"] = {"+zimno", "deep_sky_blue"}
bottle_info["szmaragdowy pieciokatny flakonik"] = {"+zimno", "deep_sky_blue"}
bottle_info["szmaragdowy szesciokatny flakonik"] = {"+zimno", "deep_sky_blue"}
bottle_info["szmaragdowy okragly flakonik"] = {"+zimno", "deep_sky_blue"}
bottle_info["szmaragdowy maly flakonik"] = {"+zimno", "deep_sky_blue"}

bottle_info["czarny trojkatny flakonik"] = {"+oparzenia", "yellow"}
bottle_info["czarny kwadratowy flakonik"] = {"+oparzenia", "yellow"}
bottle_info["czarny pieciokatny flakonik"] = {"+oparzenia", "yellow"}
bottle_info["czarny szesciokatny flakonik"] = {"+oparzenia", "yellow"}
bottle_info["czarny okragly flakonik"] = {"+oparzenia", "yellow"}
bottle_info["czarny maly flakonik"] = {"+oparzenia", "yellow"}

function ra.core.create_bottle_triggers()
  local arr = bottle_info
  if table.is_empty(arr) then
    return false
  end
  local id = 0
  ra.core.kill_bottle_triggers()
  for k, v in pairs(arr) do
     local name = k
     local mask = v[1]
     local color = v[2]
     id = tempTrigger(""..name.."", [[ra.core.mask_bottle("]]..name..[[","]]..mask..[[","]]..color..[[")]])
     table.insert(bottle_trigger_ids, id)
  end
  if ra.debug then
    cecho("\n<yellow>Utworzono wyzwalacze do flakonikow ("..table.size(arr)..").\n") 
  end
end 

function ra.core.mask_bottle(name, mask, color) 
  selectString(name, 1)
  replace(name ..  " ("..mask..")", true)
  fg(scripts.inv.magics_color)
  deselect()
  selectString(" ("..mask..")", 1)
  fg(color)
  deselect()
  resetFormat()
end

function ra.alias.show_bottle_info()
  cecho("\n\n\t<yellow>Dostepne informacje o flakonikach i ich wlasciwosciach:\n")
  local arr = bottle_info
  for k, v in spairs(arr) do
     local name = k
     local mask = v[1]
     local color = v[2]
     cecho("\n <MediumSeaGreen> - "..name.." <"..color..">"..mask )
    
  end
 cecho("\n\n")
end