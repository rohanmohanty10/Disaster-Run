  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(PathShortcuts.KnitPath.TableUtil);
require(PathShortcuts.AnimsModule);
local BaseAnimate = require(PathShortcuts.ReplicatedModules.CustomAnimations.Base.BaseAnimate);
local CollectionService = game:GetService("CollectionService");
local u1 = {};

function u1.new(p2) -- Line: 11
    -- upvalues: TableUtil (copy), BaseAnimate (copy), u1 (copy), CollectionService (copy)
    local u3 = TableUtil.Reconcile({
        Parent = BaseAnimate.new(p2)
    }, u1);

    for i, v in pairs(u3.Parent) do
        if not u3[i] then
            u3[i] = v;
        end;
    end;

    u3.Trove:Connect(CollectionService:GetInstanceAddedSignal("Summoned"), function(p4) -- Line: 21
        -- upvalues: u3 (copy)
        if u3.Character ~= p4 then
            return;
        end;

        u3.Callbacks.UpdateState(u3.CurrentState);
        u3.Animations:PlayAnimation(u3.GetAnimation("Wing Flail")).Looped = true;
    end);
    u3.Trove:Connect(CollectionService:GetInstanceRemovedSignal("Summoned"), function(p5) -- Line: 27
        -- upvalues: u3 (copy)
        if u3.Character ~= p5 then
            return;
        end;

        u3.Callbacks.UpdateState(u3.CurrentState);
    end);

    function u3.GetAnimation(p6) -- Line: 32
        return p6;
    end;

    return u3;
end;

function u1.OnIdle(p7) -- Line: 41
    p7.CurrentAnimation = p7.Animations:PlayAnimation(p7.GetAnimation("Idle"));
    p7.CurrentAnimation.Looped = true;
end;

return u1;