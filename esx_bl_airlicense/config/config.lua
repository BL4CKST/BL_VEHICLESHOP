Config                 = {}
Config.DrawDistance    = 8.0
Config.MaxErrors       = 3
Config.SpeedMultiplier = 3.6
Config.PricesOfExam	   = 100000
Config.VehicleModel    = "Velum"

Config.SpeedLimits = {
	level1   = 35,
	level2   = 130,
	level3   = 200
}

Config.Zones = {

	AIRSchool = {
		Pos   = {x = -1042.58, y = -2745.94, z = 21.36},
		Size  = {x = 0.4, y = 0.4, z = 0.4}, 
		Color = {r = 23, g = 190, b = 97},
		Type  = 33
	},

	VehicleSpawnPoint = {
		Pos   = {x = -978.79, y = -2996.29, z =14.88, h = 56.87},
		Size  = {x = 1.5, y = 1.5, z = 1.0},
		Color = {r = 204, g = 204, b = 0},
		Type  = -1
	}

}

Config.CheckPoints = {

	{
		Pos = {x = -1050.74, y = -2957.4, z = 14.91}, 
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText("Acercate a la pista de aterrizaje lentamente, velocidad maxima ~o~" ..Config.SpeedLimits['level1'].."km/h", 5000)
		end
	},

	{
		Pos = {x = -1084.38, y = -3024.3, z = 14.88},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText("Bien, ve al siguente punto y manten la ~o~velocidad ~w~permitida", 5000)
		end
	},

	{
		Pos = {x = -1007.86, y = -3073.81, z = 14.88},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText("Bien, ahora entra a la pista de aterrizaje", 5000)
		end
	},

	{
		Pos = {x = -996.82, y = -3144.71, z = 14.89},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			CreateThread(function()
				DrawMissionText("~o~Ya estas en la zona de aterrizaje, revisa que todo este en orden", 5000)
				FreezeEntityPosition(vehicle, true)
				Wait(5000)
				FreezeEntityPosition(vehicle, false)
				DrawMissionText("~g~Excelente, ahora dirigete a la zona de despegue", 5000)
			end)
		end
	},

	{
		Pos = {x = -905.5, y = -3197.52, z = 14.88},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText("Bien, dobla lentamente a la ~o~derecha", 5000)
		end
	},
	{
		Pos = {x = -882.66, y = -3261.43, z = 14.88},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			
		end
	},
	{
		Pos = {x = -920.08, y = -3325.72, z = 14.88},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText("Ahora dobla lentamente a la ~o~derecha", 5000)
		end
	},

	{
		Pos = {x =-1015.61, y = -3328.63, z = 14.88}, 
		Action = function(playerPed, vehicle, setCurrentZoneType)
			setCurrentZoneType('level2')
			CreateThread(function()
				DrawMissionText("~g~Bien, es momento de despegar, recuerda que de esto depende tu licencia.", 5000)		
				FreezeEntityPosition(vehicle, true)
				Wait(6000)
				FreezeEntityPosition(vehicle, false)
				DrawMissionText("Tu limite Max. de velocidad de vuelo es ~o~"..Config.SpeedLimits['level2'].."km/h", 5000)
				
			end)
		end
	},

	{
		Pos = {x = -1059.05, y = -3303.54, z = 14.88},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			
		end
	},

	{
		Pos = {x = -1141.39, y = -3255.52, z = 14.88},
		Action = function(playerPed, vehicle, setCurrentZoneType)
		
		end
	},
	{
		Pos = {x = -1262.96, y = -3185.56, z = 14.89}, 
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText("Estas a punto de despegar", 5000)
		end
	},

	{
		Pos = {x = -1424.76, y = -3092.13, z = 14.89},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText("~r~Despega ahora y elevate ", 5000)
			Wait(8000)
			DrawMissionText("No te olvides guardar las ruedas del avion", 5000)
		end
	}, --ook

	{
		Pos = {x = -2073.55, y = 2896.92, z = 33.74},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText("Estas aterrizando, sigue las lineas", 5000)
		end
	},
	
	{
		Pos = {x = -2136.1, y = 2933.15, z = 33.75},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText("Reduce la ~o~velocidad~w~ lo mas rapido posible", 5000)
		end
	},

	{
		Pos = {x = -2278.91, y = 3015.39, z = 33.75},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText("~g~Perfecto, fue un buen aterrizaje, ve al siguiente punto", 5000)
		end
	},
	{
		Pos = {x = -2306.28, y = 3134.33, z = 33.75},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText("Ahora ve a la zona de ~o~despegue corta.", 5000)
		end
	},
	{
		Pos = {x = -2384.03, y = 3180.1, z = 33.76}, 
		Action = function(playerPed, vehicle, setCurrentZoneType)
			setCurrentZoneType('level3')
			CreateThread(function()				
				DrawMissionText("Podras despegar esta pequeña pista?, ahora lo haras tu solo, Velocidad Max ~o~"..Config.SpeedLimits['level3'].."km/h", 5000)
				FreezeEntityPosition(vehicle, true)
				Wait(6000)
				FreezeEntityPosition(vehicle, false)
				DrawMissionText("~g~Vuela hasta el aereopuerto donde despegaste y aterriza correctamente", 5000)
			end)
		end
	},
	{
		Pos = {x = -2407.32, y = 3192.78, z = 33.77},
		Action = function(playerPed, vehicle, setCurrentZoneType)	
		end
	},

	{
		Pos = {x = -2605.78, y = 3307.31, z = 33.75},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText("~r~Elevate yaaa!!", 5000)
		end
	},
	{
		Pos = {x = -1562.74, y = -3012.41, z = 14.89},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText("Perfecto, baja la ~o~velocidad", 5000)
		end
	},
	{
		Pos = {x = -1354.41, y = -3133.78, z = 14.89},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText("~g~Eso fue un buen aterrizaje, dirigete al siguiente punto", 5000)
		end
	},
	{
		Pos = {x = -1182.55, y = -3194.11, z = 14.89},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText("Ve a guardar el avion en la ~o~zona de inicio", 5000)
		end
	},
	{
		Pos = {x = -1106.11, y = -3082.35, z = 14.89},
		Action = function(playerPed, vehicle, setCurrentZoneType)	
		end
	},
	{
		Pos = {x = -1042.89, y = -3082.18, z = 14.89},
		Action = function(playerPed, vehicle, setCurrentZoneType)	
		end
	},
	{
		Pos = {x = -1071.52, y = -3012.67, z = 14.89},
		Action = function(playerPed, vehicle, setCurrentZoneType)	
		end
	},
	{
		Pos = {x = -1057.06, y = -2959.86, z = 14.89},
		Action = function(playerPed, vehicle, setCurrentZoneType)	
		end
	},
	{
		Pos = {x = -980.88, y = -2994.98, z = 14.88},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			ESX.Game.DeleteVehicle(vehicle)
		end
	}

}
