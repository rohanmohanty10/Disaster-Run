  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(PathShortcuts.KnitPath.TableUtil);
require(PathShortcuts.AnimsModule);
local BaseAnimate = require(PathShortcuts.ReplicatedModules.CustomAnimations.Base.BaseAnimate);
game:GetService("CollectionService");
local u1 = {};

function u1.new(p2) -- Line: 12
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
    u3.Trove:Connect(Character:GetAttributeChangedSignal("Weapon"), function() -- Line: 25
        -- upvalues: u3 (copy)
        u3.Callbacks.UpdateState(u3.CurrentState);
    end);

    function u3.GetAnimation(p4) -- Line: 29
        -- upvalues: Character (copy)
        return (Character:GetAttribute("Weapon") or "") .. p4;
    end;

    function u3.GetSpeed(p5) -- Line: 34
        return 1;
    end;

    local Animations = u3.Animations;
    u3.StateChanged:Connect(function(p6) -- Line: 39
        -- upvalues: Animations (copy)
        if p6 ~= "Idling" then
            Animations:StopAnimation("Idle");
        end;
    end);

    return u3;
end;

function u1.OnIdle(p7) -- Line: 48
    p7.CurrentAnimation = p7.Animations:PlayAnimation(p7.GetAnimation("Idle"));
    p7.CurrentAnimation.Looped = true;
end;

function u1.OnWalk(p8) -- Line: 53
    p8.CurrentAnimation = p8.Animations:PlayAnimation(p8.GetAnimation("Walk"), p8:GetSpeed());
    p8.CurrentAnimation.Looped = true;
end;

function u1.OnRun(p9) -- Line: 58
    p9.CurrentAnimation = p9.Animations:PlayAnimation(p9.GetAnimation("Run"), p9:GetSpeed());
    p9.CurrentAnimation.Looped = true;
end;

function u1.OnJump(p10) -- Line: 63
    p10.CurrentAnimation = p10.Animations:PlayAnimation("Jump");
end;

function u1.OnFall(p11) -- Line: 67
    p11.CurrentAnimation = p11.Animations:PlayAnimation("Fall");
end;

return u1;