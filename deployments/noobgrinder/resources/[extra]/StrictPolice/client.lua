-- Crime types reference
-- https://docs.fivem.net/natives/?_0xE9B09589827545E7

-- debug mode (write info to console)
local debug_enabled = true

-- Global speed limit that will trigger a wanted level (mph)
local GlobalSpeedLimit = 85 -- default 85

-- Amount allowed in seconds before these crimes are reported
-- TOG: tires off ground, BO: burnouts, VW: vehicle wanted
local TOG_WarningCounter = 0
local TOG_WarningThreshold = 20
local BO_WarningCounter = 0
local BO_WarningThreshold = 10

-- Running a red light options:
-- Distance from player to detect vehicles near player
-- Angle threshold to use when comparing the direction of player and ai
local nearbyDistance = 200.0
local angleThreshold = 90.0

-- Stop police from speaking
local StopPoliceSpeaking = true -- todo: doesnt really work as expected..

-- Maximum distance police PEDs can see player in their line of sight
local MaxLosDist = 10 -- default ??

-- Switch used for modifying wanted level changes
local PlayerWantedCheck = false

-- Variables used for police pursuit
local policePeds = {} -- Store the police peds you want to control
local isPlayerStopped = false -- When chasing, always check if player is stopped

-- Function for displaying notifications to player
function ShowNotification(text)
        SetNotificationTextEntry("STRING")
        AddTextComponentString(text)
        DrawNotification(false, false)
end

-- Function for checking if a player is in the field of view of a ped
function IsPlayerInPedFOV(ped, player)
        local pedCoords = GetEntityCoords(ped, false)
        local playerCoords = GetEntityCoords(player, false)
        local pedHeading = GetEntityHeading(ped)

        local direction = playerCoords - pedCoords
        local angle = math.atan2(direction.y, direction.x) - pedHeading

        if angle > -math.pi / 2 and angle < math.pi / 2 then
                print("IsPlayerInPedFOV() - Player is in Police PED's FOV (" .. ped .. ")")
                local policeBlip = AddBlipForEntity(ped)
                SetBlipSprite(policeBlip, 8)
                SetBlipColour(policeBlip, 1)
                SetBlipAsShortRange(policeBlip, true)
                return true
        else
                return false
        end
end

-- Function to call when ped should attempt an arrest on the player
function AttemptArrest(policePed)
        local playerPed = PlayerPedId()
        -- Check if the player is within a certain range before attempting arrest
        local distance = #(GetEntityCoords(policePed) - GetEntityCoords(playerPed))
        if distance < 2.0 then

        end
end

-- Function to check if the players movement is stopped
function CheckPlayerStopped()
        local prevCoords = GetEntityCoords(playerPed)
        Citizen.Wait(1000) -- Wait for 1 second
        local currentCoords = GetEntityCoords(playerPed)

        -- Check if the player has moved significantly in the last second
        isPlayerStopped = #(currentCoords - prevCoords) < 0.1
end

-- Function for returning the closest police ped
function GetClosestPolicePed(coords)
        local playerPed = PlayerPedId()
        local closestPed, closestDist = -1, -1
        coords = coords or GetEntityCoords(playerPed)

        for _, entity in pairs(GetGamePool("CPed")) do
                local policePed
                if IsPedInAnyVehicle(entity, true) then
                        policePed = GetPedInVehicleSeat(entity, -1)
                else
                        policePed = entity
                end
                if DoesEntityExist(policePed) then
                        local entityPedType = GetPedType(policePed)
                        local distance = #(coords - GetEntityCoords(policePed))


                        if entityPedType == 6 or entityPedType == 27 then
                                print('GetClosestPolicePed() - entityPedType: ' .. entityPedType)
                                local isPlayerInFOV = IsPlayerInPedFOV(policePed, playerPed)
                                local isDead = IsEntityDead(policePed)
                                if not isDead and isPlayerInFOV and (closestDist == -1 or distance < closestDist) then
                                        closestPed = policePed
                                        closestDist = distance
                                end
                        end
                end
        end
        return closestPed, closestDist
end


-- Function for returning the closest amount of peds
function GetClosestPolicePeds(coords)
        local playerPed = PlayerPedId()
        local policePeds = {}
        coords = coords or GetEntityCoords(playerPed)

        for _, entity in pairs(GetGamePool("CPed")) do
                if IsEntityAPed(entity) and GetPedType(entity) == 7 then -- Ped is a cop
                        local policePed
                        if IsPedInAnyVehicle(entity, true) then
                                policePed = GetPedInVehicleSeat(entity, -1)
                        else
                                policePed = entity
                        end

                        if DoesEntityExist(policePed) then
                                local isDead = IsEntityDead(policePed)
                                local isPlayerInFOV = IsPlayerInPedFOV(policePed, playerPed)
                                local distance = #(coords - GetEntityCoords(policePed))
                                if not isDead and isPlayerInFOV then
                                        table.insert(policePeds, {ped = policePed, dist = distance})
                                        if debug_enabled then
                                                print('GetClosestPolicePeds: Police PED nearby (' .. policePed .. ') distance: (' .. distance .. ')')
                                        end
                                end
                        end
                end
        end

        -- Sort the policePeds table by distance in ascending order
        table.sort(policePeds, function(a, b) return a.dist < b.dist end)

        local closestPolicePeds = {}
        local maxClosestPeds = 5

        for i, data in ipairs(policePeds) do
                if i <= maxClosestPeds then
                        table.insert(closestPolicePeds, data.ped)
                        if debug_enabled then
                                print('GetClosestPolicePeds: Returning (' .. data.ped .. ')')
                        end
                else
                        break
                end
        end

        return closestPolicePeds
end

-- Thread to check player movement
Citizen.CreateThread(function()
        while true do
                CheckPlayerStopped()
                Citizen.Wait(1000) -- every 1 second
        end
end)

-- Modify police behavior based on players wanted level
Citizen.CreateThread(function()
        wanted_notified = false
        while true do

                Citizen.Wait(1000) -- every 1 second
                local policePed = -1
                local playerCoords = GetEntityCoords(PlayerPedId())
                local closestPolicePeds = GetClosestPolicePeds(playerCoords)

                -- todo: keep relationship set to respectful between police and player
                -- SetRelationshipBetweenGroups(1, GetHashKey("police"), GetHashKey("PLAYER"))
                -- SetRelationshipBetweenGroups(1, GetHashKey("PLAYER"), GetHashKey("police"))

                -- checking for combat on level 1 and 2, go straight to 3 stars if you shoot a weapon
                if IsPlayerWantedLevelGreater(PlayerId(), 0) then
                        if GetPlayerWantedLevel(PlayerId()) == 1 or GetPlayerWantedLevel(PlayerId()) == 2 then
                                if IsPlayerTargettingAnything(PlayerId()) then
                                        if IsPedShooting(PlayerPedId()) then
                                                SetPlayerWantedLevel(PlayerId(), 3, false)
                                                SetPlayerWantedLevelNow(PlayerId(), false)
                                                PlayerWantedCheck = false
                                        end
                                end
                        end
                end

                ----------------------------------
                ----------------------------------
                ----------------------------------

                -- level 1 initial code once you become wanted, police will attempt to arrest you
                if PlayerWantedCheck == false and GetPlayerWantedLevel(PlayerId()) == 1 then
                        for index, entity in pairs(GetGamePool("CPed")) do
                                -- assigning entity.. also consider peds in vehicles
                                if IsEntityAPed(entity) then
                                        -- if ped is type 'PED_TYPE_COP'
                                        if GetPedType(entity) == 7 then
                                                if IsPedInAnyVehicle(entity, true) then
                                                        policePed = GetPedInVehicleSeat(entity, -1)
                                                else
                                                        policePed = entity
                                                end
                                        end
                                end
                                if GetPedType(entity) == 7 then
                                        local isdead = IsEntityDead(policePed)
                                        if policePed ~= playerPed and not isdead then
                                                RemoveAllPedWeapons(policePed, true)
                                                --StopPedSpeaking(policePed, StopPoliceSpeaking)
                                                if not GetCurrentPedWeapon(policePed, GetHashKey("WEAPON_FLASHLIGHT")) then
                                                        GiveWeaponToPed(policePed, GetHashKey("WEAPON_FLASHLIGHT"), 100, false, true)
                                                end
                                                if not GetCurrentPedWeapon(policePed, GetHashKey("WEAPON_NIGHTSTICK")) then
                                                        GiveWeaponToPed(policePed, GetHashKey("WEAPON_NIGHTSTICK"), 100, false, false)
                                                end
                                                ----------------------------------
                                                -- loop through all nearby police peds and arrest player
                                                for _, nearbyPolicePed in ipairs(closestPolicePeds) do
                                                        local policeVehicle = GetVehiclePedIsIn(nearbyPolicePed, false)
                                                        -- Check if the police ped is in a vehicle and the player is in a vehicle
                                                        if DoesEntityExist(policeVehicle) and IsEntityAVehicle(policeVehicle) then
                                                                -- Get the vehicle player is in
                                                                local playerVehicle = GetVehiclePedIsIn(playerPed, false)
                                                                if DoesEntityExist(playerVehicle) and IsEntityAVehicle(playerVehicle) then
                                                                        -- Check if the player is in the driver's seat
                                                                        local playerSeat = GetPedInVehicleSeat(playerVehicle, -1)
                                                                        if playerSeat == playerPed then
                                                                                -- Attempt to remove the player from the vehicle
                                                                                print('debug - bot exit vehicle and attempt arrest')
                                                                                TaskLeaveVehicle(policePed, policeVehicle, 256) -- 256 is a flag to make the ped leave immediately
                                                                                Citizen.Wait(1000) -- Wait for 1 second
                                                                                AttemptArrest(policePed) -- Attempt to arrest the player
                                                                        end
                                                                end
                                                        -- Police ped is not in any vehicle, approach player and attempt arrest
                                                        elseif not DoesEntityExist(policeVehicle) or not IsEntityAVehicle(policeVehicle) then
                                                                local policeCoords = GetEntityCoords(policePed)
                                                                local distance = #(playerCoords - policeCoords)
                                                                print('debug - sending police ped on foot')

                                                                -- Check if the police ped is close enough to the player to approach
                                                                if distance < 5.0 then
                                                                        -- Stop the police ped from wandering around
                                                                        TaskStandStill(policePed, -1)

                                                                        -- Face the player
                                                                        TaskTurnPedToFaceEntity(policePed, playerPed, -1)

                                                                        -- Attempt to arrest the player
                                                                        AttemptArrest(policePed)
                                                                else
                                                                        -- If distance is greater than or equal to 5, make the police ped approach the player
                                                                        TaskGoToEntity(policePed, playerPed, -1, 5.0, 100.0, 0, 0)
                                                                end
                                                        end
                                                end
                                                ----------------------------------
                                        end
                                end
                        end
                        PlayerWantedCheck = true
                end

                ----------------------------------
                ----------------------------------
                ----------------------------------

                -- level 2 police will now use tasers and attempt to arrest you
                if PlayerWantedCheck == true and GetPlayerWantedLevel(PlayerId()) == 2 then
                        for index, entity in pairs(GetGamePool("CPed")) do
                                -- assigning entity.. also consider peds in vehicles
                                if IsEntityAPed(entity) then
                                        -- if ped is type 'PED_TYPE_COP'
                                        if GetPedType(entity) == 7 then
                                                if IsPedInAnyVehicle(entity, true) then
                                                        policePed = GetPedInVehicleSeat(entity, -1)
                                                else
                                                        policePed = entity
                                                end
                                        end
                                end
                                if GetPedType(entity) == 7 then
                                        local isdead = IsEntityDead(policePed)
                                        if policePed ~= playerPed and not isdead then
                                                RemoveAllPedWeapons(policePed, true)
                                                --StopPedSpeaking(policePed, StopPoliceSpeaking)
                                                if not GetCurrentPedWeapon(entity, GetHashKey("WEAPON_FLASHLIGHT")) then
                                                        GiveWeaponToPed(entity, GetHashKey("WEAPON_FLASHLIGHT"), 100, false, false)
                                                end
                                                if not GetCurrentPedWeapon(entity, GetHashKey("WEAPON_NIGHTSTICK")) then
                                                        GiveWeaponToPed(entity, GetHashKey("WEAPON_NIGHTSTICK"), 100, false, false)
                                                end
                                                if not GetCurrentPedWeapon(entity, GetHashKey("WEAPON_STUNGUN")) then
                                                        GiveWeaponToPed(entity, GetHashKey("WEAPON_STUNGUN"), 100, false, true)
                                                end
                                                if not IsPedRunningArrestTask(policePed) then
                                                        ShowNotification("~r~Police~s~ are attempting to stun you!")
                                                        ClearPedTasks(policePed)
                                                        ClearPedTasksImmediately(policePed)
                                                        TaskArrestPed(policePed, PlayerId())
                                                        SetPedKeepTask(policePed, true)
                                                end
                                        end
                                end
                        end
                        PlayerWantedCheck = false
                end

                ----------------------------------
                ----------------------------------
                ----------------------------------

                -- level 3 police start using pistols now
                if PlayerWantedCheck == false and GetPlayerWantedLevel(PlayerId()) == 3 then
                        for index, entity in pairs(GetGamePool("CPed")) do
                                -- assigning entity.. also consider peds in vehicles
                                if IsEntityAPed(entity) then
                                        -- if ped is type 'PED_TYPE_COP'
                                        if GetPedType(entity) == 7 then
                                                if IsPedInAnyVehicle(entity, true) then
                                                        policePed = GetPedInVehicleSeat(entity, -1)
                                                else
                                                        policePed = entity
                                                end
                                        end
                                end
                                if GetPedType(entity) == 7 then
                                        local isdead = IsEntityDead(policePed)
                                        if policePed ~= playerPed and not isdead then
                                                ClearPedTasks(policePed)
                                                RemoveAllPedWeapons(policePed, true)
                                                --StopPedSpeaking(policePed, StopPoliceSpeaking)
                                                if not GetCurrentPedWeapon(entity, GetHashKey("WEAPON_FLASHLIGHT")) then
                                                        GiveWeaponToPed(entity, GetHashKey("WEAPON_FLASHLIGHT"), 100, false, false)
                                                end
                                                if not GetCurrentPedWeapon(entity, GetHashKey("WEAPON_NIGHTSTICK")) then
                                                        GiveWeaponToPed(entity, GetHashKey("WEAPON_NIGHTSTICK"), 100, false, false)
                                                end
                                                if not GetCurrentPedWeapon(entity, GetHashKey("WEAPON_STUNGUN")) then
                                                        GiveWeaponToPed(entity, GetHashKey("WEAPON_STUNGUN"), 100, false, false)
                                                end
                                                if not GetCurrentPedWeapon(entity, GetHashKey("WEAPON_COMBATPISTOL")) then
                                                        GiveWeaponToPed(entity, GetHashKey("WEAPON_COMBATPISTOL"), 150, false, true)
                                                end
                                                ShowNotification("~r~Police~s~ are attempting to shoot you!")
                                        end
                                end
                        end
                        PlayerWantedCheck = true
                end

                ----------------------------------
                ----------------------------------
                ----------------------------------

                -- level 5 police start using rifles
                if PlayerWantedCheck == true and GetPlayerWantedLevel(PlayerId()) >= 5 then
                        for index, entity in pairs(GetGamePool("CPed")) do
                                -- assigning entity.. also consider peds in vehicles
                                if IsEntityAPed(entity) then
                                        -- if ped is type 'PED_TYPE_COP'
                                        if GetPedType(entity) == 7 then
                                                if IsPedInAnyVehicle(entity, true) then
                                                        policePed = GetPedInVehicleSeat(entity, -1)
                                                else
                                                        policePed = entity
                                                end
                                        end
                                end
                                if GetPedType(entity) == 7 then
                                        local isdead = IsEntityDead(policePed)
                                        if policePed ~= playerPed and not isdead then
                                                --StopPedSpeaking(policePed, StopPoliceSpeaking)
                                                if not GetCurrentPedWeapon(entity, GetHashKey("WEAPON_FLASHLIGHT")) then
                                                        GiveWeaponToPed(entity, GetHashKey("WEAPON_FLASHLIGHT"), 100, false, false)
                                                end
                                                if not GetCurrentPedWeapon(entity, GetHashKey("WEAPON_NIGHTSTICK")) then
                                                        GiveWeaponToPed(entity, GetHashKey("WEAPON_NIGHTSTICK"), 100, false, false)
                                                end
                                                if not GetCurrentPedWeapon(entity, GetHashKey("WEAPON_STUNGUN")) then
                                                        GiveWeaponToPed(entity, GetHashKey("WEAPON_STUNGUN"), 100, false, false)
                                                end
                                                if not GetCurrentPedWeapon(entity, GetHashKey("WEAPON_COMBATPISTOL")) then
                                                        GiveWeaponToPed(entity, GetHashKey("WEAPON_COMBATPISTOL"), 150, false, false)
                                                end
                                                if not GetCurrentPedWeapon(entity, GetHashKey("WEAPON_CARBINERIFLE")) then
                                                        GiveWeaponToPed(entity, GetHashKey("WEAPON_CARBINERIFLE"), 300, false, true)
                                                end
                                                ShowNotification("~r~Police~s~ are attempting to kill you!")
                                        end
                                end
                        end
                end

                -- reset things back to normal
                if GetPlayerWantedLevel(PlayerId()) == 0 then
                        PlayerWantedCheck = false
                end
        end
end)

-- Get the closest police within line of sight and reports crimes on player
Citizen.CreateThread(function()
        while true do
                Wait(1000) -- every 1 second

                -- collect player info
                local playerPed = PlayerPedId()
                local playerName = GetPlayerName(PlayerId())

                -- get closest PED that is police and in the line of sight of player
                local ent, dist = GetClosestPolicePed()

                -- dont bother checking if no police PED can see player
                if not ent == -1 and not dist == -1 then
                        -- traffic violations (is player in vehicle)
                        if IsPedInAnyVehicle(PlayerPedId(), false) then

                                local playerveh = GetVehiclePedIsUsing(playerPed)
                                local speedmph = (GetEntitySpeed(playerveh) * 2.236936)
                                local vehicleClass = GetVehicleClass(playerveh)

                                -- line of sight has no limit on distance, so we manually set threshold
                                if dist < MaxLosDist then
                                        -- if player is not already wanted
                                        if not IsPlayerWantedLevelGreater(PlayerId(), 0) then
                                                print('dist: ' .. dist)
                                                print('maxLosDist: ' .. MaxLosDist)
                                                local wheelieState = GetVehicleWheelieState(playerveh)
                                                if vehicleClass == 16 then
                                                        -- vehicle is a plane, do nothing
                                                else
                                                        -- cop sees you speeding in car
                                                        if speedmph > GlobalSpeedLimit then
                                                                ShowNotification("Speeding Violation! (~r~" .. speedmph .. " mph~s~)")
                                                                print(playerName .. " got a speeding violation! (" .. speedmph .. ") cop (" .. ent .. ") dist (" .. dist .. ")")
                                                                local policeBlip = AddBlipForEntity(ent)
                                                                SetBlipSprite(policeBlip, 8)
                                                                SetBlipColour(policeBlip, 1)
                                                                SetBlipAsShortRange(policeBlip, true)
                                                                ReportCrime(PlayerId(), 4, GetWantedLevelThreshold(1)) -- 4: Speeding vehicle (a "5-10")
                                                                -- cop sees you doing a wheelie
                                                        elseif wheelieState == 129 or wheelieState == 65 then
                                                                ShowNotification("~r~Police~s~ witnessed you doing a wheelie!")
                                                                print(playerName .. "Police witnessed you doing a wheelie! cop (" .. ent .. ") dist (" .. dist .. ")")
                                                                local policeBlip = AddBlipForEntity(ent)
                                                                SetBlipSprite(policeBlip, 8)
                                                                SetBlipColour(policeBlip, 1)
                                                                SetBlipAsShortRange(policeBlip, true)
                                                                ReportCrime(PlayerId(), 3, GetWantedLevelThreshold(1)) -- 3: Reckless driver
                                                                -- cop sees you driving known stolen vehicle
                                                        elseif IsVehicleStolen(playerveh) then
                                                                ShowNotification("~r~Police~s~ witnessed you driving a stolen vehicle!")
                                                                print(playerName .. "Police witnessed you driving a stolen vehicle! cop (" .. ent .. ") dist (" .. dist .. ")")
                                                                local policeBlip = AddBlipForEntity(ent)
                                                                SetBlipSprite(policeBlip, 8)
                                                                SetBlipColour(policeBlip, 1)
                                                                SetBlipAsShortRange(policeBlip, true)
                                                                ReportCrime(PlayerId(), 7, GetWantedLevelThreshold(1)) -- 7: Vehicle theft (a "5-0-3")
                                                                -- cop sees you hit any entity with vehicle
                                                        elseif HasEntityCollidedWithAnything(playerveh) then
                                                                ShowNotification("~r~Police~s~ witnessed bad driving!")
                                                                print(playerName .. "Police witnessed bad driving! cop (" .. ent .. ") dist (" .. dist .. ")")
                                                                local policeBlip = AddBlipForEntity(ent)
                                                                SetBlipSprite(policeBlip, 8)
                                                                SetBlipColour(policeBlip, 1)
                                                                SetBlipAsShortRange(policeBlip, true)
                                                                ReportCrime(PlayerId(), 3, GetWantedLevelThreshold(1)) -- 3: Reckless driver
                                                                -- cop sees you driving a known wanted vehicle (evaded successfully)
                                                        elseif IsVehicleWanted(playerveh) then
                                                                ShowNotification("~r~Police~s~ witnessed you driving a known wanted vehicle!")
                                                                print("Police witnessed " .. playerName .. " driving a known wanted vehicle! cop (" .. ent .. ") dist (" .. dist .. ")")
                                                                local policeBlip = AddBlipForEntity(ent)
                                                                SetBlipSprite(policeBlip, 8)
                                                                SetBlipColour(policeBlip, 1)
                                                                SetBlipAsShortRange(policeBlip, true)
                                                                ReportCrime(PlayerId(), 9, GetWantedLevelThreshold(1)) -- 9: ???
                                                                -- cop sees you burning out
                                                        elseif IsVehicleInBurnout(playerveh) then
                                                                BO_WarningCounter = BO_WarningCounter + 1
                                                                if BO_WarningCounter >= BO_WarningThreshold then
                                                                        ShowNotification("~r~Police~s~ witnessed your burnout!")
                                                                        print("Police witnessed " .. playerName .. " doing a burnout! cop (" .. ent .. ") dist (" .. dist .. ")")
                                                                        local policeBlip = AddBlipForEntity(ent)
                                                                        SetBlipSprite(policeBlip, 8)
                                                                        SetBlipColour(policeBlip, 1)
                                                                        SetBlipAsShortRange(policeBlip, true)
                                                                        ReportCrime(PlayerId(), 3, GetWantedLevelThreshold(1)) -- 3: Reckless driver
                                                                        BO_WarningCounter = 0
                                                                end
                                                                -- cop sees your vehicle no on all wheels (air time)
                                                        elseif not IsVehicleOnAllWheels(playerveh) then
                                                                TOG_WarningCounter = TOG_WarningCounter + 1
                                                                if TOG_WarningCounter >= TOG_WarningThreshold then
                                                                        ShowNotification("~r~Police~s~ witnessed reckless driving!")
                                                                        print("Police witnessed tires off ground! cop (" .. ent .. ") dist (" .. dist .. ")")
                                                                        local policeBlip = AddBlipForEntity(ent)
                                                                        SetBlipSprite(policeBlip, 8)
                                                                        SetBlipColour(policeBlip, 1)
                                                                        SetBlipAsShortRange(policeBlip, true)
                                                                        ReportCrime(PlayerId(), 3, GetWantedLevelThreshold(1)) -- 3: Reckless driver
                                                                        WarningCounter = 0
                                                                end
                                                        end
                                                        -- cop sees you run a red light
                                                        local nearbyVehicles = {}
                                                        for _, aiVehicle in pairs(GetGamePool("CVehicle")) do
                                                                if DoesEntityExist(aiVehicle) and aiVehicle ~= playerVehicle then
                                                                        local aiCoords = GetEntityCoords(aiVehicle)
                                                                        local aiHeading = GetEntityHeading(aiVehicle)

                                                                        -- Check the distance between the player's vehicle and the AI vehicle
                                                                        local playerCoords = GetEntityCoords(player, false)
                                                                        local distance = #(playerCoords - aiCoords)

                                                                        if distance <= nearbyDistance then
                                                                                table.insert(nearbyVehicles, { vehicle = aiVehicle, heading = aiHeading, dist = distance })
                                                                                print('vehicle found nearby (' .. aiVehicle .. ')')
                                                                        end
                                                                end
                                                        end
                                                        -- Process nearby vehicles that meet the criteria
                                                        for _, aiData in pairs(nearbyVehicles) do
                                                                local aiVehicle = aiData.vehicle
                                                                local aiHeading = aiData.heading
                                                                local distance = aiData.dist

                                                                if aiVehicle and DoesEntityExist(aiVehicle) then
                                                                        print('checking if vehicle is stopped at red light')
                                                                        -- Check if the AI vehicle is stopped at a red light
                                                                        if IsVehicleStoppedAtRedLight(aiVehicle) then
                                                                                -- Collect the player heading
                                                                                local playerHeading = GetEntityHeading(playerveh)
                                                                                -- Calculate the angle difference between the AI vehicle and the player's vehicle
                                                                                local angleDiff = math.abs(playerHeading - aiHeading)
                                                                                print('Red light calculation (' .. angleDiff .. ' <= ' .. angleThreshold .. ')')
                                                                                -- Ensure the angle difference is within the threshold
                                                                                if angleDiff >= -angleThreshold and angleDiff <= angleThreshold then
                                                                                        -- The player ran a red light in front of the stopped AI vehicle
                                                                                        ShowNotification("~r~Police~s~ witnessed you running a red light!")
                                                                                        print("Police witnessed you running a red light! cop (" .. ent .. ") dist (" .. dist .. ")")
                                                                                        local policeBlip = AddBlipForEntity(ent)
                                                                                        SetBlipSprite(policeBlip, 8)
                                                                                        SetBlipColour(policeBlip, 1)
                                                                                        SetBlipAsShortRange(policeBlip, true)
                                                                                        ReportCrime(PlayerId(), 2, GetWantedLevelThreshold(1)) -- 2: Person running a red light ("5-0-5")
                                                                                end
                                                                        end
                                                                end
                                                        end
                                                end
                                        end
                                end

                                -- non-moving violations
                        else
                                -- line of sight has no limit on distance, so we manually set threshold
                                if dist < MaxLosDist then
                                        -- cop sees you fighting
                                        if IsPedInMeleeCombat(ped) then
                                                ShowNotification("Battery Violation! (~r~" .. speedmph .. " mph~s~)")
                                                print(playerName .. " got a battery violation! (" .. speedmph .. ") cop (" .. ent .. ") dist (" .. dist .. ")")
                                                local policeBlip = AddBlipForEntity(ent)
                                                SetBlipSprite(policeBlip, 8)
                                                SetBlipColour(policeBlip, 1)
                                                SetBlipAsShortRange(policeBlip, true)
                                                ReportCrime(PlayerId(), 11, GetWantedLevelThreshold(1)) -- 11: Assault on a civilian (a "2-40")
                                        end
                                end
                        end
                end
        end
end)
