  

 

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
    u3.Trove:Connect(CollectionService:GetInstanceAddedSignal("Summoned"), function(p4) -- Line: 23
        -- upvalues: Character (copy), u3 (copy)
        if p4 ~= Character then
            return;
        end;

        u3.Callbacks.UpdateState(u3.CurrentState);
    end);
    u3.Trove:Connect(CollectionService:GetInstanceRemovedSignal("Summoned"), function(p5) -- Line: 28
        -- upvalues: Character (copy), u3 (copy)
        if p5 ~= Character then
            return;
        end;

        u3.Callbacks.UpdateState(u3.CurrentState);
    end);

    function u3.GetAnimation(p6) -- Line: 33
        -- upvalues: CollectionService (ref), u3 (copy)
        if CollectionService:HasTag(u3.Character, "Summoned") then
            p6 = "Summoned" .. p6 or p6;
        end;

        return p6;
    end;

    local Animations = u3.Animations;
    u3.StateChanged:Connect(function(p7) -- Line: 40
        -- upvalues: Animations (copy)
        if p7 ~= "Idling" then
            Animations:StopAnimation("Idle");
        end;
    end);

    return u3;
end;

function u1.OnIdle(p8) -- Line: 49
    -- upvalues: CollectionService (copy)
    if CollectionService:HasTag(p8.Character, "Summoned") then
        p8.Animations:StopAnimation("Idle");
        p8.CurrentAnimation = p8.Animations:PlayAnimation("SummonedIdle");
        p8.CurrentAnimation.Looped = true;

        return;
    end;

    p8.Animations:StopAnimation("SummonedIdle");
    p8.CurrentAnimation = p8.Animations:PlayAnimation("Idle");
    p8.CurrentAnimation.Looped = true;
end;

function u1.OnWalk(p9) -- Line: 61
    -- upvalues: CollectionService (copy)
    p9.CurrentAnimation = p9.Animations:PlayAnimation(p9.GetAnimation("Walk"));
    p9.CurrentAnimation.Looped = true;

    if CollectionService:HasTag(p9.Character, "Summoned") then
        p9.Animations:PlayAnimation("SummonedIdle");
    end;
end;

function u1.OnRun(p10) -- Line: 70
    -- upvalues: CollectionService (copy)
    p10.CurrentAnimation = p10.Animations:PlayAnimation(p10.GetAnimation("Run"));
    p10.CurrentAnimation.Looped = true;

    if CollectionService:HasTag(p10.Character, "Summoned") then
        p10.Animations:PlayAnimation("SummonedIdle");
    end;
end;

function u1.OnJump(p11) -- Line: 79
    -- upvalues: CollectionService (copy)
    p11.CurrentAnimation = p11.Animations:PlayAnimation("Jump");

    if CollectionService:HasTag(p11.Character, "Summoned") then
        p11.Animations:PlayAnimation("SummonedIdle").Looped = true;
    end;
end;

function u1.OnFall(p12) -- Line: 87
    -- upvalues: CollectionService (copy)
    p12.CurrentAnimation = p12.Animations:PlayAnimation("Fall");

    if CollectionService:HasTag(p12.Character, "Summoned") then
        p12.Animations:PlayAnimation("SummonedIdle").Looped = true;
    end;
end;

return u1;