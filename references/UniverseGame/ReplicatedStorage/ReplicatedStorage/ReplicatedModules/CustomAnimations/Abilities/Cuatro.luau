  

 

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

    u3.Trove:Connect(u3.Character:GetAttributeChangedSignal("Resurrection"), function() -- Line: 21
        -- upvalues: u3 (copy)
        if u3.CurrentState then
            u3.Callbacks.UpdateState(u3.CurrentState);
        end;
    end);
    u3.Trove:Connect(u3.Character:GetAttributeChangedSignal("SegundaEtapa"), function() -- Line: 28
        -- upvalues: u3 (copy)
        if u3.CurrentState then
            u3.Callbacks.UpdateState(u3.CurrentState);
        end;
    end);

    function u3.GetAnimation(p4) -- Line: 35
        -- upvalues: u3 (copy)
        local v5 = u3.Character:GetAttribute("SegundaEtapa") and "Segunda" .. p4;

        if v5 then
            p4 = v5;
        elseif u3.Character:GetAttribute("Resurrection") then
            p4 = "Resurrection" .. p4 or p4;
        end;

        return p4;
    end;

    return u3;
end;

function u1.OnIdle(p6) -- Line: 44
    p6.CurrentAnimation = p6.Animations:PlayAnimation(p6.GetAnimation("Idle"));
    p6.CurrentAnimation.Looped = true;
end;

function u1.OnWalk(p7) -- Line: 49
    p7.CurrentAnimation = p7.Animations:PlayAnimation(p7.GetAnimation("Walk"));
    p7.CurrentAnimation.Looped = true;
end;

function u1.OnRun(p8) -- Line: 54
    p8.CurrentAnimation = p8.Animations:PlayAnimation(p8.GetAnimation("Run"));
    p8.CurrentAnimation.Looped = true;
end;

return u1;