-- Global config options
local config = {
    pedBountySpawnMinDistance = 500.0, -- spawn bount minimum of 500 meters away
    pedBountySpawnMaxDistance = 1500.0, -- spawn bount maximum of 1500 meters away
    openBountyMenuKey = 29, -- default key bind (B), only works inside the marker
}

-- Define a table to store bounty job locations (coordinates)
local bountyLocations = {
    {x = 441.08, y = -981.33, z = 30.69},
    -- Add more locations as needed
}

-- Function to check if a player is inside a bounty area
function IsPlayerInBountyArea(playerCoords)
    for _, location in pairs(bountyLocations) do
        local distance = GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, location.x, location.y, location.z, true)
        if distance < 10.0 then
            return true, location
        end
    end
    return false, nil
end

-- Function to create a NativeUI menu for accepting bounties
function CreateBountyMenu()
    local bountyMenu = NativeUI.CreateMenu("Bounty Hunter", "Choose a bounty:")

    -- Add options to the menu (e.g., bounties)
    for _, bounty in pairs(bounties) do
        local bountyItem = NativeUI.CreateItem(bounty.name, "Reward: $" .. bounty.reward)
        bountyMenu:AddItem(bountyItem)
    end

    bountyMenu.OnItemSelect = function(menu, selectedItem, index)
        -- Handle bounty selection and blip creation here
        local selectedBounty = bounties[index]
        TriggerEvent("createBountyBlip", selectedBounty)
    end

    return bountyMenu
end

-- Event handler to create a red blip for the selected bounty
RegisterNetEvent("createBountyBlip")
AddEventHandler("createBountyBlip", function(selectedBounty)
    local targetPed = CreateRandomPed(selectedBounty.weapon)
    local blip = AddBlipForEntity(targetPed)
    SetBlipSprite(blip, 84) -- Red blip
    SetBlipDisplay(blip, 2)
    SetBlipScale(blip, 0.7)
    SetBlipNameToPlayerName(blip, targetPed)
    SetBlipAsShortRange(blip, true)
end)

-- Function to generate random spawn coordinates within the specified distance range
function GetRandomSpawnCoords(playerCoords, minDistance, maxDistance)
    local angle = math.rad(math.random(0, 360)) -- Random angle in radians
    local distance = math.random(minDistance, maxDistance) -- Random distance within the specified range

    local spawnCoords = {
        x = playerCoords.x + distance * math.cos(angle),
        y = playerCoords.y + distance * math.sin(angle),
        z = playerCoords.z
    }

    return spawnCoords
end

-- Function to create a random PED with aggressive behavior and a weapon
function CreateRandomPed(weapon)
    local modelHash = GetHashKey("a_m_m_skater_01") -- todo: choose random model from hash
    local playerCoords = GetEntityCoords(PlayerPedId())
    local spawnCoords = GetRandomSpawnCoords(playerCoords, config.pedBountySpawnMinDistance, config.pedBountySpawnMaxDistance)

    -- Create networked PED
    RequestModel(modelHash)
    while not HasModelLoaded(modelHash) do
        Wait(1)
    end
    local ped = CreatePed(4, modelHash, spawnCoords.x, spawnCoords.y, spawnCoords.z, 0.0, true, false)

    -- Give the PED a weapon and make it aggressive
    GiveWeaponToPed(ped, GetHashKey(weapon), 999, false, true)
    TaskCombatPed(ped, PlayerPedId(), 0, 16)

    return ped
end

-- Main thread checking if player is in a bounty area
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        local playerCoords = GetEntityCoords(PlayerPedId())
        local isInBountyArea, location = IsPlayerInBountyArea(playerCoords)

        if isInBountyArea then
            DrawMarker(1, location.x, location.y, location.z - 1.0, 0, 0, 0, 0, 0, 0, 3.0, 3.0, 1.0, 255, 0, 0, 200, false, false, 2, nil, nil, false)

            if IsControlJustPressed(0, config.openBountyMenuKey) then -- Replace with the desired control key
                local bountyMenu = CreateBountyMenu()
                bountyMenu:Visible(true)
            end
        end
    end
end)
