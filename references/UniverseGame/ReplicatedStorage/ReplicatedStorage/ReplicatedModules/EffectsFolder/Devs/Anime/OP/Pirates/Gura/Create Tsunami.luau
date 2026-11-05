  

 

local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local LocalPlayer = game:GetService("Players").LocalPlayer;
local u1 = ReplicatedStorage:FindFirstChild("Client Assets");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);

return function(p2) -- Line: 13
    -- upvalues: u1 (copy), TweenService (copy), EffectsHandler (copy), LocalPlayer (copy), ParticleHandler (copy)
    local Direction = p2.Direction;
    local Start = p2.Start;
    local RiseTime = p2.RiseTime;
    local FallTime = p2.FallTime;
    local Transparency = u1.Gura.Tsunami.Transparency;
    local u3 = u1.Gura.Tsunami:Clone();
    u3.Transparency = 1;
    u3.CFrame = CFrame.new(Start, Start + Direction) * CFrame.new(0, -u3.Size.Y / 2, 0);
    u3.Parent = workspace.Effects;
    task.delay(RiseTime + FallTime, u3.Destroy, u3);
    u3.Rush:Play();
    TweenService:Create(u3, TweenInfo.new(RiseTime * 0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Transparency = Transparency
    }):Play();
    local v4 = TweenService:Create(u3, TweenInfo.new(RiseTime * 0.35, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
        CFrame = u3.CFrame * CFrame.new(0, u3.Size.Y - 10, -157.5)
    });
    v4:Play();
    v4.Completed:Connect(function() -- Line: 41
        -- upvalues: TweenService (ref), u3 (copy), RiseTime (copy)
        TweenService:Create(u3, TweenInfo.new(RiseTime * 0.65, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
            CFrame = u3.CFrame * CFrame.new(0, 0, -292.5)
        }):Play();
    end);

    for _, descendant in u3:GetDescendants() do
        if descendant:IsA("Beam") then
            local Transparency2 = descendant.Transparency;
            descendant.Transparency = NumberSequence.new(1);
            EffectsHandler.CallEffect("Boat Tween", descendant, {
                EasingStyle = "EntranceExpressive",
                EasingDirection = "In",
                StepType = "RenderStepped",
                Time = RiseTime * 0.1,
                Goal = {
                    Transparency = Transparency2
                }
            });
        end;
    end;

    task.delay(RiseTime, function() -- Line: 66
        -- upvalues: LocalPlayer (ref), TweenService (ref), u3 (copy), FallTime (copy), ParticleHandler (ref), EffectsHandler (ref)
        local _ = (LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()).HumanoidRootPart;
        TweenService:Create(u3, TweenInfo.new(FallTime, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
            CFrame = u3.CFrame * CFrame.new(0, -u3.Size.Y, -225)
        }):Play();
        task.delay(FallTime * 0.5, function() -- Line: 88
            -- upvalues: TweenService (ref), u3 (ref), FallTime (ref), ParticleHandler (ref), EffectsHandler (ref)
            TweenService:Create(u3, TweenInfo.new(FallTime * 0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                Transparency = 1
            }):Play();
            ParticleHandler.EnableParticles(u3, false);

            for _, descendant in u3:GetDescendants() do
                if descendant:IsA("Beam") then
                    EffectsHandler.CallEffect("Boat Tween", descendant, {
                        EasingStyle = "ExitExpressive",
                        EasingDirection = "Out",
                        StepType = "RenderStepped",
                        Time = FallTime * 0.5,
                        Goal = {
                            Transparency = NumberSequence.new(1)
                        }
                    });
                end;
            end;
        end);
    end);
end;