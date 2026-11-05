  

 

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

    u3.Trove:Connect(u3.Character:GetAttributeChangedSignal("HyperForm"), function() -- Line: 21
        -- upvalues: u3 (copy)
        if u3.CurrentState then
            u3.Callbacks.UpdateState(u3.CurrentState);
        end;
    end);

    return u3;
end;

function u1.OnIdle(p4) -- Line: 30
    local v5 = p4.Character and p4.Character:GetAttribute("HyperForm");
    p4.CurrentAnimation = p4.Animations:PlayAnimation(v5 and "HyperIdle" or "Idle");
    p4.CurrentAnimation.Looped = true;
end;

return u1;