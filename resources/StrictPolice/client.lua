-- Used for modifiying wanted level changes
local PlayerWantedCheck = false

-- This is used to allow some violations to happen
-- a few times before being reported
local WarningCounter = 0
local WarningThreshold = 3

-- Global speed limit that will trigger wanted level
local GlobalSpeedLimit = 75

-- Maximum distance PEDs can see player in their line of sight
local MaxLosDist = 40

-- These model can report all violations
local PedModels = {
	"s_m_y_cop_01",
	's_m_m_snowcop_01',
	's_m_y_hwaycop_01',
	's_m_y_sheriff_01',
	's_m_y_ranger_01',
	's_m_m_armoured_01',
	's_m_m_armoured_01',
	's_f_y_cop_01',
	's_f_y_sheriff_01',
	's_f_y_ranger_01',
	's_m_m_ciasec_01',
	's_m_m_armoured_01',
	's_m_m_armoured_02',
	's_m_m_fibsec_01',
	'u_m_m_fibarchitect',
	's_m_y_swat_01',
}

-- Function for displaying notifications to player
function ShowNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end

-- Check if array contains a value
function has_value (arr, val)
	for index, value in ipairs(arr) do
		if value == val then
			return true
		end
	end
	return false
end

-- Function for returning closest entity
-- Usage: GetClosestEntity("CPed", "alive", "any", "inlos", false, vector3(x, y, z))
-- entitytype: "CPed", "CObject", "CVehicle", "CPickup"
-- alive: "any", "alive", "dead" or (Vehicle only: "alivedriver", "deaddriver")
-- targets: "any", "player", "npc" or (Vehicle only: "empty")
-- los: "any", "notinlos", "inlos"
-- ignoreanimals: true, false
-- coords: vector3, {x, y, z} or nil for the player's coords
function GetClosestEntity(entitytype, alive, targets, los, ignoreanimals, coords)
	local playerPed, closestEntity, closestDist, aliveCheck, losCheck = PlayerPedId(), -1, -1, false, false
	-- Get peds, objects, vehicles or pickups, according to the param
	entitytype = entitytype or "CPed"
	-- Get only alive or dead entities, according to the param
	alive = alive or "alive"
	-- Get entities that are only players or npcs or both, according to the param
	targets = targets or "any"
	-- Get only entities in or out of your line of sight, according to the param
	los = los or "inlos"
	-- Ignore entities that are animals according to the ignoreanimals param
	ignoreanimals = ignoreanimals or false
	-- Get specified coords or coords of current player if empty
	coords = coords or GetEntityCoords(playerPed)
	-- Loop through the game pool until closest entity is found.
	for index, entity in pairs(GetGamePool(entitytype)) do
		local driver = entitytype == "CVehicle" and GetPedInVehicleSeat(entity, -1) or -1
		-- Handles the alive param
		local aliveCheck =
			(alive == "any") or
			(alive == "alive" and not IsEntityDead(entity)) or
			(alive == "dead" and IsEntityDead(entity)) or
			(alive == "alivedriver" and driver > 0 and not IsEntityDead(driver)) or
			(alive == "deaddriver" and driver > 0 and IsEntityDead(driver))
		-- Handles the targets param
		local targetsCheck =
			(targets == "any") or
			(targets == "player" and IsPedAPlayer(driver == -1 and entity or driver)) or
			(targets == "npc" and driver == -1 and not IsPedAPlayer(entity)) or
			(targets == "npc" and driver > 0 and not IsPedAPlayer(driver)) or
			(targets == "empty" and driver == 0 and GetVehicleNumberOfPassengers(entity) == 0)
		-- Handles the los param
		local losCheck =
			(los == "any") or
			(los == "inlos" and HasEntityClearLosToEntity(playerPed, entity, 17)) or
			(los == "notinlos" and not HasEntityClearLosToEntity(playerPed, entity, 17))
		-- Handles the ignoreanimals param
		local ignoreanimalsCheck = (not ignoreanimals or (IsEntityAPed(entity) and GetPedType(entity) ~= 28))
		if entity ~= playerPed and aliveCheck and losCheck and targetsCheck and ignoreanimalsCheck then
			local distance = #(coords - GetEntityCoords(entity))
			if closestDist == -1 or distance < closestDist then
				closestEntity = entity
				closestDist = distance
			end
		end
	end
	return closestEntity, closestDist
end

-- Modify relationships between police and players
-- 1. police do not shoot on sight until 3 stars
-- 2.
-- todo: handle if player starts shooting, police shoot back
-- todo: force police to move towards player and attempt to arrest
-- todo: SetPedCombatAttributes(cop_id, 1424, false)  ?????
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		-- once wanted level is higher than 3, set relationship to hate
		if PlayerWantedCheck == true and GetPlayerWantedLevel(PlayerId()) >= 3 and GetRelationshipBetweenGroups(GetHashKey("police"), GetHashKey("PLAYER")) ~= 5 then
			SetPoliceIgnorePlayer(PlayerId(), false)
			SetRelationshipBetweenGroups(5, GetHashKey("police"), GetHashKey("PLAYER"))
			SetRelationshipBetweenGroups(5, GetHashKey("PLAYER"), GetHashKey("police"))
			PlayerWantedCheck = false
		end
		-- initial code once your wanted
		if PlayerWantedCheck == false and GetPlayerWantedLevel(PlayerId()) <= 2 and IsPlayerWantedLevelGreater(PlayerId(), 0) then
			SetRelationshipBetweenGroups(4, GetHashKey("police"), GetHashKey("PLAYER"))
			SetRelationshipBetweenGroups(4, GetHashKey("PLAYER"), GetHashKey("police"))
			SetPoliceIgnorePlayer(PlayerId(), true)
			if not IsPlayerBeingArrested(PlayerId()) then
				local ent, dist = GetClosestEntity("CPed", "alive", "npc", "inlos", true)
				local model = GetEntityModel(ent)
				local model_name = GetEntityArchetypeName(ent)
				local ped = GetPedIndexFromEntityIndex(ent)
				if IsModelAPed(model) then
					if has_value(PedModels, model_name) then
						ShowNotification("~r~Arresting Player!")
						TaskGotoEntityAiming(ped, PlayerId(), 1, MaxLosDist)
						TaskArrestPed(ped, PlayerId())
						SetPedKeepTask(ped, true)
					end
				end
			end
			PlayerWantedCheck = true
		end
		-- reset things back to normal
		if PlayerWantedCheck == true and GetPlayerWantedLevel(PlayerId()) == 0 then
			SetRelationshipBetweenGroups(3, GetHashKey("police"), GetHashKey("PLAYER"))
			SetRelationshipBetweenGroups(3, GetHashKey("PLAYER"), GetHashKey("police"))
			SetPoliceIgnorePlayer(PlayerId(), false)
			PlayerWantedCheck = false
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Wait(1000)

		-- get closet ped that is alive, an npc, in line of sight of player, and ignore animals is true
		local ent, dist = GetClosestEntity("CPed", "alive", "npc", "inlos", true)
		local model = GetEntityModel(ent)
		local model_name = GetEntityArchetypeName(ent)
		local model_type = GetEntityType(ent)

		if IsModelAPed(model) then
			if has_value(PedModels, model_name) then
				-- at this point, a police model can see you in their line of sight
				-- reference for violations: https://docs.fivem.net/natives/?_0xE9B09589827545E7
				--ShowNotification("Cop is in your line of sight!")
				if IsPedInAnyVehicle(PlayerPedId(), false) then

					local playerveh = GetVehiclePedIsUsing(PlayerPedId())
					local speed = GetEntitySpeed(playerveh)
					local veh_type = GetEntityType(playerveh) -- all vehicle are 2.. doesnt help
					local speedmph = (speed * 2.236936)
					--ShowNotification("Player using " .. playerveh .. " type " .. veh_type)

					-- line of sight has no limit on distance, so we manually set threshold
					if dist < MaxLosDist then
						-- if player is not already wanted
						if not IsPlayerWantedLevelGreater(PlayerId(), 0) then
							-- cop sees you driving a known wanted vehicle (evaded successfully)
							-- this needs to be the first check
							if IsVehicleWanted(playerveh) then
								ShowNotification("~r~Police~s~ witnessed you driving a wanted vehicle!")
								ReportCrime(PlayerId(), 9, GetWantedLevelThreshold(1)) -- 9: ???
							end
							-- cop sees you speeding in car
							if speedmph > GlobalSpeedLimit then
								ShowNotification("Speeding Violation! (~r~" .. speedmph .. " mph~s~)")
								ReportCrime(PlayerId(), 4, GetWantedLevelThreshold(1)) -- 4: Speeding vehicle (a "5-10")
							end
							-- cop sees you burnout
							if IsVehicleInBurnout(playerveh) then
								ShowNotification("~r~Police~s~ witnessed your burnout!")
								ReportCrime(PlayerId(), 3, GetWantedLevelThreshold(1)) -- 3: Reckless driver
							end
							-- cop sees you doing a wheelie
							if GetVehicleWheelieState(playerveh) == 129 then
								ShowNotification("~r~Police~s~ witnessed you doing a wheelie!")
								ReportCrime(PlayerId(), 3, GetWantedLevelThreshold(1)) -- 3: Reckless driver
							end
							-- cop sees you driving known stolen vehicle
							if IsVehicleStolen(playerveh) then
								ShowNotification("~r~Police~s~ witnessed you driving a stolen vehicle!")
								ReportCrime(PlayerId(), 7, GetWantedLevelThreshold(1)) -- 7: Vehicle theft (a "5-0-3")
							end
							-- todo: cop sees you hit objects with vehicle
							-- todo: cop sees you run redlight!!!
							-- :D IsVehicleStoppedAtTrafficLights()
							-- based on existing cars sitting at the redlight
						end
						-- no matter your wanted level, use warning counter
						-- cop sees you doing some crazy stuff
						if not IsVehicleOnAllWheels(playerveh) then
							WarningCounter = WarningCounter + 1
							if WarningCounter >= WarningThreshold then
								ShowNotification("~r~Police~s~ witnessed wreckless driving!")
								ReportCrime(PlayerId(), 3, GetWantedLevelThreshold(1)) -- 3: Reckless driver
								WarningCounter = 0
							end
						end
					end
				end
				-- non-vehicle vilations would go here
				-- bank robbery?
				-- gas station robbery? 
				-- altercation? might make sense to have all PEDs report
			end
		end
	end
end)
