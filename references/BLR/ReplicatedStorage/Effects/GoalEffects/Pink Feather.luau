  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);
local EmitModule = require(ReplicatedStorage.Shared.EmitModule);
local u1 = not RunService:IsRunning() and workspace.CurrentCamera or workspace.Debris;
Random.new(os.clock());

return function(p2) -- Line: 14
    -- upvalues: u1 (copy), EmitModule (copy)
    local _ = game.Players.LocalPlayer;
    local u3 = script.GE:Clone();
    u3.Parent = u1;
    u3:PivotTo(p2.Pos);
    local u4 = script.ScreenEffect:Clone();
    u4.Anchored = true;
    u4.CanCollide = false;
    u4.CanQuery = false;
    u4.CanTouch = false;
    u4.Transparency = 1;
    u4.Parent = u1;

    for _, child in u3:GetChildren() do
        if child:IsA("BasePart") then
            child.Anchored = true;
            child.CanCollide = false;
            child.Transparency = 1;
        end;
    end;

    EmitModule.emit(u3, u4);
    task.delay(8, function() -- Line: 38
        -- upvalues: u3 (copy), u4 (copy)
        u3:Destroy();
        u4:Destroy();
    end);
end;