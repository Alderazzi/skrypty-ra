function alias_func_put_magics_down_ra()
    scripts.inv.magic_put_down_coroutine = coroutine.create(function ()
        scripts.inv:get_magics_to_put_down_ra(matches[3])
    end)
    coroutine.resume(scripts.inv.magic_put_down_coroutine)
end

function scripts.inv:get_magics_to_put_down_ra(container)
    local chosen_container = container or "skrzyni"
    self.magic_items_in_inventory = {
        triggers = {},
        items = {}
    }
    for key, properties  in pairs(scripts.inv.magics_data.magics) do
        for _, item in pairs(properties.regexps) do
            table.insert(self.magic_items_in_inventory.triggers, tempRegexTrigger(self:get_magic_item_pattern(item),
                    function() self.magic_items_in_inventory.items[item] = item end))
        end
    end
    table.insert(self.magic_items_in_inventory.triggers, tempRegexTrigger("Masz przy sobie|Nie masz nic przy sobie", function() coroutine.resume(scripts.inv.magic_put_down_coroutine) end))
    send("i")
    coroutine.yield(scripts.inv.magic_put_down_coroutine)
    for k, trigger in pairs(self.magic_items_in_inventory.triggers) do
        killTrigger(trigger)
    end

    if table.size(self.magic_items_in_inventory.items) > 0 then
        local command = ""
        
        local id_inne = 15923
        local id_bronie = 15926
        local id_zbroje = 15925
        
        local types_inne = {
          "bransoleta",
          "broszka",
          "buty",
          "inne",
          "kolczyk",
          "naszyjnik",
          "opaska",
          "pas",
          "pierscien",
          "plaszcz",
          "plecak",
          "pojemnik"
        }

        local types_bronie = {
          "dwureczna bron drzewcowa",
          "dwureczna maczuga",
          "dwureczny mlot",
          "jednoreczna bron drzewcowa",
          "jednoreczna maczuga",
          "jednoreczny miecz",
          "jednoreczny mlot",
          "jednoreczny topor",
          "miecz dwureczny",
          "miecz jednoreczny",
          "sztylet"
                
        }

        local types_zbroje = {
          "ciezka zbroja",
          "helm",
          "lekka zbroja",
          "naramienniki",
          "srednia zbroja",
          "tarcza"
        }
        
        local check_magic_item = false    
        
        for k, item in pairs(self.magic_items_in_inventory.items) do
            if self.get_magics_to_put_down_exempts[item] ~= nil then
              item = self.get_magics_to_put_down_exempts[item]
            end
            local item_mianownik = scripts.inv:get_magic_item_mianownik(item)
            check_magic_item = false

            if amap.curr.id == id_zbroje then  
              --display("Lokacja na magiczne zbroje.")      
              check_magic_item = scripts.inv:check_magic_item(item_mianownik, types_zbroje)
            elseif amap.curr.id == id_bronie then
              --display("Lokacja na magiczne bronie.")
              check_magic_item = scripts.inv:check_magic_item(item_mianownik, types_bronie)
            elseif amap.curr.id == id_inne then
              --display("Lokacja na rozny sprzet magiczny.")
              check_magic_item = scripts.inv:check_magic_item(item_mianownik, types_inne)
            end
            if item and string.len(check_magic_item) > 0 then
                command = command .. "wloz " .. item .. " do ".. chosen_container .. ";"
            end
        end
        if command ~= "" then
            scripts.utils.bind_functional(command, false, true)
        end
    end
    self.magic_items_in_inventory = nil
end

function scripts.inv:get_magic_item_mianownik(dopelniacz_item)
  for k, v in pairs(scripts.inv.magics_data.magics) do
    for k1, v1 in pairs(v["regexps"]) do
      if v1 == dopelniacz_item then
        return k
      end
      
    end
  end
  display("nie znaleziono przedmiotu "..dopelniacz_item.." na magicznej liscie")
end


function scripts.inv:check_magic_item(item, magic_item_types)
    local ret = ""
    for k, t in pairs(magic_item_types) do
      local tt = scripts.inv.magics_data.magics[item]["type"]
      for k2, t2 in pairs(tt) do
        if t2 == t then
          ret = t
        end
      end
    end
    return ret
end

function scripts.inv:magic_worn_off(message, type)
  creplaceLine("<tomato>\n\n\t[  MAGIK ZNIKA   ] " .. message .. "\n\n")
  resetFormat()

  raiseEvent("playBeep")
  scripts.ui:info_action_update("ZNI. " .. type)    
  
  local user = "ra scripts"
  if gmcp ~= nil and gmcp.char ~= nil and gmcp.char.info ~= nil and gmcp.char.info.name ~= nil then
    user = gmcp.char.info.name
  end

  local url = ra.dc_webhook_puf
  local content = message.." "..os.date('%d.%m.%Y %H:%M:%S', getEpoch()).." ("..user..")\n"

  local data = {
    content = content,
    user = "Benicjo"
  }
   
  local header = {
    ["Content-Type"] = "application/json",
  }
  ra.core.postJSON(url,data,header)
  scripts:print_log("Dodano znikniecie magika na DC Alderazzi.")    
end