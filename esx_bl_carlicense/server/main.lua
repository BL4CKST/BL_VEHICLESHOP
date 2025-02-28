ESX.RegisterServerCallback('esx_bl_carlicense:canYouPay', function(source, cb, type)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.getMoney() >= Config.PricesOfExam then
		xPlayer.removeMoney(Config.PricesOfExam)
		TriggerClientEvent('esx:showNotification', source, "Acabas de pagar $"..Config.PricesOfExam.." a la escuela de autos")
		cb(true)
	else
		cb(false)
	end
end)

RegisterNetEvent('esx_bl_carlicense:addLicense')
AddEventHandler('esx_bl_carlicense:addLicense', function(type)
	local source = source
	TriggerEvent('esx_license:addLicense', source, type, function()
		TriggerEvent('esx_license:getLicenses', source, function(licenses)
			TriggerClientEvent('esx_bl_carlicense:loadLicenses', source, licenses)
		end)	
	end)
end)

