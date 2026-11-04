  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local CollectionService = game:GetService("CollectionService");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);

return function(u1) -- Line: 8
    -- upvalues: ReplicatedStorage (copy), VfxManager (copy), CollectionService (copy)
    local u2 = ReplicatedStorage.Assets.GoalEffects.Lightning["Lightning Explosion"]:Clone();
    u2.Parent = workspace;
    u2.CFrame = u1.Pos;
    VfxManager.Emit(u2);

    for _, v in CollectionService:GetTagged() do
        if u1.Team ~= v then
            for _, v2 in v:GetPlayers() do
                local u3 = ReplicatedStorage.Assets.GoalEffects.Lightning["Lightning strike"].Floor:Clone();
                local u4 = ReplicatedStorage.Assets.GoalEffects.Lightning["Lightning strike"].Cloud:Clone();
                u3.Parent = workspace;
                u4.Parent = workspace;
                u3.CFrame = v2.Character.HumanoidRootPart.CFrame * CFrame.new(0, -3, 0);
                u4.CFrame = v2.Character.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0);
                VfxManager.Emit(u4);
                VfxManager.Emit(u3);
                task.delay(2, function() -- Line: 30
                    -- upvalues: u4 (copy), u3 (copy)
                    u4:Destroy();
                    u3:Destroy();
                end);
            end;
        end;
    end;

    task.delay(4, function() -- Line: 39
        -- upvalues: u2 (copy)
        u2:Destroy();
    end);
    task.delay(12, function() -- Line: 43
        -- upvalues: u1 (ref)
        table.clear(u1);
        u1 = nil;
    end);
end;