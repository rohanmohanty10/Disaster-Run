  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);

return function(u1) -- Line: 7
    -- upvalues: ReplicatedStorage (copy), VfxManager (copy)
    local _ = game.Players.LocalPlayer;
    local GLITCH = ReplicatedStorage.Assets.GoalEffects.GLITCH;
    local u2 = GLITCH.Effect:Clone();
    u2.Parent = workspace;
    u2.CFrame = u1.Pos;

    for _, child in GLITCH:GetChildren() do
        if child:IsA("ColorCorrectionEffect") ~= false then
            local v3 = child:Clone();
            v3.Name = "GLITCHCLONE";
            v3.Parent = game.Lighting;
            task.wait(0.025);
            v3:Destroy();
        end;
    end;

    task.delay(7, function() -- Line: 24
        -- upvalues: VfxManager (ref), u2 (copy)
        VfxManager.Enable(u2, false);
    end);
    task.delay(12, function() -- Line: 28
        -- upvalues: u2 (copy), u1 (ref)
        u2:Destroy();
        table.clear(u1);
        u1 = nil;
    end);
end;