  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("UserInputService");
game:GetService("RunService");
local Debris = game:GetService("Debris");
local Essentials = require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Controllers.SpectatorController);

local function tweenAwayBeam(p1: userdata, p2: number) -- Line: 13
    -- upvalues: TweenService (copy)
    TweenService:Create(p1, TweenInfo.new(p2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Width0 = 0,
        Width1 = 0
    }):Play();
end;

return function(p3) -- Line: 18
    -- upvalues: VfxManager (copy), tweenAwayBeam (copy), Debris (copy), Essentials (copy)
    local Char = p3.Char;
    local Type = p3.Type;
    local PlayerFromCharacter = game.Players:GetPlayerFromCharacter(Char);
    local _ = p3.Remove;

    if Type == "Domain" then
        local u4 = script.Domain:Clone();
        u4.Parent = workspace.Debris;
        VfxManager.Enable(u4, true);
        local v5 = game["Run Service"].Heartbeat:Connect(function() -- Line: 33
            -- upvalues: u4 (copy), Char (copy)
            u4:PivotTo(Char.HumanoidRootPart.CFrame);
        end);
        local v6;

        if game.Players.LocalPlayer == PlayerFromCharacter then
            local v7 = workspace.PenaltyArea:FindFirstChild(PlayerFromCharacter.Team.Name);
            v6 = script.SixthSense:Clone();
            v6.CFrame = v7.CFrame;
            v6.Parent = workspace.Debris;
        else
            v6 = nil;
        end;

        repeat
            task.wait();
        until not (Char and (Char:FindFirstChild("HumanoidRootPart") and (Char:FindFirstChild("Humanoid") and (Char:GetAttribute("SixthSense") and (PlayerFromCharacter.Parent and Char.Parent)))));

        for _, child in workspace.Debris:GetChildren() do
            if child:GetAttribute("WarningAIKU") then
                for _, descendant in child:GetDescendants() do
                    if descendant:IsA("Beam") then
                        tweenAwayBeam(descendant, 0.2);
                    elseif descendant:IsA("ParticleEmitter") then
                        descendant.Enabled = false;
                    end;
                end;

                Debris:AddItem(child, 1);
            end;
        end;

        v5:Disconnect();
        task.wait(1);

        for _, descendant in u4:GetDescendants() do
            if descendant:IsA("Beam") then
                tweenAwayBeam(descendant, 0.2);
            elseif descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        if v6 then
            for _, descendant in v6:GetDescendants() do
                if descendant:IsA("Beam") then
                    tweenAwayBeam(descendant, 0.2);
                elseif descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end;

        task.wait(1);
        u4:Destroy();

        if v6 then
            v6:Destroy();
        end;
    elseif Type == "Ball" then
        local Ball = p3.Ball;
        local FX = p3.FX;
        FX.CFrame = Ball.CFrame;
        FX.Anchored = false;
        Essentials:Weld(FX, Ball);
    end;
end;