local voice

posX = nil
posY = nil

width = 0.15
height = 0.14



zonex = 0.065
zoney = 0.16

zonexpos = 0.16
zoneypos = 0

hunger = 100
thirst = 100
stress = 0



---@param state boolean;
DisplayHud = function(state)
    NuiMessage('visible', state)
    DisplayRadar(state)
end

CreateThread(function()
    while true do
        local health = GetEntityHealth(cache.ped)
        local armour = GetPedArmour(cache.ped)
        local oxygen
        if not IsEntityInWater(cache.ped) then
            oxygen = 100 - GetPlayerSprintStaminaRemaining(cache.playerId)
        end
        -- Oxygen
        if IsEntityInWater(cache.ped) then
            oxygen = GetPlayerUnderwaterTimeRemaining(cache.playerId) * 10
        end

        voice = NetworkIsPlayerTalking(cache.playerId)

        local showskull = cache.vehicle == false and true or false

        local data = {
            health = health - 100,
            skull =  showskull and GlobalSettings.skullonfoot or false,
            armour = armour,
            oxygen = oxygen,
            hunger = hunger,
            thirst = thirst,
            stress = stress,
            voice = voice,
        }
        NuiMessage('status', data)
        Wait(800)
    end
end)




AddEventHandler('pma-voice:setTalkingMode', function(mode)
    NuiMessage('voicemode', mode)
end)


CreateThread( function ()
    SetHudComponentSize(6, 0, 0)
    SetHudComponentSize(7, 0, 0)
    SetHudComponentSize(8, 0, 0)
    SetHudComponentSize(9, 0, 0)
end)