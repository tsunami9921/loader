local Knit = require(game:GetService("ReplicatedStorage").Packages.Knit)
local ExperimentService = Knit.GetService("ExperimentService")
local Player = game:GetService("Players").LocalPlayer

local function TeleportSimdi()
    ExperimentService.RequestingEnrollment:Fire()
end

Player.Chatted:Connect(function(msg)
    local m = msg:lower()
    if m == ";t" or m == "scp" then
        TeleportSimdi()
    end
end)

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

TeleportSimdi()
