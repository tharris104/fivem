local config = {
    pedFrequency = 0.8,
    trafficFrequency = 1.0,
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        ----------------------------------
        ----------------------------------
        ----------------------------------

        -- ensure extras spawn
        SetCreateRandomCops(true)
        SetCreateRandomCopsNotOnScenarios(true)
        SetCreateRandomCopsOnScenarios(true)
        SetGarbageTrucks(true)
        SetRandomBoats(true)

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

    end
end)
