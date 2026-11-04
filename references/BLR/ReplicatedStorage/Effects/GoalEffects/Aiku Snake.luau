  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Debris = game:GetService("Debris");
local TweenService = game:GetService("TweenService");
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);
local Snake = script:WaitForChild("Snake");
local Explosion = script:WaitForChild("Explosion");
local Strike = script:WaitForChild("Anims"):WaitForChild("Strike");
local u1 = Snake:GetScale() * 0.5;
task.spawn(function() -- Line: 15
    -- upvalues: Strike (copy)
    pcall(function() -- Line: 16
        -- upvalues: Strike (ref)
        local v2 = { Strike };
        game:GetService("ContentProvider"):PreloadAsync(v2);
    end);
end);

return function(p3) -- Line: 21
    -- upvalues: SpectatorController (copy), Explosion (copy), Debris (copy), Snake (copy), u1 (copy), Strike (copy), TweenService (copy), VfxManager (copy)
    local LocalPlayer = game.Players.LocalPlayer;

    if LocalPlayer.Team == game.Teams.Visitor and (LocalPlayer.PlayerGui.Misc.CloseLimited.Visible == false and (LocalPlayer.PlayerGui.Customization.Enabled == false and not SpectatorController.IsSpectating)) then
        return;
    end;

    local Pos = p3.Pos;
    local u4 = Explosion:Clone();
    u4.CFrame = Pos;
    u4.Parent = workspace.Debris;
    Debris:AddItem(u4, 12);
    local u5 = Snake:Clone();
    u5:PivotTo(Pos * CFrame.Angles(0, 3.141592653589793, 0));
    u5:ScaleTo(u1 * 0.15);
    u5.Parent = workspace.Debris;
    Debris:AddItem(u5, 12);
    local v6 = u5.AnimationController.Animator:LoadAnimation(Strike);
    v6.Looped = false;
    v6:Play(0);
    v6.TimePosition = 1.3;
    v6.Stopped:Once(function() -- Line: 42
        -- upvalues: u5 (copy)
        if u5.Parent then
            u5:Destroy();
        end;
    end);
    local NumberValue = Instance.new("NumberValue");
    NumberValue.Value = u1 * 0.15;
    NumberValue.Changed:Connect(function(p7) -- Line: 50
        -- upvalues: u5 (copy)
        if u5.Parent then
            u5:ScaleTo(p7);
        end;
    end);
    local v8 = TweenService:Create(NumberValue, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Value = u1
    });
    v8:Play();
    v8.Completed:Once(function() -- Line: 57
        -- upvalues: NumberValue (copy)
        NumberValue:Destroy();
    end);
    VfxManager.Emit(u4);
    task.delay(10, function() -- Line: 63
        -- upvalues: u4 (copy), u5 (copy)
        if u4.Parent then
            u4:Destroy();
        end;

        if u5.Parent then
            u5:Destroy();
        end;
    end);
end;