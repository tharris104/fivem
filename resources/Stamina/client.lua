Citizen.CreateThread( function()
 while true do
    Citizen.Wait(1)
    RestorePlayerStamina(PlayerId(), 1.0)
	end
end)

