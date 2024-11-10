function ra.core.convert2roman(number)
  local ret = RomanNumerals.ToRomanNumerals(number)
  return ret
end

function ra.core.convert2number(roman_str)
  local ret = RomanNumerals.ToNumber(roman_str)
  return ret
end

function ra.core.mail_creator_crate_content(content)
    return scripts.mail_creator.templates[scripts.mail_creator.template].init(scripts.mail_creator.width):crate_content()
end

function ra.core.create_content()
  return "Dalsze informacje wydaja sie slabo czytelne. Mozesz rozroznic jedynie nastepujece znaki: "..ra.core.convert2roman(amap.curr.id)
end

function ra.core.set_my_signature()
  if gmcp == nil or gmcp.char == nil or gmcp.char.info == nil or gmcp.char.info.name == nil then
    return false
  end
  ra.mail.post_text = string.title(gmcp.char.info.name)
end

function ra.core_send_mail(to, subject, add)
    if not to or not subject then
        return
    end
    ra.core.set_my_signature()
    local content = ra.core.create_content()
    sendAll("napisz list", string.trim(to), string.trim(subject), " ")
    local trigger = tempTrigger("Wpisz ~?, zeby uzyskac pomoc, lub **, by zakonczyc edycje.", function() 
        sendAll(ra.mail.pre_text, content, " ", add, " ", ra.mail.post_text, " ")
        send("**")
    end, 1)
    tempTimer(6, function() killTrigger(trigger) end)
end

function ra.core_send_mail_no_sign(to, subject, add)
    if not to or not subject then
        return
    end
    local content = ra.core.create_content()
    sendAll("napisz list", string.trim(to), string.trim(subject), " ")
    local trigger = tempTrigger("Wpisz ~?, zeby uzyskac pomoc, lub **, by zakonczyc edycje.", function() 
        sendAll(ra.mail.pre_text, content, " ", add, " ", " ")
        send("**")
    end, 1)
    tempTimer(6, function() killTrigger(trigger) end)
end