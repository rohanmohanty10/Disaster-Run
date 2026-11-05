  

 

local Petal = _G.Petal;
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local _ = Players.LocalPlayer;
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local u1 = Petal("New");
local Tween = Petal("Util").Tween;

local function _(p2, p3) -- Line: 13
    return Random.new():NextNumber(p2, p3);
end;

local _ = Instance.new;
local new = Vector3.new;
local new2 = CFrame.new;
local Angles = CFrame.Angles;

return function(p4) -- Line: 19
    -- upvalues: ParticleHandler (copy), u1 (copy), RunService (copy), new2 (copy), Angles (copy), new (copy), Tween (copy)
    local Reference = p4.Reference;
    local v5 = p4.DurationMultiplier or 1;

    if not (Reference.Parent and Reference) then
        return;
    end;

    local WorldPosition = Reference.WorldPosition;
    local v6 = ParticleHandler.GetUnusualHSVData({
        Player = p4.Player,
        Character = p4.Character
    });
    local v7 = Color3.fromRGB(135, 243, 255);
    local v8 = Color3.fromRGB(0, 174, 255);

    if v6 ~= nil then
        v7 = ParticleHandler.HSVShift(v7, v6);
        v8 = ParticleHandler.HSVShift(v8, v6);
    end;

    local v9 = u1("Part")({
        Anchored = true,
        CanCollide = false,
        Transparency = 2,
        Size = Vector3.new(0, 0, 0),
        Material = Enum.Material.Glass,
        Children = {
            SphereMesh = u1("SpecialMesh")({
                MeshType = Enum.MeshType.Cylinder
            })
        }
    });
    local u10 = u1("Model")({
        Name = "TheHandTrail",
        Parent = workspace.Effects,
        Children = {
            HighlightColor = u1("Highlight")({
                FillTransparency = 0.4,
                OutlineTransparency = 0.25,
                FillColor = v7,
                OutlineColor = v8,
                DepthMode = Enum.HighlightDepthMode.Occluded
            })
        }
    });

    while true do
        RunService.Heartbeat:Wait();

        if not Reference.Parent then
            break;
        end;

        if (Reference.WorldPosition - WorldPosition).Magnitude > 0.05 and (Reference:GetAttribute("Enabled") and Reference.Parent) then
            local u11 = v9:Clone();
            u11.CFrame = CFrame.lookAt(WorldPosition, Reference.WorldPosition) * new2(0, 0, -(Reference.WorldPosition - WorldPosition).Magnitude / 2) * Angles(0, 1.5707963267948966, 0);
            u11.Parent = u10;
            u11.Size = new((Reference.WorldPosition - WorldPosition).Magnitude, 1.75, 1.75);
            local v12 = v9:Clone();
            v12.SphereMesh.MeshType = Enum.MeshType.Sphere;
            v12.Size = Vector3.new(1.75, 1.75, 1.75);
            local v13 = v12:Clone();
            v12.Position = WorldPosition;
            v13.Position = Reference.WorldPosition;
            v12.Parent = u11;
            v13.Parent = u11;
            local v14 = Random.new():NextNumber(0.3, 0.4) * 2 * v5;
            Tween(u11, v14, "Quad", "InOut", {
                Transparency = 4,
                Size = new((Reference.WorldPosition - WorldPosition).Magnitude, 0, 0)
            });
            Tween(v12, v14, "Quad", "InOut", {
                Size = Vector3.new(0, 0, 0),
                Transparency = 4
            });
            Tween(v13, v14, "Quad", "InOut", {
                Size = Vector3.new(0, 0, 0),
                Transparency = 4
            });
            task.delay(v14, function() -- Line: 100
                -- upvalues: u11 (copy)
                u11:Destroy();
            end);
            WorldPosition = Reference.WorldPosition;
        end;
    end;

    task.delay(1 * v5, function() -- Line: 71
        -- upvalues: u10 (copy)
        u10:Destroy();
    end);
end;