  

 

local _ = game.ReplicatedStorage["Client Assets"];
local _ = game.Players.LocalPlayer;
local Petal = require(game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedModules"):WaitForChild("Petal"));
local u1 = Petal("New");
Petal("Util");
local Debris = game:GetService("Debris");
local _ = math.random;
game:GetService("RunService");
local wait = task.wait;
local new = Vector3.new;

return function(u2) -- Line: 15
    -- upvalues: u1 (copy), Debris (copy), wait (copy), new (copy)
    local u3 = u1("Part")({
        Anchored = true,
        CanCollide = false,
        CanTouch = false,
        FormFactor = 3,
        Name = "Block",
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
                MeshType = Enum.MeshType.Brick,
                Scale = u2.MeshSize
            }) }
    });
    local u4 = u3:FindFirstChildOfClass("SpecialMesh");
    local u5 = 1;
    local u6 = u2.Speed / 10;

    if u2.Type == "Add" then
        u5 = 1 * u2.Value;
    elseif u2.Type == "Divide" then
        u5 = 1 / u2.Value;
    end;

    Debris:AddItem(u3, 10 / u2.BonusSpeed + 10);
    task.spawn(function() -- Line: 47
        -- upvalues: u2 (copy), wait (ref), u5 (ref), u6 (ref), u3 (copy), u4 (copy), new (ref)
        for _ = 0, 10 / u2.BonusSpeed, 0.1 do
            wait();

            if u2.Type == "Add" then
                u5 = u5 - 0.01 * u2.Value / u2.BonusSpeed;
            elseif u2.Type == "Divide" then
                u5 = u5 - 0.01 / u2.Value * u2.BonusSpeed;
            end;

            u6 = u6 - 0.01 * u2.Speed * u2.BonusSpeed / 10;
            local v7 = u3;
            v7.CFrame = v7.CFrame + u3.CFrame.LookVector * u6 * u2.BonusSpeed;
            local v8 = u4;
            v8.Scale = v8.Scale - new(u5 * u2.BonusSpeed, u5 * u2.BonusSpeed, u5 * u2.BonusSpeed);
        end;

        u3:Destroy();
    end);
end;