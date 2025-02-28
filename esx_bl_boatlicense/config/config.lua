Config                 = {}
Config.DrawDistance    = 8.0
Config.MaxErrors       = 4
Config.SpeedMultiplier = 3.6
Config.PricesOfExam	   = 1000
Config.VehicleModel    = "jetmax"

Config.SpeedLimits = {
	level1   = 40,
	level2   = 70,
	level3   = 100
}

Config.Zones = {

	BOATSchool = {
		Pos   = {x = -780.37, y = -1505.82, z =1.6},
		Size  = {x = 0.4, y = 0.4, z = 0.4}, 
		Color = {r = 23, g = 190, b = 97},
		Type  = 35
	},

	VehicleSpawnPoint = {
		Pos   = {x = -798.26, y = -1412.53, z = 0.31, h = 228.85},
		Size  = {x = 1.5, y = 1.5, z = 1.0},
		Color = {r = 204, g = 204, b = 0},
		Type  = -1
	}

}

Config.CheckPoints = {

	{
		Pos = {x = -791.42, y = -1431.4, z = 0.31}, 
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText("Excelente, ve al siguiente punto, la velocidad maxima es ~o~" ..Config.SpeedLimits['level1'].."km/h", 5000)
		end
	},

	{
		Pos = {x = -825.31, y = -1482.38, z = 0.31},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText("Perfecto, lo estas haciendo bien, ve al siguiente punto", 5000)
		end
	},

	{
		Pos = {x = -842.74, y = -1536.11, z = 0.31},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			CreateThread(function()
				DrawMissionText("~o~Antes de continuar revisa el combustible del bote", 5000)
				FreezeEntityPosition(vehicle, true)
				Wait(4000)

				FreezeEntityPosition(vehicle, false)
				DrawMissionText("~g~Perfecto, Sigamos con el examen", 5000)
			end)
		end
	},

	{
		Pos = {x = -942.19, y = -1636.04, z = 0.31}, 
		Action = function(playerPed, vehicle, setCurrentZoneType)
			setCurrentZoneType('level2')

			CreateThread(function()
				DrawMissionText("Ahora iremos cerca de los bordes, concentrate, Tu limite Max. de velocidad es ~o~"..Config.SpeedLimits['level2'].."km/h", 5000)
				FreezeEntityPosition(vehicle, true)
				Wait(6000)
				FreezeEntityPosition(vehicle, false)
				DrawMissionText("~g~Bien, gira lentamente hacia la izquierda", 5000)
				
			end)
		end
	},

	{
		Pos = {x = -994.80, y = -1721.50, z = 0.31},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText("Ahora gira a la derecha sin chocar", 5000)
		end
	},

	{
		Pos = {x = -1070.45, y = -1738.26, z = 0.20},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText("Ve al siguiente punto", 5000)
		end
	},
	{
		Pos = {x = -1113.10, y = -1816.15, z = 0.25}, 
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText("Ve al siguiente punto", 5000)
		end
	},

	{
		Pos = {x = -1291.38, y = -1935.38, z = 0.49},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText("Sigue asi, ahora gira en U ", 5000)
		end
	},

	{
		Pos = {x = -1290.40, y = -1977.80, z = 1.30},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText("Lo estas haciendo bien, ve de regreso", 5000)
		end
	},

	{
		Pos = {x = -1201.36, y = -1896.90, z = 0.56}, 
		Action = function(playerPed, vehicle, setCurrentZoneType)
			setCurrentZoneType('level3')

			CreateThread(function()
				DrawMissionText("Veamos si aprendiste bien ahora aumenta la velocidad a un maximo de  ~o~"..Config.SpeedLimits['level3'].."km/h", 5000)
				FreezeEntityPosition(vehicle, true)
				Wait(3000)
				FreezeEntityPosition(vehicle, false)	
			end)
		end
	},
	{
		Pos = {x = -1128.28, y = -1826.20, z = 0.70},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText("Ve al siguiente punto", 5000)
		end
	},

	{
		Pos = {x = -976.26, y = -1673.62, z = 0.31},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText("~y~Excelente, lo hiciste muy bien, regresa al muelle", 5000)
		end
	},

	{
		Pos = {x = -789.95, y = -1500.19, z = 0.31},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			ESX.Game.DeleteVehicle(vehicle)
		end
	}

}
