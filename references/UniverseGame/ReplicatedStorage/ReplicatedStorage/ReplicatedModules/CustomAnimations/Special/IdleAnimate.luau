  

 

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

    function u3.GetAnimation(p6) -- Line: 34
        -- upvalues: u3 (copy), CollectionService (ref)
        local v7 = u3.Character:GetAttribute("Biking") and "Bike-" .. p6;

        if v7 then
            p6 = v7;
        elseif CollectionService:HasTag(u3.Character, "Summoned") then
            p6 = "Summoned" .. p6 or p6;
        end;

        return p6;
    end;

    local Animations = u3.Animations;
    u3.StateChanged:Connect(function(p8) -- Line: 41
        -- upvalues: Animations (copy)
        if p8 ~= "Idling" then
            Animations:StopAnimation("Idle");
        end;
    end);

    return u3;
end;

function u1.OnIdle(p9) -- Line: 50
    -- upvalues: CollectionService (copy)
    p9.CurrentAnimation = p9.Animations:PlayAnimation("Idle");
    p9.CurrentAnimation.Looped = true;

    if CollectionService:HasTag(p9.Character, "Summoned") then
        p9.Animations:PlayAnimation("SummonedIdle").Looped = true;

        return;
    end;

    p9.Animations:StopAnimation("SummonedIdle");
end;

function u1.OnWalk(p10) -- Line: 60
    -- upvalues: CollectionService (copy)
    p10.CurrentAnimation = p10.Animations:PlayAnimation(p10.GetAnimation("Walk"));
    p10.CurrentAnimation.Looped = true;

    if CollectionService:HasTag(p10.Character, "Summoned") then
        p10.Animations:PlayAnimation("SummonedIdle").Looped = true;

        return;
    end;

    p10.Animations:StopAnimation("SummonedIdle");
end;

function u1.OnRun(p11) -- Line: 70
    -- upvalues: CollectionService (copy)
    p11.CurrentAnimation = p11.Animations:PlayAnimation(p11.GetAnimation("Run"));
    p11.CurrentAnimation.Looped = true;

    if CollectionService:HasTag(p11.Character, "Summoned") then
        p11.Animations:PlayAnimation("SummonedIdle").Looped = true;

        return;
    end;

    p11.Animations:StopAnimation("SummonedIdle");
end;

return u1;