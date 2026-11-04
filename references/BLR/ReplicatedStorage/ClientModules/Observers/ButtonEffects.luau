  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
game:GetService("RunService");
local PlayerGui = Players.LocalPlayer.PlayerGui;
local Observers = require(ReplicatedStorage.Packages.Observers);
local Trove = require(ReplicatedStorage.Packages.Trove);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);
local Tweens = require(ReplicatedStorage.Shared.Tweens);

return Observers.observeTag("ButtonEffects", function(u1) -- Line: 18
    -- upvalues: Trove (copy), SoundManager (copy), Tweens (copy), PlayerGui (copy)
    local v2 = Trove.new();
    local Size = u1.Size;
    v2:Connect(u1.MouseEnter, function() -- Line: 22
        -- upvalues: u1 (copy), SoundManager (ref), Tweens (ref), Size (copy)
        if u1:GetAttribute("NoHover") then
            return;
        end;

        SoundManager.SpawnSound("Hover", 0.4, u1, 1);
        Tweens.TweenSize(0.25, "Sine", { u1 }, UDim2.new(Size.X.Scale * (u1:GetAttribute("CustomHoverScale") or 1.08), 0, Size.Y.Scale * (u1:GetAttribute("CustomHoverScale") or 1.08), 0));
    end);
    v2:Connect(u1.MouseLeave, function() -- Line: 29
        -- upvalues: u1 (copy), Tweens (ref), Size (copy)
        if u1:GetAttribute("NoHover") then
            return;
        end;

        Tweens.TweenSize(0.25, "Sine", { u1 }, Size);
    end);
    v2:Connect(u1.MouseButton1Click, function() -- Line: 34
        -- upvalues: u1 (copy), SoundManager (ref), PlayerGui (ref), Tweens (ref), Size (copy)
        if u1:GetAttribute("NoClick") then
            return;
        end;

        SoundManager.SpawnSound("Click", 0.55, PlayerGui);
        Tweens.TweenSize(0.1, "Sine", { u1 }, UDim2.new(Size.X.Scale * (u1:GetAttribute("CustomClickScale") or 0.85), 0, Size.Y.Scale * (u1:GetAttribute("CustomClickScale") or 0.85), 0));
        task.delay(0.1, function() -- Line: 39
            -- upvalues: Tweens (ref), u1 (ref), Size (ref)
            Tweens.TweenSize(0.1, "Sine", { u1 }, Size);
        end);
    end);

    return v2:WrapClean();
end);