ra.detox["chorobe zakazna"] = {}
ra.detox["chorobe zakazna"]["bylica_cytwarowa"] = "wetrzyj"
ra.detox["chorobe zakazna"]["bylica_piolun"] = "wetrzyj"
ra.detox["chorobe zakazna"]["bez"] = "przezuj"
ra.detox["chorobe zakazna"]["krzyzownica"] = "przezuj"
ra.detox["chorobe zakazna"]["czosnek"] = "wetrzyj"
ra.detox["chorobe zakazna"]["ususzony_czosnek"] = "wetrzyj"
ra.detox["chorobe zakazna"]["szalwia"] = "przyloz"

ra.detox["chorobe skory"] = {}
ra.detox["chorobe skory"]["rumianek"] = "przyloz"
ra.detox["chorobe skory"]["lukrecja"] = "przyloz"
ra.detox["chorobe skory"]["nawloc"] = "przyloz"
ra.detox["chorobe skory"]["ususzony_starzec"] = "sproszkuj"
ra.detox["chorobe skory"]["deren"] = "przezuj"
ra.detox["chorobe skory"]["ususzony_przelot"] = "sproszkuj"
ra.detox["chorobe skory"]["ususzony_jaskier"] = "rozkrusz"

ra.detox["gadzi jad"] = {}
ra.detox["gadzi jad"]["centuria"] = "zjedz"
ra.detox["gadzi jad"]["rdest_wezownik"] = "przezuj"
ra.detox["gadzi jad"]["krzyzownica"] = "przezuj"
ra.detox["gadzi jad"]["pieciornik"] = "przezuj"
ra.detox["gadzi jad"]["barwinek"] = "zjedz"
ra.detox["gadzi jad"]["rauwolfia"] = "przezuj"
ra.detox["gadzi jad"]["ususzona_mandragora"] = "przyloz"
ra.detox["gadzi jad"]["siezygron"] = "rozgryz"
ra.detox["gadzi jad"]["ususzona_boldoa"] = "rozkrusz"

ra.detox["jad insekta"] = {}
ra.detox["jad insekta"]["chaber"] = "przezuj"
ra.detox["jad insekta"]["pieciornik"] = "przezuj"
ra.detox["jad insekta"]["barwinek"] = "zjedz"
ra.detox["jad insekta"]["ususzona_mandragora"] = "przezuj"
ra.detox["jad insekta"]["nostrzyk"] = "przezuj"
ra.detox["jad insekta"]["siezygron"] = "rozgryz"
ra.detox["jad insekta"]["ususzona_macznica"] = "rozgryz"
ra.detox["jad insekta"]["ususzona_boldoa"] = "rozkrusz"

ra.detox["toksyna roslinna"] = {}
ra.detox["toksyna roslinna"]["chaber"] = "przezuj"
ra.detox["toksyna roslinna"]["pieciornik"] = "przezuj"
ra.detox["toksyna roslinna"]["ususzona_mandragora"] = "rozkrusz"
ra.detox["toksyna roslinna"]["nostrzyk"] = "przezuj" -- zjedz ?
ra.detox["toksyna roslinna"]["siezygron"] = "rozgryz"
ra.detox["toksyna roslinna"]["ususzona_boldoa"] = "rozkrusz"

ra.detox["chorobe ukladu pokarmowego"] = {}
ra.detox["chorobe ukladu pokarmowego"]["rumianek"] = "powachaj"
ra.detox["chorobe ukladu pokarmowego"]["centuria"] = "zjedz"
ra.detox["chorobe ukladu pokarmowego"]["nawloc"] = "rozgryz"
ra.detox["chorobe ukladu pokarmowego"]["bez"] = "przezuj"
ra.detox["chorobe ukladu pokarmowego"]["ususzona_mandragora"] = "rozkrusz"
ra.detox["chorobe ukladu pokarmowego"]["nostrzyk"] = "przezuj"
ra.detox["chorobe ukladu pokarmowego"]["ususzona_boldoa"] = "rozkrusz"
ra.detox["chorobe ukladu pokarmowego"]["dziewanna"] = "zjedz"
ra.detox["chorobe ukladu pokarmowego"]["szczaw"] = "przezuj"

ra.detox["chorobe pluc"] = {}
ra.detox["chorobe pluc"]["chaber"] = "powachaj"
ra.detox["chorobe pluc"]["plucnica"] = "sproszkuj"
ra.detox["chorobe pluc"]["dziewanna"] = "zjedz"

ra.detox["pasozyty"] = {}
ra.detox["pasozyty"]["bagno"] = "przyloz"
ra.detox["pasozyty"]["bylica_cytwarowa"] = "wetrzyj"
ra.detox["pasozyty"]["bylica_piolun"] = "wetrzyj"
ra.detox["pasozyty"]["wrotycz"] = "przyloz"

ra.detox["kac"] = {}
ra.detox["kac"]["tojad"] = "przyloz"
ra.detox["kac"]["ususzona_rosiczka"] = "polknij"
ra.detox["kac"]["bulawinka"] = "przezuj"

ra.detox["ogolne odtrucie"] = {}
ra.detox["ogolne odtrucie"]["ranog"] = "zjedz"
ra.detox["ogolne odtrucie"]["ususzony_ranog"] = "zjedz"

function ra.core.get_amount_by_herbname(name)
  if herbs.counts[name] == nil then
    return 0
  else
    return herbs.counts[name]
  end
end

function ra.core.print_detox_scope(scope_name, scope, show_only_have)
  
  cecho("\n<green>  "..string.title(scope_name)..":\n")
  
  for k,v in pairs(scope) do
    local to_use = ra.core.get_amount_by_herbname(k)
    if to_use == 0 then
      if show_only_have == false then
        cecho ("   /z_"..v.." "..k.." 1 - dostepna ilosc: 0\n")
      end
    else
      cecho("   ")
      local use_str = "/z_"..v.." "..k.." 1"
      cechoLink("<light_slate_blue>"..use_str, function () expandAlias(use_str) end, use_str, true)   
      cecho(" lub ")
      local get_str = "/wezz "..k.." 1"
      cechoLink("<light_slate_blue>"..get_str, function () expandAlias(get_str) end, get_str, true)   
      cecho(" - dostepna ilosc; "..to_use.."\n")
    end
  end
  cecho("\n")
end

function ra.core.print_detox_list(show_only_have)
  cecho("\n<green> Tymi ziolami mozesz sprobowac uleczyc nastepujace dolegliwosci:\n")
  for k,v in spairs(ra.detox) do
    ra.core.print_detox_scope(k, v, show_only_have)
  end
end

function ra.core.print_detox_list_leprosy(show_only_have)
  cecho("\n<green> Tymi ziolami mozesz sprobowac uleczyc trad i zwiazane z nim choroby:\n")
  for k,v in spairs(ra.detox) do
    if k == "chorobe zakazna" or k == "chorobe skory" then
      ra.core.print_detox_scope(k, v, show_only_have)
    end
  end
end
