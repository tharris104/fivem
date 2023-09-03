local config = {
    pedFrequency = 1.0,
    trafficFrequency = 1.0,
    ambientEvents = true
}

local spawnedPolice = {}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(100)

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

        -- Spawn police officers in vehicles and despawn when the player leaves the area
        if config.ambientEvents then
            local playerPed = PlayerId()
            local playerPos = GetEntityCoords(GetPlayerPed(-1))
            local policeFrequency = 5.0 -- Increase this value to spawn more police
            local isPoliceNeeded = math.random() < policeFrequency
            if isPoliceNeeded then
                local model = "police" -- Adjust the police vehicle model as needed
                RequestModel(model)
                while not HasModelLoaded(model) do
                    Citizen.Wait(1)
                end
                local x, y, z = playerPos.x + math.random(-50, 50), playerPos.y + math.random(-50, 50), playerPos.z
                local vehicle = CreateVehicle(model, x, y, z, 0.0, true, true)
                local ped = CreatePedInsideVehicle(vehicle, 6, "s_m_y_cop_01", -1, true, true)
                SetEntityAsMissionEntity(vehicle, true, true)
                SetEntityAsMissionEntity(ped, true, true)
--                SetEntityInvincible(ped, true)
                SetBlockingOfNonTemporaryEvents(ped, true)
--                TaskVehicleDriveToCoord(ped, vehicle, playerPos.x, playerPos.y, playerPos.z, 30.0, 1.0, GetEntityModel(vehicle), 262144, 1.0, true)
                table.insert(spawnedPolice, {vehicle, ped})

                -- Add a blip to the police vehicle
                local blip = AddBlipForEntity(vehicle)
                SetBlipSprite(blip, 56) -- Set the blip sprite (adjust as needed)
                SetBlipColour(blip, 3) -- Set the blip color (adjust as needed)
                SetBlipAsShortRange(blip, true)

            end

            -- Check for despawning
            local playerVehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
            if playerVehicle == 0 then
                for i, policeData in ipairs(spawnedPolice) do
                    local vehicle, ped = unpack(policeData)
                    local distance = GetDistanceBetweenCoords(playerPos.x, playerPos.y, playerPos.z, GetEntityCoords(vehicle))
                    if distance > 200.0 then -- Adjust this distance as needed
                        DeleteEntity(vehicle)
                        DeleteEntity(ped)
                        table.remove(spawnedPolice, i)
                    end
                end
            end
        end

        ----------------------------------
        ----------------------------------
        ----------------------------------

    end
end)
