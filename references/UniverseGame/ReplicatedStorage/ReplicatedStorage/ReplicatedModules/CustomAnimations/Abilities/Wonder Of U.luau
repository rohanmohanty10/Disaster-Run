  

 

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

    u3.Trove:Connect(u3.Character:GetAttributeChangedSignal("Stand"), function() -- Line: 21
        -- upvalues: u3 (copy)
        if u3.CurrentState then
            u3.Callbacks.UpdateState(u3.CurrentState);
        end;
    end);

    function u3.GetAnimation(p4) -- Line: 28
        -- upvalues: u3 (copy)
        if u3.Character:GetAttribute("Stand") then
            p4 = "Stand" .. p4 or p4;
        end;

        return p4;
    end;

    return u3;
end;

function u1.OnIdle(p5) -- Line: 37
    p5.CurrentAnimation = p5.Animations:PlayAnimation(p5.GetAnimation("Idle"));
    p5.CurrentAnimation.Looped = true;
end;

function u1.OnWalk(p6) -- Line: 42
    p6.CurrentAnimation = p6.Animations:PlayAnimation(p6.GetAnimation("Walk"));
    p6.CurrentAnimation.Looped = true;
end;

function u1.OnRun(p7) -- Line: 47
    p7.CurrentAnimation = p7.Animations:PlayAnimation(p7.GetAnimation("Run"));
    p7.CurrentAnimation.Looped = true;
end;

return u1;