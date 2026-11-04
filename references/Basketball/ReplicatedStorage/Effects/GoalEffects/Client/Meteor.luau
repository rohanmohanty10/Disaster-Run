 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local _ = game.Players.LocalPlayer;

function EnableVFX(p1: userdata, p2: boolean?)
    for _, v in next, p1:GetDescendants() do
        if v.ClassName == "ParticleEmitter" then
            v.Enabled = p2 or false;
        end;
    end;
end;

function EmitAll(p3: table)
    for _, v in next, p3 do
        if v.ClassName == "ParticleEmitter" then
            if v:GetAttribute("EmitDelay") then
                task.delay(v:GetAttribute("EmitDelay"), function() -- Line: 22
                    -- upvalues: v (copy)
                    v:Emit(v:GetAttribute("EmitCount"));
                end);
            else
                v:Emit(v:GetAttribute("EmitCount"));
            end;
        end;
    end;
end;

local u4 = 10;

local function scaleDown(p5, p6) -- Line: 34
    -- upvalues: u4 (ref)
    for _, v in p5 do
        if v:IsA("ParticleEmitter") then
            local v7 = v;
            local v8 = {};

            for _, v2 in v.Size.Keypoints do
                local v9;

                if v2.Envelope then
                    v9 = v2.Envelope / u4 or nil;
                else
                    v9 = nil;
                end;

                if v9 ~= v9 then
                    v9 = nil;
                end;

                table.insert(v8, NumberSequenceKeypoint.new(v2.Time, v2.Value / u4, v9));
            end;

            v7.Size = NumberSequence.new(v8);
            v7.Speed = NumberRange.new(v7.Speed.Min / u4, v7.Speed.Max / u4);
        elseif v:IsA("Attachment") then
            v.Position = v.Position / u4;

            if v.Position ~= v.Position then
                v.Position = Vector3.new(0, 0, 0);
            end;
        elseif v:IsA("BasePart") then
            v.Position = p6.CFrame.Position + (v.Position - p6.CFrame.Position) / u4;

            if v.Position ~= v.Position then
                v.Position = p6.CFrame.Position;
            end;

            v.Size = v.Size / u4;

            if v.Size ~= v.Size then
                v.Size = Vector3.new(0, 0, 0);
            end;
        elseif v:IsA("Beam") then
            v.Width0 = v.Width0 / u4;
            v.Width1 = v.Width1 / u4;
        end;
    end;
end;

return function(p10, u11) -- Line: 76
    -- upvalues: scaleDown (copy), VfxManager (copy), u4 (ref), TweenService (copy)
    local CFrame2 = u11.CFrame;
    local v12 = script.InitialHit:Clone();
    v12.CFrame = CFrame2;
    v12.Parent = workspace.Debris;

    if u11.Preview then
        scaleDown(v12:GetDescendants(), u11);
    end;

    VfxManager.Emit(v12);
    VfxManager.DestroyEffect(v12, 3);
    local v13 = CFrame2 * CFrame.new(Vector3.new(-100, 200, 125) / (u11.Preview and u4 * 0.2 or 1));
    local Magnitude = (v13.Position - CFrame2.Position).Magnitude;
    local v14 = CFrame.lookAt(v13.Position, CFrame2.Position) * CFrame.new(0, 0, -Magnitude) * CFrame.Angles(0, 3.141592653589793, 0);
    local v15 = Magnitude / (400 / (u11.Preview and u4 * 0.5 or 1));
    local u16 = script.Meteor:Clone();
    u16.CFrame = CFrame.lookAt(v13.Position, v14.Position) * CFrame.Angles(0, 3.141592653589793, 0);
    u16.Parent = workspace.Debris;

    if u11.Preview then
        u4 = 5;
        scaleDown({ u16 }, u11);
        scaleDown(u16:GetDescendants(), u11);
        u4 = 10;
    end;

    VfxManager.Enable(u16, true);
    local v17 = TweenService:Create(u16, TweenInfo.new(v15, Enum.EasingStyle.Linear), {
        CFrame = v14
    });
    v17:Play();
    v17.Completed:Connect(function() -- Line: 113
        -- upvalues: u16 (copy), VfxManager (ref), CFrame2 (copy), u11 (copy), u4 (ref), scaleDown (ref)
        u16.Transparency = 1;
        VfxManager.Enable(u16, false);
        local v18 = script.Impact:Clone();
        v18.CFrame = CFrame2 * CFrame.new(Vector3.new(-15, -13, 0) / (u11.Preview and u4 or 1));
        v18.Parent = workspace.Debris;

        if u11.Preview then
            scaleDown(v18:GetDescendants(), u11);
        end;

        VfxManager.Emit(v18);
        VfxManager.DestroyEffect(v18, 3);
        VfxManager.DestroyEffect(u16, 3);
    end);
end;