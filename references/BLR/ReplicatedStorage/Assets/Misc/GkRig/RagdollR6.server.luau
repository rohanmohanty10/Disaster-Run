 -- Original SourceAssetId: https://assetdelivery.roblox.com/v1/asset/?id=13676364636

-- ! Source from the asset above; the game may have edited it since.

--[[
--> Perfect R6 Ragdoll by CompletedLoop
--> June 6, 2023

--> Make sure this script is located in StarterPlayer.StarterCharacterScripts
local Character: Model = script.Parent
local Torso: BasePart = Character:WaitForChild("Torso")
local Humanoid: Humanoid = Character:FindFirstChildOfClass("Humanoid")

--> Necessary for Ragdolling to function properly
Character.Humanoid.BreakJointsOnDeath = false
Character.Humanoid.RequiresNeck = true --> If your are having issues with your character randomly dying then set this to false

--> Specific CFrame's I made for the best looking Ragdoll
local attachmentCFrames = {
	["Neck"] = {CFrame.new(0, 1, 0, 0, -1, 0, 1, 0, -0, 0, 0, 1), CFrame.new(0, -0.5, 0, 0, -1, 0, 1, 0, -0, 0, 0, 1)},
	["Left Shoulder"] = {CFrame.new(-1.3, 0.75, 0, -1, 0, 0, 0, -1, 0, 0, 0, 1), CFrame.new(0.2, 0.75, 0, -1, 0, 0, 0, -1, 0, 0, 0, 1)},
	["Right Shoulder"] = {CFrame.new(1.3, 0.75, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1), CFrame.new(-0.2, 0.75, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)},
	["Left Hip"] = {CFrame.new(-0.5, -1, 0, 0, 1, -0, -1, 0, 0, 0, 0, 1), CFrame.new(0, 1, 0, 0, 1, -0, -1, 0, 0, 0, 0, 1)},
	["Right Hip"] = {CFrame.new(0.5, -1, 0, 0, 1, -0, -1, 0, 0, 0, 0, 1), CFrame.new(0, 1, 0, 0, 1, -0, -1, 0, 0, 0, 0, 1)},
}

local ragdollInstanceNames = {
	["RagdollAttachment"] = true,
	["RagdollConstraint"] = true,
	["ColliderPart"] = true,
}

--> Used to trigger Ragdoll
local RagdollValue = Instance.new("BoolValue")
RagdollValue.Name = "IsRagdoll"
RagdollValue.Parent = Character

--> Used for anticheats to prevent flying Ragdolls from getting flagged, might be useful for you.
Character:SetAttribute("LastRag")
-------------------------------------------------------------------------------------------------

--> Allows for proper limb collisions
local function createColliderPart(part: BasePart)
	if not part then return end
	local rp = Instance.new("Part")
	rp.Name = "ColliderPart"
	rp.Size = part.Size/1.7
	rp.Massless = true			
	rp.CFrame = part.CFrame
	rp.Transparency = 1
	
	local wc = Instance.new("WeldConstraint")
	wc.Part0 = rp
	wc.Part1 = part
	
	wc.Parent = rp
	rp.Parent = part
end

--> Converts Motor6D's into BallSocketConstraints
function replaceJoints()
	for _, motor: Motor6D in pairs(Character:GetDescendants()) do
		if motor:IsA("Motor6D") then
			if not attachmentCFrames[motor.Name] then return end
			motor.Enabled = false;
			local a0, a1 = Instance.new("Attachment"), Instance.new("Attachment")
			a0.CFrame = attachmentCFrames[motor.Name][1]
			a1.CFrame = attachmentCFrames[motor.Name][2]

			a0.Name = "RagdollAttachment"
			a1.Name = "RagdollAttachment"

			createColliderPart(motor.Part1)

			local b = Instance.new("BallSocketConstraint")
			b.Attachment0 = a0
			b.Attachment1 = a1
			b.Name = "RagdollConstraint"
			
			b.Radius = 0.15
			b.LimitsEnabled = true
			b.TwistLimitsEnabled = false
			b.MaxFrictionTorque = 0
			b.Restitution = 0
			b.UpperAngle = 90
			b.TwistLowerAngle = -45
			b.TwistUpperAngle = 45

			if motor.Name == "Neck" then
				b.TwistLimitsEnabled = true
				b.UpperAngle = 45
				b.TwistLowerAngle = -70
				b.TwistUpperAngle = 70
			end
			
			a0.Parent = motor.Part0
			a1.Parent = motor.Part1
			b.Parent = motor.Parent
		end
	end
	
	Humanoid.AutoRotate = false --> Disabling AutoRotate prevents the Character rotating in first person or Shift-Lock
	Character:SetAttribute("LastRag", tick())
end

--> Destroys all Ragdoll made instances and re-enables the Motor6D's
function resetJoints()
	if Humanoid.Health < 1 then return end
	for _, instance in pairs(Character:GetDescendants()) do
		if ragdollInstanceNames[instance.Name] then
			instance:Destroy()
		end

		if instance:IsA("Motor6D") then
			instance.Enabled = true;
		end
	end
	
	Humanoid.AutoRotate = true
end

function Ragdoll(value: boolean)
	if value then replaceJoints() else resetJoints() end
end

-------------------------------------------------------------------------------------------------
--> Connect the Events
RagdollValue.Changed:Connect(Ragdoll)
Humanoid.Died:Once(function()
	RagdollValue.Value = true
end)
]]

 

local script_Parent = script.Parent;
script_Parent:WaitForChild("Torso");
local u1 = script_Parent:FindFirstChildOfClass("Humanoid");
script_Parent.Humanoid.BreakJointsOnDeath = false;
script_Parent.Humanoid.RequiresNeck = false;
local u2 = {
    Neck = { CFrame.new(0, 1, 0, 0, -1, 0, 1, 0, -0, 0, 0, 1), CFrame.new(0, -0.5, 0, 0, -1, 0, 1, 0, -0, 0, 0, 1) },
    ["Left Shoulder"] = { CFrame.new(-1.3, 0.75, 0, -1, 0, 0, 0, -1, 0, 0, 0, 1), CFrame.new(0.2, 0.75, 0, -1, 0, 0, 0, -1, 0, 0, 0, 1) },
    ["Right Shoulder"] = { CFrame.new(1.3, 0.75, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1), CFrame.new(-0.2, 0.75, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1) },
    ["Left Hip"] = { CFrame.new(-0.5, -1, 0, 0, 1, -0, -1, 0, 0, 0, 0, 1), CFrame.new(0, 1, 0, 0, 1, -0, -1, 0, 0, 0, 0, 1) },
    ["Right Hip"] = { CFrame.new(0.5, -1, 0, 0, 1, -0, -1, 0, 0, 0, 0, 1), CFrame.new(0, 1, 0, 0, 1, -0, -1, 0, 0, 0, 0, 1) }
};
local u3 = {
    RagdollAttachment = true,
    RagdollConstraint = true,
    ColliderPart = true
};
local BoolValue = Instance.new("BoolValue");
BoolValue.Name = "IsRagdoll";
BoolValue.Parent = script_Parent;
script_Parent:SetAttribute("LastRag");

local function createColliderPart(p4: userdata) -- Line: 38
    if not p4 then
        return;
    end;

    local Part = Instance.new("Part");
    Part.Name = "ColliderPart";
    Part.Size = p4.Size / 1.7;
    Part.Massless = true;
    Part.CFrame = p4.CFrame;
    Part.Transparency = 1;
    local WeldConstraint = Instance.new("WeldConstraint");
    WeldConstraint.Part0 = Part;
    WeldConstraint.Part1 = p4;
    WeldConstraint.Parent = Part;
    Part.Parent = p4;
end;

function replaceJoints()
    -- upvalues: script_Parent (copy), u2 (copy), u1 (copy)
    for _, descendant in pairs(script_Parent:GetDescendants()) do
        if descendant:IsA("Motor6D") then
            if not u2[descendant.Name] then
                return;
            end;

            descendant.Enabled = false;
            local Attachment = Instance.new("Attachment");
            local Attachment2 = Instance.new("Attachment");
            Attachment.CFrame = u2[descendant.Name][1];
            Attachment2.CFrame = u2[descendant.Name][2];
            Attachment.Name = "RagdollAttachment";
            Attachment2.Name = "RagdollAttachment";
            local Part1 = descendant.Part1;

            if Part1 then
                local Part = Instance.new("Part");
                Part.Name = "ColliderPart";
                Part.Size = Part1.Size / 1.7;
                Part.Massless = true;
                Part.CFrame = Part1.CFrame;
                Part.Transparency = 1;
                local WeldConstraint = Instance.new("WeldConstraint");
                WeldConstraint.Part0 = Part;
                WeldConstraint.Part1 = Part1;
                WeldConstraint.Parent = Part;
                Part.Parent = Part1;
            end;

            local BallSocketConstraint = Instance.new("BallSocketConstraint");
            BallSocketConstraint.Attachment0 = Attachment;
            BallSocketConstraint.Attachment1 = Attachment2;
            BallSocketConstraint.Name = "RagdollConstraint";
            BallSocketConstraint.Radius = 0.15;
            BallSocketConstraint.LimitsEnabled = true;
            BallSocketConstraint.TwistLimitsEnabled = false;
            BallSocketConstraint.MaxFrictionTorque = 0;
            BallSocketConstraint.Restitution = 0;
            BallSocketConstraint.UpperAngle = 90;
            BallSocketConstraint.TwistLowerAngle = -45;
            BallSocketConstraint.TwistUpperAngle = 45;

            if descendant.Name == "Neck" then
                BallSocketConstraint.TwistLimitsEnabled = true;
                BallSocketConstraint.UpperAngle = 45;
                BallSocketConstraint.TwistLowerAngle = -70;
                BallSocketConstraint.TwistUpperAngle = 70;
            end;

            Attachment.Parent = descendant.Part0;
            Attachment2.Parent = descendant.Part1;
            BallSocketConstraint.Parent = descendant.Parent;
        end;
    end;

    u1.AutoRotate = false;
    script_Parent:SetAttribute("LastRag", tick());
end;

function resetJoints()
    -- upvalues: u1 (copy), script_Parent (copy), u3 (copy)
    if u1.Health < 1 then
        return;
    end;

    for _, descendant in pairs(script_Parent:GetDescendants()) do
        if u3[descendant.Name] then
            descendant:Destroy();
        end;

        if descendant:IsA("Motor6D") then
            descendant.Enabled = true;
        end;
    end;

    u1.AutoRotate = true;
end;

function Ragdoll(p5: boolean)
    if p5 then
        replaceJoints();

        return;
    end;

    resetJoints();
end;

BoolValue.Changed:Connect(Ragdoll);
u1.Died:Once(function() -- Line: 124
    -- upvalues: BoolValue (copy)
    BoolValue.Value = true;
end);