  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(PathShortcuts.KnitPath.TableUtil);
require(PathShortcuts.AnimsModule);
local BaseAnimate = require(PathShortcuts.ReplicatedModules.CustomAnimations.Base.BaseAnimate);
game:GetService("CollectionService");
local u1 = {};

function u1.new(p2) -- Line: 11
    -- upvalues: TableUtil (copy), BaseAnimate (copy), u1 (copy)
    local u3 = TableUtil.Reconcile({
        Parent = BaseAnimate.new(p2)
    }, u1);

    for i, v in pairs(u3.Parent) do
        if not u3[i] then
            u3[i] = v;
        end;
    end;

    local Character = u3.Character;
    u3.Trove:Connect(Character:GetAttributeChangedSignal("ChronoResurrection"), function() -- Line: 22
        -- upvalues: u3 (copy)
        u3.Callbacks.UpdateState(u3.CurrentState);
    end);
    u3.Trove:Connect(Character:GetAttributeChangedSignal("FastForward"), function() -- Line: 25
        -- upvalues: u3 (copy), Character (copy)
        u3.Callbacks.UpdateState(u3.CurrentState);
        local v4 = 20 * u3:GetSpeed();
        Character:SetAttribute("RunSpeed", (math.clamp(v4, 20, 33)));
    end);

    function u3.GetSpeed(p5) -- Line: 30
        -- upvalues: Character (copy)
        return Character:GetAttribute("FastForward") and 2 or 1;
    end;

    return u3;
end;

function u1.OnIdle(p6) -- Line: 42
    if p6.Character:GetAttribute("ChronoResurrection") == true then
        p6.CurrentAnimation = p6.Animations:PlayAnimation("AwakenedIdle", p6:GetSpeed());
    else
        p6.CurrentAnimation = p6.Animations:PlayAnimation("Idle", p6:GetSpeed());
    end;

    p6.CurrentAnimation.Looped = true;
end;

function u1.OnWalk(p7) -- Line: 51
    if p7.Character:GetAttribute("ChronoResurrection") == true then
        p7.CurrentAnimation = p7.Animations:PlayAnimation("AwakenedWalk", p7:GetSpeed());
    else
        p7.CurrentAnimation = p7.Animations:PlayAnimation("Walk", p7:GetSpeed());
    end;

    p7.CurrentAnimation.Looped = true;
end;

function u1.OnRun(p8) -- Line: 60
    if p8.Character:GetAttribute("ChronoResurrection") == true then
        p8.CurrentAnimation = p8.Animations:PlayAnimation("AwakenedRun", p8:GetSpeed());
    else
        p8.CurrentAnimation = p8.Animations:PlayAnimation("Run", p8:GetSpeed());
    end;

    p8.CurrentAnimation.Looped = true;
end;

return u1;