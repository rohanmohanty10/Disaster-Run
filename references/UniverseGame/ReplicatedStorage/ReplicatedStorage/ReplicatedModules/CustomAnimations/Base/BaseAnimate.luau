  

 

local CollectionService = game:GetService("CollectionService");
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);
local Signal = require(PathShortcuts.KnitPath.Signal);
local TableUtil = require(PathShortcuts.KnitPath.TableUtil);
require(PathShortcuts.AnimsModule);
local u1 = {};

function u1.new(p2) -- Line: 11
    -- upvalues: TableUtil (copy), u1 (copy), Signal (copy)
    local v3 = TableUtil.Reconcile({}, u1);
    v3.Data = p2;
    v3.Player = p2.Player;
    v3.Character = p2.Character;
    v3.Trove = p2.Trove;
    v3.Ability = p2.Ability;
    v3.Skin = p2.Skin;
    v3.Animations = p2.Animations;
    v3.DefaultAnimations = p2.DefaultAnimations;
    v3.AbilityAnimations = p2.AbilityAnimations;
    v3.AbilityName = v3.Player.Data.Ability:GetAttribute("AbilityName");
    v3.SkinName = v3.Player.Data.Ability:GetAttribute("SkinName");
    v3.Humanoid = p2.Humanoid or v3.Character.Humanoid;
    v3.Animator = p2.Animator or v3.Humanoid.Animator;
    v3.StateChanged = v3.Trove:Construct(Signal);
    v3.Callbacks = {};

    return v3;
end;

function u1.OnIdle(p4) -- Line: 36
    p4.CurrentAnimation = p4.Animations:PlayAnimation("Idle");
    p4.CurrentAnimation.Looped = true;
end;

function u1.OnWalk(p5) -- Line: 41
    p5.CurrentAnimation = p5.Animations:PlayAnimation("Walk");
    p5.CurrentAnimation.Looped = true;
end;

function u1.OnIdle_Tool(p6) -- Line: 46
    p6.CurrentAnimation = p6.Animations:PlayAnimation("Idle_Tool");
    p6.CurrentAnimation.Looped = true;
end;

function u1.OnWalk_Tool(p7) -- Line: 51
    p7.CurrentAnimation = p7.Animations:PlayAnimation("Walk_Tool");
    p7.CurrentAnimation.Looped = true;
end;

function u1.OnRun(p8) -- Line: 56
    p8.CurrentAnimation = p8.Animations:PlayAnimation("Run");
    p8.CurrentAnimation.Looped = true;
end;

function u1.OnSit(p9) -- Line: 61
    p9.CurrentAnimation = p9.Animations:PlayAnimation("Sit");
end;

function u1.OnJump(p10) -- Line: 65
    -- upvalues: CollectionService (copy)
    p10.CurrentAnimation = p10.Animations:PlayAnimation("Jump");

    if CollectionService:HasTag(p10.Character, "Summoned") and p10.Animations:GetAnimation("SummonedIdle") then
        p10.Animations:PlayAnimation("SummonedIdle").Looped = true;
    end;
end;

function u1.OnLand(p11) -- Line: 73
    p11.CurrentAnimation = p11.Animations:PlayAnimation("Land");
end;

function u1.OnGlide(p12) -- Line: 77
    p12.CurrentAnimation = p12.Animations:PlayAnimation("Glide");
end;

function u1.OnFall(p13) -- Line: 81
    -- upvalues: CollectionService (copy)
    p13.CurrentAnimation = p13.Animations:PlayAnimation("Fall");

    if CollectionService:HasTag(p13.Character, "Summoned") and p13.Animations:GetAnimation("SummonedIdle") then
        p13.Animations:PlayAnimation("SummonedIdle").Looped = true;
    end;
end;

local Animation = Instance.new("Animation");

function u1.OnToolEquipped(p14, p15) -- Line: 91
    -- upvalues: PathShortcuts (copy), Animation (copy)
    local v16 = PathShortcuts.ReplicatedModules.ToolAnimations:FindFirstChild(p15);

    if not v16 then
        return;
    end;

    for i, v in require(v16) do
        Animation.AnimationId = "rbxassetid://" .. v;

        if p14.Animations:GetAnimation(i) then
            p14.Animations:OverrideAnimation(i, {
                Animation = Animation,
                Priority = Enum.AnimationPriority.Action2
            });
        else
            p14.Animations:AddAnimation(i, {
                Priority = "Action2",
                Animation = Animation
            });
        end;
    end;

    if p14.Animations:GetAnimation("ToolEquipped") then
        p14.Animations:PlayAnimation("ToolEquipped");
    end;

    p14.Character:SetAttribute("ToolEquipped_Animate", true);
end;

function u1.OnToolUnequipped(p17, p18) -- Line: 120
    -- upvalues: PathShortcuts (copy)
    local v19 = PathShortcuts.ReplicatedModules.ToolAnimations:FindFirstChild(p18);

    if not v19 then
        return;
    end;

    local v20 = require(v19);

    if p17.Animations:GetAnimation("ToolUnequipped") then
        p17.Animations:PlayAnimation("ToolUnequipped");
    end;

    for i, _ in v20 do
        p17.Animations:RemoveAnimation(i);
    end;

    p17.Character:SetAttribute("ToolEquipped_Animate", false);
end;

function u1.Bind(u21, p22, u23) -- Line: 143
    if not u23 then
        warn("No callback", debug.traceback());

        return;
    end;

    if not p22 then
        return;
    end;

    u21.Trove:Connect(p22, function(p24) -- Line: 146
        -- upvalues: u21 (copy), u23 (copy)
        u21.CurrentState = p24;

        if u21.CurrentAnimation then
            u21.CurrentAnimation:Stop();
        end;

        u21.StateChanged:Fire(p24);
        u23(u21);
    end);
end;

function u1.BindSignals(u25, p26) -- Line: 154
    u25:Bind(p26.Idling, u25.OnIdle);
    u25:Bind(p26.Walking, u25.OnWalk);
    u25:Bind(p26.Idling_Tool, u25.OnIdle_Tool);
    u25:Bind(p26.Walking_Tool, u25.OnWalk_Tool);
    u25:Bind(p26.Running, u25.OnRun);
    u25:Bind(p26.Jumping, u25.OnJump);
    u25:Bind(p26.Sitting, u25.OnSit);
    u25:Bind(p26.Falling, u25.OnFall);
    u25:Bind(p26.Landed, u25.OnLand);
    u25:Bind(p26.Gliding, u25.OnGlide);

    if p26.ToolEquipped and p26.ToolUnequipped then
        u25.Trove:Connect(p26.ToolEquipped, function(p27) -- Line: 170
            -- upvalues: u25 (copy)
            u25:OnToolEquipped(p27);
        end);
        u25.Trove:Connect(p26.ToolUnequipped, function(p28) -- Line: 173
            -- upvalues: u25 (copy)
            u25:OnToolUnequipped(p28);
        end);
    end;
end;

function u1.BindCallback(p29, p30, p31) -- Line: 181
    p29.Callbacks[p30] = p31;
end;

return u1;