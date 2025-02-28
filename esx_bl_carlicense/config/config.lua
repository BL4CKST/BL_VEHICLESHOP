Config                 = {}
Config.DrawDistance    = 8.0
Config.MaxErrors       = 4
Config.SpeedMultiplier = 3.6
Config.PricesOfExam	   = 3000
Config.VehicleModel    = "blista"

Config.SpeedLimits = {
	level1   = 40,
	level2   = 70,
	level3   = 100
}

Config.Zones = {

	CARSchool = {
		Pos   = {x = 239.471, y = -1380.960, z = 33.741},
		Size  = {x = 0.4, y = 0.4, z = 0.4}, 
		Color = {r = 23, g = 190, b = 97},
		Type  = 36
	},

	VehicleSpawnPoint = {
		Pos   = {x = 249.409, y = -1407.230, z = 30.4094, h = 317.0},
		Size  = {x = 1.5, y = 1.5, z = 1.0},
		Color = {r = 204, g = 204, b = 0},
		Type  = -1
	}

}

Config.CheckPoints = {

	{
		Pos = {x = 255.139, y = -1400.731, z = 29.537},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText("¡Vete al siguiente punto! Límite de velocidad: "..Config.SpeedLimits['level1'].."km/h", 5000)
		end
	},

	{
		Pos = {x = 271.874, y = -1370.574, z = 30.932},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText("Vete al siguiente punto", 5000)
		end
	},

	{
		Pos = {x = 234.907, y = -1345.385, z = 29.542},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			CreateThread(function()
				DrawMissionText("Para en el paso de peatones", 5000)
				PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', false, 0, true)
				FreezeEntityPosition(vehicle, true)
				Wait(4000)

				FreezeEntityPosition(vehicle, false)
				DrawMissionText("Bien, continua", 5000)
			end)
		end
	},

	{
		Pos = {x = 217.821, y = -1410.520, z = 28.292},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			setCurrentZoneType('level2')

			CreateThread(function()
				DrawMissionText("~r~Para y mira a la izquierda. Límite de velocidad: "..Config.SpeedLimits['level2'].."km/h", 5000)
				PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', false, 0, true)
				FreezeEntityPosition(vehicle, true)
				Wait(6000)

				FreezeEntityPosition(vehicle, false)
				DrawMissionText("Bien, gira a la derecha y sigue la línea", 5000)
			end)
		end
	},

	{
		Pos = {x = 178.550, y = -1401.755, z = 27.725},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText("Mira el tráfico y enciende las luces", 5000)
		end
	},

	{
		Pos = {x = 113.160, y = -1365.276, z = 27.725},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText("Vete al siguiente punto", 5000)
		end
	},

	{
		Pos = {x = -73.542, y = -1364.335, z = 27.789},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText("~r~Para para que pasen los vehículos", 5000)
			PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', false, 0, true)
			FreezeEntityPosition(vehicle, true)
			Wait(6000)
			FreezeEntityPosition(vehicle, false)
		end
	},

	{
		Pos = {x = -355.143, y = -1420.282, z = 27.868},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText("Vete al siguiente punto", 5000)
		end
	},

	{
		Pos = {x = -439.148, y = -1417.100, z = 27.704},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText("Vete al siguiente punto", 5000)
		end
	},

	{
		Pos = {x = -453.790, y = -1444.726, z = 27.665},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			setCurrentZoneType('level3')

			DrawMissionText("Es hora de conducir por la autopista! Límite de velocidad: ".. Config.SpeedLimits['level3'].."km/h", 5000)
			PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', false, 0, true)
		end
	},

	{
		Pos = {x = -463.237, y = -1592.178, z = 37.519},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText("Vete al siguiente punto", 5000)
		end
	},

	{
		Pos = {x = -900.647, y = -1986.28, z = 26.109},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText("Vete al siguiente punto", 5000)
		end
	},

	{
		Pos = {x = 1225.759, y = -1948.792, z = 38.718},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText("Vete al siguiente punto", 5000)
		end
	},

	{
		Pos = {x = 1225.759, y = -1948.792, z = 38.718},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			setCurrentZoneType('level2')
			DrawMissionText("Entraste a la ciudad, presta atención a tu velocidad! Límite de velocidad: ".. Config.SpeedLimits['level2'].."km/h", 5000)
		end
	},

	{
		Pos = {x = 1163.603, y = -1841.771, z = 35.679},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText("Estoy impresionado pero no dejes de estar ~r~alerta mientras conduces", 5000)
			PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', false, 0, true)
		end
	},

	{
		Pos = {x = 235.283, y = -1398.329, z = 28.921},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			ESX.Game.DeleteVehicle(vehicle)
		end
	}

}
