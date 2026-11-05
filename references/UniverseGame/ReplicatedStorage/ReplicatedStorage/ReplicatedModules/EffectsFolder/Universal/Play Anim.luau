  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local AnimsModule = require(PathShortcuts.AnimsModule);
local AnimationHandler = require(PathShortcuts.ReplicatedModules.AnimationHandler);
local u1 = {};
local u2 = {};

return function(p3, p4, p5) -- Line: 7
    -- upvalues: u1 (copy), AnimsModule (copy), u2 (copy), AnimationHandler (copy)
    if not (p3 and p3.Parent) then
        return;
    end;

    local Animator = p3.Humanoid.Animator;

    if p3:GetAttribute("StopAnimations") then
        return;
    end;

    local v6 = u1[p4] or AnimsModule.GetAnims(p4);

    if not u1[p4] then
        u1[p4] = v6;
    end;

    local v7 = u2[p3] or AnimationHandler.new(Animator, v6);

    if not u2[p3] then
        u2[p3] = v7;
    end;

    v7:PlayAnimation(p5);
end;