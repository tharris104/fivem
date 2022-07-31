---------------------------------------------------
---------------------------------------------------
---------------------------------------------------

-- F3 (170)
-- F5 (166)
-- F6 (167)
-- F7 (168)

local keybind = 170 -- default 170: F3
local licenseplatename = 'NEMESIS'

---------------------------------------------------
---------------------------------------------------
---------------------------------------------------

menus = {
	['Police Cars'] = {
--		{ name = '1998 Toyota Supra JZA80', spawncode = 'mkivbb_vv' },
--		{ name = '2009 Corvette ZR1', spawncode = 'czr1' },
		{ name = '2009 Dodge Viper SRT-10', spawncode = 'viper' },
		{ name = '2018 Dodge Charger', spawncode = '1501' },
		{ name = '2020 Corvette C8', spawncode = '2020c8' },
		{ name = '2021 Lamborghini Aventador', spawncode = 'nm_avent' },
		{ name = '2021 Dodge Charger Hellcat', spawncode = 'HellcatRed' },
--		{ name = '2023 BMW 3Series G20', spawncode = 'ucg20' },
	},
	['Real Cars'] = {
		{ name = '2002 Nissan Skyline GT-R', spawncode = 'skyline' },
		{ name = '2021 Nissan GT-R', spawncode = '21gtr' },
		{ name = '2023 Toyota Supra', spawncode = 'a90pit' },
		{ name = 'Audi RS4', spawncode = 'rs4' },
		{ name = 'Ford Escort RS Cosworth', spawncode = 'cos' },
		{ name = 'Mitsubishi Eclipse GS-T', spawncode = 'gsx' },
		{ name = 'MK5 Golf R32', spawncode = 'mkvr32' },
	},
	['Muscle'] = {
		{ name = 'Gauntlet', spawncode = 'gauntlet' },
		{ name = 'Gauntlet2', spawncode = 'gauntlet2' },
		{ name = 'Dominator2', spawncode = 'dominator2' },
		{ name = 'Dominator', spawncode = 'dominator' },
		{ name = 'Dukes2', spawncode = 'dukes2' },
		{ name = 'Hotknife', spawncode = 'hotknife' },
		{ name = 'Ruiner2', spawncode = 'ruiner2' },
		{ name = 'SabreGT', spawncode = 'sabregt2' },
		{ name = 'Vigero', spawncode = 'vigero' },
	},
	['Sports'] = {
		{ name = 'Banshee2', spawncode = 'Banshee2' },
		{ name = 'Buffalo3', spawncode = 'Buffalo3' },
		{ name = 'Comet3', spawncode = 'Comet3' },
		{ name = 'Elegy2', spawncode = 'Elegy2' },
		{ name = 'Feltzer2', spawncode = 'Feltzer2' },
		{ name = 'Infernus2', spawncode = 'Infernus2' },
		{ name = 'Kuruma Armored', spawncode = 'Kuruma2' },
		{ name = 'RapidGT', spawncode = 'RapidGT' },
		{ name = 'Ruston Convertible', spawncode = 'Ruston' },
		{ name = 'Verlierer2', spawncode = 'Verlierer2' },
	},
	['Super'] = {
		{ name = 'Bullet', spawncode = 'Bullet' },
		{ name = 'Cheetah', spawncode = 'Cheetah' },
		{ name = 'GP1', spawncode = 'GP1' },
		{ name = 'FMJ', spawncode = 'FMJ' },
		{ name = 'RE7B', spawncode = 'RE7B' },
		{ name = 'Nero2', spawncode = 'Nero2' },
		{ name = 'Penetrator', spawncode = 'Penetrator' },
		{ name = 'Prototipo', spawncode = 'Prototipo' },
		{ name = 'Sheava', spawncode = 'Sheava' },
		{ name = 'Tempesta', spawncode = 'Tempesta' },
		{ name = 'Turismo2', spawncode = 'Turismo2' },
		{ name = 'Tyrus', spawncode = 'Tyrus' },
		{ name = 'Zentorno', spawncode = 'Zentorno' },
	},
	['Boats'] = {
		{ name = 'Dinghy2', spawncode = 'Dinghy2' },
		{ name = 'Jet Ski', spawncode = 'Seashark2' },
		{ name = 'Sailboat', spawncode = 'Marquis' },
		{ name = 'Speeder2', spawncode = 'Speeder2' },
		{ name = 'Squalo', spawncode = 'Squalo' },
		{ name = 'Toro2', spawncode = 'Toro2' },
	},
	['Planes'] = {
		{ name = 'Besra', spawncode = 'Besra' },
		{ name = 'Duster', spawncode = 'Duster' },
		{ name = 'Hydra', spawncode = 'Hydra' },
		{ name = 'Lazer', spawncode = 'Lazer' },
		{ name = 'Luxor2', spawncode = 'Luxor2' },
		{ name = 'Mammatus', spawncode = 'Mammatus' },
		{ name = 'Stunt', spawncode = 'Stunt' },
		{ name = 'Titan', spawncode = 'Titan' },
		{ name = 'Velum2', spawncode = 'Velum2' },
	}
}

---------------------------------------------------
---------------------------------------------------
---------------------------------------------------

_menuPool = NativeUI.CreatePool()
mainMenu = NativeUI.CreateMenu("Spawner Menu", "~g~Choose your catagory", 1430, 0)
_menuPool:Add(mainMenu)
mainMenu.SetMenuWidthOffset(50);
function initMenu(menu)
    for Name, Category in pairs(menus) do
        local doncatagory = _menuPool:AddSubMenu(menu, Name, '', true)
        for _, Vehicle in pairs(Category) do
            local donvehicles = NativeUI.CreateItem(Vehicle.name, '')
            doncatagory:AddItem(donvehicles)
            donvehicles.Activated = function(ParentMenu, SelectedItem)
                spawn(Vehicle.spawncode)
            end
        end
    end
end

initMenu(mainMenu)
_menuPool:RefreshIndex() 
_menuPool:MouseControlsEnabled (false)
_menuPool:MouseEdgeEnabled (false)
_menuPool:ControlDisablingEnabled(false)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        _menuPool:ProcessMenus()
        if IsControlJustPressed(1, keybind) then
            mainMenu:Visible(not mainMenu:Visible())
		end
	end
end)

function ShowNotification(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end

function spawn(car)
    -- show error and return if car does not exist
    if not IsModelInCdimage(car) or not IsModelAVehicle(car) then
        ShowNotification("~r~Cannot spawn " .. car .. "!")
        return
    end

    -- remove current vehicle
    DeleteVehicle(GetVehiclePedIsIn(GetPlayerPed(-1)))
    local coords = GetEntityCoords(GetPlayerPed(-1))
    RequestModel(car)
    while not HasModelLoaded(car) do
        Wait(0)
    end

    -- create the car
    local veh = CreateVehicle(car, coords.x + 3, coords.y + 3, coords.z + 1, GetEntityHeading(GetPlayerPed(-1)), true, false)

    -- move ped into car
    SetPedIntoVehicle(GetPlayerPed(-1), veh, -1)

    -- custom license plate
    SetVehicleNumberPlateText(veh, licenseplatename)

    -- https://docs.fivem.net/natives/?_0x6AF0636DDEDCB6DD
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

    -- add white HID headlights, stock is -1
    ToggleVehicleMod(veh, 22, true)
    SetVehicleXenonLightsColour(veh, 0)

    -- show notification of car and close
    ShowNotification("~g~Spawned " .. car .. "!")
    _menuPool:CloseAllMenus()
    return veh
end
