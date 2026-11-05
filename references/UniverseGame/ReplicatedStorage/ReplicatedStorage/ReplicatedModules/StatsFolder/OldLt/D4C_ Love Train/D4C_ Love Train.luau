  

 

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
    u3.Trove:Connect(CollectionService:GetInstanceAddedSignal("LoveTrain"), function(p4) -- Line: 22
        -- upvalues: Character (copy), u3 (copy)
        if p4 ~= Character then
            return;
        end;

        u3.Callbacks.UpdateState(u3.CurrentState);
    end);
    u3.Trove:Connect(CollectionService:GetInstanceRemovedSignal("LoveTrain"), function(p5) -- Line: 27
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
    u3.StateChanged:Connect(function(p8) -- Line: 42
        -- upvalues: u3 (copy)
        if p8 ~= "Idling" then
            u3.Animations:StopAnimation("Idle");
        end;
    end);

    function u3.GetAnimation(p9) -- Line: 48
        -- upvalues: CollectionService (ref), Character (copy)
        if not CollectionService:HasTag(Character, "Summoned") then
            return p9;
        end;

        if CollectionService:HasTag(Character, "LoveTrain") then
            return "LoveTrain" .. p9;
        end;

        return "Summoned" .. p9;
    end;

    return u3;
end;

function u1.OnIdle(p10) -- Line: 63
    p10.CurrentAnimation = p10.Animations:PlayAnimation(p10.GetAnimation("Idle"));
    p10.CurrentAnimation.Looped = true;
    p10.Animations:PlayAnimation("Idle").Looped = true;
end;

function u1.OnWalk(p11) -- Line: 69
    p11.CurrentAnimation = p11.Animations:PlayAnimation(p11.GetAnimation("Walk"));
    p11.CurrentAnimation.Looped = true;
end;

function u1.OnRun(p12) -- Line: 74
    p12.CurrentAnimation = p12.Animations:PlayAnimation(p12.GetAnimation("Run"));
    p12.CurrentAnimation.Looped = true;
end;

return u1;