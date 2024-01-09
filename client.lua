Citizen.CreateThread(function()
    if Config.Framework == 'esx' then 
        ESX = exports['es_extended']:getSharedObject()
    elseif Config.Framework == 'qb' then  
        QBCore = exports['qb-core']:GetCoreObject()
    end
end)

local RecentRobbery = 0

local parkingmeter = Config.ParkingMeterProps

exports['qb-target']:AddTargetModel(parkingmeter,  {
    options = {
      {
        type = 'client',
        event = 'xkrz_meter_robbery:lockpick',
        icon = "fa-solid fa-lock",
        label = "Aufbrechen",
      },
    },
    distance = 1.5,
})

RegisterNetEvent('xkrz_meter_robbery:lockpick')
AddEventHandler('xkrz_meter_robbery:lockpick', function()
    if RecentRobbery == 0 or GetGameTimer() > RecentRobbery then
        if Config.Framework == 'esx' then
            local hasItem = exports.ox_inventory:Search('count', Config.UseItem)
            if hasItem >= 1 then
                local success = lib.skillCheck(Config.SkillCheckDifficulty, Config.SkillCheckKeys)
                if success then
                    TriggerEvent('xkrz_meter_robbery:client:lockpicked')
                else
                    lib.notify({
                        title = 'Error',
                        description = 'Noch ein versuch.',
                        position = 'top',
                        type = 'error'
                    })
                end
            else
                lib.notify({
                    title = 'Error',
                    description = 'Du brauchst einen Lockpick.',
                    position = 'top',
                    type = 'error'
                })
            end
        elseif Config.Framework == 'qb' then 
            local hasItem = QBCore.Functions.HasItem(Config.UseItem)
            if hasItem then
                local success = lib.skillCheck(Config.SkillCheckDifficulty, Config.SkillCheckKeys)
                if success then
                    TriggerEvent('xkrz_meter_robbery:client:lockpicked:qb')
                else
                    lib.notify({
                        title = 'Error',
                        description = 'Noch ein versuch.',
                        position = 'top',
                        type = 'error'
                    })
                end
            else
                lib.notify({
                    title = 'Error',
                    description = 'Du brauchst einen Lockpick.',
                    position = 'top',
                    type = 'error'
                })
            end
        end
    else
        lib.notify({
            title = 'Error',
            description = 'Versuche es später nochmal.',
            position = 'top',
            type = 'error'
        })
    end    
end)

RegisterNetEvent('xkrz_meter_robbery:client:lockpicked')
AddEventHandler('xkrz_meter_robbery:client:lockpicked', function()
    lib.progressCircle({
        duration = 5000,
        label = 'Aufbrechen..',
        useWhileDead = false,
        canCancel = false,
        position = "bottom",
        disable = {
            move = true,
            car = true,
            combat = true,
            mouse = false
        },
        anim = {dict = 'veh@break_in@0h@p_m_one@', clip = 'low_force_entry_ds'}, 
    })
    ClearPedTasks(PlayerPedId())
    RecentRobbery = GetGameTimer() + Config.Cooldown
    lib.callback('xkrz_meter_robbery:lockpicked', source, cb)
    lib.notify({
        title = 'Erfolg!',
        description = 'Du hast es erfolgreich aufgebrochen.',
        position = 'top',
        type = 'success'
    })
end)

RegisterNetEvent('xkrz_meter_robbery:client:lockpicked:qb')
AddEventHandler('xkrz_meter_robbery:client:lockpicked:qb', function()
    lib.progressCircle({
        duration = 5000,
        label = 'Aufbrechen..',
        useWhileDead = false,
        canCancel = false,
        position = "bottom",
        disable = {
            move = true,
            car = true,
            combat = true,
            mouse = false
        },
        anim = {dict = 'veh@break_in@0h@p_m_one@', clip = 'low_force_entry_ds'}, 
    })
    ClearPedTasks(PlayerPedId())
    RecentRobbery = GetGameTimer() + Config.Cooldown
    lib.callback('xkrz_meter_robbery:lockpicked:qb', source, cb)
    lib.notify({
        title = 'Erfolg!',
        description = 'Du hast es erfolgreich aufgebrochen.',
        position = 'top',
        type = 'success'
    })
end)