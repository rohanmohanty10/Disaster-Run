  

 

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

    local Character = u3.Character;
    u3.Trove:Connect(CollectionService:GetInstanceAddedSignal("RageMode"), function(p4) -- Line: 22
        -- upvalues: Character (copy), u3 (copy)
        if p4 ~= Character then
            return;
        end;

        u3.Callbacks.UpdateState(u3.CurrentState);
    end);
    u3.Trove:Connect(CollectionService:GetInstanceRemovedSignal("RageMode"), function(p5) -- Line: 27
        -- upvalues: Character (copy), u3 (copy)
        if p5 ~= Character then
            return;
        end;

        u3.Callbacks.UpdateState(u3.CurrentState);
    end);

    function u3.GetAnimation(p6) -- Line: 32
        -- upvalues: CollectionService (ref), Character (copy)
        return `{CollectionService:HasTag(Character, "RageMode") and "Rage " or ""}{p6}`;
    end;

    return u3;
end;

function u1.OnIdle(p7) -- Line: 40
    p7.CurrentAnimation = p7.Animations:PlayAnimation(p7.GetAnimation("Idle"));
    p7.CurrentAnimation.Looped = true;
end;

return u1;