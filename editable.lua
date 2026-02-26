PlayerLoaded = false


local Active = false

currentaspectratio, _aspectratio, screenx, screeny, _screenx, _screeny = 0, 0, 0, 0, 0, 0
aspectratio = 0
-- MINIMAP
CreateThread(function()
    DisplayRadar(false)
    while true do
        if PlayerLoaded then
            SetRadarZoom(1100)
            _screenx, _screeny = GetActiveScreenResolution()
            _aspectratio = GetAspectRatio()
            if (_screenx ~= screenx) or (_screeny ~= screeny) then
                StreamMinimap()
            end
        end
        Wait(2000)
    end
end)




function Getminimapproperties()
    posX = 0.835
    posY = 0.003
    if GlobalSettings.fliphud then
        posX = -0.011
        posY = 0.003
    end
    screenx, screeny = GetActiveScreenResolution()
    if screenx == 4096 and screeny == 2160 then
        posX = 0.862
        posY = -0.006
        if GlobalSettings.fliphud then
            posX = -0.01
            posY = 0.002
        end
        width = 0.15
        height = 0.24
    end
    if screenx == 2560 and screeny == 1080 then
        posX = 0.97
        posY = -0.045
        if GlobalSettings.fliphud then
            posX = -0.157
            posY = -0.045
        end
        width = 0.15
        height = 0.24
    end
    if screenx == 2560 and screeny == 1600 then
        posX = 0.7425
        posY = 0.016
        if GlobalSettings.fliphud then
            posX = -0.017
            posY = 0.0105
        end
        width = 0.15
        height = 0.24
    end
    if screenx == 2560 and screeny == 1440 then
        posX = 0.835
        posY = 0.003
        if GlobalSettings.fliphud then
            posX = -0.01
            posY = 0.002
        end
        width = 0.15
        height = 0.24
    end
    if screenx == 2048 and screeny == 1536 then
        posX = 0.5919
        posY = 0.0186
        if GlobalSettings.fliphud then
            posX = -0.01
            posY = 0.0186
        end
        width = 0.15
        height = 0.24
    end
    if screenx == 1680 and screeny == 1050 then
        posX = 0.744
        posY = 0.016
        if GlobalSettings.fliphud then
            posX = -0.018
            posY = 0.015
        end
        width = 0.15
        height = 0.24
    end
    if screenx == 1440 and screeny == 900 then
        posX = 0.744
        posY = 0.016
        if GlobalSettings.fliphud then
            posX = -0.018
            posY = 0.015
        end
        width = 0.15
        height = 0.24
    end

    if screenx == 1280 and screeny == 1024 then
        posX = 0.55
        posY = 0.016
        if GlobalSettings.fliphud then
            posX = -0.015
            posY = 0.014
        end
        width = 0.15
        height = 0.24
    end
    if screenx == 1024 and screeny == 768 then
        posX = 0.597
        posY = 0.020
        if GlobalSettings.fliphud then
            posX = -0.015
            posY = 0.0186
        end
        width = 0.15
        height = 0.24
    end
    if screenx == 800 and screeny == 600 then
        posX = 0.597
        posY = 0.020
        if GlobalSettings.fliphud then
            posX = -0.015
            posY = 0.0186
        end
        width = 0.15
        height = 0.24
    end


    -- For Multiple Aspect ratios for 1080p resolution

    if screenx == 1920 and screeny == 1080 then
        currentaspectratio = GetAspectRatio()
        local r = 1.7777777910233 - currentaspectratio
        aspectratio = -(r / 10)
        if not (GlobalSettings.fliphud) then
            if not (GetIsWidescreen()) then
                aspectratio = aspectratio + -0.02
                posX = posX + 0.02
            end
            if currentaspectratio == 1.5 then
                aspectratio = aspectratio - -0.01
                posX = posX - 0.01
            end
            posX = posX - (r / 2)
        end
    end
end

StreamMinimap = function()
    if Config.maxminimapzone then
        zonex = 0.083
        zoney = 0.19

        zonexpos = 0.11
        zoneypos = 0.06
    end

    local response = Getminimapproperties()
    RequestStreamedTextureDict("circlemap", false)
    while not HasStreamedTextureDictLoaded("circlemap") do
        Wait(100)
    end
    SetBlipAlpha(GetNorthRadarBlip(), 0)
    AddReplaceTexture("platform:/textures/graphics", "radarmasksm", "circlemap", "radarmasksm")


    SetMinimapComponentPosition('minimap', 'L', 'B', posX, posY + -0.01, 0.15, 0.2)
    SetMinimapComponentPosition('minimap_mask', 'L', 'B', posX + zonexpos, posY - zoneypos, zonex, zoney)
    SetMinimapComponentPosition('minimap_blur', 'L', 'B', posX - 0.018, posY + 0.063, 0.256 + aspectratio, 0.337)
    SetMinimapClipType(1)

    SetRadarBigmapEnabled(true, false)
    Wait(0)
    SetRadarBigmapEnabled(false, false)


    return true

end



-- CreateThread(function()
--     while true do
--         local sleep = 1000
--         if VehicleState.seatbelt then
--             sleep = 0
--             DisableControlAction(0, 75, true)
--             DisableControlAction(27, 75, true)
--         end
--         Wait(sleep)
--     end
-- end)



local doesseatbeltexist = function(vehicle)
    local class = GetVehicleClass(vehicle)
    if class ~= 8 and class ~= 13 and class ~= 14 then
        return true
    end
    return false
end

local toggleseatbelt = function()
    if cache.vehicle then
        if doesseatbeltexist(cache.vehicle) then
            VehicleState.seatbelt = not VehicleState.seatbelt
            if VehicleState.seatbelt then
                SetFlyThroughWindscreenParams(1000.0, 1000.0, 0.0, 0.0)
            else
                SetFlyThroughWindscreenParams(15.0, 20.0, 17.0, -500.0)
            end
        end
    end
end


local TextUI = function (data)
    NuiMessage('textui', data)
end

exports('TextUI', TextUI)

local Notify =  function (data)
    NuiMessage('notification', data)
end

exports('Notify', Notify)


exports('DisplayHud', DisplayHud)

-- RegisterCommand('test', function ()
-- local data = {
--         title = "Sprunk Soda",
--         icon = 'local_drink',
--         duration = 2000,
--         description = "you have drank too many sprunk soda drank too many sprunk soda many",
--     }

--     Notify(data)
-- end)


lib.addKeybind({
    name = 'seatbelt',
    description = 'Toggle vehicle seatbelt',
    defaultKey = Config.seatbelt,
    onPressed = function(self)
        toggleseatbelt()
    end,
})





local prevloc1, prevloc2 = '', ''
location1, location2 = '', ''



CreateThread(function()
    while true do
        local PauseMenuActive = IsPauseMenuActive()

        if PauseMenuActive and not Active then
            Active = true
            NuiMessage('visible', false)
        elseif Active and not PauseMenuActive then
            Active = false
            NuiMessage('visible', true)
        end



        if cache.vehicle then
            local ped = cache.ped
            local coords = GetEntityCoords(ped)
            local street1, street2 = GetStreetNameAtCoord(coords.x, coords.y, coords.z)
            location2 = GetStreetNameFromHashKey(street2)
            location1 = GetStreetNameFromHashKey(street1)

            if location1 == '' then
                location1 = prevloc1
            else
                prevloc1 = location1
            end


            if location2 == '' then
                location2 = prevloc2
            else
                prevloc2 = location2
            end
        end


        Wait(1000)
    end
end)











