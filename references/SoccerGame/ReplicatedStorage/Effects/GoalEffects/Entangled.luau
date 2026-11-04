  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.VfxManager);

return function(p1) -- Line: 7
    -- upvalues: ReplicatedStorage (copy), TweenService (copy)
    local CFrame_Angles_ret = CFrame.Angles(0, 0, 0);

    if p1.Team == game.Teams.Away then
        CFrame_Angles_ret = CFrame.Angles(0, 3.141592653589793, 0);
    end;

    local u2 = ReplicatedStorage.Assets.GoalEffects.Entangled.EntangledVines:Clone();
    u2:PivotTo(p1.Pos * CFrame_Angles_ret);
    u2.Parent = workspace;
    local script_SidePostsAnim = script.SidePostsAnim;
    local script_BottomPostAnim = script.BottomPostAnim;
    local AnimationController = u2.Vine2.AnimationController;
    local AnimationController2 = u2.BottomPost.AnimationController;
    local u3 = u2.Vine1.AnimationController:LoadAnimation(script_SidePostsAnim);
    local u4 = AnimationController:LoadAnimation(script_SidePostsAnim);
    local u5 = AnimationController2:LoadAnimation(script_BottomPostAnim);
    u3.Looped = false;
    u4.Looped = false;
    u5.Looped = false;
    u3:Play(0);
    u4:Play(0);
    u5:Play(0);
    u3.Stopped:Once(function() -- Line: 37
        -- upvalues: u3 (copy)
        u3:Play(0, 1, 0);
        u3.TimePosition = u3.Length - 1e-6;
    end);
    u4.Stopped:Once(function() -- Line: 42
        -- upvalues: u4 (copy)
        u4:Play(0, 1, 0);
        u4.TimePosition = u4.Length - 1e-6;
    end);
    u5.Stopped:Once(function() -- Line: 47
        -- upvalues: u5 (copy)
        u5:Play(0, 1, 0);
        u5.TimePosition = u5.Length - 1e-6;
    end);
    local FieldOfView = workspace.CurrentCamera.FieldOfView;
    task.delay(0.23333333333333334, function() -- Line: 54
        -- upvalues: TweenService (ref)
        workspace.CurrentCamera.FieldOfView = 70;
        TweenService:Create(workspace.CurrentCamera, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            FieldOfView = 110
        }):Play();
    end);
    task.delay(0.3333333333333333, function() -- Line: 62
        -- upvalues: TweenService (ref)
        TweenService:Create(workspace.CurrentCamera, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            FieldOfView = 99
        }):Play();
    end);
    task.delay(0.43333333333333335, function() -- Line: 68
        -- upvalues: TweenService (ref), FieldOfView (copy)
        TweenService:Create(workspace.CurrentCamera, TweenInfo.new(0.13333333333333333, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            FieldOfView = FieldOfView
        }):Play();
    end);
    task.delay(0.26666666666666666, function() -- Line: 74
        -- upvalues: u2 (copy)
        for _, descendant in pairs(u2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                task.spawn(function() -- Line: 77
                    -- upvalues: descendant (copy)
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end);
            end;
        end;
    end);
    task.delay(8, function() -- Line: 84
        -- upvalues: u2 (copy)
        u2:Destroy();
    end);
end;