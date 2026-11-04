 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
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
        if v:IsA("ParticleEmitter") or (v:IsA("Beam") or v:IsA("Trail")) then
            local Attribute = v:GetAttribute("EmitDuration");
            local v4 = v:GetAttribute("EmitDelay") or 0;
            local Attribute2 = v:GetAttribute("EmitCount");

            if Attribute == nil or Attribute == 0 then
                if v4 and (Attribute2 ~= 0 and (Attribute2 ~= nil and v:IsA("ParticleEmitter"))) then
                    task.delay(v4, function() -- Line: 36
                        -- upvalues: v (copy)
                        v:Emit(v:GetAttribute("EmitCount"));
                    end);
                end;
            else
                task.delay(v4, function() -- Line: 28
                    -- upvalues: v (copy), Attribute (copy)
                    v.Enabled = true;
                    task.wait(Attribute);
                    v.Enabled = false;
                end);
            end;
        end;
    end;
end;

local function scaleDown(p5, p6) -- Line: 47
    for _, v in p5 do
        if v:IsA("ParticleEmitter") then
            local v7 = v;
            local v8 = {};

            for _, v2 in v.Size.Keypoints do
                local v9;

                if v2.Envelope then
                    v9 = v2.Envelope / 15 or nil;
                else
                    v9 = nil;
                end;

                if v9 ~= v9 then
                    v9 = nil;
                end;

                table.insert(v8, NumberSequenceKeypoint.new(v2.Time, v2.Value / 15, v9));
            end;

            v7.Size = NumberSequence.new(v8);
            v7.Speed = NumberRange.new(v7.Speed.Min / 15, v7.Speed.Max / 15);
        elseif v:IsA("Attachment") then
            v.Position = v.Position / 15;

            if v.Position ~= v.Position then
                v.Position = Vector3.new(0, 0, 0);
            end;
        elseif v:IsA("BasePart") then
            v.Position = p6.CFrame.Position + (v.Position - p6.CFrame.Position) / 15;

            if v.Position ~= v.Position then
                v.Position = p6.CFrame.Position;
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

return function(p10, p11) -- Line: 89
    -- upvalues: scaleDown (copy), VfxManager (copy), SfxManager (copy)
    local v12 = script.ENERGY:Clone();
    v12:PivotTo(p11.CFrame);
    v12.Parent = workspace.Debris;

    if p11.Preview then
        scaleDown(v12:GetDescendants(), p11);
    end;

    EmitAll(v12:GetDescendants());
    VfxManager.DestroyEffect(v12, 3);
    SfxManager:playSound({
        Sound = "bbz grand explosion",
        Parent = p11.Preview and v12.Root or workspace
    });

    if not p11.Preview then
        local game_Lighting = game.Lighting;
        game_Lighting:FindFirstChild("ColorCorrection");
        local DepthOfField = game_Lighting:FindFirstChild("DepthOfField");
        local _ = DepthOfField.FarIntensity;
        local _ = DepthOfField.FocusDistance;
        local _ = DepthOfField.InFocusRadius;
        local _ = DepthOfField.NearIntensity;
    end;
end;