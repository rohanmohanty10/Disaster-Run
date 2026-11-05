  

 

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

    local Character = u3.Character;
    u3.Trove:Connect(CollectionService:GetInstanceAddedSignal("Summoned"), function(p4) -- Line: 24
        -- upvalues: Character (copy), u3 (copy)
        if p4 ~= Character then
            return;
        end;

        u3.Callbacks.UpdateState(u3.CurrentState);
    end);
    u3.Trove:Connect(CollectionService:GetInstanceRemovedSignal("Summoned"), function(p5) -- Line: 29
        -- upvalues: Character (copy), u3 (copy)
        if p5 ~= Character then
            return;
        end;

        u3.Callbacks.UpdateState(u3.CurrentState);
    end);
    u3.Trove:Connect(Character:GetAttributeChangedSignal("TimeAccelLevel"), function() -- Line: 34
        -- upvalues: u3 (copy), Character (copy)
        u3.Callbacks.UpdateState(u3.CurrentState);
        local v6 = 20 * u3:GetSpeed();
        Character:SetAttribute("RunSpeed", (math.clamp(v6, 20, 33)));
    end);

    function u3.GetAnimation(p7) -- Line: 39
        -- upvalues: CollectionService (ref), u3 (copy)
        if CollectionService:HasTag(u3.Character, "Summoned") then
            p7 = "Summoned" .. p7 or p7;
        end;

        return p7;
    end;

    function u3.GetSpeed(p8) -- Line: 44
        -- upvalues: Character (copy)
        local v9 = Character:GetAttribute("TimeAccelLevel") or 0;

        return v9 == 1 and 1.125 or (v9 == 2 and 1.25 or (v9 == 3 and 1.5 or (v9 >= 4 and 2 or 1)));
    end;

    local Animations = u3.Animations;
    u3.StateChanged:Connect(function(p10) -- Line: 59
        -- upvalues: Animations (copy)
        if p10 ~= "Idling" then
            Animations:StopAnimation("Idle");
        end;
    end);

    return u3;
end;

function u1.OnIdle(p11) -- Line: 68
    -- upvalues: CollectionService (copy)
    if CollectionService:HasTag(p11.Character, "Summoned") then
        p11.Animations:StopAnimation("Idle");
        p11.CurrentAnimation = p11.Animations:PlayAnimation("SummonedIdle", p11:GetSpeed());
        p11.CurrentAnimation.Looped = true;

        return;
    end;

    p11.Animations:StopAnimation("SummonedIdle");
    p11.CurrentAnimation = p11.Animations:PlayAnimation("Idle");
    p11.CurrentAnimation.Looped = true;
end;

function u1.OnWalk(p12) -- Line: 80
    -- upvalues: CollectionService (copy)
    p12.CurrentAnimation = p12.Animations:PlayAnimation(p12.GetAnimation("Walk"), p12:GetSpeed());
    p12.CurrentAnimation.Looped = true;

    if CollectionService:HasTag(p12.Character, "Summoned") then
        p12.Animations:PlayAnimation("SummonedIdle");
    end;
end;

function u1.OnRun(p13) -- Line: 88
    -- upvalues: CollectionService (copy)
    p13.CurrentAnimation = p13.Animations:PlayAnimation(p13.GetAnimation("Run"), p13:GetSpeed());
    p13.CurrentAnimation.Looped = true;

    if CollectionService:HasTag(p13.Character, "Summoned") then
        p13.Animations:PlayAnimation("SummonedIdle");
    end;
end;

function u1.OnJump(p14) -- Line: 96
    -- upvalues: CollectionService (copy)
    p14.CurrentAnimation = p14.Animations:PlayAnimation("Jump");

    if CollectionService:HasTag(p14.Character, "Summoned") then
        p14.Animations:PlayAnimation("SummonedIdle").Looped = true;
    end;
end;

function u1.OnFall(p15) -- Line: 103
    -- upvalues: CollectionService (copy)
    p15.CurrentAnimation = p15.Animations:PlayAnimation("Fall");

    if CollectionService:HasTag(p15.Character, "Summoned") then
        p15.Animations:PlayAnimation("SummonedIdle").Looped = true;
    end;
end;

return u1;