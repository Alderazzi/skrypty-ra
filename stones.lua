function ra.core.kill_stone_triggers()
  if stones_trigger_ids ~=nil then
    local arr = stones_trigger_ids
    if not table.is_empty(arr) then
      for k, v in pairs(arr) do
         killTrigger(v)
      end
      if ra.debug then
        cecho("\n<yellow>Usunieto wyzwalacze do kamieni ("..table.size(arr)..").\n") 
      end
    end
  end
end

ra.core.kill_stone_triggers()


stones_info = {}
stones_trigger_ids = {}

stones_info["fioletowy ametyst"] = {"czysta magia [+10]", "ansi_magenta"}
stones_info["fioletowe ametysty"] = {"czysta magia [+10]", "ansi_magenta"}
stones_info["fioletowych ametystow"] = {"czysta magia [+10]", "ansi_magenta"}
stones_info["wielobarwny oliwin"] = {"czysta magia [+20]", "ansi_magenta"}
stones_info["wielobarwne oliwiny"] = {"czysta magia [+20]", "ansi_magenta"}
stones_info["wielobarwnych oliwinow"] = {"czysta magia [+20]", "ansi_magenta"}
stones_info["lazurowy kyanit"] = {"czysta magia [+20]", "ansi_magenta"}
stones_info["lazurowe kyanity"] = {"czysta magia [+20]", "ansi_magenta"}
stones_info["lazurowych kyanitow"] = {"czysta magia [+20]", "ansi_magenta"}
stones_info["skrzacy aleksandryt"] = {"czysta magia [+20]", "ansi_magenta"}
stones_info["skrzace aleksandryty"] = {"czysta magia [+20]", "ansi_magenta"}
stones_info["skrzacych aleksandrytow"] = {"czysta magia [+20]", "ansi_magenta"}
stones_info["wielobarwny labrador"] = {"czysta magia [+10]", "ansi_magenta"}
stones_info["wielobarwne labradory"] = {"czysta magia [+10]", "ansi_magenta"}
stones_info["wielobarwnych labradorow"] = {"czysta magia [+10]", "ansi_magenta"}

stones_info["szaroniebieski granat"] = {"elektrycznosc [+20]", "ansiLightYellow"}
stones_info["szaroniebieskie granaty"] = {"elektrycznosc [+20]", "ansiLightYellow"}
stones_info["szaroniebieskich granatow"] = {"elektrycznosc [+20]", "ansiLightYellow"}
stones_info["wzorzysty onyks"] = {"elektrycznosc [+10]", "ansiLightYellow"}
stones_info["wzorzyste onyksy"] = {"elektrycznosc [+10]", "ansiLightYellow"}
stones_info["wzorzystych onyksow"] = {"elektrycznosc [+10]", "ansiLightYellow"}
stones_info["wielobarwny turmalin"] = {"elektrycznosc [+20]", "ansiLightYellow"}
stones_info["wielobarwne turmaliny"] = {"elektrycznosc [+20]", "ansiLightYellow"}
stones_info["wielobarwnych turmalinow"] = {"elektrycznosc [+20]", "ansiLightYellow"}

stones_info["szmaragdowozielony chryzoberyl"] = {"kwas [+10]", "LawnGreen"}
stones_info["szmaragdowozielone chryzoberyle"] = {"kwas [+10]", "LawnGreen"}
stones_info["szmaragdowozielonych chryzoberylow"] = {"kwas [+10]", "LawnGreen"}
stones_info["zielony diopsyd"] = {"kwas [+20]", "LawnGreen"}
stones_info["zielone diopsydy"] = {"kwas [+20]", "LawnGreen"}
stones_info["zielonych diopsydow"] = {"kwas [+20]", "LawnGreen"}
stones_info["zielonkawy awenturyn"] = {"kwas [+10]", "LawnGreen"}
stones_info["zielonkawe awenturyny"] = {"kwas [+10]", "LawnGreen"}
stones_info["zielonkawych awenturynow"] = {"kwas [+10]", "LawnGreen"}
stones_info["oliwkowozielony serpentyn"] = {"kwas [+10]", "LawnGreen"}
stones_info["oliwkowozielone serpentyny"] = {"kwas [+10]", "LawnGreen"}
stones_info["oliwkowozielonych serpentynow"] = {"kwas [+10]", "LawnGreen"}
stones_info["zoltawozielony szmaragd"] = {"kwas [+20]", "LawnGreen"}
stones_info["zoltawozielone szmaragdy"] = {"kwas [+20]", "LawnGreen"}
stones_info["zoltawozielonych szmaragdow"] = {"kwas [+20]", "LawnGreen"}
stones_info["ciemnozielony malachit"] = {"kwas [+10]", "LawnGreen"}
stones_info["ciemnozielone malachity"] = {"kwas [+10]", "LawnGreen"}
stones_info["ciemnozielonych malachitow"] = {"kwas [+10]", "LawnGreen"}
stones_info["jasnozielony chryzopraz"] = {"kwas [+10]", "LawnGreen"}
stones_info["jasnozielone chryzoprazy"] = {"kwas [+10]", "LawnGreen"}
stones_info["jasnozielonych chryzoprazow"] = {"kwas [+10]", "LawnGreen"}

stones_info["nakrapiany jaspis"] = {"magia smierci [+10]", "DarkSlateGray"}
stones_info["nakrapiane jaspisy"] = {"magia smierci [+10]", "DarkSlateGray"}
stones_info["nakrapianych jaspisow"] = {"magia smierci [+10]", "DarkSlateGray"}
stones_info["czarny gagat"] = {"magia smierci [+10]", "DarkSlateGray"}
stones_info["czarne gagaty"] = {"magia smierci [+10]", "DarkSlateGray"}
stones_info["czarnych gagatow"] = {"magia smierci [+10]", "DarkSlateGray"}
stones_info["szaroczarny hematyt"] = {"magia smierci [+10]", "DarkSlateGray"}
stones_info["szaroczarne hematyty"] = {"magia smierci [+10]", "DarkSlateGray"}
stones_info["szaroczarnych hematytow"] = {"magia smierci [+10]", "DarkSlateGray"}
stones_info["czerwonobrazowy karneol"] = {"magia smierci [+10]", "DarkSlateGray"}
stones_info["czerwonobrazowe karneole"] = {"magia smierci [+10]", "DarkSlateGray"}
stones_info["czerwonobrazowych karneolow"] = {"magia smierci [+10]", "DarkSlateGray"}
stones_info["czarny opal"] = {"magia smierci [+20]", "DarkSlateGray"}
stones_info["czarne opale"] = {"magia smierci [+20]", "DarkSlateGray"}
stones_info["czarnych opali"] = {"magia smierci [+20]", "DarkSlateGray"}

stones_info["bezbarwny ortoklaz"] = {"magia umyslu [+20]", "ansi_light_cyan"}
stones_info["bezbarwne ortoklazy"] = {"magia umyslu [+20]", "ansi_light_cyan"}
stones_info["bezbarwnych ortoklazow"] = {"magia umyslu [+20]", "ansi_light_cyan"}
stones_info["pasiasty fluoryt"] = {"magia umyslu [+10]", "ansi_light_cyan"}
stones_info["pasiaste fluoryty"] = {"magia umyslu [+10]", "ansi_light_cyan"}
stones_info["pasiastych fluorytow"] = {"magia umyslu [+10]", "ansi_light_cyan"}
stones_info["bialy opal"] = {"magia umyslu [+20]", "ansi_light_cyan"}
stones_info["biale opale"] = {"magia umyslu [+20]", "ansi_light_cyan"}
stones_info["bialych opali"] = {"magia umyslu [+20]", "ansi_light_cyan"}
stones_info["zlocisty piryt"] = {"magia umyslu [+10]", "ansi_light_cyan"}
stones_info["zlociste piryty"] = {"magia umyslu [+10]", "ansi_light_cyan"}
stones_info["zlocistych pirytow"] = {"magia umyslu [+10]", "ansi_light_cyan"}
stones_info["bezbarwny diament"] = {"magia umyslu [+20]", "ansi_light_cyan"}
stones_info["bezbarwne diamenty"] = {"magia umyslu [+20]", "ansi_light_cyan"}
stones_info["bezbarwnych diamentow"] = {"magia umyslu [+20]", "ansi_light_cyan"}

stones_info["krwistoczerwony rubin"] = {"ogien [+20]", "red"}
stones_info["krwistoczerwone rubiny"] = {"ogien [+20]", "red"}
stones_info["krwistoczerwonych rubinow"] = {"ogien [+20]", "red"}
stones_info["ognisty agat"] = {"ogien [+10]", "red"}
stones_info["ogniste agaty"] = {"ogien [+10]", "red"}
stones_info["ognistych agatow"] = {"ogien [+10]", "red"}
stones_info["krwisty rodolit"] = {"ogien [+10]", "red"}
stones_info["krwiste rodolity"] = {"ogien [+10]", "red"}
stones_info["krwistych rodolitow"] = {"ogien [+10]", "red"}
stones_info["ciemnoczerwony topaz"] = {"ogien [+30]", "red"}
stones_info["ciemnoczerwone topazy"] = {"ogien [+30]", "red"}
stones_info["ciemnoczerwonych topazow"] = {"ogien [+30]", "red"}
stones_info["zoltawozielony apatyt"] = {"ogien [+20]", "red"}
stones_info["zoltawozielone apatyty"] = {"ogien [+20]", "red"}
stones_info["zoltawozielonych apatytow"] = {"ogien [+20]", "red"}

stones_info["niebieski azuryt"] = {"powietrze [+10]", "LightGoldenrod"}
stones_info["niebieskie azuryty"] = {"powietrze [+10]", "LightGoldenrod"}
stones_info["niebieskich azurytow"] = {"powietrze [+10]", "LightGoldenrod"}
stones_info["purpurowoniebieski lazuryt"] = {"powietrze [+10]", "LightGoldenrod"}
stones_info["purpurowoniebieskie lazuryty"] = {"powietrze [+10]", "LightGoldenrod"}
stones_info["purpurowoniebieskich lazurytow"] = {"powietrze [+10]", "LightGoldenrod"}
stones_info["fioletowy szafir"] = {"powietrze [+20]", "LightGoldenrod"}
stones_info["fioletowe szafiry"] = {"powietrze [+20]", "LightGoldenrod"}
stones_info["fioletowych szafirow"] = {"powietrze [+20]", "LightGoldenrod"}
stones_info["jasnozielony nefryt"] = {"powietrze [+10]", "LightGoldenrod"}
stones_info["jasnozielone nefryty"] = {"powietrze [+10]", "LightGoldenrod"}
stones_info["jasnozielonych nefrytow"] = {"powietrze [+10]", "LightGoldenrod"}

stones_info["niebieskozielony akwamaryn"] = {"woda [+20]", "dodger_blue"}
stones_info["niebieskozielone akwamaryny"] = {"woda [+20]", "dodger_blue"}
stones_info["niebieskozielonych akwamarynow"] = {"woda [+20]", "dodger_blue"}
stones_info["purpurowy iolit"] = {"woda [+20]", "dodger_blue"}
stones_info["purpurowe iolity"] = {"woda [+20]", "dodger_blue"}
stones_info["purpurowych iolitow"] = {"woda [+20]", "dodger_blue"}
stones_info["czarna perla"] = {"woda [+30]", "dodger_blue"}
stones_info["czarna perle"] = {"woda [+30]", "dodger_blue"}
stones_info["czarne perly"] = {"woda [+30]", "dodger_blue"}
stones_info["czarnych perel"] = {"woda [+30]", "dodger_blue"}
stones_info["biala perla"] = {"woda [+20]", "dodger_blue"}
stones_info["biala perle"] = {"woda [+20]", "dodger_blue"}
stones_info["biale perly"] = {"woda [+20]", "dodger_blue"}
stones_info["bialych perel"] = {"woda [+20]", "dodger_blue"}

stones_info["zoltawobrazowy monacyt"] = {"ziemia [+10]", "orange_red"}
stones_info["zoltawobrazowe monacyty"] = {"ziemia [+10]", "orange_red"}
stones_info["zoltawobrazowych monacytow"] = {"ziemia [+10]", "orange_red"}
stones_info["lilioworozowy spinel"] = {"ziemia [+20]", "orange_red"}
stones_info["lilioworozowe spinele"] = {"ziemia [+20]", "orange_red"}
stones_info["lilioworozowych spineli"] = {"ziemia [+20]", "orange_red"}
stones_info["bezbarwny gorski krysztal"] = {"ziemia [+10]", "orange_red"}
stones_info["bezbarwne gorskie krysztaly"] = {"ziemia [+10]", "orange_red"}
stones_info["bezbarwnych gorskich krysztalow"] = {"ziemia [+10]", "orange_red"}
stones_info["brazowy tytanit"] = {"ziemia [+30]", "orange_red"}
stones_info["brazowe tytanity"] = {"ziemia [+30]", "orange_red"}
stones_info["brazowych tytanitow"] = {"ziemia [+30]", "orange_red"}
stones_info["szary obsydian"] = {"ziemia [+10]", "orange_red"}
stones_info["szare obsydiany"] = {"ziemia [+10]", "orange_red"}
stones_info["szarych obsydianow"] = {"ziemia [+10]", "orange_red"}
stones_info["brazowy kwarc"] = {"ziemia [+10]", "orange_red"}
stones_info["brazowe kwarce"] = {"ziemia [+10]", "orange_red"}
stones_info["brazowych kwarcow"] = {"ziemia [+30]", "orange_red"}

stones_info["niebieski turkus"] = {"zimno [+10]", "ansi_cyan"}
stones_info["niebieskie turkusy"] = {"zimno [+10]", "ansi_cyan"}
stones_info["niebieskich turkusow"] = {"zimno [+10]", "ansi_cyan"}
stones_info["niebieskawy zoisyt"] = {"zimno [+20]", "ansi_cyan"}
stones_info["niebieskawe zoisyty"] = {"zimno [+20]", "ansi_cyan"}
stones_info["niebieskawych zoisytow"] = {"zimno [+20]", "ansi_cyan"}
stones_info["blekitny almandyn"] = {"zimno [+20]", "ansi_cyan"}
stones_info["blekitne almandyny"] = {"zimno [+20]", "ansi_cyan"}
stones_info["blekitnych almandynow"] = {"zimno [+20]", "ansi_cyan"}

stones_info["jasnozloty heliodor"] = {"magia zycia", "GhostWhite"}
stones_info["jasnozlote heliodory"] = {"magia zycia", "GhostWhite"}
stones_info["jasnozlotych heliodorow"] = {"magia zycia", "GhostWhite"}
stones_info["zolty cyrkon"] = {"magia zycia", "GhostWhite"}
stones_info["zolte cyrkony"] = {"magia zycia", "GhostWhite"}
stones_info["zoltych cyrkonow"] = {"magia zycia", "GhostWhite"}
stones_info["zolty celestyn"] = {"magia zycia", "GhostWhite"}
stones_info["zolte celestyny"] = {"magia zycia", "GhostWhite"}
stones_info["zoltych celestynow"] = {"magia zycia", "GhostWhite"}
stones_info["zoltawobrazowy bursztyn"] = {"magia zycia", "GhostWhite"}
stones_info["zoltawobrazowe bursztyny"] = {"magia zycia", "GhostWhite"}
stones_info["zoltawobrazowych bursztynow"] = {"magia zycia", "GhostWhite"}
stones_info["rozowy rodochrozyt"] = {"magia zycia", "GhostWhite"}
stones_info["rozowe rodochrozyty"] = {"magia zycia", "GhostWhite"}
stones_info["rozowych rodochrozytow"] = {"magia zycia", "GhostWhite"}
stones_info["jaskrawozolty cytryn"] = {"magia zycia", "GhostWhite"}
stones_info["jaskrawozolte cytryny"] = {"magia zycia", "GhostWhite"}
stones_info["jaskrawozoltych cytrynow"] = {"magia zycia", "GhostWhite"}

function ra.core.create_stones_triggers()
  local arr = stones_info
  if table.is_empty(arr) then
    return false
  end
  local id = 0
  ra.core.kill_stone_triggers()
  for k, v in pairs(arr) do
     local name = k
     local mask = v[1]
     local color = v[2]
     id = tempTrigger(""..name.."", [[ra.core.mask_stone("]]..name..[[","]]..mask..[[","]]..color..[[")]])
     table.insert(stones_trigger_ids, id)
  end
  if ra.debug then
    cecho("\n<yellow>Utworzono wyzwalacze do kamieni ("..table.size(arr)..").\n") 
  end
end 

function ra.core.mask_stone(name, mask, color) 
  selectString(name, 1)
  replace(name ..  " ("..mask..")", true)
  fg("ansiLightBlack")
  deselect()
  selectString(" ("..mask..")", 1)
  fg(color)
  deselect()
  resetFormat()
end

function ra.alias.show_stone_info()
  cecho("\n\n\t<yellow>Dostepne informacje o kamieniach i ich wlasciwosciach:\n\n")
  local arr = stones_info
  for k, v in pairs(arr) do
     local name = k
     local mask = v[1]
     local color = v[2]
     cecho("\n <MediumSeaGreen> - "..name.." <"..color..">"..mask )
    
  end
 cecho("\n\n")
end

function misc:value_stones()
    misc["stones_value"] = 0
    misc["weigth_stones"] = 0
    misc["valuing_stones"] = true
    send("ocen kamienie", false)
    tempTimer(0.7, [[ misc:print_stones_value() ]])
end

function misc:add_stone_weigth()
  if misc["weigth_stones"] >= 0 then
      misc["weigth_stones"] = misc["weigth_stones"] + tonumber(matches[3])
  else
    misc["weigth_stones"] = 0
  end
end

function misc:print_stones_value()
  local money_str = misc:get_valued_string(misc["stones_value"])
  misc["stones_value"] = nil
  scripts:print_log("Kamienie sa warte:" .. money_str)
  if misc["weigth_stones"] > 0 then
    scripts:print_log("Kamienie waza: " .. misc["weigth_stones"].. " g, czyli "..(misc["weigth_stones"]/1000).." kg.")
  end
  misc["weigth_stones"] = nil
  misc["valuing_stones"] = nil
end