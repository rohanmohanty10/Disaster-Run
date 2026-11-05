  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(PathShortcuts.KnitPath.TableUtil);
require(PathShortcuts.AnimsModule);
local BaseAnimate = require(PathShortcuts.ReplicatedModules.CustomAnimations.Base.BaseAnimate);
local CollectionService = game:GetService("CollectionService");
local u1 = {};

function u1.new(p2) -- Line: 12
    -- upvalues: TableUtil (copy), BaseAnimate (copy), u1 (copy), CollectionService (copy)
    local u3 = TableUtil.Reconcile({
        Parent = BaseAnimate.new(p2)
    }, u1);

    for i, v in pairs(u3.Parent) do
        if not u3[i] then
            u3[i] = v;
        end;
    end;

    function u3.GetAnimation(p4) -- Line: 22
        -- upvalues: CollectionService (ref), u3 (copy)
        if CollectionService:HasTag(u3.Character, "Summoned") then
            p4 = "Summoned" .. p4 or p4;
        end;

        return p4;
    end;

    local Animations = u3.Animations;
    u3.StateChanged:Connect(function(p5) -- Line: 28
        -- upvalues: Animations (copy)
        if p5 ~= "Idling" then
            Animations:StopAnimation("Idle");
        end;
    end);
    u3.Trove:Connect(CollectionService:GetInstanceAddedSignal("Piloting"), function(p6) -- Line: 34
        -- upvalues: u3 (copy)
        if p6 ~= u3.Character then
            return;
        end;

        u3.Callbacks.UpdateState(u3.CurrentState);
    end);
    u3.Trove:Connect(CollectionService:GetInstanceRemovedSignal("Piloting"), function(p7) -- Line: 38
        -- upvalues: u3 (copy)
        if p7 ~= u3.Character then
            return;
        end;

        u3.Callbacks.UpdateState(u3.CurrentState);
    end);

    return u3;
end;

function u1.OnIdle(p8) -- Line: 46
    -- upvalues: CollectionService (copy)
    if CollectionService:HasTag(p8.Character, "Piloting") then
        p8.Animations:StopAnimation("SummonedIdle");
    else
        p8.CurrentAnimation = p8.Animations:PlayAnimation(p8.GetAnimation("Idle"));
        p8.CurrentAnimation.Looped = true;
    end;

    p8.Animations:PlayAnimation("Idle");
end;

function u1.OnFall(p9) -- Line: 56
    p9.Parent.OnFall(p9);
    p9.Animations:PlayAnimation("SummonedIdle");
end;

return u1;