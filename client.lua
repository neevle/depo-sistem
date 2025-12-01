local QBCore = exports['qb-core']:GetCoreObject()

RegisterCommand("depoekle", function(source, args, raw)
    local itemadi = args[1]
    local miktar = args[2]
    TriggerServerEvent("itemekleme", itemadi, miktar)
end, false)

RegisterCommand("depoal", function(source, args, raw)
    local itemadi = args[1]
    local miktar = args[2]
    TriggerServerEvent("itemalmak", itemadi, miktar)
end, false)

RegisterCommand("depo", function(source, args, raw)
    TriggerServerEvent("depolisteleme")
end, false)