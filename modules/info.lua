cash, bank = 0, 0
job = ''
grade = ''

prev = {
    job = 0,
    grade = 0,
    cash = 0,
    bank = 0,
}


local cashinfoloop = function(info)
    CreateThread(function()
        Wait(5000)
        prev.cash = info
    end)
end

local bankinfoloop = function(info)
    CreateThread(function()
        Wait(5000)
        prev.bank = info
    end)
end

local jobinfoloop = function(job, grade)
    CreateThread(function()
        Wait(5000)
        prev.job = job
        prev.grade = grade
    end)
end


CreateThread(function()
    while true do
        local show = {
            bank = false,
            cash = false,
            job = false
        }

        if not (job == prev.job) or not (grade == prev.grade) then
            jobinfoloop(job, grade)
            show.job = true
        end

        if not (bank == prev.bank) then
            bankinfoloop(bank)
            show.bank = true
        end

        if not (cash == prev.cash) then
            cashinfoloop(cash)
            show.cash = true
        end


        local playerjob = job .. ' - ' .. grade
        NuiMessage('info', {
            bank = bank,
            cash = cash,
            job = playerjob,
            show = show
        })
        Wait(1200)
    end
end)

if Config.infocommmands then
    RegisterCommand('job', function()
        prev.job = job .. '. '
    end)

    RegisterCommand('cash', function()
        prev.cash = cash + 1
    end)
    RegisterCommand('bank', function()
        prev.bank = bank + 1
    end)
end
