 
 

local SoundService = game:GetService("SoundService");
local RunService = game:GetService("RunService");
script:WaitForChild("FootstepSounds").Parent = SoundService;
local FootstepSounds = SoundService:WaitForChild("FootstepSounds");
local LocalPlayer = game.Players.LocalPlayer;
local v1 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait();
local HumanoidRootPart = v1:WaitForChild("HumanoidRootPart");
local Humanoid = v1:WaitForChild("Humanoid");
local u2 = nil;
local u4 = Humanoid.Running:connect(function(p3) -- Line: 13
    -- upvalues: Humanoid (copy), u2 (ref)
    if Humanoid.WalkSpeed / 2 < p3 then
        u2 = true;

        return;
    end;

    u2 = false;
end);

function getMaterial()
    -- upvalues: Humanoid (copy)
    return string.split(tostring(Humanoid.FloorMaterial or "Air"), "Enum.Material.")[2];
end;

for _, child in pairs(HumanoidRootPart:GetChildren()) do
    if child:IsA("Sound") then
        child:Destroy();
    end;
end;

local u5 = nil;
local u8 = RunService.PreRender:connect(function() -- Line: 36
    -- upvalues: HumanoidRootPart (copy), u2 (ref), FootstepSounds (copy), u5 (ref), Humanoid (copy)
    if u2 and HumanoidRootPart.AssemblyLinearVelocity.Magnitude > 0.1 then
        local v6 = getMaterial();

        if FootstepSounds:FindFirstChild(v6) then
            if v6 ~= u5 and u5 ~= nil then
                FootstepSounds[u5].Playing = false;
            end;

            local v7 = FootstepSounds[v6];
            v7.PlaybackSpeed = Humanoid.WalkSpeed / 30;
            v7.Playing = true;
            u5 = v6;
        end;
    else
        for _, child in pairs(FootstepSounds:GetChildren()) do
            child.Playing = false;
        end;
    end;
end);
Humanoid.Died:Connect(function() -- Line: 58
    -- upvalues: u8 (copy), u4 (copy)
    u8:Disconnect();
    u4:Disconnect();
end);