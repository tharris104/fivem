local JustGotIn = false

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)

		if IsPedInAnyVehicle(PlayerPedId(), false) then
			if IsPlayerVehRadioEnable() then
				local veh = GetVehiclePedIsUsing(GetPlayerPed())
				if GetPlayerRadioStationName() ~= nil then
					SetVehRadioStation(veh, "OFF")
				end
			end
			JustGotIn = true
		end

		if not IsPedInAnyVehicle(PlayerPedId(), false) then
			JustGotIn = false
		end

	end
end)
