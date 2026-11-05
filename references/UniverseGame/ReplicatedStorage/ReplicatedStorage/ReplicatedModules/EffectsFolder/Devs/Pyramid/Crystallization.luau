  

 

local TweenService = game:GetService("TweenService");
local Debris = game:GetService("Debris");
local RunService = game:GetService("RunService");
local CollectionService = game:GetService("CollectionService");

local function audio(p1, p2, p3, p4, p5) -- Line: 6
    local Sound = Instance.new("Sound", p5);
    Sound.SoundId = "rbxassetid://" .. p1;
    Sound.Volume = p2 or 0.5;
    Sound.TimePosition = p3 or 0;
    Sound.Looped = p4 or false;
    Sound.RollOffMaxDistance = 60;
    Sound.RollOffMinDistance = 5;
    Sound.RollOffMode = Enum.RollOffMode.InverseTapered;

    return Sound;
end;

return function(u6) -- Line: 18
    -- upvalues: RunService (copy), CollectionService (copy), TweenService (copy), Debris (copy)
    local function wait(p7) -- Line: 19
        -- upvalues: RunService (ref), CollectionService (ref), u6 (copy)
        local v8 = 0;
        local v9 = p7 or 0;

        while true do
            v8 = v8 + RunService.Heartbeat:Wait();

            if CollectionService:HasTag(u6, "Timestopped") then
                repeat
                    CollectionService:GetInstanceRemovedSignal("Timestopped"):Wait();
                until not CollectionService:HasTag(u6, "Timestopped");
            end;

            if v9 <= v8 or not CollectionService:HasTag(u6, "CrystalTrapped") then
                return v8;
            end;
        end;
    end;

    local u10 = game.ReplicatedStorage["Client Assets"].Omnitrix.Crystal:Clone();
    u10.Parent = workspace.Effects;
    u10.Size = Vector3.new(5, 20, 5);
    u10.CFrame = u6.PrimaryPart.CFrame * CFrame.new(0, -2, 0) * CFrame.new(0, -u10.Size.Y, 0);
    TweenService:Create(u10, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
        CFrame = u10.CFrame * CFrame.new(0, u10.Size.Y, 0)
    }):Play();
    coroutine.wrap(function() -- Line: 39
        -- upvalues: wait (copy), u10 (copy), u6 (copy), Debris (ref), TweenService (ref)
        wait(2);
        u10:Destroy();
        local Sound = Instance.new("Sound", u6.PrimaryPart);
        Sound.SoundId = "rbxassetid://" .. 7077537409;
        Sound.Volume = 1;
        Sound.TimePosition = 0;
        Sound.Looped = false;
        Sound.RollOffMaxDistance = 60;
        Sound.RollOffMinDistance = 5;
        Sound.RollOffMode = Enum.RollOffMode.InverseTapered;
        Sound:Play();
        Debris:AddItem(Sound, Sound.TimeLength + 0.25);

        for i = 1, 40 do
            local v11 = game.ReplicatedStorage["Client Assets"].Omnitrix.Crystal:Clone();
            v11.Parent = workspace.Effects;
            v11.Size = Vector3.new(0.5, 1.5, 0.5);
            local v12 = u6.PrimaryPart.CFrame * CFrame.new(0, -1, 0);
            local Angles = CFrame.Angles;
            local v13 = i * 18 + math.random(-20, 20);
            v11.CFrame = v12 * Angles(0, math.rad(v13), 0);
            v11.Anchored = false;
            local v14 = v11.CFrame.LookVector * (50 - math.random(5, 20));
            local v15 = 80 - math.random(0, 30);
            v11.Velocity = v14 + Vector3.new(0, v15, 0);
            local BodyAngularVelocity = Instance.new("BodyAngularVelocity", v11);
            local v16 = math.random(0, 360);
            local v17 = math.random(0, 360);
            BodyAngularVelocity.AngularVelocity = Vector3.new(v16, v17, math.random(0, 360));
            TweenService:Create(v11, TweenInfo.new(1, Enum.EasingStyle.Exponential), {
                Transparency = 1
            }):Play();
            Debris:AddItem(v11, 1);
        end;
    end)();

    for _ = 1, 4 do
        local u18 = game.ReplicatedStorage["Client Assets"].Omnitrix.Crystal:Clone();
        u18.Parent = workspace.Effects;
        u18.Size = Vector3.new(3, 8, 3);
        u18.CFrame = u6.PrimaryPart.CFrame * CFrame.new(0, -2, 0) * CFrame.new(0, -u18.Size.Y, 0);
        local v19 = math.random(-20, 20);
        local v20 = math.random(-20, 20);
        u18.Orientation = Vector3.new(v19, v20, math.random(-20, 20));
        TweenService:Create(u18, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
            CFrame = u18.CFrame * CFrame.new(0, u18.Size.Y, 0)
        }):Play();
        coroutine.wrap(function() -- Line: 65
            -- upvalues: wait (copy), u18 (copy)
            wait(2);
            u18:Destroy();
        end)();
    end;
end;