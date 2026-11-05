  

 

local TweenService = game:GetService("TweenService");
local Debris = game:GetService("Debris");
local CurrentCamera = workspace.CurrentCamera;

return function(u1) -- Line: 5
    -- upvalues: Debris (copy), TweenService (copy), CurrentCamera (copy)
    coroutine.resume(coroutine.create(function() -- Line: 6
        -- upvalues: u1 (copy), Debris (ref), TweenService (ref), CurrentCamera (ref)
        local BlurEffect = Instance.new("BlurEffect");
        BlurEffect.Size = 0;
        BlurEffect.Parent = game.Lighting;
        local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
        ColorCorrectionEffect.TintColor = Color3.fromRGB(255, 255, 255);
        ColorCorrectionEffect.Brightness = 0.04;
        ColorCorrectionEffect.Parent = game.Lighting;
        local v2 = game.ReplicatedStorage["Client Assets"]["Gold Experience"].LifeDome:Clone();
        v2.Size = Vector3.new(0, 0, 0);
        v2.CFrame = u1.HumanoidRootPart.CFrame;
        v2.Parent = u1;
        Debris:AddItem(BlurEffect, 5);
        Debris:AddItem(v2, 5);
        Debris:AddItem(ColorCorrectionEffect, 5);
        TweenService:Create(v2, TweenInfo.new(0.5), {
            Size = Vector3.new(150, 150, 150)
        }):Play();
        TweenService:Create(CurrentCamera, TweenInfo.new(0.5), {
            FieldOfView = 60
        }):Play();
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.5), {
            Saturation = -1,
            TintColor = Color3.fromRGB(104, 104, 104)
        }):Play();
        wait(3);
        TweenService:Create(CurrentCamera, TweenInfo.new(0.3), {
            FieldOfView = game.Players.LocalPlayer.Settings.FieldOfView.Value
        }):Play();
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.3), {
            Saturation = 0,
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
        TweenService:Create(v2, TweenInfo.new(0.5), {
            Transparency = 1
        }):Play();
    end));
    local _, _ = coroutine.resume(coroutine.create(function() -- Line: 37
        -- upvalues: u1 (copy), TweenService (ref)
        for _, child in pairs(game.Workspace.Living:GetChildren()) do
            pcall(function() -- Line: 39
                -- upvalues: u1 (ref), child (copy), TweenService (ref)
                if (u1.PrimaryPart.Position - child.PrimaryPart.Position).Magnitude < 75 and child ~= u1 then
                    local u3 = game.ReplicatedStorage["Client Assets"]["Gold Experience"].LifeDetectGui:Clone();
                    u3.Parent = child.PrimaryPart;
                    local _, _ = coroutine.resume(coroutine.create(function() -- Line: 45
                        -- upvalues: u3 (copy), TweenService (ref)
                        for _ = 1, 10 do
                            u3.Frame.Size = UDim2.new(0, 0, 0, 0);
                            u3.Frame.BackgroundTransparency = 0;
                            TweenService:Create(u3.Frame, TweenInfo.new(1), {
                                Size = UDim2.new(1, 0, 1, 0)
                            }):Play();
                            wait(0.3);
                            TweenService:Create(u3.Frame, TweenInfo.new(0.7), {
                                BackgroundTransparency = 1
                            }):Play();
                            wait(0.7);
                        end;
                    end));
                end;
            end);
        end;
    end));
end;