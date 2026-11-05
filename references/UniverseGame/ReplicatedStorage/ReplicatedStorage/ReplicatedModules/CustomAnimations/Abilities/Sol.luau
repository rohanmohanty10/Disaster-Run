  

 

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

    u3.Trove:Connect(u3.Character:GetAttributeChangedSignal("Sol_Armor"), function() -- Line: 21
        -- upvalues: u3 (copy)
        u3.Callbacks.UpdateState(u3.CurrentState);
    end);
    u3.Trove:Connect(CollectionService:GetInstanceAddedSignal("Summoned"), function(p4) -- Line: 26
        -- upvalues: u3 (copy)
        if u3.Character ~= p4 then
            return;
        end;

        u3.Animations:StopAnimation("Walk");
        u3.Animations:StopAnimation("Run");
        u3.Callbacks.UpdateState(u3.CurrentState);
    end);
    u3.Trove:Connect(CollectionService:GetInstanceRemovedSignal("Summoned"), function(p5) -- Line: 33
        -- upvalues: u3 (copy)
        if u3.Character ~= p5 then
            return;
        end;

        u3.Animations:StopAnimation("Summoned-Walk");
        u3.Animations:StopAnimation("Summoned-Run");
        u3.Callbacks.UpdateState(u3.CurrentState);
    end);

    function u3.GetAnimation(p6) -- Line: 40
        -- upvalues: u3 (copy)
        if u3.Character:GetAttribute("Sol_Armor") then
            p6 = "Armor-" .. p6 or p6;
        end;

        return p6;
    end;

    return u3;
end;

function u1.OnIdle(p7) -- Line: 49
    -- upvalues: CollectionService (copy)
    p7.CurrentAnimation = p7.Animations:PlayAnimation(p7.GetAnimation("Idle"));
    p7.CurrentAnimation.Looped = true;

    if CollectionService:HasTag(p7.Character, "Summoned") then
        p7.Animations:PlayAnimation("Summoned-Idle").Looped = true;
        p7.Animations:StopAnimation("Summoned-Walk");
        p7.Animations:StopAnimation("Summoned-Run");
    end;
end;

function u1.OnWalk(p8) -- Line: 59
    -- upvalues: CollectionService (copy)
    p8.CurrentAnimation = p8.Animations:PlayAnimation(p8.GetAnimation("Walk"));
    p8.CurrentAnimation.Looped = true;

    if CollectionService:HasTag(p8.Character, "Summoned") then
        p8.Animations:PlayAnimation("Summoned-Walk").Looped = true;
        p8.Animations:StopAnimation("Summoned-Idle");
        p8.Animations:StopAnimation("Summoned-Run");
    end;
end;

function u1.OnRun(p9) -- Line: 69
    -- upvalues: CollectionService (copy)
    p9.CurrentAnimation = p9.Animations:PlayAnimation(p9.GetAnimation("Run"));
    p9.CurrentAnimation.Looped = true;

    if CollectionService:HasTag(p9.Character, "Summoned") then
        p9.Animations:PlayAnimation("Summoned-Run").Looped = true;
        p9.Animations:StopAnimation("Summoned-Idle");
        p9.Animations:StopAnimation("Summoned-Walk");
    end;
end;

return u1;