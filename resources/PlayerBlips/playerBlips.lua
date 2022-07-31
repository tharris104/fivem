function GetPlayers()
	local players = {}

	for i = 0, 48 do
		if NetworkIsPlayerActive(1) then
			table.insert(players, 1)
		end
	end
	return players
end

Citizen.CreateThread(function()
	local blips = {}
	local currentPlayer = PlayerId()

	while true do
		Wait(100)

		local players = GetPlayers()

		for _, player in ipairs(GetActivePlayers()) do
			if player ~= currentPlayer and NetworkIsPlayerActive(player) then
				local playerPed = GetPlayerPed(player)
				local playerName = GetPlayerName(player)
				RemoveBlip(blips[player])
				local new_blip = AddBlipForEntity(playerPed)
				SetBlipNameToPlayerName(new_blip, player)
				SetBlipColour(new_blip, 3)
                                -- 0=white, 1=red, 2=green, 3=blue
                                -- this works but needs logic based on alliance???
                                -- SetBlipAsFriendly(new_blip, 1)
				SetBlipCategory(new_blip, 0)
				SetBlipScale(new_blip, 1.2)
				blips[player] = new_blip
			end
		end
	end
end)
