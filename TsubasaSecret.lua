local Knit = require(game:GetService("ReplicatedStorage").Packages.Knit)
local ExperimentService = Knit.GetService("ExperimentService")
local Player = game:GetService("Players").LocalPlayer

local function TeleportSimdi()
    ExperimentService.RequestingEnrollment:Fire()
end

-- Chat
Player.Chatted:Connect(function(msg)
    local m = msg:lower()

    if m:sub(1, 2) == ";t" then
        local args = m:split(" ")

        if args[2] == "ts99" then
            TeleportSimdi()
        end
    end
end)

-- Teleport
local TeleporterController = Knit.GetController("FTUTeleporterController")
local oldObserve = TeleporterController.KnitStart

TeleporterController.KnitStart = function(self)
    task.spawn(function()
        while task.wait(1) do
            if ExperimentService.IsTeleportPromptVisible:Get() then
                TeleportSimdi()
                break
            end
        end
    end)
    return oldObserve(self)
end
