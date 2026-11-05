  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local Players = game:GetService("Players");
local Debris = game:GetService("Debris");
local LocalPlayer = Players.LocalPlayer;
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
require(PathShortcuts.KnitPath.Knit);
local Trove = require(PathShortcuts.KnitPath.Trove);

return function(p1) -- Line: 14
    -- upvalues: LocalPlayer (copy), Debris (copy), Trove (copy), TweenService (copy)
    local u2 = "Rainbow_Character_" .. p1.Character.Name;
    local u3 = LocalPlayer.PlayerGui:FindFirstChild(u2);

    if u3 then
        u3.Name = string.reverse(u2);
        u3:SetAttribute("Stop", p1.Tween or true);
        Debris:AddItem(u3, (p1.Tween or 0) + 1);
    end;

    if p1.Remove then
        return;
    end;

    local u4 = Trove.new();
    u4:AttachToInstance(p1.Character);
    local u5 = script.Rainbow:Clone();
    u5.Name = u2;
    u5.User.Value = p1.Character;
    u5.Parent = LocalPlayer.PlayerGui;
    u5.ViewportFrame.ImageTransparency = p1.Tween and 1 or (p1.Transparency or 0.5);

    if p1.Tween then
        TweenService:Create(u5.ViewportFrame, TweenInfo.new(p1.Tween, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            ImageTransparency = p1.Transparency or 0.5
        }):Play();
    end;

    u5.Handler.Enabled = true;
    u4:Add(function() -- Line: 40
        -- upvalues: u5 (copy), u2 (copy), u3 (copy)
        if u5.Name ~= u2 then
            return;
        end;

        u5.Name = string.reverse(u2);
        u5:SetAttribute("Stop", true);
        u5:AddItem(u3, 1);
    end);
    u4:Connect(u5:GetPropertyChangedSignal("Name"), function() -- Line: 46
        -- upvalues: u4 (copy)
        u4:Destroy();
    end);
end;