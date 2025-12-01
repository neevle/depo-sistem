local QBCore = exports['qb-core']:GetCoreObject()

local getDatabase = function()
    local db = LoadResourceFile(GetCurrentResourceName(), 'database.json')
    return json.decode(db)
end

local setDatabase = function(data)
    local jsonCevirme = json.encode(data, {
        indent = true
    })
    SaveResourceFile(GetCurrentResourceName(), 'database.json', jsonCevirme, -1)
end

RegisterNetEvent("itemekleme", function(itemadi, miktar)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local bulundu = false
    local db = getDatabase()
    local items = db.items
    local miktarNumber = tonumber(miktar) or 1

    for i, item in ipairs(items) do
        if item.name == itemadi then
            item.count = item.count + miktarNumber
            Player.Functions.Notify('Istenilen item depoya konuldu.', 'success', 5000)
            bulundu = true
            setDatabase(db)
            break
        end
    end

    if not bulundu then
        table.insert(items, { name = itemadi, count = miktarNumber })
        Player.Functions.Notify('Istenilen item depoya eklendi.', 'success', 5000)
        setDatabase(db)
    end
end)

RegisterNetEvent("itemalmak", function(itemadi, miktar)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local bulundu = false
    local db = getDatabase()
    local items = db.items
    local miktarNumber = tonumber(miktar) or 1

    for i, item in ipairs(items) do
        if item.name == itemadi then

            bulundu = true

            if item.count >= miktarNumber then
                item.count = item.count - miktarNumber
                if item.count <= 0 then
                    table.remove(items, i)
                end
                setDatabase(db)
                Player.Functions.Notify('Istenilen item depodan alindi.', 'success', 5000)
                break
            elseif item.count < miktarNumber then
                Player.Functions.Notify('Itemin miktari yeterli degil', 'error', 5000)
            end
        end
    end

    if not bulundu then
        Player.Functions.Notify('Istenen item bulunamadi!', 'error', 5000)
    end
end)

RegisterNetEvent("depolisteleme", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local db = getDatabase()
    local items = db.items

    Player.Functions.Notify(json.encode(items), 'success', 5000)
end)