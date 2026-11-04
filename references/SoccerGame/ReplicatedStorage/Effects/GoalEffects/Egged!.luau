  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("UserInputService");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);

return function(p1) -- Line: 9
    -- upvalues: VfxManager (copy), ReplicatedStorage (copy)
    local v2 = script.GoalExplosion:Clone();
    v2.Parent = workspace.Debris;
    v2:PivotTo(p1.Pos);
    VfxManager.Emit(v2);
    local u3 = { ReplicatedStorage.Assets.GoalEffects["Egged!"].Egg1, ReplicatedStorage.Assets.GoalEffects["Egged!"].Egg2, ReplicatedStorage.Assets.GoalEffects["Egged!"].Egg3 };
    local Field = workspace.Field.Field;

    for i = 1, 70 do
        task.delay(0.5 + math.random() * 2, function() -- Line: 19
            -- upvalues: u3 (copy), Field (copy)
            local v4 = u3[math.random(1, #u3)];
            local Position = Field.Position;
            local math_random_ret = math.random(-Field.Size.X / 2, Field.Size.X / 2);
            local v5 = Position + Vector3.new(math_random_ret, 0, math.random(-Field.Size.Z / 2, Field.Size.Z / 2));
            local v6 = v4:Clone();
            local math_random_ret2 = math.random(60, 100);
            v6.Position = v5 + Vector3.new(0, math_random_ret2, 0);
            v6.Parent = workspace.Debris;
            game:GetService("Debris"):AddItem(v6, 5);
        end);
        local _ = i;
    end;

    task.wait(5);
    v2:Destroy();
end;