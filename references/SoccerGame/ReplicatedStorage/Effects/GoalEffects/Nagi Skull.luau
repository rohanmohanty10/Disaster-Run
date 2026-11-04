  

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

    for _, child in u3:GetChildren() do
        if child:IsA("BasePart") then
            child.Anchored = true;
            child.CanCollide = false;
        end;
    end;

    EmitModule.emit(u3);
    task.delay(8, function() -- Line: 29
        -- upvalues: u3 (copy)
        u3:Destroy();
    end);
end;