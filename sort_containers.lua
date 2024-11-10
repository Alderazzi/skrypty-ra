ra.equipment = ra.equipment or {
  handler = nil
}

function ra.equipment:init()
  self.handler = scripts.event_register:register_singleton_event_handler(self.handler, "equipment_ra", function(_, equipment)
      self:evaluate(equipment)
  end)
end

function ra.equipment:init2()
  if scripts.event_handlers["equipment_ra"] then
      killAnonymousEventHandler(scripts.event_handlers["equipment_ra"])
  end
  ra.tmp.equipment = {}
  scripts.event_handlers["equipment_ra"] = registerAnonymousEventHandler("equipment_ra", 
    function(_, equipment) ra.equipment:add_trigger_result(equipment) end
  )    
end

function ra.equipment:evaluate(equipment)
  local value_keys = {
      "wywazenie",
      "obrazenia",
      "klute",
      "obuchowe",
      "ciete",
      "parowanie"
  }

  if equipment.typSprzetu == "puklerz" then
      return
  end
  local sum, count = 0, 0
  for _, value_key in pairs(value_keys) do
      if equipment[value_key] and equipment[value_key].value then
          sum = sum + equipment[value_key].value
          count = count + 1
      end
  end
  echo("\n\n")
  cecho("<light_slate_blue>" .. string.sub(" Suma: <grey>" .. sum .. "                                            ", 0, 50))
  cecho("<light_slate_blue> " .. string.sub("Srednia: <grey>" .. round(sum / count, 2) .. "                                 ", 0, 50))
end

function ra.equipment:sort()
  local nr = 0
  for k,v in pairs(ra.tmp.equipment) do
    --display(type(v))
    cecho("\n")
    if type(v) == "table" then
      for kk,vv in pairs(v) do
        if type(vv) == "table" then
          cecho(kk.."poziom: "..vv.value.."\n")
        end
      end
    else
      if k%2 == 1 then
        nr = nr + 1
      else
        cecho("przedmiot nr: "..nr.." "..v.."\n")
      end
    end
  end
end

function ra.equipment:add_trigger_result(obj)
  display("add_trigger_result")
  table.insert(ra.tmp.equipment, obj)
end

function ra.equipment:trigger()
    display("ra.equipment:trigger")
    ra.equipment:add_trigger_result(matches)
end
