  

 

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
    local Animations = u3.Animations;
    u3.Trove:Connect(Character:GetAttributeChangedSignal("AwakenedMode"), function() -- Line: 24
        -- upvalues: u3 (copy), Animations (copy)
        if u3.Character:GetAttribute("AwakenedMode") then
            Animations:StopAnimation("SummonedIdle");
        end;

        u3.Callbacks.UpdateState(u3.CurrentState);
    end);
    u3.Trove:Connect(CollectionService:GetInstanceAddedSignal("Summoned"), function(p4) -- Line: 31
        -- upvalues: Character (copy), u3 (copy)
        if p4 ~= Character then
            return;
        end;

        u3.Callbacks.UpdateState(u3.CurrentState);
    end);
    u3.Trove:Connect(CollectionService:GetInstanceRemovedSignal("Summoned"), function(p5) -- Line: 36
        -- upvalues: Character (copy), u3 (copy)
        if p5 ~= Character then
            return;
        end;

        u3.Callbacks.UpdateState(u3.CurrentState);
    end);

    function u3.GetAnimation(p6) -- Line: 41
        -- upvalues: u3 (copy), CollectionService (ref), Character (copy)
        local v7 = u3.Character:GetAttribute("AwakenedMode") and "Awakened" .. p6;

        if v7 then
            p6 = v7;
        elseif CollectionService:HasTag(Character, "Summoned") then
            p6 = "Summoned" .. p6 or p6;
        end;

        return p6;
    end;

    u3.StateChanged:Connect(function(p8) -- Line: 47
        -- upvalues: Animations (copy), u3 (copy)
        if p8 ~= "Idling" then
            Animations:StopAnimation(u3.GetAnimation("Idle"));
        end;
    end);

    return u3;
end;

function u1.OnIdle(p9) -- Line: 56
    p9.CurrentAnimation = p9.Animations:PlayAnimation(p9.GetAnimation("Idle"));
    p9.CurrentAnimation.Looped = true;
end;

function u1.OnWalk(p10) -- Line: 61
    p10.CurrentAnimation = p10.Animations:PlayAnimation(p10.GetAnimation("Walk"));
    p10.CurrentAnimation.Looped = true;
end;

function u1.OnRun(p11) -- Line: 66
    p11.CurrentAnimation = p11.Animations:PlayAnimation(p11.GetAnimation("Run"));
    p11.CurrentAnimation.Looped = true;
end;

function u1.OnJump(p12) -- Line: 71
    -- upvalues: CollectionService (copy)
    p12.CurrentAnimation = p12.Animations:PlayAnimation("Jump");

    if not p12.Character:GetAttribute("AwakenedMode") and (CollectionService:HasTag(p12.Character, "Summoned") and p12.Animations:GetAnimation("SummonedIdle")) then
        p12.Animations:PlayAnimation("SummonedIdle").Looped = true;
    end;
end;

function u1.OnFall(p13) -- Line: 79
    -- upvalues: CollectionService (copy)
    p13.CurrentAnimation = p13.Animations:PlayAnimation("Fall");

    if not p13.Character:GetAttribute("AwakenedMode") and (CollectionService:HasTag(p13.Character, "Summoned") and p13.Animations:GetAnimation("SummonedIdle")) then
        p13.Animations:PlayAnimation("SummonedIdle").Looped = true;
    end;
end;

return u1;