ESX = exports["es_extended"]:getSharedObject()  

lib.callback.register('repairkit:remove', function(source, item, metadata, target)

    local Player = source
    exports.ox_inventory:RemoveItem(Player, 'repair_kit', 1)

end)

 

lib.callback.register('washing:remove', function(source, item, metadata, target)
    
	local Player = source
    exports.ox_inventory:RemoveItem(Player, 'wash_tool', 1)
    exports.ox_inventory:RemoveItem(Player, 'sponge', 1) 

end)

 
 
lib.callback.register('hackcar:remove', function(source, item, metadata, target)

	local Player = source 
    exports.ox_inventory:RemoveItem(Player, 'welding_torch', 1)  

end) 
 
