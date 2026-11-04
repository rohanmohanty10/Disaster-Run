 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Debris = workspace:FindFirstChild("Debris");
local _ = game.Players.LocalPlayer;

local function lerp(p1, p2, p3) -- Line: 14
    return p1 + (p2 - p1) * p3;
end;

local function QuadBezier(p4, p5, p6, p7) -- Line: 18
    local v8 = p5 + (p6 - p5) * p4;

    return v8 + (p6 + (p7 - p6) * p4 - v8) * p4;
end;

local function randNum(p9, p10) -- Line: 25
    return Random.new():NextNumber(p9, p10);
end;

local function scaleDown(p11, p12) -- Line: 31
    for _, v in p11 do
        if v:IsA("ParticleEmitter") then
            local v13 = v;
            local v14 = {};

            for _, v2 in v.Size.Keypoints do
                local v15;

                if v2.Envelope then
                    v15 = v2.Envelope / 10 or nil;
                else
                    v15 = nil;
                end;

                if v15 ~= v15 then
                    v15 = nil;
                end;

                table.insert(v14, NumberSequenceKeypoint.new(v2.Time, v2.Value / 10, v15));
            end;

            v13.Size = NumberSequence.new(v14);
            v13.Speed = NumberRange.new(v13.Speed.Min / 10, v13.Speed.Max / 10);
        elseif v:IsA("Attachment") then
            v.Position = v.Position / 10;

            if v.Position ~= v.Position then
                v.Position = Vector3.new(0, 0, 0);
            end;
        elseif v:IsA("BasePart") then
            v.Position = p12.CFrame.Position + (v.Position - p12.CFrame.Position) / 10;

            if v.Position ~= v.Position then
                v.Position = p12.CFrame.Position;
            end;

            v.Size = v.Size / 10;

            if v.Size ~= v.Size then
                v.Size = Vector3.new(0, 0, 0);
            end;
        elseif v:IsA("Beam") then
            v.Width0 = v.Width0 / 10;
            v.Width1 = v.Width1 / 10;
        end;
    end;
end;

return function(p16, p17) -- Line: 73
    -- upvalues: Debris (copy), Essentials (copy), VfxManager (copy), SfxManager (copy), TweenService (copy), scaleDown (copy), RunService (copy)
    local Floor = workspace:FindFirstChild("Courts2"):FindFirstChild("Court"):FindFirstChild("Floor");

    if p17.Preview then
        local Attachment = Instance.new("Attachment");
        Attachment.Parent = workspace.Terrain;
        Attachment.WorldPosition = p17.CFrame.Position;
        SfxManager:playSound({
            Sound = "TimeStopSFX",
            Parent = Attachment
        }).Ended:Once(function() -- Line: 156
            -- upvalues: Attachment (copy)
            Attachment:Destroy();
        end);
        local v18 = script["Time_Stop "]:Clone();
        v18.CFrame = p17.CFrame;
        v18.Parent = Debris;
        scaleDown(v18:GetDescendants(), p17);
        VfxManager.Emit(v18);
        VfxManager.DestroyEffect(v18, 3);

        for i = 1, 3 do
            local v19 = p17.CFrame + Random.new():NextUnitVector() * math.random() * 12 * Vector3.new(1, 0.7, 1);
            local CFrame2 = p17.CFrame;
            local u20 = script.Clock:Clone();
            u20:ScaleTo(0.1);
            local CFrame_new_ret = CFrame.new(v19.Position, CFrame2.Position);
            local CFrame_Angles = CFrame.Angles;
            local math_random_ret = math.random(-45, 45);
            local math_rad_ret = math.rad(math_random_ret);
            local math_random_ret2 = math.random(-45, 45);
            u20:PivotTo(CFrame_new_ret * CFrame_Angles(math_rad_ret, math.rad(math_random_ret2), 0));
            u20.Parent = Debris;
            local _ = i;

            for _, descendant in u20:GetDescendants() do
                if descendant:IsA("ParticleEmitter") and descendant:GetAttribute("EmitCount") then
                    descendant:SetAttribute("EmitCount", descendant:GetAttribute("EmitCount") / 3);
                end;
            end;

            VfxManager.Emit(u20);
            u20.AnimationController:LoadAnimation(script["Timestop Clock Animation"]):Play();
            local u21 = 0;
            local CFrame3 = u20["Plane.002"].CFrame;
            local u25 = RunService.Heartbeat:Connect(function(p22) -- Line: 193
                -- upvalues: u21 (ref), u20 (copy), CFrame3 (copy)
                u21 = u21 + p22 * 2;
                local v23 = u20["Plane.002"];
                local v24 = math.sin(u21) * 5 / 10;
                v23.CFrame = CFrame3 + Vector3.new(0, v24, 0);
            end);
            task.delay(5, function() -- Line: 198
                -- upvalues: VfxManager (ref), u20 (copy), u25 (copy)
                VfxManager.Emit(u20["Plane.002"].Emit);
                VfxManager.Enable(u20, false);
                u20["Plane.002"].Transparency = 1;
                VfxManager.DestroyEffect(u20, 3);
                u25:Disconnect();
            end);
        end;

        return;
    end;

    if p17.Player ~= nil then
        local Character = p17.Player.Character;

        for _, child in script.Aura:GetChildren() do
            if Character:FindFirstChild(child.Name) then
                local u26 = child:Clone();
                u26.CFrame = Character:FindFirstChild(child.Name).CFrame;
                u26.Parent = Debris;
                Essentials:Weld(u26, Character:FindFirstChild(child.Name));
                VfxManager.Enable(u26, true);
                task.delay(4, function() -- Line: 91
                    -- upvalues: VfxManager (ref), u26 (copy)
                    VfxManager.Enable(u26, false);
                    VfxManager.DestroyEffect(u26, 2);
                end);
            end;
        end;
    end;

    SfxManager:playSound({
        Sound = "TimeStopSFX",
        Parent = workspace
    });
    local ColorCorrection = game.Lighting:FindFirstChild("ColorCorrection");
    local Color3_fromRGB_ret = Color3.fromRGB(255, 255, 255);
    TweenService:Create(ColorCorrection, TweenInfo.new(0.175), {
        Contrast = 2,
        TintColor = Color3.fromRGB(112, 30, 255)
    }):Play();
    task.delay(0.175, function() -- Line: 112
        -- upvalues: TweenService (ref), ColorCorrection (copy), Color3_fromRGB_ret (copy)
        TweenService:Create(ColorCorrection, TweenInfo.new(0.175), {
            TintColor = Color3.fromRGB(120, 255, 57)
        }):Play();
        task.wait(0.175);
        TweenService:Create(ColorCorrection, TweenInfo.new(0.175), {
            TintColor = Color3.fromRGB(255, 234, 3)
        }):Play();
        task.wait(0.175);
        TweenService:Create(ColorCorrection, TweenInfo.new(0.975), {
            Saturation = -1,
            Contrast = 0.2,
            TintColor = Color3_fromRGB_ret
        }):Play();
    end);
    task.delay(3.5, function() -- Line: 124
        -- upvalues: TweenService (ref), ColorCorrection (copy)
        TweenService:Create(ColorCorrection, TweenInfo.new(0.175), {
            Saturation = 0.3,
            Contrast = 2,
            TintColor = Color3.fromRGB(255, 234, 3)
        }):Play();
        task.delay(0.175, function() -- Line: 127
            -- upvalues: TweenService (ref), ColorCorrection (ref)
            TweenService:Create(ColorCorrection, TweenInfo.new(0.175), {
                TintColor = Color3.fromRGB(120, 255, 57)
            }):Play();
            task.wait(0.175);
            TweenService:Create(ColorCorrection, TweenInfo.new(0.175), {
                TintColor = Color3.fromRGB(112, 30, 255)
            }):Play();
            task.wait(0.175);
            TweenService:Create(ColorCorrection, TweenInfo.new(0.975), {
                Contrast = 0.2,
                Saturation = 0.3,
                TintColor = Color3.fromRGB(255, 255, 255)
            }):Play();
        end);
    end);
    local u27 = script.SpaceDots:Clone();
    u27.CFrame = Floor.CFrame * CFrame.new(15.118194580078125, 18.76532554626465, 2.7973995208740234) * CFrame.fromEulerAnglesYXZ(1.5707963705062866, -1.5707963705062866, 0);
    u27.Parent = Debris;
    VfxManager.Enable(u27, true);
    task.delay(5, function() -- Line: 146
        -- upvalues: VfxManager (ref), u27 (copy)
        VfxManager.Enable(u27, false);
        VfxManager.DestroyEffect(u27, 1.5);
    end);
    local v28 = script["Time_Stop "]:Clone();
    v28.CFrame = p17.CFrame;
    v28.Parent = Debris;
    VfxManager.Emit(v28);
    VfxManager.DestroyEffect(v28, 3);

    for i = 1, 6 do
        local v29 = Floor.CFrame * CFrame.new(math.random(-160, 160), math.random(30, 50), math.random(-70, 70));
        local CFrame2 = Floor.CFrame;

        if p17.Player ~= nil then
            CFrame2 = p17.Player.Character.HumanoidRootPart.CFrame;
        end;

        local u30 = script.Clock:Clone();
        local CFrame_new_ret = CFrame.new(v29.Position, CFrame2.Position);
        local CFrame_Angles = CFrame.Angles;
        local math_random_ret = math.random(-45, 45);
        local math_rad_ret = math.rad(math_random_ret);
        local math_random_ret2 = math.random(-45, 45);
        u30:PivotTo(CFrame_new_ret * CFrame_Angles(math_rad_ret, math.rad(math_random_ret2), 0));
        u30.Parent = Debris;
        VfxManager.Emit(u30);
        u30.AnimationController:LoadAnimation(script["Timestop Clock Animation"]):Play();
        local u31 = 0;
        local CFrame3 = u30["Plane.002"].CFrame;
        local u35 = RunService.Heartbeat:Connect(function(p32) -- Line: 236
            -- upvalues: u31 (ref), u30 (copy), CFrame3 (copy)
            u31 = u31 + p32 * 2;
            local v33 = u30["Plane.002"];
            local v34 = math.sin(u31) * 5;
            v33.CFrame = CFrame3 + Vector3.new(0, v34, 0);
        end);
        task.delay(5, function() -- Line: 241
            -- upvalues: VfxManager (ref), u30 (copy), u35 (copy)
            VfxManager.Emit(u30["Plane.002"].Emit);
            VfxManager.Enable(u30, false);
            u30["Plane.002"].Transparency = 1;
            VfxManager.DestroyEffect(u30, 3);
            u35:Disconnect();
        end);
        local _ = i;
    end;
end;