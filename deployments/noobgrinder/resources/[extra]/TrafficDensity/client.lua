local config = {
	pedFrequency = 1.0, -- max value 1.0
	trafficFrequency = 1.0, -- max value 1.0
	ambientEvents = true, -- built-in ambient events all enabled by default
	maxPoliceSpawned = 5,  -- Set the maximum number of cops to be spawned in area
	spawnDistance = 100.0,  -- Set the distance from the player where cops will spawn
	copDespawnDistance = 750.0, -- Set the distance when cops are de-spawned
	copDrivingStyle = 1074528677, -- https://vespura.com/fivem/drivingstyle/
	showBlipsOnCops = true, -- disabled by default, will show a constant blip on any spawned cops
}

local spawnedPolice = {}
local policeBlips = {}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000) -- once per second

        ----------------------------------
        ----------------------------------
        ----------------------------------

        -- ensure extras spawn
        SetCreateRandomCops(config.ambientEvents)
        SetCreateRandomCopsNotOnScenarios(config.ambientEvents)
        SetCreateRandomCopsOnScenarios(config.ambientEvents)
        SetGarbageTrucks(config.ambientEvents)
        SetRandomBoats(config.ambientEvents)

        ----------------------------------
        ----------------------------------
        ----------------------------------

        -- 0.0 = no peds, 1.0 = normal peds
        -- https://docs.fivem.net/natives/#_0x95E3D6257B166CF2
        -- https://docs.fivem.net/natives/#_0x7A556143A1C03898

        SetPedDensityMultiplierThisFrame(config.pedFrequency)
        SetScenarioPedDensityMultiplierThisFrame(config.pedFrequency, config.pedFrequency)

        ----------------------------------
        ----------------------------------
        ----------------------------------

        -- 0.0 = no vehicles, 1.0 = normal vehicles
        -- https://docs.fivem.net/natives/?_0x90B6DA738A9A25DA
        -- https://docs.fivem.net/natives/#_0xB3B3359379FE77D3
        -- https://docs.fivem.net/natives/#_0xEAE6DCC7EEE3DB1D
        -- https://docs.fivem.net/natives/#_0x245A6883D966D537

        SetAmbientVehicleRangeMultiplierThisFrame(config.trafficFrequency)
        SetRandomVehicleDensityMultiplierThisFrame(config.trafficFrequency)
        SetParkedVehicleDensityMultiplierThisFrame(config.trafficFrequency)
        SetVehicleDensityMultiplierThisFrame(config.trafficFrequency)

        ----------------------------------
        ----------------------------------
        ----------------------------------

        -- Spawn police officers in vehicles and add a blip
        if config.ambientEvents then
            if IsPedInAnyVehicle(PlayerPedId(), false) then
                local playerPed = PlayerId()
                local playerPos = GetEntityCoords(GetPlayerPed(-1))

                -- Check the maximum number of cops spawned
                if #spawnedPolice < config.maxPoliceSpawned and GetDistanceBetweenCoords(playerPos.x, playerPos.y, playerPos.z, spawnX, spawnY, playerPos.z, true) > config.spawnDistance then
                    local vehicleModel = "police" -- Adjust the police vehicle model as needed
                    local pedModel = "s_m_y_cop_01" -- Adjust the police ped model as needed
                
                    RequestModel(vehicleModel)
                    RequestModel(pedModel)
                
                    while not HasModelLoaded(vehicleModel) or not HasModelLoaded(pedModel) do
                        Citizen.Wait(1)
                    end

                    -- Generate a random spawn location far from the player
                    local spawnX, spawnY = playerPos.x, playerPos.y
                    while GetDistanceBetweenCoords(playerPos.x, playerPos.y, 0.0, spawnX, spawnY, 0.0, true) < config.spawnDistance do
                        spawnX = playerPos.x + math.random(-500, 500) -- Adjust the range as needed
                        spawnY = playerPos.y + math.random(-500, 500) -- Adjust the range as needed
                    end

                    local vehicle = CreateVehicle(vehicleModel, spawnX, spawnY, playerPos.z, 0.0, true, true)
                    local ped = CreatePedInsideVehicle(vehicle, 6, pedModel, -1, true, true)
                    SetEntityAsMissionEntity(vehicle, true, true)
                    SetEntityAsMissionEntity(ped, true, true)

                    -- Make the police ped enter the vehicle
                    TaskWarpPedIntoVehicle(ped, vehicle, -1)

                    -- Make the vehicle patrol randomly
                    local heading = GetEntityHeading(vehicle)
                    TaskVehicleDriveWander(ped, vehicle, 20.0, config.copDrivingStyle, heading)

                    -- Record and log spawned cop
                    table.insert(spawnedPolice, {vehicle, ped})

                    -- Add a blip to the police vehicle
                    if config.showBlipsOnCops then
                        local blip = AddBlipForEntity(vehicle)
                        SetBlipSprite(blip, 41) -- Set the blip sprite to police blip
                        SetBlipScale(blip, 0.5)
                        table.insert(policeBlips, blip)
                    end
                end

                -- Check for despawning
                if #spawnedPolice > 0 then
                    for i, policeData in ipairs(spawnedPolice) do
                        local vehicle = policeData[1] -- Access the vehicle directly
                        local ped = policeData[2] -- Access the ped directly
                        local distance = GetDistanceBetweenCoords(playerPos.x, playerPos.y, playerPos.z, GetEntityCoords(vehicle))
                        if distance > config.copDespawnDistance then
                            if config.showBlipsOnCops then
                                local blip = policeBlips[i]
                                RemoveBlip(blip)
                                table.remove(policeBlips, i)
                            end
                            DeleteEntity(vehicle)
                            DeleteEntity(ped)
                            table.remove(spawnedPolice, i)
                        end                
                    end
                end
            end
        end

        ----------------------------------
        ----------------------------------
        ----------------------------------

	-- Check and filter PED chat for specific words

        ----------------------------------
        ----------------------------------
        ----------------------------------

    end
end)
