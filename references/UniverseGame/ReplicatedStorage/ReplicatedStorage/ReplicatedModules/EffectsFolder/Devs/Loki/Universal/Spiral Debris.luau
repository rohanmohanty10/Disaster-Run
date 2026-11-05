  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("Players");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(ReplicatedStorage.ClientLibrary.Fusion);
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(ReplicatedStorage.ReplicatedModules.Types);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(Knit.Util.Trove);
Random.new();
local u1 = RaycastParams.new();
u1.FilterDescendantsInstances = { workspace.Map };
u1.FilterType = Enum.RaycastFilterType.Include;
local u2 = Random.new();

local function u5(p3, p4) -- Line: 55
    -- upvalues: u2 (copy)
    return u2:NextNumber(p3, p4);
end;

local function UseNumber(p6) -- Line: 59
    -- upvalues: u5 (copy)
    if typeof(p6) == "number" then
        return p6;
    end;

    return typeof(p6) ~= "NumberRange" and 0 or u5(p6.Min, p6.Max);
end;

return function(p7, u8) -- Line: 69
    -- upvalues: Trove (copy), u2 (copy), ParticleHandler (copy), u5 (copy), u1 (copy), RunService (copy), UseNumber (copy)
    local Center = u8.Center;

    if Center then
        local u9 = {};
        local u10 = u8.RequiresGround or false;
        local u11 = Trove.new();
        local Folder = Instance.new("Folder");
        Folder.Name = "SpiralDebris";
        local u12 = {
            Center = Center
        };
        local Radius = u8.Radius;

        if typeof(Radius) ~= "number" then
            Radius = typeof(Radius) ~= "NumberRange" and 0 or u2:NextNumber(Radius.Min, Radius.Max);
        end;

        u12.Radius = Radius or 35;
        u12.Speed = u8.AxisSpeed or NumberRange.new(1, 4);
        u12.PullSpeed = u8.PullSpeed or NumberRange.new(40, 60);
        u12.Rate = u8.Rate or 0.1;
        u12.Trove = u11;
        u12.Holder = Folder;

        function u12.Destroy(u13) -- Line: 95
            -- upvalues: u11 (copy)
            u11:Destroy();
            task.defer(function() -- Line: 97
                -- upvalues: u13 (copy)
                table.clear(u13);
                table.freeze(u13);
            end);
        end;

        local function CreateEffect() -- Line: 104
            -- upvalues: u12 (copy), u2 (ref), ParticleHandler (ref), Center (copy), u5 (ref), Folder (copy), u1 (ref), u8 (copy), u10 (copy), u9 (copy)
            local Radius2 = u12.Radius;

            if typeof(Radius2) ~= "number" then
                Radius2 = typeof(Radius2) ~= "NumberRange" and 0 or u2:NextNumber(Radius2.Min, Radius2.Max);
            end;

            local v14 = ParticleHandler.TranslateToPosition(Center);
            local Part = Instance.new("Part");
            Part.Size = Vector3.new(1, 1, 1);
            local v15 = u2:NextNumber(-Radius2, Radius2);
            Part.Position = v14 + vector.create(v15, 0, u5(-Radius2, Radius2));
            Part.Anchored = true;
            Part.Material = Enum.Material.Slate;
            Part.Color = Color3.new(0.4, 0.3, 0.2);
            Part.CanCollide = false;
            Part.Massless = true;
            Part.Parent = Folder;
            local Speed = u12.Speed;

            if typeof(Speed) ~= "number" then
                Speed = typeof(Speed) ~= "NumberRange" and 0 or u2:NextNumber(Speed.Min, Speed.Max);
            end;

            local PullSpeed = u12.PullSpeed;

            if typeof(PullSpeed) ~= "number" then
                PullSpeed = typeof(PullSpeed) ~= "NumberRange" and 0 or u2:NextNumber(PullSpeed.Min, PullSpeed.Max);
            end;

            local Magnitude = (Part.Position - v14).Magnitude;
            local v16 = math.atan2(Part.Position.Z - v14.Z, Part.Position.X - v14.X);
            local v17 = workspace:Raycast(Part.Position, Vector3.new(-0, -100, -0), u1);

            if v17 then
                Part.Position = v17.Position;
                Part.Material = v17.Instance.Material;
                Part.Color = v17.Instance.Color;
                local Size = Part.Size;
                local Scale = u8.Scale;

                if typeof(Scale) ~= "number" then
                    Scale = typeof(Scale) ~= "NumberRange" and 0 or u2:NextNumber(Scale.Min, Scale.Max);
                end;

                Part.Size = Size * Scale;

                for _, child in v17.Instance:GetChildren() do
                    if child:IsA("Decal") then
                        Instance.fromExisting(child).Parent = Part;
                    end;
                end;
            elseif u10 then
                Part:Destroy();

                return;
            end;

            table.insert(u9, {
                Elapsed = 0,
                Instance = Part,
                Center = Center,
                Speed = Speed,
                InwardSpeed = PullSpeed,
                InitialRadius = Magnitude,
                InitialAngle = v16,
                FloorY = v17 and v17.Position.Y or Part.Position.Y
            });
            local v18 = #u9 > 100 and table.remove(u9, 1);

            if v18 then
                v18.Instance:Destroy();
            end;
        end;

        local u19 = true;
        u11:Add(function() -- Line: 162
            -- upvalues: u19 (ref)
            u19 = false;
        end);
        local u20 = nil;
        u20 = RunService.Heartbeat:Connect(function(p21) -- Line: 166
            -- upvalues: u9 (copy), u20 (ref), ParticleHandler (ref), u19 (ref)
            for i = #u9, 1, -1 do
                local v22 = u9[i];

                if not (v22 and v22.Center) then
                    u20:Disconnect();

                    return;
                end;

                v22.Elapsed = v22.Elapsed + p21;
                local v23 = ParticleHandler.TranslateToPosition(v22.Center);
                local v24 = math.max(0, v22.InitialRadius - v22.InwardSpeed * v22.Elapsed);
                local v25 = v22.InitialAngle + v22.Elapsed * v22.Speed;
                local v26 = math.cos(v25) * v24;
                local v27 = math.sin(v25) * v24;
                local v28 = math.clamp(v22.Elapsed * v22.InwardSpeed / v22.InitialRadius, 0, 1);
                local v29 = v22.FloorY + (v23.Y - v22.FloorY) * v28;

                if v22.Instance and v22.Instance.Parent then
                    v22.Instance.CFrame = CFrame.new((Vector3.new(v23.X + v26, v29, v23.Z + v27))) * CFrame.Angles(v22.Elapsed * 10, v22.Elapsed * 5, v22.Elapsed * -3);
                end;

                if v24 <= 0.05 then
                    if v22.Instance then
                        v22.Instance:Destroy();
                    end;

                    table.remove(u9, i);

                    if not u19 and #u9 == 0 then
                        u20:Disconnect();
                    end;
                end;
            end;
        end);
        task.spawn(function() -- Line: 202
            -- upvalues: u19 (ref), CreateEffect (copy), UseNumber (ref), u12 (copy)
            while u19 do
                CreateEffect();
                task.wait(UseNumber(u12.Rate));
            end;
        end);
        Folder.Parent = workspace.Effects;
        u11:Add(function() -- Line: 211
            -- upvalues: Folder (copy)
            task.delay(1, function() -- Line: 212
                -- upvalues: Folder (ref)
                Folder:Destroy();
            end);
        end);

        return u12;
    end;
end;