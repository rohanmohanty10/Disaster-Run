  

 

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
    local u4 = nil;

    local function WormIdle() -- Line: 33
        -- upvalues: Character (copy), u3 (copy), u4 (ref)
        local v5 = (Character:GetAttribute("Weapon") or "") .. "WormIdle";
        local v6 = u3.Animations:GetAnimation(v5);

        if v6 then
            if u4 and u4 ~= v6 then
                u4:Stop();
            end;

            u4 = v6;

            if not v6.IsPlaying then
                u3.Animations:PlayAnimation(v5);
            end;
        end;
    end;

    function u3.GetAnimation(p7) -- Line: 29
        -- upvalues: Character (copy)
        return (Character:GetAttribute("Weapon") or "") .. p7;
    end;

    function u3.GetSpeed(p8) -- Line: 48
        return 1;
    end;

    local Animations = u3.Animations;
    u3.StateChanged:Connect(function(p9) -- Line: 53
        -- upvalues: WormIdle (copy), Animations (copy)
        WormIdle();

        if p9 ~= "Idling" then
            Animations:StopAnimation("Idle");
        end;
    end);

    return u3;
end;

function u1.OnIdle(p10) -- Line: 63
    p10.CurrentAnimation = p10.Animations:PlayAnimation(p10.GetAnimation("Idle"));
    p10.CurrentAnimation.Looped = true;
end;

function u1.OnWalk(p11) -- Line: 68
    p11.CurrentAnimation = p11.Animations:PlayAnimation(p11.GetAnimation("Walk"), p11:GetSpeed());
    p11.CurrentAnimation.Looped = true;
end;

function u1.OnRun(p12) -- Line: 73
    p12.CurrentAnimation = p12.Animations:PlayAnimation(p12.GetAnimation("Run"), p12:GetSpeed());
    p12.CurrentAnimation.Looped = true;
end;

function u1.OnJump(p13) -- Line: 78
    p13.CurrentAnimation = p13.Animations:PlayAnimation("Jump");
end;

function u1.OnFall(p14) -- Line: 82
    p14.CurrentAnimation = p14.Animations:PlayAnimation("Fall");
end;

return u1;