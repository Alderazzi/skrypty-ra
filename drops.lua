function ra.core.add_magic_item_dc(name, treasury)
  -- TODO: dodanie magika na dc
end

function ra.core.create_buffer(treasury)
  -- TODO: stworzenie bufora do konkretnego skarbca
end

function ra.core.delete_buffer(treasury)
  -- TODO: usuniecie bufora z konkretnego skarbca
end

function ra.core.add_drop_into_buffer(treasury)
  -- TODO: dodaje dropa bufora z konkretnego skarbca
end

function ra.core.add_buffer_notification(treasury)
  ra.core.notification_center:add_notification(treasury) 
end