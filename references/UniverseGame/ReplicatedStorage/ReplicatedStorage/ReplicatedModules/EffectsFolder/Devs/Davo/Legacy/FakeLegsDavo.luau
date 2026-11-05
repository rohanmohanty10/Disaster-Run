  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CameraShaker = require(ReplicatedStorage.ClientModules:WaitForChild("CameraShaker"));
local Skins = require(ReplicatedStorage.ReplicatedModules.Skins);
local LocalPlayer = game.Players.LocalPlayer;
local CurrentCamera = workspace.CurrentCamera;
local TweenService = game:GetService("TweenService");

local function quadBezier(p1, p2, p3, p4) -- Line: 8
    return (1 - p4) ^ 2 * p1 + 2 * (1 - p4) * p4 * p2 + p4 ^ 2 * p3;
end;

return function(p5, p6, p7, p8, p9, p10, p11) -- Line: 12
    -- upvalues: Skins (copy), LocalPlayer (copy), CameraShaker (copy), CurrentCamera (copy), TweenService (copy)
    local v12 = game.Players:GetPlayerFromCharacter(p5.Parent);
    local v13 = p9 or (v12 or p9);
    local v14 = type(v13) == "string" and v13 and v13 or nil;

    if not v14 and (typeof(v13) == "Instance" and v13:IsA("Player")) then
        local v15 = v13;

        if v15:FindFirstChild("Data") then
            v14 = Skins.Funcs.GetSkin(v15.Data.Ability.Value, v15.Data.Skin.Value) or v14;
        end;
    end;

    local u16 = p10 or p5.StandHumanoidRootPart.CFrame * CFrame.new(0, -0.825, 0);
    local u17 = p8 or 1;

    if LocalPlayer.Settings.CameraShake.Value == true and v12 == LocalPlayer then
        local v19 = CameraShaker.new(Enum.RenderPriority.Camera.Value, function(p18) -- Line: 33
            -- upvalues: CurrentCamera (ref)
            CurrentCamera.CFrame = CurrentCamera.CFrame * p18;
        end);
        v19:Stop();
        v19:Start();
        v19:Shake(CameraShaker.Presets.Ride);
    end;

    for _ = 1, 3 do
        local v20 = game.ReplicatedStorage["Client Assets"][p6];

        if type(v14) == "string" then
            v20 = v20:FindFirstChild(v14) or v20;
        end;

        local Position = (u16 * CFrame.new(0, 0, -8.35)).Position;

        local function PointGenerator(p21) -- Line: 51
            -- upvalues: u17 (copy), u16 (ref)
            local v22;

            if p21 == "Right" then
                v22 = math.random(5, 30) / 10 * u17;
                u16 = u16 * CFrame.new(-1.15, 0, 0);
            else
                v22 = math.random(-30, -5) / 10 * u17;
                u16 = u16 * CFrame.new(1.15, 0, 0);
            end;

            local v23 = math.random(-50, 50) / 100 * u17;
            math.random();

            return (u16 * CFrame.new(v22, v23, -2)).Position, (u16 * CFrame.new(v22 * 2, v23 * 6, -4)).Position;
        end;

        local u24, u25, u26;

        if p11 then
            u24 = (v20:FindFirstChild("Stand " .. p11 .. " Leg") or v20:FindFirstChild("Stand " .. p11 .. "Leg")):Clone();
            u25, u26 = PointGenerator(p11);
        elseif math.random(10) > 5 then
            u24 = (v20:FindFirstChild("Stand Right Leg") or v20:FindFirstChild("Stand RightLeg")):Clone();
            u25, u26 = PointGenerator("Right");
        else
            u24 = (v20:FindFirstChild("Stand Left Leg") or v20:FindFirstChild("Stand LeftLeg")):Clone();
            u25, u26 = PointGenerator("Left");
        end;

        for _, child in pairs(u24:GetChildren()) do
            if child:IsA("BasePart") then
                child.Transparency = 0;
            end;
        end;

        local Attachment = Instance.new("Attachment");
        Attachment.Parent = u24;
        Attachment.Position = Vector3.new(-0.394, 0.793, 0.477);
        local Attachment2 = Instance.new("Attachment");
        Attachment2.Parent = u24;
        Attachment2.Position = Vector3.new(0.329, -0.847, -0.348);
        local u27 = game.ReplicatedStorage["Client Assets"].BakEffects["MotionBlur" .. math.random(1, 2)]:Clone();
        u27.Attachment0 = Attachment;
        u27.Attachment1 = Attachment2;
        u27.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, u24.Color), ColorSequenceKeypoint.new(1, u24.Color) });
        u27.Enabled = true;
        u27.Parent = u24;
        u24.Transparency = 0;
        local u28 = 0;
        u24.Parent = workspace.Effects;
        local u29 = nil;
        local u30 = p7 or 0.7;
        local u31 = 1 / u30;
        coroutine.wrap(function() -- Line: 108
            -- upvalues: u30 (copy), u24 (ref), TweenService (ref), u27 (copy)
            wait(u30 / 5);

            for _, child in pairs(u24:GetChildren()) do
                if child:IsA("BasePart") or (child:IsA("Texture") or child:IsA("Decal")) then
                    TweenService:Create(child, TweenInfo.new(u30 / 1.25), {
                        Transparency = 1
                    }):Play();
                end;
            end;

            TweenService:Create(u24, TweenInfo.new(u30 / 1.25), {
                Transparency = 1
            }):Play();
            wait(u30 / 1.25);
            u27.Enabled = false;
            wait(0.75);
            u24:Destroy();
        end)();
        u29 = game["Run Service"].RenderStepped:Connect(function(p32) -- Line: 121
            -- upvalues: u28 (ref), u31 (copy), u29 (ref), TweenService (ref), u25 (ref), u26 (ref), Position (copy), u24 (ref)
            u28 = u28 + p32 * u31;

            if u28 > 1 then
                u29:Disconnect();
                u28 = 1;
            end;

            if u28 + p32 * u31 > 0.8 then
                local v33 = TweenService:GetValue(u28, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out);
                u24.CFrame = CFrame.new((1 - v33) ^ 2 * u25 + 2 * (1 - v33) * v33 * u26 + v33 ^ 2 * Position, Position) * CFrame.Angles(1.5707963267948966, 1.5707963267948966, 0);

                return;
            end;

            local v34 = TweenService:GetValue(u28, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out);
            local v35 = TweenService:GetValue(u28 + p32 * u31, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out);
            u24.CFrame = CFrame.new((1 - v34) ^ 2 * u25 + 2 * (1 - v34) * v34 * u26 + v34 ^ 2 * Position, (1 - v35) ^ 2 * u25 + 2 * (1 - v35) * v35 * u26 + v35 ^ 2 * Position) * CFrame.Angles(1.5707963267948966, 1.5707963267948966, 0);
        end);
    end;
end;