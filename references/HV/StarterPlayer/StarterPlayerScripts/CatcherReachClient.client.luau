 

 

local RunService = game:GetService("RunService");
local ChickenOrHero = game.ReplicatedStorage:WaitForChild("ChickenOrHero");
local ParticipantDirectory = require(ChickenOrHero.Presentation:WaitForChild("ParticipantDirectory"));
local ReachPose = require(ChickenOrHero.Presentation:WaitForChild("ReachPose"));
local ContactCatchConfig = require(ChickenOrHero.Game:WaitForChild("ContactCatchConfig"));
local u1 = {};
local u2 = {};
local u3 = {};
local u4 = 1;

local function restore(p5) -- Line: 9
    if p5.motor.Parent and (p5.applied and p5.motor.Transform == p5.applied) then
        p5.motor.Transform = p5.base;
    end;

    p5.applied = nil;
end;

table.insert(u3, RunService.PreAnimation:Connect(function() -- Line: 13
    -- upvalues: u1 (copy)
    for _, v in u1 do
        if v.motor.Parent and (v.applied and v.motor.Transform == v.applied) then
            v.motor.Transform = v.base;
        end;

        v.applied = nil;
    end;
end));
table.insert(u3, RunService.PreSimulation:Connect(function(p6) -- Line: 14
    -- upvalues: u4 (ref), u2 (copy), ParticipantDirectory (copy), u1 (copy), ContactCatchConfig (copy), ReachPose (copy)
    u4 = u4 + p6;

    if u4 >= 0.1 then
        u4 = 0;
        table.clear(u2);

        for _, v in ParticipantDirectory.list() do
            u2[v.UserId] = v;
            local Character = v.Character;
            local v7;

            if Character then
                v7 = Character:FindFirstChild("Torso");
            else
                v7 = Character;
            end;

            local v8;

            if v7 then
                v8 = v7:FindFirstChild("Right Shoulder");
            else
                v8 = v7;
            end;

            if v8 and not u1[Character] then
                u1[Character] = {
                    weight = 0,
                    character = Character,
                    motor = v8,
                    torso = v7
                };
            end;
        end;
    end;

    for i, v in u1 do
        if v.motor.Parent and (v.applied and v.motor.Transform == v.applied) then
            v.motor.Transform = v.base;
        end;

        v.applied = nil;

        if i.Parent and v.motor.Parent then
            local Attribute = i:GetAttribute("ReachTargetUserId");

            if Attribute then
                Attribute = u2[Attribute];
            end;

            local v9 = Attribute and Attribute.Character and Attribute.Character:FindFirstChild("HumanoidRootPart");
            local HumanoidRootPart = i:FindFirstChild("HumanoidRootPart");
            local v10 = i:FindFirstChildOfClass("Humanoid");

            if i:GetAttribute("DaggerEquipped") == true and true or (not ContactCatchConfig.Enabled or (not (HumanoidRootPart and v10) or (v10.Health <= 0 and true or (HumanoidRootPart.Anchored and not i:GetAttribute("ClientBot") or (i:GetAttribute("MovementLocked") == true and true or i:GetAttribute("TackleActive") == true))))) then
                v.weight = 0;
                v.aim = nil;
            else
                local Attribute2 = i:GetAttribute("ReachPhase");
                local Attribute3 = i:GetAttribute("ReachDirection");
                local v11;

                if (Attribute2 == "Windup" or Attribute2 == "Active") and typeof(Attribute3) == "Vector3" then
                    v11 = true;
                elseif Attribute2 == "Tracking" then
                    if v9 then
                        if Attribute:GetAttribute("GameRole") == "Runner" and Attribute:GetAttribute("RunState") == "Active" then
                            v11 = (v9.Position - HumanoidRootPart.Position).Magnitude <= ContactCatchConfig.ReachDistance + 2;
                        else
                            v11 = false;
                        end;
                    else
                        v11 = v9;
                    end;
                else
                    v11 = false;
                end;

                local weight = v.weight;
                local v12 = (v11 and (Attribute2 == "Tracking" and ContactCatchConfig.TrackingWeight or (Attribute2 == "Windup" and ContactCatchConfig.WindupWeight or 1)) or 0) - v.weight;
                local v13 = -ContactCatchConfig.ReachFadeRate * math.min(p6, 0.1);
                v.weight = weight + v12 * (1 - math.exp(v13));

                if v11 then
                    v.aim = Attribute2 == "Tracking" and v9.Position + Vector3.new(0, 0.25, 0) or HumanoidRootPart.Position + Attribute3 * 8 + Vector3.new(0, 0.25, 0);
                end;

                if v.weight >= 0.001 and v.aim then
                    local CFrame = v.torso.CFrame;
                    local RootJoint = HumanoidRootPart:FindFirstChild("RootJoint");

                    if RootJoint then
                        CFrame = HumanoidRootPart.CFrame * RootJoint.C0 * RootJoint.Transform * RootJoint.C1:Inverse();
                    end;

                    v.base = v.motor.Transform;
                    local v14 = ReachPose.transform(CFrame, v.motor, v.aim, v.base);

                    if v.pose then
                        local pose = v.pose;
                        local v15 = math.min(p6, 0.1) * -26;
                        v14 = pose:Lerp(v14, 1 - math.exp(v15)) or v14;
                    end;

                    v.pose = v14;
                    v.applied = v.base:Lerp(v.pose, v.weight);
                    v.motor.Transform = v.applied;
                end;
            end;
        else
            u1[i] = nil;
        end;
    end;
end));
script.Destroying:Connect(function() -- Line: 55
    -- upvalues: u3 (copy), u1 (copy)
    for _, v in u3 do
        v:Disconnect();
    end;

    for _, v in u1 do
        if v.motor.Parent and (v.applied and v.motor.Transform == v.applied) then
            v.motor.Transform = v.base;
        end;

        v.applied = nil;
    end;

    table.clear(u1);
end);