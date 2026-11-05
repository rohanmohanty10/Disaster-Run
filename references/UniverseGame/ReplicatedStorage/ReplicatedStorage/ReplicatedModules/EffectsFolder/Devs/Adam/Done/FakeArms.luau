  

 

local Skins = require(game.ReplicatedStorage.ReplicatedModules.Skins);
local CameraShaker = require(game:GetService("ReplicatedStorage").ClientModules:WaitForChild("CameraShaker"));
local LocalPlayer = game.Players.LocalPlayer;
local CurrentCamera = workspace.CurrentCamera;
local TweenService = game:GetService("TweenService");

local function quadBezier(p1, p2, p3, p4) -- Line: 7
    return (1 - p4) ^ 2 * p1 + 2 * (1 - p4) * p4 * p2 + p4 ^ 2 * p3;
end;

return function(p5, p6, p7, p8, p9, p10) -- Line: 11
    -- upvalues: Skins (copy), LocalPlayer (copy), CameraShaker (copy), CurrentCamera (copy), TweenService (copy)
    local v11 = game.Players:GetPlayerFromCharacter(p5.Parent);
    local v12 = p9 or (v11 or p9);
    local v13 = type(v12) == "string" and v12 and v12 or nil;

    if not v13 and (typeof(v12) == "Instance" and (v12:IsA("Player") and v12:FindFirstChild("Data"))) then
        v13 = Skins.Funcs.GetSkin(v12.Data.Ability.Value, v12.Data.Skin.Value) or v13;
    end;

    if not v13 and p5:GetAttribute("SkinName") then
        v13 = p5:GetAttribute("SkinName");
    end;

    local u14 = p10 or p5.StandHumanoidRootPart.CFrame;
    local u15 = p8 or 1;

    if LocalPlayer.Settings.CameraShake.Value == true and v11 == LocalPlayer then
        local v17 = CameraShaker.new(Enum.RenderPriority.Camera.Value, function(p16) -- Line: 37
            -- upvalues: CurrentCamera (ref)
            CurrentCamera.CFrame = CurrentCamera.CFrame * p16;
        end);
        v17:Stop();
        v17:Start();
        v17:Shake(CameraShaker.Presets.Ride);
    end;

    for _ = 1, 3 do
        local v18 = game.ReplicatedStorage["Client Assets"][p6];

        if type(v13) == "string" then
            v18 = v18:FindFirstChild(v13) or v18;
        end;

        local Position = (u14 * CFrame.new(0, 0, -10)).Position;

        local function PointGenerator(p19) -- Line: 55
            -- upvalues: u15 (copy), u14 (copy)
            local v20;

            if p19 == "Right" then
                v20 = math.random(5, 30) / 10 * u15;
            else
                v20 = math.random(-30, -5) / 10 * u15;
            end;

            local v21 = math.random(-50, 50) / 100 * u15;
            math.random();

            return (u14 * CFrame.new(v20, v21, -2)).Position, (u14 * CFrame.new(v20 * 2, v21 * 6, -4)).Position;
        end;

        local u22, u23, u24;

        if math.random(10) > 5 then
            u22 = (v18:FindFirstChild("Stand Right Arm") or v18:FindFirstChild("Stand RightArm")):Clone();
            u23, u24 = PointGenerator("Right");
        else
            u22 = (v18:FindFirstChild("Stand Left Arm") or v18:FindFirstChild("Stand LeftArm")):Clone();
            u23, u24 = PointGenerator("Left");
        end;

        for _, descendant in pairs(u22:GetDescendants()) do
            if descendant:IsA("BasePart") or descendant:IsA("Texture") then
                descendant.Transparency = 0;
            end;
        end;

        local Attachment = Instance.new("Attachment");
        Attachment.Parent = u22;
        Attachment.Position = Vector3.new(-0.394, 0.793, 0.477);
        local Attachment2 = Instance.new("Attachment");
        Attachment2.Parent = u22;
        Attachment2.Position = Vector3.new(0.329, -0.847, -0.348);
        local u25 = game.ReplicatedStorage["Client Assets"].BakEffects["MotionBlur" .. math.random(1, 2)]:Clone();
        u25.Attachment0 = Attachment;
        u25.Attachment1 = Attachment2;
        u25.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, u22.Color), ColorSequenceKeypoint.new(1, u22.Color) });
        u25.Enabled = true;
        u25.Parent = u22;
        u22.Transparency = 0;
        local u26 = 0;
        u22.Parent = workspace.Effects;
        local u27 = nil;
        local u28 = 1 / (p7 or 0.7);
        coroutine.wrap(function() -- Line: 105
            -- upvalues: u22 (ref), TweenService (ref), u25 (copy)
            wait(0.2);

            for _, descendant in pairs(u22:GetDescendants()) do
                if descendant:IsA("BasePart") or descendant:IsA("Texture") then
                    TweenService:Create(descendant, TweenInfo.new(0.2), {
                        Transparency = 1
                    }):Play();
                end;
            end;

            TweenService:Create(u22, TweenInfo.new(0.2), {
                Transparency = 1
            }):Play();
            u25.Enabled = false;
            wait(0.25);
            u22:Destroy();
        end)();
        u27 = game["Run Service"].RenderStepped:Connect(function(p29) -- Line: 117
            -- upvalues: u26 (ref), u28 (copy), u27 (ref), TweenService (ref), u23 (ref), u24 (ref), Position (copy), u22 (ref)
            u26 = u26 + p29 * u28;

            if u26 > 1 then
                u27:Disconnect();
                u26 = 1;
            end;

            if u26 + p29 * u28 > 0.8 then
                local v30 = TweenService:GetValue(u26, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out);
                u22.CFrame = CFrame.new((1 - v30) ^ 2 * u23 + 2 * (1 - v30) * v30 * u24 + v30 ^ 2 * Position, Position) * CFrame.Angles(1.5707963267948966, 0, 0);

                return;
            end;

            local v31 = TweenService:GetValue(u26, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out);
            local v32 = TweenService:GetValue(u26 + p29 * u28, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out);
            u22.CFrame = CFrame.new((1 - v31) ^ 2 * u23 + 2 * (1 - v31) * v31 * u24 + v31 ^ 2 * Position, (1 - v32) ^ 2 * u23 + 2 * (1 - v32) * v32 * u24 + v32 ^ 2 * Position) * CFrame.Angles(1.5707963267948966, 0, 0);
        end);
    end;
end;