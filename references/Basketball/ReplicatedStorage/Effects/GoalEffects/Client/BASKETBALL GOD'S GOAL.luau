 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Debris = workspace:FindFirstChild("Debris");
local LocalPlayer = game.Players.LocalPlayer;

local function lerp(p1, p2, p3) -- Line: 13
    return p1 + (p2 - p1) * p3;
end;

local function QuadBezier(p4, p5, p6, p7) -- Line: 17
    local v8 = p5 + (p6 - p5) * p4;

    return v8 + (p6 + (p7 - p6) * p4 - v8) * p4;
end;

local function randNum(p9, p10) -- Line: 24
    return Random.new():NextNumber(p9, p10);
end;

local function scaleDown(p11, p12) -- Line: 30
    for _, v in p11 do
        if v:IsA("ParticleEmitter") then
            local v13 = v;
            local v14 = {};

            for _, v2 in v.Size.Keypoints do
                local v15;

                if v2.Envelope then
                    v15 = v2.Envelope / 15 or nil;
                else
                    v15 = nil;
                end;

                if v15 ~= v15 then
                    v15 = nil;
                end;

                table.insert(v14, NumberSequenceKeypoint.new(v2.Time, v2.Value / 15, v15));
            end;

            v13.Size = NumberSequence.new(v14);
            v13.Speed = NumberRange.new(v13.Speed.Min / 15, v13.Speed.Max / 15);
        elseif v:IsA("Attachment") then
            v.Position = v.Position / 15;

            if v.Position ~= v.Position then
                v.Position = Vector3.new(0, 0, 0);
            end;
        elseif v:IsA("BasePart") then
            v.Position = p12.CFrame.Position + (v.Position - p12.CFrame.Position) / 15;

            if v.Position ~= v.Position then
                v.Position = p12.CFrame.Position;
            end;

            v.Size = v.Size / 15;

            if v.Size ~= v.Size then
                v.Size = Vector3.new(0, 0, 0);
            end;
        elseif v:IsA("Beam") then
            v.Width0 = v.Width0 / 15;
            v.Width1 = v.Width1 / 15;
        end;
    end;
end;

return function(p16, u17) -- Line: 72
    -- upvalues: LocalPlayer (copy), VfxManager (copy), Debris (copy), scaleDown (copy), RunService (copy), TweenService (copy)
    local CFrame2 = u17.CFrame;
    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local u18, u19;

    if u17.Preview then
        u18 = nil;
        u19 = nil;
    else
        local v20 = script.Vignette:Clone();
        v20.Parent = PlayerGui;
        v20.Enabled = true;
        VfxManager.DestroyEffect(v20, 4);
        u19 = v20.Vignette;
        u18 = v20.Vignette1;
        u18.ImageColor3 = Color3.fromRGB(255, 255, 0);
        u18.ImageTransparency = 0;
        u19.ImageTransparency = 0;
    end;

    local u21 = 0;
    local u22 = CFrame2 * CFrame.new(Vector3.new(-400, 100, 0) / (u17.Preview and 15 or 1));
    local Position = (CFrame.lookAt(u22.Position:Lerp(CFrame2.Position, 0.25), CFrame2.Position) * CFrame.new(Vector3.new(100, 100, 0) / (u17.Preview and 15 or 1))).Position;
    local u23 = script["BASKETBALL GOD GOAL"]:Clone();
    u23:PivotTo(CFrame2);
    u23.Parent = Debris;

    if u17.Preview then
        scaleDown(u23:GetDescendants(), u17);
    end;

    VfxManager.Emit(u23.Goal);
    VfxManager.Emit(u23.Dollars);
    local u24 = script.Car:Clone();
    u24:PivotTo(u22);
    VfxManager.Enable(u24["Plane.006"].FX, true);
    u24["Plane.006"].Transparency = 0;
    u24.Parent = Debris;

    if u17.Preview then
        scaleDown(u24:GetDescendants(), u17);
    end;

    VfxManager.DestroyEffect(u23, 6);
    VfxManager.DestroyEffect(u24, 3);
    local u25 = nil;
    u25 = RunService.Heartbeat:Connect(function(p26) -- Line: 119
        -- upvalues: u21 (ref), u22 (copy), Position (copy), CFrame2 (copy), u25 (ref), VfxManager (ref), u23 (copy), u24 (copy), u17 (copy), TweenService (ref), u18 (ref), u19 (ref)
        u21 = u21 + p26 * 1;
        local v27 = u21;
        local Position2 = u22.Position;
        local v28 = Position;
        local v29 = Position2 + (v28 - Position2) * v27;
        local v30 = v29 + (v28 + (CFrame2.Position - v28) * v27 - v29) * v27;
        local v31 = u21 + 0.01;
        local Position3 = u22.Position;
        local v32 = Position;
        local v33 = Position3 + (v32 - Position3) * v31;
        local v34 = v33 + (v32 + (CFrame2.Position - v32) * v31 - v33) * v31;

        if u21 >= 1 then
            u25:Disconnect();
            VfxManager.Emit(u23);
            u24["Plane.006"].Transparency = 1;
            VfxManager.Enable(u24, false);

            if not u17.Preview then
                TweenService:Create(u18, TweenInfo.new(3, Enum.EasingStyle.Sine), {
                    ImageTransparency = 1,
                    ImageColor3 = Color3.fromRGB(0, 0, 0)
                }):Play();
                TweenService:Create(u19, TweenInfo.new(3, Enum.EasingStyle.Linear), {
                    ImageTransparency = 1
                }):Play();
            end;
        else
            u24["Plane.006"].CFrame = CFrame.new(v30, v34);
        end;
    end);
    task.delay(1, function() -- Line: 142
        -- upvalues: u25 (ref)
        if u25 then
            u25:Disconnect();
        end;
    end);
end;