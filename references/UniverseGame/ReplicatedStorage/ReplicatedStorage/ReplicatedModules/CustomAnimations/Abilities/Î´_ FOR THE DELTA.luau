  

 

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

function u1.OnFall(p5) -- Line: 29
    p5.Animations:PlayAnimation("Idle");
    p5.CurrentAnimation = p5.Animations:PlayAnimation("Fall", 3.5, nil);
    p5.CurrentAnimation.Looped = true;
end;

function u1.OnWalk(p6) -- Line: 35
    p6.CurrentAnimation = p6.Animations:PlayAnimation("Walk");
    p6.CurrentAnimation.Looped = true;
end;

function u1.OnRun(p7) -- Line: 40
    p7.CurrentAnimation = p7.Animations:PlayAnimation("Run");
    p7.CurrentAnimation.Looped = true;
end;

function u1.Bind(u8, p9, u10) -- Line: 45
    if not u10 then
        warn("No callback", debug.traceback());

        return;
    end;

    if not p9 then
        return;
    end;

    u8.Trove:Connect(p9, function(p11) -- Line: 48
        -- upvalues: u8 (copy), u10 (copy)
        if u8.CurrentState == "Falling" then
            u8.Animations:StopAnimation("Idle");
        end;

        u8.CurrentState = p11;

        if u8.CurrentAnimation then
            u8.CurrentAnimation:Stop(0.125);
        end;

        u8.StateChanged:Fire(p11);
        u10(u8);
    end);
end;

function u1.BindSignals(u12, p13) -- Line: 60
    u12:Bind(p13.Idling, u12.OnIdle);
    u12:Bind(p13.Walking, u12.OnWalk);
    u12:Bind(p13.Idling_Tool, u12.OnIdle_Tool);
    u12:Bind(p13.Walking_Tool, u12.OnWalk_Tool);
    u12:Bind(p13.Running, u12.OnRun);
    u12:Bind(p13.Jumping, u12.OnJump);
    u12:Bind(p13.Sitting, u12.OnSit);
    u12:Bind(p13.Falling, u12.OnFall);
    u12:Bind(p13.Gliding, u12.OnGlide);

    if p13.ToolEquipped and p13.ToolUnequipped then
        u12.Trove:Connect(p13.ToolEquipped, function(p14) -- Line: 72
            -- upvalues: u12 (copy)
            u12:OnToolEquipped(p14);
        end);
        u12.Trove:Connect(p13.ToolUnequipped, function(p15) -- Line: 75
            -- upvalues: u12 (copy)
            u12:OnToolUnequipped(p15);
        end);
    end;
end;

function u1.BindCallback(p16, p17, p18) -- Line: 81
    p16.Callbacks[p17] = p18;
end;

return u1;