  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local Knit = require(ReplicatedStorage.Packages.Knit);
local Popup = require(ReplicatedStorage.Shared.Popup);
local v1 = Knit.CreateController({
    Name = "PopupTestController"
});

function v1.KnitStart(p2) -- Line: 19
    -- upvalues: RunService (copy), Players (copy), UserInputService (copy), Popup (copy)
    if not RunService:IsStudio() then
        return;
    end;

    local LocalPlayer = Players.LocalPlayer;
    UserInputService.InputBegan:Connect(function(p3, p4) -- Line: 24
        -- upvalues: Popup (ref), LocalPlayer (copy)
        if p4 then
            return;
        end;

        if p3.KeyCode == Enum.KeyCode.G then
            Popup.PopTxt(LocalPlayer, "steal");

            return;
        end;

        if p3.KeyCode == Enum.KeyCode.H then
            Popup.PopTxt(LocalPlayer, "save");
        end;
    end);
end;

return v1;