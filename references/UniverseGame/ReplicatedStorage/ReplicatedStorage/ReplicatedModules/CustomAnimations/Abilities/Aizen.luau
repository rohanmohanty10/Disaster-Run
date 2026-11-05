  

 

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
    u3.Trove:Connect(Character:GetAttributeChangedSignal("Hogyoku"), function() -- Line: 25
        -- upvalues: u3 (copy)
        u3.Callbacks.UpdateState(u3.CurrentState);
    end);

    function u3.GetAnimation(p4) -- Line: 29
        -- upvalues: Character (copy)
        local v5 = Character:GetAttribute("Hogyoku");

        if table.find({ "Jump", "Fall" }, p4) or v5 and v5 < 1 then
            return p4;
        end;

        if v5 then
            p4 = "Hogyoku" .. v5 .. p4 or p4;
        end;

        return p4;
    end;

    function u3.GetSpeed(p6) -- Line: 43
        return 1;
    end;

    local Animations = u3.Animations;
    u3.StateChanged:Connect(function(p7) -- Line: 48
        -- upvalues: Animations (copy)
        if p7 ~= "Idling" then
            Animations:StopAnimation("Idle");
        end;
    end);

    return u3;
end;

function u1.OnIdle(p8) -- Line: 57
    p8.CurrentAnimation = p8.Animations:PlayAnimation(p8.GetAnimation("Idle"));
    p8.CurrentAnimation.Looped = true;
end;

function u1.OnWalk(p9) -- Line: 62
    p9.CurrentAnimation = p9.Animations:PlayAnimation(p9.GetAnimation("Walk"), p9:GetSpeed());
    p9.CurrentAnimation.Looped = true;
end;

function u1.OnRun(p10) -- Line: 67
    p10.CurrentAnimation = p10.Animations:PlayAnimation(p10.GetAnimation("Run"), p10:GetSpeed());
    p10.CurrentAnimation.Looped = true;
end;

function u1.OnJump(p11) -- Line: 72
    p11.CurrentAnimation = p11.Animations:PlayAnimation("Jump");
end;

function u1.OnFall(p12) -- Line: 76
    p12.CurrentAnimation = p12.Animations:PlayAnimation("Fall");
end;

return u1;