 -- Original SourceAssetId: https://assetdelivery.roblox.com/v1/asset/?id=13676364636

-- ! Source from the asset above; the game may have edited it since.

--[[
local Character: Model = script.Parent.Parent
local Torso: BasePart = Character:WaitForChild("Torso")
local Humanoid: Humanoid = Character:WaitForChild("Humanoid")
local RagdollValue: BoolValue = Character:WaitForChild("IsRagdoll")

local function push()
	Torso:ApplyImpulse(Torso.CFrame.LookVector * -100)
end

RagdollValue:GetPropertyChangedSignal("Value"):Connect(function()
	if (Humanoid.Health == 0) then --> Prevents OOF sound from playing twice thanks to @robloxdestroyer1035
		Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp, false)
		push()
		return
	end
	
	if RagdollValue.Value then
		Humanoid:ChangeState(Enum.HumanoidStateType.Ragdoll)
		Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp, false)
		push()
	elseif not RagdollValue.Value then
		Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
	end
end)

Humanoid.Died:Connect(push)
]]

 

local Parent = script.Parent.Parent;
local Torso = Parent:WaitForChild("Torso", 10);
local Humanoid = Parent:WaitForChild("Humanoid");
local IsRagdoll = Parent:WaitForChild("IsRagdoll");
IsRagdoll:GetPropertyChangedSignal("Value"):Connect(function() -- Line: 10
    -- upvalues: Humanoid (copy), Torso (copy), IsRagdoll (copy)
    if Humanoid.Health == 0 then
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp, false);
        Torso:ApplyImpulse(Torso.CFrame.LookVector * 100);

        return;
    end;

    if not IsRagdoll.Value then
        if not IsRagdoll.Value then
            Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp);
        end;

        return;
    end;

    Humanoid:ChangeState(Enum.HumanoidStateType.Ragdoll);
    Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp, false);
    Torso:ApplyImpulse(Torso.CFrame.LookVector * 100);
end);
Humanoid.Died:Connect(function() -- Line: 6, Name: push
    -- upvalues: Torso (copy)
    Torso:ApplyImpulse(Torso.CFrame.LookVector * 100);
end);