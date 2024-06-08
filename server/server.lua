local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('madv.ads:server:sendAd')
AddEventHandler('madv.ads:server:sendAd', function(adText)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player then
        local playerJob = Player.PlayerData.job.name
        if IsPlayerAllowedToAdvertise(playerJob) then
            TriggerClientEvent('madv.ads:client:displayAd', -1, adText)
        else
            TriggerClientEvent('QBCore:Notify', src, "You do not have permission to post advertisements.", "error")
        end
    end
end)

function IsPlayerAllowedToAdvertise(job)
    for _, company in ipairs(Config.Companies) do
        if job == company then
            return true
        end
    end
    return false
end
