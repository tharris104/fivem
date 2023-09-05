-- Global configurations
local config = {
    pedBountySpawnMinDistance = 500.0, -- spawn bount minimum of 500 meters away
    pedBountySpawnMaxDistance = 1500.0, -- spawn bount maximum of 1500 meters away
    openBountyMenuKey = 29, -- default key bind (B), only works inside the marker
    markerDisplayDistance = 12.0, -- distance in which to draw markers
}

-- Define where bounty jobs can be accepted (coordinates)
local bountyLocations = {
    {x = 441.08, y = -981.33, z = 30.69},
    -- Add more locations as needed
}

-- Define the criminals with their bounties and skill levels
-- alertnessModifier = Set alertness (value ranges from 0 to 3)
-- accuracyModifier = Set accuracy 0-100 (default is 50)
local bounties = {
    {
        name = "John Doe",
        model = "a_m_m_hillbilly_01",
        story = "a deer, a female deer",
        reward = 1800,
        deadOrAlive = "Alive",
        primaryWeapon = "WEAPON_PISTOL",
        alertnessModifier = 2,
        accuracyModifier = 40,
        vehicle_model = "cheetah",
    },
    {
        name = "Zoie Smith",
        model = "a_f_y_bevhills_04",
        story = "its a long story",
        reward = 1750,
        deadOrAlive = "Alive",
        primaryWeapon = "WEAPON_SMG",
        alertnessModifier = 1,
        accuracyModifier = 50,
        vehicle_model = "gauntlet",
    },
    {
        name = "Bobby the Stickman",
        model = "u_m_m_streetart_01",
        story = "he stuck it to the man",
        reward = 2500,
        deadOrAlive = "Alive",
        primaryWeapon = "WEAPON_NIGHTSTICK",
        alertnessModifier = 0,
        accuracyModifier = 75,
    },
    {
        name = "Emily Wilkerson",
        model = "g_f_y_vagos_01",
        story = "she did something horrible",
        reward = 5000,
        deadOrAlive = "Dead or Alive",
        primaryWeapon = "WEAPON_HEAVYSNIPER",
        alertnessModifier = 1,
        accuracyModifier = 60,
    },
    {
        name = "Thomas Harris",
        model = "a_m_m_skater_01",
        story = "its a long story",
        reward = 3800,
        deadOrAlive = "Dead or Alive",
        primaryWeapon = "WEAPON_ASSAULTRIFLE",
        alertnessModifier = 3,
        accuracyModifier = 70,
        vehicle_model = "oppressor2",
    },
    {
        name = "Bunny Foo Foo",
        model = "a_f_m_fatcult_01",
        story = "hop hop hop",
        reward = 600,
        deadOrAlive = "Dead or Alive",
        primaryWeapon = "WEAPON_MACHETE",
        alertnessModifier = 3,
        accuracyModifier = 60,
    },
    {
        name = "Bruce Batty",
        model = "u_m_y_babyd",
        story = "a hitman",
        reward = 1200,
        deadOrAlive = "Dead or Alive",
        primaryWeapon = "WEAPON_BAT",
        alertnessModifier = 1,
        accuracyModifier = 45,
    },
}

-- Initilize NativeUI menu
_menuPool = NativeUI.CreatePool()
bountyMenu = NativeUI.CreateMenu("Bounty Menu", "~g~Choose the bounty you wish to collect", 1430, 0)
_menuPool:Add(bountyMenu)
bountyMenu.SetMenuWidthOffset(50);
function initMenu(menu)
    for index, bounty in pairs(bounties) do
        local entry = NativeUI.CreateItem(bounty.name, "Reward: $" .. bounty.reward .. " Info: " .. bounty.story)
        bountyMenu:AddItem(entry)
        entry.Activated = function(ParentMenu, SelectedItem)
            local selectedBounty = bounties[index]
            TriggerEvent("createBountyBlip", selectedBounty)
        end
    end
end
initMenu(mainMenu)
-- menu parameters
_menuPool:RefreshIndex()
_menuPool:MouseControlsEnabled (false)
_menuPool:MouseEdgeEnabled (false)
_menuPool:ControlDisablingEnabled(false)

-- Event handler to create a red blip for the selected bounty
RegisterNetEvent("createBountyBlip")
AddEventHandler("createBountyBlip", function(selectedBounty)
    local playerName = GetPlayerName(PlayerId())
    print(playerName .. ' accepted a bounty job for (' .. selectedBounty.name .. ')')
    local targetPed = CreateBountyPed(selectedBounty, config.pedBountySpawnMinDistance, config.pedBountySpawnMaxDistance)
    local blip = AddBlipForEntity(targetPed)
    SetBlipSprite(blip, 84) -- skull blip
    SetBlipDisplay(blip, 2)
    SetBlipScale(blip, 0.7)
    SetBlipNameToPlayerName(blip, targetPed)
    SetBlipAsShortRange(blip, false)
    _menuPool:CloseAllMenus()
end)

-- Function for displaying notifications to player
function ShowNotification(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end

-- Function to check if a player is inside a bounty marker area
function IsPlayerInBountyMarker(playerCoords)
    for _, location in pairs(bountyLocations) do
        local distance = GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, location.x, location.y, location.z, true)
        if distance <= 1.0 then
            return true, location
        end
    end
    return false, nil
end

-- Function to check if a player is inside a bounty area
function IsPlayerInBountyArea(playerCoords)
    for _, location in pairs(bountyLocations) do
        local distance = GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, location.x, location.y, location.z, true)
        if distance < config.markerDisplayDistance then
            return true, location
        end
    end
    return false, nil
end

-- Function to find a valid sidewalk position near the given coordinates
function FindValidSidewalkPosition(coords)
    local sidewalkObject = GetClosestObjectOfType(coords.x, coords.y, coords.z, 5.0, GetHashKey("prop_sidewalk_mp"), false, false, false)

    if sidewalkObject ~= 0 then
        local sidewalkCoords = GetEntityCoords(sidewalkObject)
        -- If a valid sidewalk object was found, spawn the pedestrian slightly above it
        sidewalkCoords.z = sidewalkCoords.z + 1.0
        return sidewalkCoords
    else
        print('Warning: Sidewalk coords could not be found')
        return coords
    end
end

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

-- Function to create a random PED within a specified distance from the player
function CreateBountyPed(bountyData, minDistance, maxDistance)
    local modelHash = bountyData.model
    local vehichle_modelHash = bountyData.vehicle_model
    local playerCoords = GetEntityCoords(PlayerPedId())
    local spawnCoords = GetRandomSpawnCoords(playerCoords, minDistance, maxDistance)

    -- Find a valid sidewalk position from the random coords
    local sidewalkCoords = FindValidSidewalkPosition(spawnCoords)
    if not sidewalkCoords then
        print('Error: Could not find a nearby sidewalk, spawnCoords (' .. spawnCoords.x .. ',' .. spawnCoords.y .. ',' .. spawnCoords.z .. ')')
        sidewalkCoords = spawnCoords -- Set it to spawnCoords if no valid sidewalk position is found
    end

    -- Find the nearest road entity from the random coords
    local roadNode, _ = GetClosestVehicleNode(spawnCoords.x, spawnCoords.y, spawnCoords.z, 1, 3.0, 0)

    -- Generate PED
    local ped
    RequestModel(modelHash)
    while not HasModelLoaded(modelHash) do
        Wait(1)
    end

    if vehicle_modelHash then
        if roadNode and roadNode.x and roadNode.y and roadNode.z then
            ped = CreatePed(4, modelHash, roadNode.x, roadNode.y, roadNode.z, 0.0, true, false)
        else
            print('Error: Invalid roadNode coordinates')
        end

        -- Modify attributes of the PED
        SetEntityHealth(ped, 200) -- Set the health (default is 100)
        SetPedAccuracy(ped, bountyData.accuracyModifier)
        SetPedAlertness(ped, bountyData.alertnessModifier)

        -- Give the PED a primary weapon
        GiveWeaponToPed(ped, GetHashKey(bountyData.primaryWeapon), 999, false, true)

        -- Generate Vehicle
        RequestModel(vehichle_modelHash)
        while not HasModelLoaded(car) do
            Wait(500)
        end
        local veh = CreateVehicle(car, coords.x, coords.y, coords.z, GetEntityHeading(GetPlayerPed(-1)), true, false)

        -- Put PED into vehicle
        SetPedIntoVehicle(ped, veh, -1)
        return ped

    else
        if sidewalkCoords and sidewalkCoords.x and sidewalkCoords.y and sidewalkCoords.z then
            ped = CreatePed(4, modelHash, sidewalkCoords.x, sidewalkCoords.y, sidewalkCoords.z, 0.0, true, false)
        else
            print('Error: Invalid sidewalkCoords coordinates')
        end

        -- Modify attributes of the PED
        SetEntityHealth(ped, 200) -- Set the health (default is 100)
        SetPedAccuracy(ped, bountyData.accuracyModifier)
        SetPedAlertness(ped, bountyData.alertnessModifier)

        -- Give the PED a primary weapon
        GiveWeaponToPed(ped, GetHashKey(bountyData.primaryWeapon), 999, false, true)

        return ped

    end
end

-- Main thread checking if player is in a bounty area
Citizen.CreateThread(function()
    local isInsideMarker = false -- lock used so notifications are not spammed

    while true do
        Citizen.Wait(0)
        _menuPool:ProcessMenus()

        local playerCoords = GetEntityCoords(PlayerPedId())
        local isInBountyArea, location = IsPlayerInBountyArea(playerCoords)

        if isInBountyArea then
            DrawMarker(1, location.x, location.y, location.z - 1.0, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 255, 0, 0, 200, false, false, 2, nil, nil, false)

            if IsControlJustPressed(0, config.openBountyMenuKey) then -- Replace with the desired control key
                bountyMenu:Visible(not bountyMenu:Visible())
            end

            if IsPlayerInBountyMarker(playerCoords) and isInsideMarker == false then
                isInsideMarker = true
                ShowNotification("~s~Select a ~r~bounty ~s~to complete by pressing ~r~B~s~ key")
            end
        else
            isInsideMarker = false
        end
    end
end)
