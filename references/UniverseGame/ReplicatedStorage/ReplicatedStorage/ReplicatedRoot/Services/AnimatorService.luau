  

 

local Core = require(game.ReplicatedStorage.ReplicatedRoot.Core);
local StateService = require(Core.ReplicatedServices.StateService);
local TableUtil = require(Core.ReplicatedLibraries.Utility.TableUtil);
local Trove = require(Core.ReplicatedLibraries.Classes.Trove);
local Promise = require(Core.ReplicatedLibraries.Classes.Promise);
local u1 = {
    Name = "AnimateService"
};
local CharacterAnimator = require(Core.ReplicatedLibraries.Classes.CharacterAnimator);

function u1.GetAnimationFolder(p2) -- Line: 13
    local _Animations = p2:FindFirstChild("_Animations");

    if _Animations == nil then
        _Animations = Instance.new("Folder");
        _Animations.Name = "_Animations";
        _Animations.Parent = p2;
    end;

    return _Animations;
end;

function u1.GetAnimations(p3, p4) -- Line: 23
    -- upvalues: u1 (copy)
    return u1.GetAnimationFolder(p3):FindFirstChild(p4);
end;

function u1.CreateAnimation(p5) -- Line: 28
    local v6 = p5 or {};
    local Animation = Instance.new("Animation");
    Animation.Name = v6.Name or Animation.Name;
    Animation.AnimationId = v6.AnimationId or Animation.AnimationId;
    Animation:SetAttribute("State", v6.State or "Unknown");
    Animation:SetAttribute("StatePriority", v6.StatePriority or 0);
    Animation:SetAttribute("Priority", v6.Priority);
    Animation:SetAttribute("Transition", v6.Transition or 0.1);
    Animation:SetAttribute("EndTransition", v6.EndTransition);
    Animation:SetAttribute("StopTransition", v6.StopTransition);
    Animation:SetAttribute("Weight", v6.Weight or 1);
    Animation:SetAttribute("Speed", v6.Speed or 1);
    Animation:SetAttribute("Enabled", v6.Enabled or false);

    return Animation;
end;

function u1.AddAnimations(p7, p8, p9) -- Line: 48
    -- upvalues: u1 (copy)
    local v10 = u1.GetAnimationFolder(p7);
    local v11 = v10:FindFirstChild(p8);

    if v11 == nil then
        v11 = Instance.new("Folder");
        v11.Name = p8;
        v11.Parent = v10;
    end;

    local v12 = {};

    for i, v in pairs(p9) do
        local v13 = u1.CreateAnimation(v);
        v13.Name = v.Name or i;
        v13.Parent = v11;
        v12[i] = v12;
    end;

    return v11;
end;

function u1.SpawnAnimation(p14, u15, p16) -- Line: 68
    -- upvalues: Trove (copy), Promise (copy), u1 (copy)
    local v17 = p14:FindFirstChildWhichIsA("Humanoid");
    local u18 = v17 and v17:FindFirstChildWhichIsA("Animator") or nil;

    if u18 == nil then
        return;
    end;

    local u19 = p16 or {};
    local u20 = Trove.new();
    Promise.try(function() -- Line: 77
        -- upvalues: u15 (ref), u20 (copy), u1 (ref), u18 (copy), u19 (copy)
        if typeof(u15) == "table" then
            u15 = u20:Construct(u1.CreateAnimation, u15);
        end;

        if u15 == nil then
            return;
        end;

        local v21 = u20:Add(u18:LoadAnimation(u15));
        v21.Looped = u19.Looped or false;
        v21.Priority = u19.Priority or (v21:GetAttribute("Priority") or v21.Priority);
        v21:Play(u19.Transition or (v21:GetAttribute("Transition") or 0.1), u19.Weight or (v21:GetAttribute("Weight") or 1), u19.Speed or (v21:GetAttribute("Speed") or 1));
        local u22 = true;
        u20:Connect(v21.Ended, function() -- Line: 92
            -- upvalues: u22 (ref)
            u22 = false;
        end);

        while u18 ~= nil and (u18:IsDescendantOf(game) and (v21 ~= nil and v21.Length == 0)) or u22 == true do
            task.wait();
        end;
    end):finallyCall(u20.Destroy, u20):catch(warn);
end;

function u1.GetAnimator(p23) -- Line: 102
    -- upvalues: StateService (copy)
    local v24 = StateService.GetState(p23, "AnimatorState");

    return v24 ~= nil and v24.Animator or nil;
end;

function u1.CreateAnimator(p25, p26) -- Line: 107
    -- upvalues: StateService (copy), CharacterAnimator (copy), TableUtil (copy), Trove (copy)
    local u27 = StateService.GetState(p25, "AnimatorState");

    if u27 == nil then
        u27 = StateService.CreateState(p25, "AnimatorState");
    end;

    local Animator = u27.Animator;

    if Animator == nil then
        Animator = u27.Collector:Construct(CharacterAnimator, TableUtil.Reconcile(p26 or {}, {
            Character = p25,
            Animations = p25:WaitForChild("_Animations")
        }));
        u27.Animator = Animator;
        Animator.Collector = Trove.new();
        Animator.Collector:Add(function() -- Line: 121
            -- upvalues: u27 (ref)
            u27.Animator = nil;
        end);
    end;

    return Animator;
end;

return u1;