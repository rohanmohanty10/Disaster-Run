  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(PathShortcuts.KnitPath.TableUtil);
require(PathShortcuts.AnimsModule);
local BaseAnimate = require(PathShortcuts.ReplicatedModules.CustomAnimations.Base.BaseAnimate);
game:GetService("CollectionService");
local u1 = {};

function u1.new(p2) -- Line: 11
    -- upvalues: TableUtil (copy), BaseAnimate (copy), u1 (copy)
    local v3 = TableUtil.Reconcile({
        Parent = BaseAnimate.new(p2)
    }, u1);

    for i, v in pairs(v3.Parent) do
        if not v3[i] then
            v3[i] = v;
        end;
    end;

    return v3;
end;

function u1.OnIdle(p4) -- Line: 24
    p4.CurrentAnimation = p4.Animations:PlayAnimation("Idle");
    p4.CurrentAnimation.Looped = true;
end;

function u1.OnWalk(p5) -- Line: 29
    p5.CurrentAnimation = p5.Animations:PlayAnimation("Walk");
    p5.CurrentAnimation.Looped = true;
end;

function u1.OnRun(p6) -- Line: 34
    p6.CurrentAnimation = p6.Animations:PlayAnimation("Run");
    p6.CurrentAnimation.Looped = true;
end;

return u1;