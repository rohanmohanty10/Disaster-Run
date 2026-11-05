  

 

local Petal = require(game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedModules"):WaitForChild("Petal"));
local u1 = Petal("New");
Petal("Util");
game:GetService("Debris");
local RunService = game:GetService("RunService");
local CollectionService = game:GetService("CollectionService");
local new = Vector3.new;
local new2 = CFrame.new;
local Angles = CFrame.Angles;

return function(u2, u3) -- Line: 13
    -- upvalues: u1 (copy), new2 (copy), Angles (copy), RunService (copy), new (copy), CollectionService (copy)
    if not (u3 and (u3:IsA("Sound") and u3.IsPlaying)) then
        return;
    end;

    local Stand = u2.Stand;
    local u4 = u1("Part")({
        CanCollide = false,
        CanTouch = false,
        Size = Vector3.new(0.05, 1, 1),
        Shape = Enum.PartType.Cylinder,
        Material = Enum.Material.Neon,
        Color = Color3.new(0, 0, 0),
        Parent = workspace.Effects,
        Children = { u1("SpecialMesh")({
                Name = "Mesh",
                MeshType = Enum.MeshType.Cylinder
            }) }
    });
    local Mesh = u4.Mesh;
    u1("Weld")({
        Part0 = u4,
        Part1 = u2.HumanoidRootPart,
        Parent = u4,
        C0 = new2(-2.955, 0, 0) * Angles(0, 0, 1.5707963267948966)
    });
    local Color = Stand.Glow.Color;
    local Volume = u3.Volume;

    if u3:FindFirstChildOfClass("DistortionSoundEffect") then
        Volume = Volume + Volume * u3:FindFirstChildOfClass("DistortionSoundEffect").Level;
    end;

    local u5 = 0;
    local u6 = nil;
    u6 = RunService.RenderStepped:Connect(function() -- Line: 47
        -- upvalues: u5 (ref), Mesh (copy), u3 (copy), Volume (ref), new (ref), u4 (copy), Stand (copy), u2 (copy), CollectionService (ref), Color (copy), u6 (ref)
        u5 = u5 + 3;

        if u5 >= 359 then
            u5 = 1;
        end;

        Mesh.Scale = new(0, u3.PlaybackLoudness / (50 / Volume), u3.PlaybackLoudness / (50 / Volume));
        u4.Color = Color3.fromHSV(u5 / 360, 0.85, 1);
        Stand.Glow.Color = u4.Color;
        Stand.Muzzle.Color = u4.Color;

        if not (u2 and (Mesh and (u3 and (u4 and (u3.IsPlaying and CollectionService:HasTag(u2, "Posing")))))) then
            if u4 then
                u4:Destroy();
            end;

            if Stand then
                Stand.Glow.Color = Color;
                Stand.Muzzle.Color = Color;
            end;

            u6:Disconnect();
        end;
    end);
end;