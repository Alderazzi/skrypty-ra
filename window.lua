ra.window = ra.window or {
    name = "ra_window",
    window = nil,
    font_size = 9,
    captures = {
        ["ra.refresh"] = true,
        ["ra.clear"] = true,
        ["ra.auto"] = ra.window_auto_refresh_enable,
        ["ra.calendar"] = ra.window_show_calendar,
        ["ra.keygivers"] = ra.window_show_keygivers,
    },    
    wrap = true,
    current_toggle = "",
    buttons = {},
    
}

function ra.window:create()
  if ra.window_enabled and not self.window then
    self.window = scripts.ui.window:new(self.name, "Alderazzi", self.wrap)
    self.window:add_buttons(function() self:create_buttons() end)
  end
  if self.window then
    self.window:set_font_size(self.font_size)
  end
  self:print("")
end

function ra.window:print(menu)
  local base = 25
  ra.window:create_buttons()
  if self.window then
    self:clear()
    if ( menu == "ra.refresh" ) then
      ra.tmp.notify = ra.calendar.get_calendar_notify()
      ra.window:print_notify()
    elseif ( menu == "ra.clear" ) then
      ra.tmp.notify = {}
      ra.window:print_notify()
    elseif ( menu == "ra.auto" ) then
      --ra.window:print_notify()
      ra.window.refresh()
    end
  end
end

function ra.window:clear()
  clearUserWindow(self.name)
end

function ra.window:create_buttons()
  local base = 25
  ra.window:create_menu(base)
end

function ra.window:create_menu(base)
  local line = 14
  local buttons = {
    { label = "Odswiez", type = "ra.refresh" },  
    { label = "Wyczysc", type = "ra.clear" },
    { label = "Auto odswiez", type = "ra.auto" },     
    { label = "Kalendarz", type = "ra.calendar" },
    { label = "Klucznicy", type = "ra.keygivers" },
  }
  
  for k, value in pairs(buttons) do
      local label_id = "ra_" .. value.type
      local button = scripts.ui.toggle_button:new(label_id, value.label, base, line, "h", function(toggled)
          self:toggle_type(value.type, toggled)
          if toggled then
            ra.window:print(value.type)
          else
            ra.window:clear()
          end
          scripts.state_store:set(self.name, self.captures)
      end, self.name)
      button:toggle(self:should_capture(value.type))
      self.buttons[k] = button
      base = base + button.width + 10
  end
end

function ra.window:toggle(toggle, menu)
  self.current_toggle = menu
  for k,v in pairs(self.buttons) do
    v:toggle(self.current_toggle == k)
  end
  
  if toggle then
    self:print(menu)
  end
end

function ra.window:toggle_type(type, value)
  self.captures[type] = value
  ra.window.refresh_settings(type, value)
  return self.captures[type]
end

function ra.window:should_capture(type)
  return self.captures[type]
end

function ra.window:print_notify()
  clearUserWindow(self.name)
  local str = ""
  local gt = table.deepcopy(ra.tmp.notify["gametime"])
  if table.size(gt) > 0 then
    cecho(self.name, "\n<"..gt["color"]..">"..gt["prefix"].." "..gt["desc"].."\n")
  end
  
  if ra.window_show_calendar then
    local dc = table.deepcopy(ra.tmp.notify["calendar"])
    cecho(self.name, "\nOpcja czas:\n")
    if table.size(dc) > 0 then
      for k,v in pairs(dc) do
        cecho(self.name, "\n<"..v["color"]..">"..v["prefix"]..v["desc"].." "..os.date('%d.%m.%Y %H:%M:%S', v["timestamp"]).." <yellow>-> "..v["desc_color"].."za "..v["resttime"])
      end
    else
      cecho(self.name, "\n\nBrak eventow w nastepnych "..ra.window_time_in.." min.\n")
    end
    cecho(self.name, "\n")
  end
  
  if ra.window_show_keygivers then
    local dc = table.deepcopy(ra.tmp.notify["keygivers"])
    cecho(self.name, "\nOpcja kluczodajki:\n")
    if table.size(dc) > 0 then
      cecho(self.name, "\nKluczodajka | Data Zabicia > Nast. Resp (h):\n")
      for k,v in pairs(dc) do
        cecho(self.name, "\n<"..v["color"]..">"..v["prefix"].." "..v["desc"].." <grey>("..v["time_prefix"].." "..v["resttime"]..")")
      end
    else
      cecho(self.name, "\n\nBrak informacji o kluczodajkach miedzy -"..(ra.window_notify_pre_time_keygivers/60).." i "..(ra.window_notify_post_time_keygivers/60).." min.\n")
    end
    cecho(self.name, "\n")
  end
  
  cecho(self.name, "\n\n")
end

function ra.window.refresh()
  ra.tmp.notify["gametime"] = ra.calendar.get_gametimes4notify()
  ra.tmp.notify["calendar"] = ra.calendar.get_calendar_notify()
  ra.tmp.notify["keygivers"] = ra.core.get_drops_notify()
  ra.window:print_notify()
  if ra.window_auto_refresh_enable then
    tempTimer(1, [[ ra.window.refresh() ]])
  end
end

function ra.window.refresh_settings(type, value)
  if type == "ra.auto" and value then
    ra.window_auto_refresh_enable = true
  elseif type == "ra.auto" and not value then
    ra.window_auto_refresh_enable = false
  end
  
  if type == "ra.calendar" and value then
    ra.window_show_calendar = true
  elseif type == "ra.calendar" and not value then
    ra.window_show_calendar = false
  end
  
  if type == "ra.keygivers" and value then
    ra.window_show_keygivers = true
  elseif type == "ra.keygivers" and not value then
    ra.window_show_keygivers = false
  end
  
end