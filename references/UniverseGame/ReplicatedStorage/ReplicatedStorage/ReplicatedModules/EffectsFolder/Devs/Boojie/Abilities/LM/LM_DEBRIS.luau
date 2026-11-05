  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.GenericModule);
local _ = PathShortcuts.ClientAssets;
local u1 = Random.new();

return function(p2) -- Line: 8
    -- upvalues: u1 (copy)
    local Part = (p2 or {}).Part;
    local v3 = 0;
    local u4 = {};
    local u5 = {};

    while Part and (Part:IsDescendantOf(workspace) and Part:GetAttribute("Active")) do
        if os.clock() - v3 >= Part:GetAttribute("Rate") then
            v3 = os.clock();
            local v6 = Part:GetAttribute("Max");

            for _ = 1, Part:GetAttribute("Amount") do
                if v6 > #u4 then
                    task.spawn(function() -- Line: 27
                        -- upvalues: Part (copy), u1 (ref), u4 (copy), u5 (copy)
                        local v7 = Part:GetAttribute("Size");
                        local v8 = CFrame.new(Part.Position);
                        local Angles = CFrame.Angles;
                        local v9 = u1:NextNumber(-360, 360);
                        local v10 = v8 * Angles(0, math.rad(v9), 0) * CFrame.new(0, 0, -u1:NextNumber(0, v7));
                        local v11 = RaycastParams.new();
                        v11.FilterType = Enum.RaycastFilterType.Include;
                        v11.FilterDescendantsInstances = { workspace.Map };
                        local v12 = workspace:Raycast(v10.Position, Vector3.new(0, -v7, 0), v11);

                        if not (v12 and v12.Instance) then
                            return;
                        end;

                        local Part2 = Instance.new("Part");
                        local v13 = u1:NextNumber(1.5, 5);
                        local v14 = u1:NextNumber(1.5, 5);
                        Part2.Size = Vector3.new(v13, v14, u1:NextNumber(1.5, 5)) * Part:GetAttribute("Scale");
                        local v15 = CFrame.new(v12.Position);
                        local Angles2 = CFrame.Angles;
                        local v16 = u1:NextNumber(-360, 360);
                        local v17 = math.rad(v16);
                        local v18 = u1:NextNumber(-360, 360);
                        local v19 = math.rad(v18);
                        local v20 = u1:NextNumber(-360, 360);
                        Part2.CFrame = v15 * Angles2(v17, v19, (math.rad(v20)));
                        Part2.Color = v12.Instance.Color;
                        Part2.Material = v12.Instance.Material;
                        Part2.Transparency = v12.Instance.Transparency;
                        Part2.CanCollide = true;
                        Part2.CollisionGroup = "FX";
                        Part2.Parent = workspace.Effects;
                        table.insert(u4, Part2);
                        local Attachment = Instance.new("Attachment");
                        Attachment.Parent = Part2;
                        local v21 = v7 / 2;
                        local Attachment2 = Instance.new("Attachment");
                        local v22 = u1:NextNumber(-v21, v21);
                        local v23 = u1:NextNumber(-v21, v21);
                        Attachment2.Position = Vector3.new(v22, v23, u1:NextNumber(-v21, v21));
                        Attachment2.Parent = Part;
                        local AlignPosition = Instance.new("AlignPosition");
                        AlignPosition.Attachment0 = Attachment;
                        AlignPosition.Attachment1 = Attachment2;
                        AlignPosition.Responsiveness = 75;
                        AlignPosition.MaxForce = 40000;
                        AlignPosition.MaxVelocity = (1 / 0);
                        AlignPosition.Parent = Part2;
                        local BodyAngularVelocity = Instance.new("BodyAngularVelocity");
                        BodyAngularVelocity.MaxTorque = Vector3.new(100000, 100000, 100000);
                        local v24 = u1:NextNumber(-7.5, 7.5);
                        local v25 = u1:NextNumber(-7.5, 7.5);
                        BodyAngularVelocity.AngularVelocity = Vector3.new(v24, v25, u1:NextNumber(-7.5, 7.5));
                        BodyAngularVelocity.Parent = Part2;
                        table.insert(u5, Attachment2);
                    end);
                end;
            end;
        end;

        task.wait();
    end;

    for _, v in pairs(u5) do
        v:Destroy();
    end;

    table.clear(u5);

    for _, v in pairs(u4) do
        v.AlignPosition:Destroy();
        v.BodyAngularVelocity:Destroy();
        local BodyVelocity = Instance.new("BodyVelocity");
        BodyVelocity.MaxForce = Vector3.new(400000, 400000, 400000);
        BodyVelocity.Velocity = u1:NextUnitVector() * u1:NextNumber(72, 128);
        BodyVelocity.Parent = v;
        task.delay(0.1, function() -- Line: 95
            -- upvalues: BodyVelocity (copy)
            BodyVelocity:Destroy();
        end);
        task.delay(u1:NextNumber(3, 4), function() -- Line: 99
            -- upvalues: v (copy)
            game:GetService("TweenService"):Create(v, TweenInfo.new(2.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                Transparency = 1
            }):Play();
            task.wait(2.5);
            v:Destroy();
        end);
    end;
end;