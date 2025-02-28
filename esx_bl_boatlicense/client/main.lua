local CurrentAction     = nil
local CurrentActionMsg  = nil
local CurrentActionData = nil
local Licenses          = {}
local CurrentTest       = nil
local CurrentTestType   = nil
local CurrentVehicle    = nil
local CurrentCheckPoint, DriveErrors = 0, 0
local LastCheckPoint    = -1
local CurrentBlip       = nil
local CurrentZoneType   = nil
local IsAboveSpeedLimit = false
local LastVehicleHealth = nil

function DrawMissionText(msg, time)
	ClearPrints()
	BeginTextCommandPrint('STRING')
	AddTextComponentSubstringPlayerName(msg)
	EndTextCommandPrint(time, true)
end

function StartDriveTest(type)
	ESX.Game.SpawnVehicle(Config.VehicleModel, vector3(Config.Zones.VehicleSpawnPoint.Pos.x, Config.Zones.VehicleSpawnPoint.Pos.y, Config.Zones.VehicleSpawnPoint.Pos.z), Config.Zones.VehicleSpawnPoint.Pos.h, function(vehicle)
		CurrentTest       = 'boat'
		CurrentTestType   = type
		CurrentCheckPoint = 0
		LastCheckPoint    = -1
		CurrentZoneType   = 'level1'
		DriveErrors       = 0
		IsAboveSpeedLimit = false
		CurrentVehicle    = vehicle
		LastVehicleHealth = GetEntityHealth(vehicle)
		local playerPed   = PlayerPedId()
		TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
		SetVehicleFuelLevel(vehicle, 100.0)
		DecorSetFloat(vehicle, "_FUEL_LEVEL", GetVehicleFuelLevel(vehicle))
	end)
end

function StopBoatExam(success)
	if success then
		TriggerServerEvent('esx_bl_boatlicense:addLicense', "boat_license")
		ESX.ShowNotification("Felcitaciones, pasaste el examen correctamente")
	else
		ESX.ShowNotification("No llegaste a superar el examen")
	end
	CurrentTest     = nil
	CurrentTestType = nil
end

function SetCurrentZoneType(type)
CurrentZoneType = type
end

function OpenBOATSchoolMenu()
	local ownedLicenses = {}
	for i=1, #Licenses, 1 do
		ownedLicenses[Licenses[i].type] = true
	end
	local elements = {}

		if not ownedLicenses['boat_license'] then
			table.insert(elements, {
				label = (('%s - <span style="color:orange;">[ %s ]</span>'):format("Rendir examen ", Config.PricesOfExam)),
				value = 'boat_test',
				type = 'boat'
			})
		end
		if ownedLicenses['boat_license'] then
			table.insert(elements, {
				label = ("Ya tienes la licencia de botes, consulta /verlicencia")
			})
		end

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'boat_license_actions', {
		title    = "Escuela de conduccion de botes",
		elements = elements,
		align    = 'right'
	}, function(data, menu)
		if data.current.value == 'boat_test' then
			menu.close()
			ESX.TriggerServerCallback('esx_bl_boatlicense:canYouPay', function(haveMoney)
				if haveMoney then
					StartDriveTest(data.current.type)
				else
					ESX.ShowNotification("No tienes suficiente dinero")
				end
			end, data.current.type)
		end
	end, function(data, menu)
		menu.close()
		CurrentAction     = 'boatlicense_menu'
		CurrentActionMsg  = "Pulse [E] para abrir el menu"
		
	end)
end


AddEventHandler('esx_bl_boatlicense:hasEnteredMarker', function(zone)
	if zone == 'BOATSchool' then
		CurrentAction     = 'boatlicense_menu'
		CurrentActionMsg  = "Pulse [E] para abrir el menu"
		CurrentActionData = {}
	end
end)

AddEventHandler('esx_bl_boatlicense:hasExitedMarker', function(zone)
	CurrentAction = nil
	ESX.UI.Menu.CloseAll()
end)

RegisterNetEvent('esx_bl_boatlicense:loadLicenses')
AddEventHandler('esx_bl_boatlicense:loadLicenses', function(licenses)
	Licenses = licenses
end)

CreateThread(function()
	local blip = AddBlipForCoord(Config.Zones.BOATSchool.Pos.x, Config.Zones.BOATSchool.Pos.y, Config.Zones.BOATSchool.Pos.z)

	SetBlipSprite (blip, 410)
	SetBlipDisplay(blip, 4)
	SetBlipScale  (blip, 0.7)
	SetBlipColour (blip, 2)
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentSubstringPlayerName("Escuela de manejo de botes")
	EndTextCommandSetBlipName(blip)
end)

CreateThread(function()
	while true do
		local sleep = 1500
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)

		for k,v in pairs(Config.Zones) do
			local Pos = vector3(v.Pos.x, v.Pos.y, v.Pos.z)
			if(v.Type ~= -1 and #(coords - Pos) < Config.DrawDistance) then
				sleep = 0
				DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
			end
		end

		if CurrentTest == 'boat' then
			sleep = 0
			local nextCheckPoint = CurrentCheckPoint + 1

			if Config.CheckPoints[nextCheckPoint] == nil then
				if DoesBlipExist(CurrentBlip) then
					RemoveBlip(CurrentBlip)
				end

				CurrentTest = nil

				ESX.ShowNotification("Examen de manejo finalizado")

				if DriveErrors < Config.MaxErrors then
					StopBoatExam(true)
				else
					StopBoatExam(false)
				end
			else
				if CurrentCheckPoint ~= LastCheckPoint then
					if DoesBlipExist(CurrentBlip) then
						RemoveBlip(CurrentBlip)
					end

					CurrentBlip = AddBlipForCoord(Config.CheckPoints[nextCheckPoint].Pos.x, Config.CheckPoints[nextCheckPoint].Pos.y, Config.CheckPoints[nextCheckPoint].Pos.z)
					SetBlipRoute(CurrentBlip, 1)

					LastCheckPoint = CurrentCheckPoint
				end
            
				local Pos = vector3(Config.CheckPoints[nextCheckPoint].Pos.x,Config.CheckPoints[nextCheckPoint].Pos.y,Config.CheckPoints[nextCheckPoint].Pos.z)
				local distance = #(coords - Pos)
            
				if distance <= Config.DrawDistance then
					DrawMarker(4, Config.CheckPoints[nextCheckPoint].Pos.x, Config.CheckPoints[nextCheckPoint].Pos.y, Config.CheckPoints[nextCheckPoint].Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 2.0, 2.0, 2.0, 23, 190, 97, 100, false, true, 2, false, false, false, false)
				end

				if distance <= 3.0 then
					Config.CheckPoints[nextCheckPoint].Action(playerPed, CurrentVehicle, SetCurrentZoneType)
					CurrentCheckPoint = CurrentCheckPoint + 1
				end
			end
		end

		if CurrentAction then
			sleep = 0
			ESX.TextUI(CurrentActionMsg)

			if (IsControlJustReleased(0, 38)) and (CurrentAction == 'boatlicense_menu') then
					OpenBOATSchoolMenu()
					ESX.HideUI()
					CurrentAction = nil
			end
		end
		
		local isInMarker  = false
		local currentZone = nil

		for k,v in pairs(Config.Zones) do
			local Pos = vector3(v.Pos.x, v.Pos.y, v.Pos.z)
			if(#(coords - Pos) < v.Size.x) then
				sleep = 0
				isInMarker  = true
				currentZone = k
			end
		end

		if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
			HasAlreadyEnteredMarker = true
			LastZone                = currentZone
			TriggerEvent('esx_bl_boatlicense:hasEnteredMarker', currentZone)
		end

		if not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			TriggerEvent('esx_bl_boatlicense:hasExitedMarker', LastZone)
			ESX.HideUI()
		end
		Wait(sleep)
	end
end)

CreateThread(function()
	while true do
		local sleep = 1500

		if CurrentTest == 'boat' then
			sleep = 0
			local playerPed = PlayerPedId()

			if IsPedInAnyVehicle(playerPed, false) then

				local vehicle      = GetVehiclePedIsIn(playerPed, false)
				local speed        = GetEntitySpeed(vehicle) * Config.SpeedMultiplier
				local tooMuchSpeed = false

				for k,v in pairs(Config.SpeedLimits) do
					if CurrentZoneType == k and speed > v then
						tooMuchSpeed = true

						if not IsAboveSpeedLimit then
							DriveErrors       = DriveErrors + 1
							IsAboveSpeedLimit = true

							ESX.ShowNotification("Reduce tu velocidad, la velocidad maxima es "..v.."km/h")
							ESX.ShowNotification("Fallos "..DriveErrors.." / "..Config.MaxErrors)
						end
					end
				end

				if not tooMuchSpeed then
					IsAboveSpeedLimit = false
				end

				local health = GetEntityHealth(vehicle)
				if health < LastVehicleHealth then

					DriveErrors = DriveErrors + 1

					ESX.ShowNotification("Estas dañando tu vehiculo")
					ESX.ShowNotification("Fallos "..DriveErrors.." / "..Config.MaxErrors)

					-- avoid stacking faults
					LastVehicleHealth = health
					Wait(1500)
				end
			end
		end
		Wait(sleep)
	end
end)
