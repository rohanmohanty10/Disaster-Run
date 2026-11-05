  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(PathShortcuts.KnitPath.TableUtil);
require(PathShortcuts.AnimsModule);
local BaseAnimate = require(PathShortcuts.ReplicatedModules.CustomAnimations.Base.BaseAnimate);
local CollectionService = game:GetService("CollectionService");
local u1 = {};

function u1.new(p2) -- Line: 11
    -- upvalues: TableUtil (copy), BaseAnimate (copy), u1 (copy), CollectionService (copy)
    local u3 = TableUtil.Reconcile({
        Parent = BaseAnimate.new(p2)
    }, u1);

    for i, v in pairs(u3.Parent) do
        if not u3[i] then
            u3[i] = v;
        end;
    end;

    local Character = u3.Character;
    u3.Trove:Connect(CollectionService:GetInstanceAddedSignal("Sovereign"), function(p4) -- Line: 22
        -- upvalues: Character (copy), u3 (copy)
        if p4 ~= Character then
            return;
        end;

        u3.Callbacks.UpdateState(u3.CurrentState);
    end);
    u3.Trove:Connect(CollectionService:GetInstanceRemovedSignal("Sovereign"), function(p5) -- Line: 27
        -- upvalues: Character (copy), u3 (copy)
        if p5 ~= Character then
            return;
        end;

        u3.Callbacks.UpdateState(u3.CurrentState);
    end);
    u3.Trove:Connect(CollectionService:GetInstanceAddedSignal("Summoned"), function(p6) -- Line: 32
        -- upvalues: Character (copy), u3 (copy)
        if p6 ~= Character then
            return;
        end;

        u3.Callbacks.UpdateState(u3.CurrentState);
    end);
    u3.Trove:Connect(CollectionService:GetInstanceRemovedSignal("Summoned"), function(p7) -- Line: 37
        -- upvalues: Character (copy), u3 (copy)
        if p7 ~= Character then
            return;
        end;

        u3.Callbacks.UpdateState(u3.CurrentState);
    end);

    function u3.GetAnimation(p8) -- Line: 42
        -- upvalues: CollectionService (ref), Character (copy)
        if not CollectionService:HasTag(Character, "Summoned") then
            return p8;
        end;

        if CollectionService:HasTag(Character, "Sovereign") then
            return "Sovereign" .. p8;
        end;

        return "Summoned" .. p8;
    end;

    return u3;
end;

function u1.OnIdle(p9) -- Line: 57
    p9.CurrentAnimation = p9.Animations:PlayAnimation(p9.GetAnimation("Idle"));
    p9.CurrentAnimation.Looped = true;
end;

function u1.OnWalk(p10) -- Line: 62
    p10.CurrentAnimation = p10.Animations:PlayAnimation(p10.GetAnimation("Walk"));
    p10.CurrentAnimation.Looped = true;
end;

function u1.OnRun(p11) -- Line: 67
    p11.CurrentAnimation = p11.Animations:PlayAnimation(p11.GetAnimation("Run"));
    p11.CurrentAnimation.Looped = true;
end;

return u1;