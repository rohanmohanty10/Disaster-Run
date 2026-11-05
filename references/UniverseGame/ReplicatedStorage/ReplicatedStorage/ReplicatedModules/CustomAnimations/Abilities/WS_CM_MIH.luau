  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
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
    u3.Trove:Connect(Character:GetAttributeChangedSignal("CurrentAbility"), function() -- Line: 38
        -- upvalues: u3 (copy)
        u3.Callbacks.UpdateState(u3.CurrentState);
    end);

    function u3.GetAnimation(p7) -- Line: 42
        -- upvalues: CollectionService (ref), u3 (copy)
        if CollectionService:HasTag(u3.Character, "Summoned") then
            p7 = "Summoned" .. p7 or p7;
        end;

        return p7;
    end;

    function u3.GetSpeed(p8) -- Line: 47
        -- upvalues: Character (copy)
        local v9 = Character:GetAttribute("TimeAccelLevel") or 0;

        return v9 == 1 and 1.125 or (v9 == 2 and 1.25 or (v9 == 3 and 1.5 or (v9 >= 4 and 2 or 1)));
    end;

    local Animations = u3.Animations;
    u3.StateChanged:Connect(function(p10) -- Line: 62
        -- upvalues: Animations (copy)
        if p10 ~= "Idling" then
            Animations:StopAnimation("Idle");
        end;
    end);
    u3.Trove:Connect(CollectionService:GetInstanceAddedSignal("Piloting"), function(p11) -- Line: 68
        -- upvalues: u3 (copy)
        if p11 ~= u3.Character then
            return;
        end;

        u3.Callbacks.UpdateState(u3.CurrentState);
    end);
    u3.Trove:Connect(CollectionService:GetInstanceRemovedSignal("Piloting"), function(p12) -- Line: 72
        -- upvalues: u3 (copy)
        if p12 ~= u3.Character then
            return;
        end;

        u3.Callbacks.UpdateState(u3.CurrentState);
    end);

    return u3;
end;

function u1.OnIdle(p13) -- Line: 80
    -- upvalues: CollectionService (copy)
    if p13.Character:GetAttribute("CurrentAbility") == "MIH" then
        if CollectionService:HasTag(p13.Character, "Summoned") then
            p13.Animations:StopAnimation("Idle");
            p13.CurrentAnimation = p13.Animations:PlayAnimation("SummonedIdle", p13:GetSpeed());

            if p13.CurrentAnimation then
                p13.CurrentAnimation.Looped = true;
            end;
        else
            p13.Animations:StopAnimation("SummonedIdle");
            p13.CurrentAnimation = p13.Animations:PlayAnimation("Idle");

            if p13.CurrentAnimation then
                p13.CurrentAnimation.Looped = true;
            end;
        end;
    else
        if CollectionService:HasTag(p13.Character, "Piloting") then
            p13.Animations:StopAnimation("SummonedIdle");
        else
            p13.CurrentAnimation = p13.Animations:PlayAnimation(p13.GetAnimation("Idle"));

            if p13.CurrentAnimation then
                p13.CurrentAnimation.Looped = true;
            end;
        end;

        p13.Animations:PlayAnimation("Idle");
    end;
end;

function u1.OnWalk(p14) -- Line: 108
    -- upvalues: CollectionService (copy)
    if p14.Character:GetAttribute("CurrentAbility") == "MIH" then
        p14.CurrentAnimation = p14.Animations:PlayAnimation(p14.GetAnimation("Walk"), p14:GetSpeed());

        if p14.CurrentAnimation then
            p14.CurrentAnimation.Looped = true;
        end;

        if CollectionService:HasTag(p14.Character, "Summoned") then
            p14.Animations:PlayAnimation("SummonedIdle");
        end;
    else
        p14.CurrentAnimation = p14.Animations:PlayAnimation(p14.GetAnimation("Walk"));

        if p14.CurrentAnimation then
            p14.CurrentAnimation.Looped = true;
        end;

        if CollectionService:HasTag(p14.Character, "Summoned") then
            p14.Animations:PlayAnimation("SummonedIdle").Looped = true;
        end;
    end;
end;

function u1.OnRun(p15) -- Line: 128
    -- upvalues: CollectionService (copy)
    if p15.Character:GetAttribute("CurrentAbility") == "MIH" then
        p15.CurrentAnimation = p15.Animations:PlayAnimation(p15.GetAnimation("Run"), p15:GetSpeed());

        if p15.CurrentAnimation then
            p15.CurrentAnimation.Looped = true;
        end;

        if CollectionService:HasTag(p15.Character, "Summoned") then
            p15.Animations:PlayAnimation("SummonedIdle");
        end;
    else
        p15.CurrentAnimation = p15.Animations:PlayAnimation(p15.GetAnimation("Run"));

        if p15.CurrentAnimation then
            p15.CurrentAnimation.Looped = true;
        end;

        local v16 = CollectionService:HasTag(p15.Character, "Summoned") and p15.Animations:PlayAnimation("SummonedIdle");

        if v16 then
            v16.Looped = true;
        end;
    end;
end;

function u1.OnJump(p17) -- Line: 151
    -- upvalues: CollectionService (copy), Knit (copy)
    if p17.Character:GetAttribute("CurrentAbility") == "MIH" then
        p17.CurrentAnimation = p17.Animations:PlayAnimation("Jump");
        local v18 = CollectionService:HasTag(p17.Character, "Summoned") and p17.Animations:PlayAnimation("SummonedIdle");

        if v18 then
            v18.Looped = true;
        end;
    else
        p17.CurrentAnimation = p17.Animations:PlayAnimation("Jump");
        local v19 = Knit.CollectionService:HasTag(p17.Character, "Summoned") and p17.Animations:PlayAnimation("SummonedIdle");

        if v19 then
            v19.Looped = true;
        end;
    end;
end;

function u1.OnFall(p20) -- Line: 171
    -- upvalues: CollectionService (copy)
    if p20.Character:GetAttribute("CurrentAbility") == "MIH" then
        p20.CurrentAnimation = p20.Animations:PlayAnimation("Fall");

        if CollectionService:HasTag(p20.Character, "Summoned") then
            p20.Animations:PlayAnimation("SummonedIdle").Looped = true;
        end;
    else
        p20.Parent.OnFall(p20);
        p20.Animations:PlayAnimation("SummonedIdle");
    end;
end;

return u1;