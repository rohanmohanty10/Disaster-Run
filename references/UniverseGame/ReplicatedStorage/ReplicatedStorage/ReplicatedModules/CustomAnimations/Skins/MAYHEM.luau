  

 

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

    u3.Trove:Connect(u3.Character:GetAttributeChangedSignal("Sovereign"), function() -- Line: 21
        -- upvalues: u3 (copy)
        if u3.CurrentState then
            u3.Callbacks.UpdateState(u3.CurrentState);
        end;
    end);
    u3.Trove:Connect(u3.Character:GetAttributeChangedSignal("GlitcherForm"), function() -- Line: 27
        -- upvalues: u3 (copy)
        if u3.CurrentState then
            u3.Callbacks.UpdateState(u3.CurrentState);
        end;
    end);
    u3.Trove:Connect(u3.Character:GetAttributeChangedSignal("NeptunianEquipped"), function() -- Line: 33
        -- upvalues: u3 (copy)
        if u3.CurrentState then
            u3.Callbacks.UpdateState(u3.CurrentState);
        end;
    end);

    function u3.GetAnimation(p4, p5) -- Line: 40
        -- upvalues: u3 (copy)
        if not p5 and u3.Character:GetAttribute("Sovereign") then
            p4 = "Sovereign-" .. p4 or p4;
        end;

        return p4;
    end;

    return u3;
end;

function u1.OnIdle(p6) -- Line: 49
    local v7 = p6.Character and p6.Character:GetAttribute("GlitcherForm");

    if v7 == "Neptunian" and p6.Character:GetAttribute("NeptunianEquipped") then
        p6.CurrentAnimation = p6.Animations:PlayAnimation("Neptunian Idle Equipped");
    else
        local v8;

        if v7 and v7 ~= "None" then
            v8 = p6.Animations:PlayAnimation(v7 .. " Idle");
        else
            v8 = p6.Animations:PlayAnimation(p6.GetAnimation("Idle"));
        end;

        p6.CurrentAnimation = v8;
    end;

    p6.CurrentAnimation.Looped = true;
end;

function u1.OnWalk(p9) -- Line: 59
    local v10 = p9.Character and p9.Character:GetAttribute("GlitcherForm");
    local v11;

    if v10 == "Neptunian" then
        v11 = p9.Character:GetAttribute("NeptunianEquipped");
    else
        v11 = false;
    end;

    local v12 = v10 and p9.Animations:GetAnimation((`{v10} Walk{v11 and " Equipped" or ""}`)) and `{v10} Walk{v11 and " Equipped" or ""}`;
    p9.CurrentAnimation = v12 and p9.Animations:PlayAnimation(v12) or p9.Animations:PlayAnimation(p9.GetAnimation("Walk"));
    p9.CurrentAnimation.Looped = true;
end;

function u1.OnRun(p13) -- Line: 68
    local v14 = p13.Character and p13.Character:GetAttribute("GlitcherForm");
    local v15;

    if v14 == "Neptunian" then
        v15 = p13.Character:GetAttribute("NeptunianEquipped");
    else
        v15 = false;
    end;

    local v16 = v14 and p13.Animations:GetAnimation((`{v14} Run{v15 and " Equipped" or ""}`)) and `{v14} Run{v15 and " Equipped" or ""}`;
    p13.CurrentAnimation = v16 and p13.Animations:PlayAnimation(v16) or p13.Animations:PlayAnimation(p13.GetAnimation("Run"));
    p13.CurrentAnimation.Looped = true;
end;

return u1;