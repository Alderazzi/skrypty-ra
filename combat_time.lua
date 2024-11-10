ra.tmp.in_combat = -1
if scripts.event_handlers["ra_core_combat_time"] then
    killAnonymousEventHandler(scripts.event_handlers["ra_core_combat_time"])
end

scripts.event_handlers["ra_core_combat_time"] = registerAnonymousEventHandler("gmcp.gmcp_msgs.type", ra.core.combat_time)

function ra.core.combat_time()
  if gmcp.gmcp_msgs.type == "combat.avatar" then
    ra.tmp.in_combat = 0
  elseif gmcp.gmcp_msgs.type == "other" then
    ra.tmp.in_combat = getEpoch()
  end
  display(ra.tmp.in_combat)
end