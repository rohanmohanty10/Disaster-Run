 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
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

local function scaleDown(p4, p5) -- Line: 34
    for _, v in p4 do
        if v:IsA("ParticleEmitter") then
            local v6 = v;
            local v7 = {};

            for _, v2 in v.Size.Keypoints do
                local v8;

                if v2.Envelope then
                    v8 = v2.Envelope / 10 or nil;
                else
                    v8 = nil;
                end;

                if v8 ~= v8 then
                    v8 = nil;
                end;

                table.insert(v7, NumberSequenceKeypoint.new(v2.Time, v2.Value / 10, v8));
            end;

            v6.Size = NumberSequence.new(v7);
            v6.Speed = NumberRange.new(v6.Speed.Min / 10, v6.Speed.Max / 10);
        elseif v:IsA("Attachment") then
            v.Position = v.Position / 10;

            if v.Position ~= v.Position then
                v.Position = Vector3.new(0, 0, 0);
            end;
        elseif v:IsA("BasePart") then
            v.Position = p5.CFrame.Position + (v.Position - p5.CFrame.Position) / 10;

            if v.Position ~= v.Position then
                v.Position = p5.CFrame.Position;
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

return function(p9, p10) -- Line: 76
    -- upvalues: scaleDown (copy), VfxManager (copy)
    local CFrame = p10.CFrame;
    local v11 = script["Symbiote GoalFX"]:Clone();
    v11:PivotTo(CFrame);
    v11.Parent = workspace.Debris;

    if p10.Preview then
        scaleDown(v11:GetDescendants(), p10);
    end;

    VfxManager.Emit(v11);
    VfxManager.DestroyEffect(v11, 4);
end;