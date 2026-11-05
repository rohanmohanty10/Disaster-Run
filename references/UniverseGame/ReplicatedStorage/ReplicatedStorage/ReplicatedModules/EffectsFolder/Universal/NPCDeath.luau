  

 

local ClientAssets = require(game.ReplicatedStorage:WaitForChild("ReplicatedModules"):WaitForChild("PathShortcuts")).ClientAssets;
local SoundGroups = require(game.ReplicatedStorage.ReplicatedModules:WaitForChild("SoundGroups"));
local Death = ClientAssets:WaitForChild("NPCs"):WaitForChild("Death");
local u1 = { "HumanoidRootPart" };
local u2 = { 15619422633, 15619422735, 15619422811 };

return function(p3) -- Line: 16
    -- upvalues: u2 (copy), SoundGroups (copy), Death (copy), u1 (copy)
    if p3 == nil then
        return;
    end;

    local v4 = p3:FindFirstChild("HumanoidRootPart") or p3:FindFirstChild("Torso");

    if v4 then
        local Sound = Instance.new("Sound");
        Sound.SoundId = "rbxassetid://" .. u2[math.random(1, #u2)];
        Sound.Volume = 1.5;
        Sound.Parent = v4;
        SoundGroups:AssignSoundTag(Sound);
        Sound:Play();
    end;

    local v5 = {};

    for _, child in Death:GetChildren() do
        if child:IsA("ParticleEmitter") then
            table.insert(v5, child);
        end;
    end;

    for _, descendant in p3:GetDescendants() do
        if descendant:IsA("BasePart") or descendant:IsA("Decal") then
            descendant.Transparency = 1;
        end;
    end;

    local Model = Instance.new("Model");
    Model.Name = "NPCDeath";
    local v6 = {};

    for _, child in p3:GetChildren() do
        if child:IsA("BasePart") and not table.find(u1, child.Name) then
            local Part = Instance.new("Part");
            Part.Size = child.Size;
            Part.CFrame = child.CFrame;
            Part.Anchored = true;
            Part.CanCollide = false;
            Part.CanTouch = false;
            Part.CanQuery = false;
            Part.CastShadow = false;
            Part.Transparency = 1;

            for _, v in v5 do
                if v:IsA("ParticleEmitter") then
                    local v7 = v:Clone();
                    v7.Parent = Part;
                    table.insert(v6, v7);
                end;
            end;

            local v8;

            if child.Name == "Torso" then
                v8 = Death.Attachment:Clone();
                v8.Parent = Part;
            else
                v8 = nil;
            end;

            Part.Parent = Model;

            if v8 then
                table.insert(v6, v8.Flare);
            end;
        end;
    end;

    task.delay(8, Model.Destroy, Model);
    Model.Parent = workspace.Effects;

    for _, v in v6 do
        v:Emit(v:GetAttribute("EmitCount"));
    end;
end;