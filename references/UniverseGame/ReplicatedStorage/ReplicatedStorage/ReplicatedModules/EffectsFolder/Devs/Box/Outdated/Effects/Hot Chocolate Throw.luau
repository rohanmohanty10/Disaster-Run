  

 

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

return function(u7, p8) -- Line: 28
    -- upvalues: Debris (copy), CreateInstance (copy), u1 (copy), SoundGroups (copy), TweenService (copy)
    local u9;

    if u7 then
        u9 = u7:FindFirstChild("HumanoidRootPart") or u7.PrimaryPart;
        u7:FindFirstChild("Humanoid");
    else
        u9 = nil;
    end;

    local u10 = RaycastParams.new();
    u10.FilterType = Enum.RaycastFilterType.Blacklist;

    local function Marshmellow(p11) -- Line: 39
        -- upvalues: Debris (ref), CreateInstance (ref)
        local u12 = p11:Clone();
        u12.Weld:Destroy();
        u12.Parent = workspace.Effects;
        Debris:AddItem(u12, 5.5);
        local v13 = CreateInstance("BodyVelocity", {
            MaxForce = Vector3.new(inf, inf, inf)
        });
        v13.Velocity = u12.CFrame.LookVector * -math.random(15, 25) + u12.CFrame.UpVector * math.random(5, 10);
        v13.Parent = u12;
        Debris:AddItem(v13, 0.15);
        coroutine.wrap(function() -- Line: 51
            -- upvalues: u12 (copy)
            task.wait(0.15);
            u12.CanCollide = true;
        end)();
    end;

    local Marshmellow1 = p8.Marshmellow1;
    local Marshmellow2 = p8.Marshmellow2;
    local Marshmellow3 = p8.Marshmellow3;
    coroutine.wrap(function() -- Line: 58
        -- upvalues: Marshmellow (copy), Marshmellow1 (copy), Marshmellow2 (copy), Marshmellow3 (copy)
        task.wait(0.05);
        Marshmellow(Marshmellow1);
        Marshmellow(Marshmellow2);
        Marshmellow(Marshmellow3);
        Marshmellow1:Destroy();
        Marshmellow2:Destroy();
        Marshmellow3:Destroy();
    end)();
    local u14 = false;

    for _ = 1, 10 do
        local u15 = u1["Candy Cutlass"].HotChocolate.CoffeeTrail:Clone();
        local v16 = u9.CFrame * CFrame.new(-1.75, 2, -1.75);
        local Angles = CFrame.Angles;
        local v17 = math.random(-5, 5);
        local v18 = math.rad(v17);
        local v19 = math.random(-5, 5);
        local v20 = math.rad(v19);
        local v21 = math.random(-5, 5);
        u15.CFrame = v16 * Angles(v18, v20, (math.rad(v21)));
        u15.Parent = workspace.Effects;
        Debris:AddItem(u15, 2);
        local v22 = CreateInstance("BodyVelocity", {
            MaxForce = Vector3.new(inf, inf, inf)
        });
        v22.Velocity = u15.CFrame.LookVector * math.random(15, 25) + u15.CFrame.UpVector * math.random(5, 10);
        v22.Parent = u15;
        Debris:AddItem(v22, 0.15);
        coroutine.wrap(function() -- Line: 81
            -- upvalues: u10 (copy), u15 (copy), u7 (copy), u1 (ref), u9 (ref), u14 (ref), CreateInstance (ref), SoundGroups (ref), Debris (ref), TweenService (ref)
            u10.FilterDescendantsInstances = { u15, workspace.Effects, u7 };
            local v23 = tick();
            local v24;

            repeat
                v24 = workspace:Raycast(u15.Position + Vector3.new(-0.01, -0.01, -0.01), (Vector3.new(-0.01, -0.01, -0.01)).Unit * 1.5, u10);
                task.wait();
            until v24 ~= nil or tick() - v23 > 1;

            local Position = u15.Position;
            u15.Anchored = true;
            coroutine.wrap(function() -- Line: 94
                -- upvalues: u15 (ref)
                task.wait(0.25);
                u15:Destroy();
            end)();

            if not v24 then
                u15:Destroy();

                return;
            end;

            local Instance2 = v24.Instance;

            if Instance2.Parent:FindFirstChild("Humanoid") or Instance2:FindFirstChild("HumanoidRootPart") then
                u15:Destroy();

                return;
            end;

            local v25 = u1["Candy Cutlass"].HotChocolate.CoffeePool:Clone();
            v25.Position = Vector3.new(Position.X, u9.Position.Y - 3, Position.Z);
            v25.Parent = workspace.Effects;

            if not u14 then
                u14 = true;
                local v26 = CreateInstance("Sound", {
                    SoundId = "rbxassetid://8398001441",
                    Volume = 1,
                    RollOffMaxDistance = 110,
                    RollOffMinDistance = 30,
                    RollOffMode = "InverseTapered",
                    Parent = v25
                });
                SoundGroups:AssignSoundTag(v26);
                v26:Play();
                Debris:AddItem(v26, 2);
            end;

            task.wait(0.05);
            local v27 = math.random(1, 2);
            TweenService:Create(v25, TweenInfo.new(0.75), {
                Size = Vector3.new(v27, 0, v27)
            }):Play();
            task.wait(5);
            TweenService:Create(v25, TweenInfo.new(0.5), {
                Transparency = 1
            }):Play();
            task.wait(0.6);
            v25:Destroy();
        end)();
    end;
end;