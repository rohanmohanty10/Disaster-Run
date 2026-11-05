  

 

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

    u3.Trove:Connect(CollectionService:GetInstanceAddedSignal("Summoned"), function(p4) -- Line: 22
        -- upvalues: u3 (copy)
        if p4 ~= u3.Character then
            return;
        end;

        u3.Callbacks.UpdateState(u3.CurrentState);
    end);
    u3.Trove:Connect(CollectionService:GetInstanceRemovedSignal("Summoned"), function(p5) -- Line: 27
        -- upvalues: u3 (copy)
        if p5 ~= u3.Character then
            return;
        end;

        u3.Callbacks.UpdateState(u3.CurrentState);
    end);

    function u3.GetAnimation(p6) -- Line: 33
        -- upvalues: CollectionService (ref), u3 (copy)
        if CollectionService:HasTag(u3.Character, "Summoned") then
            p6 = "Summoned" .. p6 or p6;
        end;

        return p6;
    end;

    return u3;
end;

function u1.OnIdle(p7) -- Line: 41
    p7.Animations:StopAnimations({ "Walk", "SummonedWalk", "Run", "SummonedRun" });
    p7.CurrentAnimation = p7.Animations:PlayAnimation(p7.GetAnimation("Idle"));
    p7.CurrentAnimation.Looped = true;
    p7.Animations:PlayAnimation("Idle").Looped = true;
end;

function u1.OnWalk(p8) -- Line: 48
    p8.Animations:StopAnimations({ "Idle", "SummonedIdle", "Run", "SummonedRun" });
    p8.CurrentAnimation = p8.Animations:PlayAnimation(p8.GetAnimation("Walk"));
    p8.CurrentAnimation.Looped = true;
    p8.Animations:PlayAnimation("Walk").Looped = true;
end;

function u1.OnRun(p9) -- Line: 55
    p9.Animations:StopAnimations({ "Idle", "SummonedIdle", "Walk", "SummonedWalk" });
    p9.CurrentAnimation = p9.Animations:PlayAnimation(p9.GetAnimation("Run"));
    p9.CurrentAnimation.Looped = true;
    p9.Animations:PlayAnimation("Run").Looped = true;
end;

function u1.OnJump(p10) -- Line: 62
    p10.Parent.OnJump(p10);
    p10.Animations:StopAnimations({ "SummonedWalk", "SummonedRun" });
    p10.Animations:PlayAnimation("SummonedIdle");
end;

function u1.OnFall(p11) -- Line: 68
    p11.Parent.OnFall(p11);
    p11.Animations:StopAnimations({ "SummonedWalk", "SummonedRun" });
    p11.Animations:PlayAnimation("SummonedIdle");
end;

return u1;