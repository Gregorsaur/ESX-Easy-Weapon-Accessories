local ESX = nil
local weapons = {
    [GetHashKey('WEAPON_PISTOL')] = { suppressor = GetHashKey('component_at_pi_supp_02'), flashlight = GetHashKey('COMPONENT_AT_PI_FLSH'), grip = nil, skin = GetHashKey('COMPONENT_PISTOL_VARMOD_LUXE') },
    [GetHashKey('WEAPON_PISTOL50')] = { suppressor = GetHashKey('COMPONENT_AT_AR_SUPP_02'), flashlight = GetHashKey('COMPONENT_AT_PI_FLSH'), grip = nil, skin = GetHashKey('COMPONENT_PISTOL50_VARMOD_LUXE') },
    [GetHashKey('WEAPON_COMBATPISTOL')] = { suppressor = GetHashKey('COMPONENT_AT_PI_SUPP'), flashlight = GetHashKey('COMPONENT_AT_PI_FLSH'), grip = nil, skin = nil },
    [GetHashKey('WEAPON_APPISTOL')] = { suppressor = GetHashKey('COMPONENT_AT_PI_SUPP'), flashlight = GetHashKey('COMPONENT_AT_PI_FLSH'), grip = nil, skin = GetHashKey('COMPONENT_APPISTOL_VARMOD_LUXE') },
    [GetHashKey('WEAPON_HEAVYPISTOL')] = { suppressor = GetHashKey('COMPONENT_AT_PI_SUPP'), flashlight = GetHashKey('COMPONENT_AT_PI_FLSH'), grip = nil, skin = GetHashKey('COMPONENT_HEAVYPISTOL_VARMOD_LUXE') },
    [GetHashKey('WEAPON_VINTAGEPISTOL')] = { suppressor = GetHashKey('COMPONENT_AT_PI_SUPP'), flashlight = nil, grip = nil, skin = nil },
    [GetHashKey('WEAPON_SMG')] = { suppressor = GetHashKey('COMPONENT_AT_PI_SUPP'), flashlight = GetHashKey('COMPONENT_AT_AR_FLSH'), grip = nil, skin = GetHashKey('COMPONENT_SMG_VARMOD_LUXE') },
    [GetHashKey('WEAPON_MICROSMG')] = { suppressor = GetHashKey('COMPONENT_AT_AR_SUPP_02'), flashlight = GetHashKey('COMPONENT_AT_PI_FLSH'), grip = nil, skin = GetHashKey('COMPONENT_MICROSMG_VARMOD_LUXE') },
    [GetHashKey('WEAPON_ASSAULTSMG')] = { suppressor = GetHashKey('COMPONENT_AT_AR_SUPP_02'), flashlight = GetHashKey('COMPONENT_AT_AR_FLSH'), grip = nil, skin = nil },
    [GetHashKey('WEAPON_ASSAULTRIFLE')] = { suppressor = GetHashKey('COMPONENT_AT_AR_SUPP_02'), flashlight = GetHashKey('COMPONENT_AT_AR_FLSH'), grip = GetHashKey('COMPONENT_AT_AR_AFGRIP'), skin = GetHashKey('COMPONENT_ASSAULTRIFLE_VARMOD_LUXE') },
    [GetHashKey('WEAPON_CARBINERIFLE')] = { suppressor = GetHashKey('COMPONENT_AT_AR_SUPP'), flashlight = GetHashKey('COMPONENT_AT_AR_FLSH'), grip = GetHashKey('COMPONENT_AT_AR_AFGRIP'), skin = GetHashKey('COMPONENT_CARBINERIFLE_VARMOD_LUXE') },
    [GetHashKey('WEAPON_ADVANCEDRIFLE')] = { suppressor = GetHashKey('COMPONENT_AT_AR_SUPP'), flashlight = GetHashKey('COMPONENT_AT_AR_FLSH'), grip = nil, skin = GetHashKey('COMPONENT_ADVANCEDRIFLE_VARMOD_LUXE') },
    [GetHashKey('WEAPON_SPECIALCARBINE')] = { suppressor = GetHashKey('COMPONENT_AT_AR_SUPP_02'), flashlight = GetHashKey('COMPONENT_AT_AR_FLSH'), grip = GetHashKey('COMPONENT_AT_AR_AFGRIP'), skin = nil },
    [GetHashKey('WEAPON_BULLPUPRIFLE')] = { suppressor = GetHashKey('COMPONENT_AT_AR_SUPP'), flashlight = GetHashKey('COMPONENT_AT_AR_FLSH'), grip = GetHashKey('COMPONENT_AT_AR_AFGRIP'), skin = nil },
    [GetHashKey('WEAPON_ASSAULTSHOTGUN')] = { suppressor = GetHashKey('COMPONENT_AT_AR_SUPP'), flashlight = GetHashKey('COMPONENT_AT_AR_FLSH'), grip = GetHashKey('COMPONENT_AT_AR_AFGRIP'), skin = nil },
    [GetHashKey('WEAPON_HEAVYSHOTGUN')] = { suppressor = GetHashKey('COMPONENT_AT_AR_SUPP_02'), flashlight = GetHashKey('COMPONENT_AT_AR_FLSH'), grip = GetHashKey('COMPONENT_AT_AR_AFGRIP'), skin = nil },
    [GetHashKey('WEAPON_BULLPUPSHOTGUN')] = { suppressor = GetHashKey('COMPONENT_AT_AR_SUPP_02'), flashlight = GetHashKey('COMPONENT_AT_AR_FLSH'), grip = GetHashKey('COMPONENT_AT_AR_AFGRIP'), skin = nil },
    [GetHashKey('WEAPON_PUMPSHOTGUN')] = { suppressor = GetHashKey('COMPONENT_AT_SR_SUPP'), flashlight = GetHashKey('COMPONENT_AT_AR_FLSH'), grip = nil, skin = nil },
    [GetHashKey('WEAPON_MARKSMANRIFLE')] = { suppressor = GetHashKey('COMPONENT_AT_AR_SUPP'), flashlight = GetHashKey('COMPONENT_AT_AR_FLSH'), grip = GetHashKey('COMPONENT_AT_AR_AFGRIP'), skin = nil },
    [GetHashKey('WEAPON_SNIPERRIFLE')] = { suppressor = GetHashKey('COMPONENT_AT_AR_SUPP_02'), flashlight = nil, grip = nil, skin = nil },
    [GetHashKey('WEAPON_COMBATPDW')] = { suppressor = nil, flashlight = GetHashKey('COMPONENT_AT_AR_FLSH'), grip = GetHashKey('COMPONENT_AT_AR_AFGRIP'), skin = nil }
}
 
-- ESX
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)
 
-- ESX, playerloaded
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)
 
-- Use item
RegisterNetEvent('eden_accesories:use')
AddEventHandler('eden_accesories:use', function( type )
    if weapons[GetSelectedPedWeapon(PlayerPedId())] and weapons[GetSelectedPedWeapon(PlayerPedId())][type] then
        if not HasPedGotWeaponComponent(GetPlayerPed(-1), GetSelectedPedWeapon(PlayerPedId()), weapons[GetSelectedPedWeapon(PlayerPedId())][type]) then
            GiveWeaponComponentToPed(GetPlayerPed(-1), GetSelectedPedWeapon(PlayerPedId()), weapons[GetSelectedPedWeapon(PlayerPedId())][type])  
            ESX.ShowNotification(string.format('%s %s', "You've equiped your ", type))
        else
            RemoveWeaponComponentFromPed(GetPlayerPed(-1), GetSelectedPedWeapon(PlayerPedId()), weapons[GetSelectedPedWeapon(PlayerPedId())][type])  
            ESX.ShowNotification(string.format('%s %s', "You've removed your ", type))
        end
    else
        ESX.ShowNotification(string.format('%s %s %s', 'The ', type, " doesn't fit on your weapon.."))
    end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsControlJustPressed(0, 172) then
			if weapons[GetSelectedPedWeapon(PlayerPedId())] then
				for k,v in pairs(weapons) do
					if GetSelectedPedWeapon(PlayerPedId()) == k then
						if HasPedGotWeaponComponent(GetPlayerPed(-1), GetSelectedPedWeapon(PlayerPedId()), v.suppressor) then
							TriggerServerEvent('eden_accesories:giveBack', 'suppressor')
							ESX.ShowNotification("You've removed your weapon suppressor")
							RemoveWeaponComponentFromPed(GetPlayerPed(-1), GetSelectedPedWeapon(PlayerPedId()), v.suppressor)
						elseif HasPedGotWeaponComponent(GetPlayerPed(-1), GetSelectedPedWeapon(PlayerPedId()), v.flashlight) then
							TriggerServerEvent('eden_accesories:giveBack', 'flashlight')
							ESX.ShowNotification("You've removed your weapon flashlight")
							RemoveWeaponComponentFromPed(GetPlayerPed(-1), GetSelectedPedWeapon(PlayerPedId()), v.flashlight)
						elseif HasPedGotWeaponComponent(GetPlayerPed(-1), GetSelectedPedWeapon(PlayerPedId()), v.skin) then
							TriggerServerEvent('eden_accesories:giveBack', 'yusuf')
							ESX.ShowNotification("You've removed your weapon skin")
							RemoveWeaponComponentFromPed(GetPlayerPed(-1), GetSelectedPedWeapon(PlayerPedId()), v.skin)
						elseif HasPedGotWeaponComponent(GetPlayerPed(-1), GetSelectedPedWeapon(PlayerPedId()), v.grip) then
							TriggerServerEvent('eden_accesories:giveBack', 'grip')
							ESX.ShowNotification("You've removed your weapon grip")
							RemoveWeaponComponentFromPed(GetPlayerPed(-1), GetSelectedPedWeapon(PlayerPedId()), v.grip)
						end
					end
				end
			end
		end
	end
end)