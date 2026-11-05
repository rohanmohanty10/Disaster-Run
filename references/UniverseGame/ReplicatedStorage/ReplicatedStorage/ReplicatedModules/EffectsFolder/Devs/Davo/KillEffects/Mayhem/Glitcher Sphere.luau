  

 

local _ = game.ReplicatedStorage["Client Assets"];
local _ = game.Players.LocalPlayer;
local Petal = require(game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedModules"):WaitForChild("Petal"));
local u1 = Petal("New");
Petal("Util");
local Debris = game:GetService("Debris");
local _ = math.random;
game:GetService("RunService");
local new = Vector3.new;

return function(u2) -- Line: 13
    -- upvalues: u1 (copy), Debris (copy), new (copy)
    local u3 = u1("Part")({
        Anchored = true,
        CanCollide = false,
        CanTouch = false,
        FormFactor = 3,
        Name = "Ring",
        Size = Vector3.new(1, 1, 1),
        Transparency = 0,
        TopSurface = 0,
        BottomSurface = 0,
        Color = u2.Color,
        Material = Enum.Material.Neon,
        CFrame = u2.CFrame,
        Parent = workspace.Effects,
        Children = { u1("SpecialMesh")({
                Name = "Mesh",
                MeshType = Enum.MeshType.Sphere,
                Scale = u2.MeshSize
            }) }
    });
    local u4 = u3:FindFirstChildOfClass("SpecialMesh");
    local u5 = 1;

    if u2.Type == "Add" then
        u5 = 1 * u2.Value;
    elseif u2.Type == "Divide" then
        u5 = 1 / u2.Value;
    end;

    Debris:AddItem(u3, 10 / u2.Speed + 10);
    task.spawn(function() -- Line: 44
        -- upvalues: u2 (copy), u5 (ref), u3 (copy), u4 (copy), new (ref)
        for _ = 0, 10 / u2.Speed, 0.1 do
            task.wait();

            if u2.Type == "Add" then
                u5 = u5 - 0.01 * u2.Value / u2.Speed;
            elseif u2.Type == "Divide" then
                u5 = u5 - 0.01 / u2.Value * u2.Speed;
            end;

            local v6 = u3;
            v6.Transparency = v6.Transparency + 0.01 * u2.Speed;
            local v7 = u4;
            v7.Scale = v7.Scale + new(u5 * u2.Speed, u5 * u2.Speed, u5 * u2.Speed);
        end;

        u3:Destroy();
    end);
end;