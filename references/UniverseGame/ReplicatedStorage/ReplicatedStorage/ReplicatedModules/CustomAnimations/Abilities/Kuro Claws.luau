  

 

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

    u3.Trove:Connect(u3.Character:GetAttributeChangedSignal("Movement_Animator_Multiplier"), function() -- Line: 21
        -- upvalues: u3 (copy)
        u3.Callbacks.UpdateState(u3.CurrentState);
    end);

    return u3;
end;

function u1.OnIdle(p4) -- Line: 28
    p4.CurrentAnimation = p4.Animations:PlayAnimation("Idle");
    p4.CurrentAnimation.Looped = true;
end;

function u1.OnWalk(p5) -- Line: 33
    p5.CurrentAnimation = p5.Animations:PlayAnimation("Walk", p5.Character:GetAttribute("Movement_Animator_Multiplier") or 1);
    p5.CurrentAnimation.Looped = true;
end;

function u1.OnRun(p6) -- Line: 38
    p6.CurrentAnimation = p6.Animations:PlayAnimation("Run", p6.Character:GetAttribute("Movement_Animator_Multiplier") or 1);
    p6.CurrentAnimation.Looped = true;
end;

return u1;