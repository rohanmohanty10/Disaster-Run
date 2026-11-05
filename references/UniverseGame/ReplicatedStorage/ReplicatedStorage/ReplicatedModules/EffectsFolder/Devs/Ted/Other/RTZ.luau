  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CameraShaker = require(ReplicatedStorage.ClientModules:WaitForChild("CameraShaker"));
local CurrentCamera = workspace.CurrentCamera;
local u2 = CameraShaker.new(Enum.RenderPriority.Camera.Value, function(p1) -- Line: 5
    -- upvalues: CurrentCamera (copy)
    CurrentCamera.CFrame = CurrentCamera.CFrame * p1;
end);
local LocalPlayer = game.Players.LocalPlayer;
local TweenService = game:GetService("TweenService");
u2:Start();

return function(p3) -- Line: 12
    -- upvalues: u2 (copy), CameraShaker (copy), LocalPlayer (copy), TweenService (copy)
    local wait = task.wait;
    local new = CFrame.new;
    local Angles = CFrame.Angles;
    local rad = math.rad;
    local random = math.random;
    game:GetService("CollectionService");
    wait(0.15);
    u2:Shake(CameraShaker.Presets.LongerExplosion2);
    local u4 = Vector3.new();
    local v5 = {};

    for _, v in pairs({ game.Workspace.Map, game.Workspace.ItemSpawns }) do
        for _, descendant in ipairs(v:GetDescendants()) do
            if descendant:IsA("BasePart") then
                if (descendant.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 50 and descendant.Size.Magnitude < 150 then
                    v5[descendant] = descendant.Transparency;
                    local _ = descendant.Transparency;
                    local u6 = descendant:Clone();
                    u6.Parent = descendant.Parent;
                    u6.Anchored = true;
                    u6.CanCollide = false;
                    TweenService:Create(u6, TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        CFrame = u6.CFrame * Angles(rad((random(-360, 360))), rad((random(-360, 360))), (rad((random(-360, 360))))) * new(random(-50, 50), random(-25, 25), random(-25, 25))
                    }):Play();
                    descendant.Transparency = 1;
                    coroutine.wrap(function() -- Line: 38
                        -- upvalues: wait (copy), TweenService (ref), u6 (copy), u4 (copy)
                        wait(0.15);
                        TweenService:Create(u6, TweenInfo.new(0.55, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                            Size = u4
                        }):Play();
                        wait(0.55);
                        u6:Destroy();
                    end)();
                else
                    v5[descendant] = descendant.Transparency;
                    descendant.Transparency = 1;
                end;
            elseif descendant:IsA("Texture") or descendant:IsA("Decal") then
                v5[descendant] = descendant.Transparency;
                descendant.Transparency = 1;
            end;
        end;
    end;

    local _RTZSKY = game.Lighting:FindFirstChild("_RTZSKY");

    if not _RTZSKY then
        _RTZSKY = Instance.new("Folder");
        _RTZSKY.Name = "_RTZSKY";
        _RTZSKY.Parent = game.Lighting;
    end;

    for _, child in pairs(game.Lighting:GetChildren()) do
        if child:IsA("Sky") then
            child.Parent = _RTZSKY;
        end;
    end;

    game.Lighting.Atmosphere.Density = 0;
    game.Lighting.Atmosphere.Glare = 0;
    game.Lighting.Atmosphere.Haze = 0;
    game.Lighting.DefaultSunRays.Enabled = false;
    game.ReplicatedStorage["Client Assets"].Galaxy:Clone().Parent = game.Lighting;
    game.Lighting.Ambient = Color3.fromRGB(207, 194, 255);
    local v7 = 0;

    repeat
        v7 = v7 + wait();
    until p3 < v7;

    for i, v in pairs(v5) do
        i.Transparency = v;
    end;

    game.Lighting.Galaxy:Destroy();
    game.Lighting.Atmosphere.Density = 0.2;
    game.Lighting.Atmosphere.Glare = 2;
    game.Lighting.Atmosphere.Haze = 0;
    game.Lighting.DefaultSunRays.Enabled = true;
    game.Lighting.Ambient = Color3.fromRGB(165, 165, 165);

    if _RTZSKY then
        for _, child in pairs(_RTZSKY:GetChildren()) do
            child.Parent = game.Lighting;
        end;

        _RTZSKY:Destroy();
    end;
end;