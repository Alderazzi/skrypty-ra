function ra.alias.wyczysc_historie_kosztow()
  ra.tmp.money = {}
  cecho("\n<yellow>Wyczyszczono historie sprzedazy.\n")
end

function ra.alias.pokaz_link_czyszczenia()
  cechoLink(" <light_slate_blue>(wyczysc historie sprzedazy)<grey>", function() ra.alias.wyczysc_historie_kosztow() end, "Czysci historie pieniedzy otrzymanych w ostatnich tranzakcjach.", true)
  scripts.utils.bind_functional("/musun_historie", false, true)
end

function ra.alias.ustaw_procent_banku(ile)
  local old = ra.tmp.bank_transaction_cost 
  ra.tmp.bank_transaction_cost = ile
  cecho("\n<yellow>Przestawiono procent kosztow przy denominacji z "..old.."% na "..ra.tmp.bank_transaction_cost.."%.\n") 
end


function ra.alias.przelicz_wycene(str, ontop)
  local str_num = scripts.string_to_liczebnik
  str_num["jedna"] = 1
  str_num["jeden"] = 1
  local m = 0
  local s = 0
  local z = 0
  local h = 0 
  local sum = 0
  local res = {}
  local arr = string.split(str, " ")
  local n = 0
  
  for k, v in pairs(arr) do
    if v ~= "i" then
        if string.sub(v, 1, 3) == "mie" then
          m = tonumber(n)
        elseif string.sub(v, 1, 3) == "zlo" then
          z = tonumber(n)
        elseif string.sub(v, 1, 3) == "sre" then
          s = tonumber(n)
        elseif string.sub(v, 1, 3) == "mit" then
          h = tonumber(n)
        else
          n = str_num[v]
          if n == nil then
            n = v
          end
        end
    end
  end
  
--  m = 2042
--  s = 546
--  z = 35
--  h = 3 
  
  sum = m + (s * 12) + (z * 20 * 12) + (h * 100 * 20  * 12)
  
  if (ontop == true) and (not table.is_empty(ra.tmp.money)) then
    res["miedz"] = m + ra.tmp.money["miedz"]
    res["srebro"] = s + ra.tmp.money["srebro"]
    res["zloto"] = z + ra.tmp.money["zloto"]
    res["mithryl"] = h + ra.tmp.money["mithryl"]
    res["suma"] = sum + ra.tmp.money["suma"]
  else
    res["miedz"] = m
    res["srebro"] = s
    res["zloto"] = z
    res["mithryl"] = h
    res["suma"] = sum
  end
  ra.tmp.money = res
  return res
end

function ra.core.policz_procent(procent, data)
  local datar = {}
  datar["miedz"] = math.floor(data["miedz"]*(procent/100))
  datar["srebro"] = math.floor(data["srebro"]*(procent/100))
  datar["zloto"] = math.floor(data["zloto"]*(procent/100))
  datar["mithryl"] = math.floor(data["mithryl"]*(procent/100))
  datar["suma"] = math.floor(data["suma"]*(procent/100))
  return datar
end

function ra.alias.pokaz_procent(ile)
  if not table.is_empty(ra.tmp.money) then
    local procenty = ra.core.policz_procent(ile, ra.tmp.money)
    local str = ra.core.get_money_string(procenty)
    local miedz = procenty["suma"] 
    procenty = ra.core.policz_procent((100-tonumber(ra.tmp.bank_transaction_cost)), procenty)
    cecho("\n<tomato>  "..ile.." % <green>z monet to"..str.." (<yellow>po denominacji (z kosztem "..ra.tmp.bank_transaction_cost.."%)"..misc:get_valued_string(procenty["suma"])..") <grey>[rownowartosc w miedziakach: "..miedz.."]")
    --cecho("\n")
  else
    cecho("\n<yellow> Brak informacji o cenie towaru.\n")
  end
end

function ra.alias.daj_procent(ile, komu)
  if not table.is_empty(ra.tmp.money) then
    local procenty = ra.core.policz_procent(ile, ra.tmp.money)
    
    for k,v in pairs(procenty) do
      if v > 0 and k ~= "suma" then
        --cecho("\n")
        --cecho("daj "..ra.core.monety_dopelniacz_liczby(v, k).." "..komu)
        --cecho("\n")
        send("daj "..ra.core.monety_dopelniacz_liczby(v, k).." "..komu)
      end
    end
    
  else
    cecho("\n<yellow> Brak informacji o cenie.\n")
  end
end

function ra.alias.wloz_procent(ile, gdzie)
  if not table.is_empty(ra.tmp.money) then
    local procenty = ra.core.policz_procent(ile, ra.tmp.money)
    
    for k,v in pairs(procenty) do
      if v > 0 and k ~= "suma" then
        --cecho("\n")
        --cecho("wloz "..ra.core.monety_dopelniacz_liczby(v, k).." "..gdzie)
        --cecho("\n")
        send("wloz "..ra.core.monety_dopelniacz_liczby(v, k).." "..gdzie)
      end
    end
    
  else
    cecho("\n<yellow> Brak informacji o cenie.\n")
  end
end

function ra.core.monety_dopelniacz_liczby(ile, monety)
-- 4 monety, 14 monet, 24 - monety
-- 104  monety, 114 monet, 124 monety (edited)
-- 1004 monety, 1014 monet, 1114 monet,1124 monety

  local str = ""
  local last_number = tonumber(string.sub(tostring(ile),-1))
  local sec_last_number = tonumber(string.sub(string.sub(tostring(ile),-2), 0, 1))
  if ile == 1 then
    if monety == "miedz" then
      str = ile.." miedziana monete"
    elseif monety == "srebro" then
      str = ile.." srebrna monete"
    elseif monety == "zloto" then
      str = ile.." zlota monete"      
    elseif monety == "mithryl" then
      str = ile.." mithrylowa monete"   
    end
  elseif ile > 1 and ile < 5 then 
    if monety == "miedz" then
      str = ile.." miedziane monety"
    elseif monety == "srebro" then
      str = ile.." srebrne monety"
    elseif monety == "zloto" then
      str = ile.." zlote monety"      
    elseif monety == "mithryl" then
      str = ile.." mithrylowe monety"   
    end 
  elseif ile > 4 then 
    if last_number > 1 and last_number < 5 then 
      if sec_last_number == 1 then      
      -- 1004 monety, 1014 monet, 1114 monet,1124 monety
        if monety == "miedz" then
          str = ile.." miedzianych monet"
        elseif monety == "srebro" then
          str = ile.." srebrnych monet"
        elseif monety == "zloto" then
          str = ile.." zlotych monet"      
        elseif monety == "mithryl" then
          str = ile.." mithrylych monet"
        end
      else
        if monety == "miedz" then
          str = ile.." miedziane monety"
        elseif monety == "srebro" then
          str = ile.." srebrne monety"
        elseif monety == "zloto" then
          str = ile.." zlote monety"      
        elseif monety == "mithryl" then
          str = ile.." mithrylowe monety"   
        end
      end
    else 
      if monety == "miedz" then
        str = ile.." miedzianych monet"
      elseif monety == "srebro" then
        str = ile.." srebrnych monet"
      elseif monety == "zloto" then
        str = ile.." zlotych monet"      
      elseif monety == "mithryl" then
        str = ile.." mithrylowych monet"   
      end
    end
  end  
  return str
end

function ra.alias.pokaz_wycene()
  if not table.is_empty(ra.tmp.money) then
    ra.alias.pokaz_procent(100)
  else
    cecho("\n<yellow> Brak informacji o cenie.\n")
  end
end


function ra.core.get_money_string(data)
    local money_str = ""
    if data["mithryl"] > 0 then
        money_str = money_str .. " <CornflowerBlue>" .. data["mithryl"] .. " mth"
    end
    if data["zloto"] > 0 then
        money_str = money_str .. " <gold>" .. data["zloto"] .. " zl"
    end
    if data["srebro"] > 0 then
        money_str = money_str .. " <grey>" .. data["srebro"] .. " sr"
    end
    if data["miedz"] > 0 then
        money_str = money_str .. " <sienna>" .. data["miedz"] .. " mdz"
    end
    return money_str
end
