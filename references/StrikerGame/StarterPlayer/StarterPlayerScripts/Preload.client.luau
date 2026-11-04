 

 

local RunService = game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");

if game:GetService("Players").LocalPlayer.UserId == 103548428 then
    print("NO THX");

    return;
end;

if RunService:IsStudio() then
    local v1 = {
        ParticleEmitter = true,
        Trail = true,
        Beam = true
    };
    local v2 = {};

    local function createHolder(p3) -- Line: 23
        local Part = Instance.new("Part");
        Part.CFrame = CFrame.new(0, 0, 0);
        Part.Anchored = true;
        Part.Transparency = 1;
        Part.CanCollide = false;
        Part.CanQuery = false;
        Part.CanTouch = false;
        Part.Parent = workspace.Terrain;
        local Decal = Instance.new("Decal");
        Decal.Texture = p3;
        Decal.Parent = Part;
    end;

    local v4 = 0;

    for _, descendant in ReplicatedStorage:GetDescendants() do
        if v1[descendant.ClassName] and not v2[descendant.Texture] then
            v2[descendant.Texture] = true;
            createHolder(descendant.Texture);
            v4 = v4 + 1;

            if v4 == 15 then
                RunService.PreRender:Wait();
                v4 = 0;
            end;
        end;
    end;
end;