function trigger_func_skrypty_misc_gubisz_kompana()
  if selectString(matches[2], 1) > -1 then
    fg("purple")
    bg("grey")
    replace(string.upper(matches[2]))
    resetFormat()
    local c = ra.core.saveDefaultRoomColor()
    ra.core.make_keyroom_red(amap.curr.id)
    tempTimer(120, [[ ra.core.setDefaultRoomColor(]]..c..[[) ]])
  end
end

function ra.core.saveDefaultRoomColor()
  local id = getRoomEnv(amap.curr.id)
  ra.tmp.last_room_color = id
  return id
end

function ra.core.setDefaultRoomColor(loc_id)
  setRoomEnv(tonumber(loc_id), amap.color_table[ra.tmp.last_room_color])
end

function ra.core.make_keyroom_red(loc_id)
  local color = "red"
  setRoomEnv(tonumber(loc_id), amap.color_table[color])
end