  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("UserInputService");
game:GetService("RunService");
game:GetService("Debris");
game:GetService("Lighting");
local _ = game:GetService("Players").LocalPlayer;
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Controllers.CameraController);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);

return function(p1) -- Line: 17
    -- upvalues: SpectatorController (copy), VfxManager (copy), TweenService (copy)
    local HumanoidRootPart = p1.Char:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local v2 = script.nagichememit05:Clone();
    v2.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.72, -3, 0.5);
    v2.Parent = workspace.Debris;
    VfxManager.Emit(v2);
    task.delay(0.45, function() -- Line: 33
        -- upvalues: HumanoidRootPart (copy), TweenService (ref)
        local v3 = script.nagichembeams:Clone();
        v3.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.11899948120117188, 0.45399999618530273, -2.6409988403320312) * CFrame.fromOrientation(0.023474678439323732, 1.5706217938696971, 0.96033251432484);
        v3.Parent = workspace.Debris;
        local v4 = script.nagichememit1:Clone();
        v4.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.04599761962890625, 0.45600008964538574, -2.6220016479492188) * CFrame.fromOrientation(0.5235987755982988, -0.08726646259971647, 0);
        v4.Parent = workspace.Debris;
        local NumberValue = Instance.new("NumberValue");
        NumberValue.Value = 1;
        NumberValue.Parent = v3;
        local NumberSequence_new_ret = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.5, 0.85), NumberSequenceKeypoint.new(1, 1) });
        TweenService:Create(NumberValue, TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
            Value = 0
        }):Play();

        for _, descendant in pairs(v3:GetDescendants()) do
            task.spawn(function() -- Line: 55
                -- upvalues: descendant (copy), NumberSequence_new_ret (copy), TweenService (ref), NumberValue (copy)
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                    descendant.Transparency = NumberSequence_new_ret;
                    descendant.TextureSpeed = 5;
                    TweenService:Create(descendant, TweenInfo.new(1.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                        TextureSpeed = 1
                    }):Play();
                    local u5 = nil;
                    local u6 = NumberValue.Changed:Connect(function() -- Line: 65
                        -- upvalues: descendant (ref), NumberValue (ref)
                        descendant.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.5, 0.85 + NumberValue.Value * 0.15), NumberSequenceKeypoint.new(1, 1) });
                    end);
                    task.delay(0.9, function() -- Line: 73
                        -- upvalues: u6 (ref), u5 (ref), NumberValue (ref), descendant (ref)
                        u6:Disconnect();
                        u5 = NumberValue.Changed:Connect(function() -- Line: 75
                            -- upvalues: descendant (ref), NumberValue (ref)
                            descendant.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.9 + NumberValue.Value * 0.1), NumberSequenceKeypoint.new(1, 1) });
                        end);
                        task.wait(1);
                        descendant.Enabled = false;

                        if u5 then
                            u5:Disconnect();
                        end;

                        NumberValue:Destroy();
                    end);
                end;
            end);
        end;

        task.wait(0.9);
        TweenService:Create(NumberValue, TweenInfo.new(0.8, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
            Value = 1
        }):Play();
        task.wait(0.8);
        v3:Destroy();
        NumberValue:Destroy();
        v4:Destroy();
    end);
    task.wait(2);
    v2:Destroy();
end;