  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("Debris");
ReplicatedStorage:FindFirstChild("ReplicatedModules");
local u1 = ReplicatedStorage:FindFirstChild("Client Assets");
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(Knit.Util.Trove);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local SoundGroups = require(PathShortcuts.ReplicatedModules:WaitForChild("SoundGroups"));

return function(p2, p3, p4) -- Line: 20
    -- upvalues: Trove (copy), u1 (copy), ParticleHandler (copy), SoundGroups (copy)
    if not (p2 and p2:IsDescendantOf(workspace)) then
        return;
    end;

    if type(p3) ~= "table" then
        return;
    end;

    local HumanoidRootPart = p2:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    local v5 = Trove.new();
    v5:AttachToInstance(p2);
    local Attachment = Instance.new("Attachment", HumanoidRootPart);
    v5:Add(Attachment);
    local _ = p3.CFrame;
    local Duration = p3.Duration;

    if typeof(Duration) ~= "number" then
        return;
    end;

    local u6 = (p4 and (u1.Sol:FindFirstChild(p4) and (u1.Sol[p4]:FindFirstChild("SolMagicCircle", true) and u1.Sol[p4])) or u1.Sol).SolMagicCircle:Clone();
    v5:Add(u6);
    local v7 = ParticleHandler.GetUnusualHSVData({
        Character = p2
    });

    if v7 ~= nil then
        ParticleHandler.Unusualify(u6, {
            HSVData = v7
        });
    end;

    u6.CanCollide = false;
    u6.Anchored = false;
    u6.Parent = workspace.Effects;
    SoundGroups:AssignSoundTag(u6.Sound.Loop);
    u6.Sound.Loop:Play();

    for _, child in ipairs(u6.Summon:GetChildren()) do
        if child:IsA("ParticleEmitter") then
            child:Emit(child:GetAttribute("EmitCount"));
        end;
    end;

    task.delay(0.2, function() -- Line: 63
        -- upvalues: u6 (copy)
        for _, descendant in ipairs(u6:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;
    end);
    local u9 = game:GetService("RunService").RenderStepped:Connect(function(p8) -- Line: 70
        -- upvalues: u6 (copy), HumanoidRootPart (copy)
        u6.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -2.975, 0) * CFrame.Angles(0.00008726646259971648, 0, 0);
    end);
    v5:Add(function() -- Line: 74
        -- upvalues: u9 (copy)
        u9:Disconnect();
    end);
    task.delay(Duration, function() -- Line: 78
        -- upvalues: u6 (copy), Attachment (copy), u9 (copy)
        for _, child in ipairs(u6.Desummon:GetChildren()) do
            if child:IsA("ParticleEmitter") then
                child:Emit(child:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in ipairs(u6:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;

        task.delay(2.5, u6.Destroy, u6);
        task.delay(2.5, Attachment.Destroy, Attachment);
        task.delay(2.5, u9.Disconnect, u9);
    end);
end;