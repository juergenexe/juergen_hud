lib.notify = function(data)
    exports['codem-supreme-notification']:SendNotification(data.type, data.description, data.duration)
end

Notify = function (title,description,type)
    lib.notify({
        title = title,
        description = description,
        type = type
    })
end

NuiMessage = function (action,data)
    SendNUIMessage({
        action = action,
        data = data
    })
end
