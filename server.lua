Citizen.CreateThread(function()
    if Config.Framework == 'esx' then 
        ESX = exports['es_extended']:getSharedObject()
    elseif Config.Framework == 'qb' then  
        QBCore = exports['qb-core']:GetCoreObject()
    end
end)

lib.callback.register('xkrz_meter_robbery:lockpicked', function(source)
    local src = source
	local ped = ESX.GetPlayerFromId(src)
	local count = math.random(Config.MinAmount, Config.MaxAmount)
	ped.removeInventoryItem(Config.UseItem, 1)
	ped.addInventoryItem('money', count)
end)

lib.callback.register('xkrz_meter_robbery:lockpicked:qb', function(source)
    local _source = source
	local Player = QBCore.Functions.GetPlayer(tonumber(source))
	local count = math.random(Config.MinAmount, Config.MaxAmount)
    Player.Functions.RemoveItem(Config.UseItem, 1)
    Player.Functions.AddMoney('cash', count)
end)