-- Stress Gain



local function IsVehicleBlacklisted(vehicle)
    local model = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))
    for i = 1, #Config.BlacklistVehicle do
        if string.upper(Config.BlacklistVehicle[i]) == model then
            return true
        end
    end
    return false
end

CreateThread(function() -- Speeding
    while true do
        if cache.vehicle and (not Config.disablestressjobs[playerjob]) then
            if not IsVehicleBlacklisted(cache.vehicle) then
                local speed = GetEntitySpeed(cache.vehicle) * 3
                local stressSpeed = VehicleState.seatbelt and Config.MinimumSpeed or Config.MinimumSpeedUnbuckled
                if speed >= stressSpeed then
                    UpdateStress()
                end
            end
        end
        Wait(15000)
    end
end)






local function IsWhitelistedWeaponStress(weapon)
    if weapon then
        for _, v in pairs(Config.WhitelistedWeaponStress) do
            if weapon == v then
                return true
            end
        end
    end
    return false
end






lastweapon = nil
lib.onCache('weapon', function(weapon)
    lastweapon = weapon
    while weapon and weapon == lastweapon do
        local sleep = 2000
        if Config.disablestressjobs[playerjob] and IsWhitelistedWeaponStress(weapon) then
            return
        else
            if math.random() < Config.StressChance and IsPedShooting(cache.ped) then
                UpdateStress()
            end
            sleep = 70
        end
        Wait(sleep)
    end
end)






-- Stress Screen Effects

local function GetBlurIntensity(stresslevel)
    for i = 1, #(Config.BlurIntensity) do
        local v = Config.BlurIntensity[i]
        if stresslevel >= v.min and stresslevel <= v.max then
            return v.intensity
        end
    end
    return 1500
end

local function GetEffectInterval(stresslevel)
    for i = 1, #(Config.EffectInterval) do
        local v = Config.EffectInterval[i]
        if stresslevel >= v.min and stresslevel <= v.max then
            return v.timeout
        end
    end
    return 60000
end

CreateThread(function()
    while true do
        if PlayerLoaded then
            local ped = cache.ped
            local effectInterval = GetEffectInterval(stress)
            if stress >= 100 then
                local BlurIntensity = GetBlurIntensity(stress)
                local FallRepeat = math.random(2, 4)
                local RagdollTimeout = FallRepeat * 1750
                TriggerScreenblurFadeIn(1000.0)
                Wait(BlurIntensity)
                TriggerScreenblurFadeOut(1000.0)

                if not IsPedRagdoll(ped) and IsPedOnFoot(ped) and not IsPedSwimming(ped) then
                    SetPedToRagdollWithFall(ped, RagdollTimeout, RagdollTimeout, 1, GetEntityForwardVector(ped), 1.0, 0.0,
                        0.0, 0.0, 0.0, 0.0, 0.0)
                end

                Wait(1000)
                for i = 1, FallRepeat, 1 do
                    Wait(750)
                    DoScreenFadeOut(200)
                    Wait(1000)
                    DoScreenFadeIn(200)
                    TriggerScreenblurFadeIn(1000.0)
                    Wait(BlurIntensity)
                    TriggerScreenblurFadeOut(1000.0)
                end
            elseif stress >= Config.MinimumStress then
                local BlurIntensity = GetBlurIntensity(stress)
                TriggerScreenblurFadeIn(1000.0)
                Wait(BlurIntensity)
                TriggerScreenblurFadeOut(1000.0)
            end
            Wait(effectInterval)
        else
            Wait(1000)
        end
    end
end)
