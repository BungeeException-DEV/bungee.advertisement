local QBCore = exports['qb-core']:GetCoreObject()
local adText = ""
local companyName = ""

RegisterCommand('advertisement', function()
    local playerData = QBCore.Functions.GetPlayerData()
    if IsPlayerAllowedToAdvertise(playerData.job.name) then
        OpenAdInput()
    else
        QBCore.Functions.Notify("You do not have permission to post advertisements.", "error")
    end
end, false)

function IsPlayerAllowedToAdvertise(job)
    for _, company in ipairs(Config.Companies) do
        if job == company then
            return true
        end
    end
    return false
end

function OpenAdInput()
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = "openAdInput"
    })
end

RegisterNUICallback('submitAd', function(data, cb)
    companyName = data.company
    adText = data.text
    local completeAdText = companyName .. " - " .. adText
    TriggerServerEvent('madv.ads:server:sendAd', completeAdText)
    SetNuiFocus(false, false)
    cb('ok')
end)

RegisterNUICallback('closeAdInput', function(data, cb)
    SetNuiFocus(false, false)
    cb('ok')
end)

RegisterNetEvent('madv.ads:client:displayAd')
AddEventHandler('madv.ads:client:displayAd', function(adText)
    SendNUIMessage({
        action = "displayAd",
        text = adText,
        displayTime = Config.AdDisplayTime
    })
end)
