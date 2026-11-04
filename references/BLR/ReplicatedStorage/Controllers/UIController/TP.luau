  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local TeleportService = game:GetService("TeleportService");
local TweenService = game:GetService("TweenService");
local Knit = require(ReplicatedStorage.Packages.Knit);
local v1 = Knit.CreateController({
    Name = "TP"
});

function v1.KnitStart(u2) -- Line: 12
    -- upvalues: Knit (copy), RunService (copy), ReplicatedStorage (copy), TeleportService (copy), TweenService (copy)
    local TPGui = Knit.Player.PlayerGui:WaitForChild("TPGui");
    RunService.RenderStepped:Connect(function(p3) -- Line: 15
        -- upvalues: TPGui (copy)
        local Logo = TPGui.BG.LogoContainer.Logo;
        Logo.Rotation = Logo.Rotation + 90 * p3;
    end);
    ReplicatedStorage.Teleporting.OnClientEvent:Connect(function() -- Line: 21
        -- upvalues: u2 (copy), TPGui (copy), TeleportService (ref), TweenService (ref)
        if u2.isTeleporting then
            return;
        end;

        u2.isTeleporting = true;
        TPGui.BG.GroupTransparency = 1;
        TPGui.Enabled = true;
        TeleportService:SetTeleportGui(TPGui);
        TweenService:Create(TPGui.BG, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {
            GroupTransparency = 0
        }):Play();
    end);
end;

return v1;