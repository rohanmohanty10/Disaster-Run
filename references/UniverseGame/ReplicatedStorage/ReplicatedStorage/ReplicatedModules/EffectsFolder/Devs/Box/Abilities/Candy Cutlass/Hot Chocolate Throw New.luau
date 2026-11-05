  

 

local Debris = game:GetService("Debris");
local u1 = game:GetService("ReplicatedStorage")["Client Assets"];
local TweenService = game:GetService("TweenService");
local SoundGroups = require(game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedModules"):WaitForChild("SoundGroups"));

local function CreateInstance(p2, p3) -- Line: 7
    local function CheckProperty(p4, p5) -- Line: 9
        local _ = p4[p5];
    end;

    local u6 = Instance.new(p2);
    local Parent = p3.Parent;
    p3.Parent = nil;

    for i, v in pairs(p3) do
        if pcall(function() -- Line: 18
            -- upvalues: u6 (copy), i (copy)
            local _ = u6[i];
        end) then
            u6[i] = v;
        end;
    end;

    u6.Parent = Parent;

    return u6;
end;

return function(u7) -- Line: 28
    -- upvalues: u1 (copy), Debris (copy), CreateInstance (copy), SoundGroups (copy), TweenService (copy)
    if u7 == nil then
        return;
    end;

    local u8;

    if u7 then
        u8 = u7:FindFirstChild("HumanoidRootPart") or u7.PrimaryPart;
        u7:FindFirstChild("Humanoid");
    else
        u8 = nil;
    end;

    if u8 == nil then
        return;
    end;

    local u9 = RaycastParams.new();
    u9.FilterType = Enum.RaycastFilterType.Exclude;
    local u10 = false;

    for _ = 1, 10 do
        local u11 = u1["Candy Cutlass"].HotChocolate.CoffeeTrail:Clone();
        local v12 = u8.CFrame * CFrame.new(-1, 2, -1.75);
        local Angles = CFrame.Angles;
        local v13 = math.random(-5, 5);
        local v14 = math.rad(v13);
        local v15 = math.random(-5, 5);
        local v16 = math.rad(v15);
        local v17 = math.random(-5, 5);
        u11.CFrame = v12 * Angles(v14, v16, (math.rad(v17)));
        u11.Parent = workspace.Effects;
        Debris:AddItem(u11, 2);
        local v18 = CreateInstance("BodyVelocity", {
            MaxForce = Vector3.new(inf, inf, inf)
        });
        v18.Velocity = u11.CFrame.LookVector * math.random(15, 25) + u11.CFrame.UpVector * math.random(5, 10);
        v18.Parent = u11;
        Debris:AddItem(v18, 0.15);
        task.spawn(function() -- Line: 54
            -- upvalues: u9 (copy), u11 (copy), u7 (copy), u1 (ref), u8 (ref), u10 (ref), CreateInstance (ref), SoundGroups (ref), Debris (ref), TweenService (ref)
            u9.FilterDescendantsInstances = { u11, workspace.Effects, u7 };
            local v19 = tick();
            local v20;

            repeat
                v20 = workspace:Raycast(u11.Position + Vector3.new(-0.01, -0.01, -0.01), (Vector3.new(-0.01, -0.01, -0.01)).Unit * 1.5, u9);
                task.wait();
            until v20 ~= nil or tick() - v19 > 1;

            local Position = u11.Position;
            u11.Anchored = true;
            task.spawn(function() -- Line: 67
                -- upvalues: u11 (ref)
                task.wait(0.25);
                u11:Destroy();
            end);

            if not v20 then
                u11:Destroy();

                return;
            end;

            local Instance2 = v20.Instance;

            if Instance2.Parent:FindFirstChild("Humanoid") or Instance2:FindFirstChild("HumanoidRootPart") then
                u11:Destroy();

                return;
            end;

            local v21 = u1["Candy Cutlass"].HotChocolate.CoffeePool:Clone();
            v21.Position = Vector3.new(Position.X, u8.Position.Y - 3, Position.Z);
            v21.Parent = workspace.Effects;

            if not u10 then
                u10 = true;
                local v22 = CreateInstance("Sound", {
                    SoundId = "rbxassetid://8398001441",
                    Volume = 1,
                    RollOffMaxDistance = 110,
                    RollOffMinDistance = 30,
                    RollOffMode = "InverseTapered",
                    Parent = v21
                });
                SoundGroups:AssignSoundTag(v22);
                v22:Play();
                Debris:AddItem(v22, 2);
            end;

            task.wait(0.05);
            local v23 = math.random(1, 2);
            TweenService:Create(v21, TweenInfo.new(0.75), {
                Size = Vector3.new(v23, 0, v23)
            }):Play();
            task.wait(5);
            TweenService:Create(v21, TweenInfo.new(0.5), {
                Transparency = 1
            }):Play();
            task.wait(0.6);
            v21:Destroy();
        end);
    end;
end;