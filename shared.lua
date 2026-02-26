Config = {}

--  setr game_enableFlyThroughWindscreen true
--  add this in the server.cfg for the seatbelt to work

Config.seatbelt = 'b'
Config.settingskey = 'i'


GetFuel = function(vehicle)
    local fuel = math.ceil(GetVehicleFuelLevel(vehicle)) -- change this according to your exports for the fuel system
    return fuel
end

GetVehicleDamage = function (vehicle)
    local damage = math.ceil(GetEntityHealth(vehicle) / 10)
    return damage
end

GetVehicleMileage = function (plate)
    local distance, unit = lib.callback.await('jg-vehiclemileage:server:get-mileage',false, plate)
    return distance.mileage
end

GetFramework = function()
    if GetResourceState('es_extended') ~= 'missing' then
        return 'esx'
    elseif GetResourceState('qbx_core') ~= 'missing' then
        return 'qbx'
    elseif GetResourceState('qb-core') ~= 'missing' then
        return 'qb'
    elseif GetResourceState('ox_core') ~= 'missing' then
        return 'ox'
    end
end

Config.framework = GetFramework() -- qb / esx /qbox /ox

------- Info
Config.infocommmands = true -- /job /cash /bank command 

------- Minimap

Config.maxminimapzone = false

------- Speedometer Configuration

-- you can increase them inorder to increase performance
Config.speedometerspeed = 50 -- how many millisecond it will delay before updating the speedometer again
Config.compassspeed = 50     -- how many millisecond it will delay before updating the compass again
Config.mileage = false

------- Settings Configuration
Config.settingscommand = 'hud' 

--------DONT CHANGE ANYTHING IF YOU DONT KNOW WHAT YOU ARE DOING
Config.settings = {
    ['showhud'] = {
        name = 'showhud',
        label = "Toggle Hud",
        description = "This option is for you to decide if you want to enable or disable the hud",
        show = true,
        value = true,
        type = 'button',
        category = 'general'
    },
    ['cinematicmode'] = {
        name = 'cinematicmode',
        label = 'Cinemtic Mode',
        description = "This option is for you to decide if you want to enable or disable the cinematic bars and hide the hud",
        show = true,
        value = false,
        type = 'button',
        category = 'general'
    },
    ['fliphud'] = {
        name = 'fliphud',
        label = 'Flip Hud',
        description = "This option is for you to decide if you want to replace the position of the minimap and speedometer",
        show = true,
        value = false,
        type = 'button',
        category = 'general'
    },
    ['showminimap'] = {
        name = 'showminimap',
        label = 'Toggle Minimap',
        description = "This option is for you to decide if you want to enable or disable the minimap",
        show = true,
        value = true,
        type = 'button',
        category = 'minimap'
    },
    ['minimapextrastatus'] = {
        name = 'minimapextrastatus',
        label = 'Toggle Minimap Status',
        description = "This option is for you to decide if you want to enable or disable the minimap extra status for example hunger thirst stress etc",
        show = true,
        value = true,
        type = 'button',
        category = 'minimap'
    },
    ['skullonfoot'] = {
        name = 'skullonfoot',
        label = 'Skull on foot',
        description = "This option is for you to decide if you want to enable or disable skull on the map when you are outside of the vehicle",
        show = true,
        value = false,
        type = 'button',
        category = 'minimap'
    },
    ['minimapsize'] = {
        name = 'minimapsize',
        label = 'Minimap Size',
        description = "This option is for you to decide if you want to adjust the size of minimap size",
        show = true,
        value = 50,
        type = 'slider',
        category = 'minimap'
    },
    ['showspeedometer'] = {
        name = 'showspeedometer',
        label = 'Toggle Speedometer',
        description = "This options is for you to decide if you want to enable or disable the speedometer of the hud",
        show = true,
        value = true,
        type = 'button',
        category = 'speedometer'
    },
    ['speedometersize'] = {
        name = 'speedometersize',
        label = 'Speedometer Scale',
        description = "This option is for you to decide if you want to adjust the size of speedometer size",
        show = true,
        value = 50,
        type = 'slider',
        category = 'speedometer'
    },
    ['mphkmh'] = {
        name = 'mphkmh',
        label = 'Vehicle Speed Unit',
        description = "This option is for you to decide if you want to change the speedometer speed unit",
        show = true,
        value = true,
        option1 = 'MPH',
        option2 = 'KMH',
        type = 'select',
        category = 'speedometer'
    },
    ['showcompass'] = {
        name = 'showcompass',
        label = 'Toggle Compass',
        description = "This options is for you to decide if you want to enable or disable the compass of the hud",
        show = true,
        value = true,
        type = 'button',
        category = 'compass'
    },
    ['compassize'] = {
        name = 'compassize',
        label = 'Compass Scale',
        description = "This option is for you to decide if you want to adjust the size of compasss size",
        show = true,
        value = 50,
        type = 'slider',
        category = 'compass'
    },
    ['showstreet'] = {
        name = 'showstreet',
        label = 'Toggle Street Names',
        description = "This options is for you to decide if you want to enable or disable the streetname on the compass",
        show = true,
        value = true,
        type = 'button',
        category = 'compass'
    },
    ['seatbeltalarm'] = {
        name = 'seatbeltalarm',
        label = 'Toggle Seatbelt Alarm',
        description = "This options is for you to decide if you want to enable or disable the seatbelt alarm when you are in vehicle and have not buckled the seatbelt",
        show = true,
        value = true,
        type = 'button',
        category = 'speedometer'
    },
    ['showinfo'] = {
        name = 'showinfo',
        label = 'Toggle Info',
        description = "This options is for you to decide if you want to enable or disable the player info like Cash Bank and Job",
        show = true,
        value = true,
        type = 'button',
        category = 'general'
    },
    ['dynamicinfo'] = {
        name = 'dynamicinfo',
        label = 'Toggle Dynamic Info',
        description = "This options is for you to decide if you want to enable or disable the player info like Cash Bank and Job only when they get updated",
        show = true,
        value = true,
        type = 'button',
        category = 'general'
    },
}






-- Stress Configuration

Config.StressChance = 0.1         -- Default: 10% -- Percentage Stress Chance When Shooting (0-1)
Config.MinimumStress = 50         -- Minimum Stress Level For Screen Shaking
Config.MinimumSpeedUnbuckled = 50 -- Going Over This Speed Will Cause Stress
Config.MinimumSpeed = 100         -- Going Over This Speed Will Cause Stress

Config.disablestressjobs = {
    police = true,
    ambulance = true,
}

Config.BlacklistVehicle = {
    'jet'
}

Config.WhitelistedWeaponStress = {
    `weapon_petrolcan`,
    `weapon_hazardcan`,
    `weapon_fireextinguisher`
}


Config.BlurIntensity = {
    {
        min = 50,
        max = 60,
        intensity = 1500,
    },
    {
        min = 60,
        max = 70,
        intensity = 2000,
    },
    {
        min = 70,
        max = 80,
        intensity = 2500,
    },
    {
        min = 80,
        max = 90,
        intensity = 2700,
    },
    {
        min = 90,
        max = 100,
        intensity = 3000,
    },
}

Config.EffectInterval = {
    {
        min = 50,
        max = 60,
        timeout = math.random(50000, 60000)
    },
    {
        min = 60,
        max = 70,
        timeout = math.random(40000, 50000)
    },
    {
        min = 70,
        max = 80,
        timeout = math.random(30000, 40000)
    },
    {
        min = 80,
        max = 90,
        timeout = math.random(20000, 30000)
    },
    {
        min = 90,
        max = 100,
        timeout = math.random(15000, 20000)
    }
}
