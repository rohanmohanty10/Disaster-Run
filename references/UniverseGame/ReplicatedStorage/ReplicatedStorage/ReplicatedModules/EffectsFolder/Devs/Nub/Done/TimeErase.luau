  

 

local CollectionService = game:GetService("CollectionService");
local CurrentCamera = workspace.CurrentCamera;
local LocalPlayer = game:GetService("Players").LocalPlayer;
local u1 = game:GetService("ReplicatedStorage")["Client Assets"];
local TweenService = game:GetService("TweenService");
local CameraShaker = require(game:GetService("ReplicatedStorage").ClientModules.CameraShaker);
local wrap = coroutine.wrap;
local Lighting = game:GetService("Lighting");

return function(u2, u3, p4) -- Line: 10
    -- upvalues: CollectionService (copy), CameraShaker (copy), CurrentCamera (copy), u1 (copy), LocalPlayer (copy), TweenService (copy), wrap (copy), Lighting (copy)
    local wait = task.wait;
    local new = CFrame.new;
    local Angles = CFrame.Angles;
    local rad = math.rad;
    local random = math.random;
    local u5 = CollectionService;
    local v6 = CameraShaker;
    local u7 = CurrentCamera;
    local u8 = u1.Umbra:FindFirstChild("clone"):Clone();
    local v9 = game.ReplicatedStorage["Client Assets"]["King Crimson"].TimeSkipEffect:Clone();
    v9.Parent = LocalPlayer.PlayerGui;
    v9.LocalScript.Disabled = false;
    wait(0.15);
    local v11 = v6.new(Enum.RenderPriority.Camera.Value, function(p10) -- Line: 24
        -- upvalues: u7 (copy)
        u7.CFrame = u7.CFrame * p10;
    end);
    v11:Start();
    v11:Shake(v6.Presets.LongerExplosion2);
    local u12 = Vector3.new();
    local v13 = {};

    for _, v in pairs({ game.Workspace.Map, game.Workspace.ItemSpawns }) do
        for _, descendant in ipairs(v:GetDescendants()) do
            if descendant:IsA("BasePart") then
                if (descendant.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 50 and descendant.Size.Magnitude < 150 then
                    v13[descendant] = descendant.Transparency;
                    local _ = descendant.Transparency;
                    local u14 = descendant:Clone();
                    u14.Parent = descendant.Parent;
                    u14.Anchored = true;
                    u14.CanCollide = false;
                    TweenService:Create(u14, TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        CFrame = u14.CFrame * Angles(rad((random(-360, 360))), rad((random(-360, 360))), (rad((random(-360, 360))))) * new(random(-50, 50), random(-25, 25), random(-25, 25))
                    }):Play();
                    descendant.Transparency = 1;
                    coroutine.wrap(function() -- Line: 47
                        -- upvalues: wait (copy), TweenService (ref), u14 (copy), u12 (copy)
                        wait(0.15);
                        TweenService:Create(u14, TweenInfo.new(0.55, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                            Size = u12
                        }):Play();
                        wait(0.55);
                        u14:Destroy();
                    end)();
                else
                    v13[descendant] = descendant.Transparency;
                    descendant.Transparency = 1;
                end;
            elseif descendant:IsA("Texture") or descendant:IsA("Decal") then
                v13[descendant] = descendant.Transparency;
                descendant.Transparency = 1;
            end;
        end;
    end;

    if p4 then
        local PhysicsService = game:GetService("PhysicsService");

        local function find(p15, p16) -- Line: 68
            for _, child in ipairs(p15:GetChildren()) do
                if (child.Name == p16 or child.Name:find(p16)) and child:IsA("BasePart") then
                    return child;
                end;
            end;
        end;

        for _, v in pairs(p4) do
            local v17 = v[1];
            local v18 = v[2];
            v17.Archivable = true;
            local u19 = v17:Clone();
            u19.HumanoidRootPart.CFrame = v17.HumanoidRootPart.CFrame;
            local CFrame2 = u19.HumanoidRootPart.CFrame;
            local u20 = v17:Clone();
            local _ = u20.HumanoidRootPart;
            u20.HumanoidRootPart.Anchored = true;
            u20.HumanoidRootPart.CFrame = v18;

            if workspace:FindFirstChild("1v1Mode") then
                PhysicsService:SetPartCollisionGroup(u20.HumanoidRootPart, "Map");
            else
                PhysicsService:SetPartCollisionGroup(u20.HumanoidRootPart, "TimeErase");
            end;

            if u20:FindFirstChild("Stand") then
                u20.Stand:Destroy();
            end;

            if u19:FindFirstChild("Stand") then
                u19.Stand:Destroy();
            end;

            for _, descendant in ipairs(u20:GetDescendants()) do
                if descendant:IsA("BasePart") and descendant.Name ~= "HumanoidRootPart" then
                    descendant.Transparency = 0.5;

                    if workspace:FindFirstChild("1v1Mode") then
                        PhysicsService:SetPartCollisionGroup(descendant, "Map");
                    else
                        PhysicsService:SetPartCollisionGroup(descendant, "TimeErase");
                    end;
                end;
            end;

            u5:RemoveTag(u20, "Hitable");
            u5:RemoveTag(u19, "Hitable");
            u19.Parent = workspace.Effects;
            u20.Parent = workspace.Effects;
            local Animation = Instance.new("Animation");
            Animation.AnimationId = "rbxassetid://6707573199";
            u19.Humanoid.WalkSpeed = (u20.HumanoidRootPart.CFrame.Position - u19.HumanoidRootPart.CFrame.Position).Magnitude / u3;
            u19.Humanoid:LoadAnimation(Animation):Play(nil, nil, 0.5);
            u19.Humanoid:MoveTo(u20.HumanoidRootPart.CFrame.Position, u20.HumanoidRootPart);
            u19.Humanoid:ChangeState(11);
            wrap(function() -- Line: 121
                -- upvalues: wait (copy), u5 (copy), u2 (copy), u19 (copy), CFrame2 (copy), u20 (copy), u8 (copy), find (copy), u3 (copy)
                local insert = table.insert;
                local v21 = 0;
                local v22 = {};

                while true do
                    v21 = v21 + wait(1);

                    if u5:HasTag(u2, "RTZ") then
                        u19.Humanoid:MoveTo(CFrame2);
                    else
                        u19.Humanoid:MoveTo(u20.HumanoidRootPart.CFrame.Position, u20.HumanoidRootPart);
                    end;

                    local v23 = u8:Clone();
                    insert(v22, v23);
                    v23.Parent = workspace.Effects;

                    for _, child in ipairs(v23:GetChildren()) do
                        local v24 = find(u19, child.Name);

                        if v24 then
                            child.CFrame = v24.CFrame;

                            if u5:HasTag(u2, "RTZ") then
                                child.Color = Color3.new(0, 1, 0);
                            else
                                child.Color = Color3.new(1, 0, 0);
                            end;

                            child.Transparency = 0.7;
                        end;
                    end;

                    if not u5:HasTag(u2, "TimeErase") or u3 < v21 then
                        u20:Destroy();
                        u19:Destroy();

                        for _, v2 in ipairs(v22) do
                            v2:Destroy();
                        end;

                        return;
                    end;
                end;
            end)();
            v17.Archivable = false;
        end;
    end;

    local _TESKY = game.Lighting:FindFirstChild("_TESKY");

    if not _TESKY then
        _TESKY = Instance.new("Folder");
        _TESKY.Name = "_TESKY";
        _TESKY.Parent = game.Lighting;
    end;

    for _, child in pairs(game.Lighting:GetChildren()) do
        if child:IsA("Sky") then
            child.Parent = _TESKY;
        end;
    end;

    local v25 = {
        [Lighting] = {
            Ambient = Lighting.Ambient
        }
    };
    local Atmosphere = game.Lighting:FindFirstChild("Atmosphere");

    if Atmosphere then
        v25[Atmosphere] = {
            Density = Atmosphere.Density,
            Glare = Atmosphere.Glare,
            Haze = Atmosphere.Haze
        };
        Atmosphere.Density = 0;
        Atmosphere.Glare = 0;
        Atmosphere.Haze = 0;
    end;

    local DefaultSunRays = game.Lighting:FindFirstChild("DefaultSunRays");

    if DefaultSunRays then
        v25[DefaultSunRays] = {
            Enabled = DefaultSunRays.Enabled
        };
        DefaultSunRays.Enabled = false;
    end;

    game.ReplicatedStorage["Client Assets"].Galaxy:Clone().Parent = game.Lighting;
    game.Lighting.Ambient = Color3.fromRGB(170, 0, 255);
    local Character = LocalPlayer.Character;
    local v26 = Character and Character.Humanoid.Health <= Character.Humanoid.MaxHealth * 0.35 and Character:FindFirstChild("TimeEraseAmbientPanic", true) or Character:FindFirstChild("TimeEraseAmbient", true);
    local v27;

    if v26 then
        v27 = v26:Clone();
        v27.Parent = workspace.Effects;
        v27:Play();
    else
        v27 = nil;
    end;

    local v28 = 0;

    repeat
        v28 = v28 + wait();
    until not u5:HasTag(u2, "TimeErase") or u3 < v28;

    for i, v in pairs(v13) do
        i.Transparency = v;
    end;

    game.Lighting.Galaxy:Destroy();
    game.Lighting.DefaultSunRays.Enabled = true;

    for i, v in v25 do
        for i2, v2 in v do
            pcall(function() -- Line: 218
                -- upvalues: i (copy), i2 (copy), v2 (copy)
                i[i2] = v2;
            end);
        end;
    end;

    table.clear(v25);

    if _TESKY then
        for _, child in pairs(_TESKY:GetChildren()) do
            child.Parent = game.Lighting;
        end;

        _TESKY:Destroy();
    end;

    if v27 then
        v27:Destroy();
    end;

    local v29 = game.ReplicatedStorage["Client Assets"]["King Crimson"].TimeSkipEffect:Clone();
    (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("TimeEraseEnd", true) or game.workspace.GameMusic.TEEND):Play();

    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("TimeEraseEndVoiceline", true) then
        LocalPlayer.Character:FindFirstChild("TimeEraseEndVoiceline", true):Play();
    end;

    v29.Parent = LocalPlayer.PlayerGui;
    v29.LocalScript.Disabled = false;
end;