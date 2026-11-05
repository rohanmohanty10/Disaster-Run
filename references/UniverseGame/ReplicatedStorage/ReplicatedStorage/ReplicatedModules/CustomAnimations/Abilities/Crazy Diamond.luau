  

 

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
    u3.Trove:Connect(CollectionService:GetInstanceAddedSignal("Summoned"), function(p4) -- Line: 22
        -- upvalues: Character (copy), u3 (copy)
        if p4 ~= Character then
            return;
        end;

        u3.Callbacks.UpdateState(u3.CurrentState);
    end);
    u3.Trove:Connect(CollectionService:GetInstanceRemovedSignal("Summoned"), function(p5) -- Line: 27
        -- upvalues: Character (copy), u3 (copy)
        if p5 ~= Character then
            return;
        end;

        u3.Callbacks.UpdateState(u3.CurrentState);
    end);
    u3.Trove:Connect(Character:GetAttributeChangedSignal("Rampage"), function() -- Line: 32
        -- upvalues: u3 (copy)
        u3.Callbacks.UpdateState(u3.CurrentState);
    end);

    function u3.GetAnimation(p6) -- Line: 36
        -- upvalues: u3 (copy), CollectionService (ref), Character (copy)
        local v7 = u3.Character:GetAttribute("Rampage") and "Rampage" .. p6;

        if v7 then
            p6 = v7;
        elseif CollectionService:HasTag(Character, "Summoned") then
            p6 = "Summoned" .. p6 or p6;
        end;

        return p6;
    end;

    return u3;
end;

function u1.OnIdle(p8) -- Line: 44
    p8.CurrentAnimation = p8.Animations:PlayAnimation(p8.GetAnimation("Idle"));
    p8.CurrentAnimation.Looped = true;
end;

function u1.OnWalk(p9) -- Line: 49
    p9.CurrentAnimation = p9.Animations:PlayAnimation(p9.GetAnimation("Walk"));
    p9.CurrentAnimation.Looped = true;
end;

function u1.OnRun(p10) -- Line: 54
    p10.CurrentAnimation = p10.Animations:PlayAnimation(p10.GetAnimation("Run"));
    p10.CurrentAnimation.Looped = true;
end;

return u1;