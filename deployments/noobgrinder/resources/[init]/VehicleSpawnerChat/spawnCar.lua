function ShowNotification(text)
  SetNotificationTextEntry("STRING")
  AddTextComponentString(text)
  DrawNotification(false, false)
end

RegisterCommand('spawn', function(source, args)
  -- account for the argument not being passed
  local vehicleName = args[1] or 'adder'

  -- check if the vehicle actually exists
  if not IsModelInCdimage(vehicleName) or not IsModelAVehicle(vehicleName) then
    TriggerEvent('chat:addMessage', {
      ShowNotification('~r~Error: ~s~Cannot spawn ' .. vehicleName .. '!')
    })
    return
  end

  -- delete vehicle player is or was previously using
  if IsPedInAnyVehicle(GetPlayerPed(-1), true) then
    local delvehin = GetVehiclePedIsIn(GetPlayerPed(-1), true)
    local delvehtrying = GetVehiclePedIsTryingToEnter(GetPlayerPed(-1))
    local delvehenter = GetVehiclePedIsEntering(GetPlayerPed(-1))
    local delvehusing = GetVehiclePedIsUsing(GetPlayerPed(-1))
    DeleteVehicle(delvehin)
    DeleteVehicle(delvehtrying)
    DeleteVehicle(delvehenter)
    DeleteVehicle(delvehusing)
  end

  -- load the model
  RequestModel(vehicleName)

  -- wait for the model to load
  while not HasModelLoaded(vehicleName) do
    Wait(500) -- often you'll also see Citizen.Wait
  end

  -- get the player's position
  local playerPed = PlayerPedId() -- get the local player ped
  local pos = GetEntityCoords(playerPed) -- get the position of the local player ped

  -- create the vehicle
  local vehicle = CreateVehicle(vehicleName, pos.x, pos.y, pos.z, GetEntityHeading(playerPed), true, false)

  -- set the player ped into the vehicle's driver seat
  SetPedIntoVehicle(playerPed, vehicle, -1)

  -- give the vehicle back to the game (this'll make the game decide when to despawn the vehicle)
  SetEntityAsNoLongerNeeded(vehicle)

  -- release the model
  SetModelAsNoLongerNeeded(vehicleName)

  -- custom license plate
  SetVehicleNumberPlateText(veh, licenseplatename)

  -- enable vehicle mods
  SetVehicleModKit(veh, 0)

  -- install best spoiler if available
  local bestspoiler = GetNumVehicleMods(veh, 0)-1
  if bestspoiler then
    SetVehicleMod(veh, 0, bestspoiler, false)
  end

  -- install EMS Upgrade, Level 4
  local bestengine = GetNumVehicleMods(veh, 11)-1
  if bestengine then
    SetVehicleMod(veh, 11, bestengine, false)
  end

  -- install Race Brakes
  local bestbrakes = GetNumVehicleMods(veh, 12)-1
  if bestbrakes then
    SetVehicleMod(veh, 12, bestbrakes, false)
  end

  -- install Race Transmission
  local bestgearbox = GetNumVehicleMods(veh, 13)-1
  if bestgearbox then
    SetVehicleMod(veh, 13, bestgearbox, false)
  end

  -- install Street Suspension
  SetVehicleMod(veh, 15, 1, false)

  -- install max armor
  local bestarmor = GetNumVehicleMods(veh, 16)-1
  if bestarmor then
    SetVehicleMod(veh, 16, bestarmor, false)
  end

  -- install turbo
  ToggleVehicleMod(veh, 18, true)

  -- install neon kit
  -- 0=left, 1=right, 2=front, 3=back
  SetVehicleNeonLightEnabled(veh, 0, true)
  SetVehicleNeonLightEnabled(veh, 1, true)
  SetVehicleNeonLightEnabled(veh, 2, true)
  SetVehicleNeonLightEnabled(veh, 3, true)
  SetVehicleNeonLightsColour(veh, 255, 1, 1)

  -- add white HID headlights (stock is -1, white is 0)
  ToggleVehicleMod(veh, 22, true)
  SetVehicleXenonLightsColour(veh, 0)

  -- fresh car wash, nobody wants to spawn a dirty car
  SetVehicleDirtLevel(veh, 0.0)

  -- tell the player
  ShowNotification('~g~Enjoy your new ^*' .. vehicleName .. '!')

end, false)
