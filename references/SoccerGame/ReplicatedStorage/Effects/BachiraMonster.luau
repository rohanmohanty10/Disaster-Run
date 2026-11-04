  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Debris = game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.VfxManager);
local Popup = require(ReplicatedStorage.Shared.Popup);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);

return function(u1) -- Line: 10
    -- upvalues: ReplicatedStorage (copy), SoundManager (copy), TweenService (copy), Debris (copy), Popup (copy)
    local game_Workspace = game.Workspace;
    local SpawnPos = u1.SpawnPos;
    local BachiraAwakening = ReplicatedStorage.Assets.Vfx.BachiraAwakening;
    task.spawn(function() -- Line: 21
        -- upvalues: u1 (copy)
        u1.Plr.Character:WaitForChild("Bachira").Volume = 0.05;
    end);
    local InOut = Enum.EasingDirection.InOut;
    local _ = Enum.EasingStyle.Cubic;
    local Linear = Enum.EasingStyle.Linear;
    local u2 = BachiraAwakening.Ground:Clone();
    u2.Parent = game_Workspace;
    u2.Position = SpawnPos * CFrame.new(0, -3.1, 0).Position;
    local u3 = BachiraAwakening.Rise:Clone();
    u3.Parent = game_Workspace;
    u3.Position = SpawnPos * CFrame.new(0, -3.1, 0).Position;
    local u4 = BachiraAwakening.BlackRise:Clone();
    u4.Parent = game_Workspace;
    u4.Position = SpawnPos * CFrame.new(0, -3.1, -7).Position;
    local u5 = BachiraAwakening.RiseExplosion:Clone();
    u5.Parent = game_Workspace;
    u5.Position = SpawnPos * CFrame.new(0, -3.15, 0).Position;
    local u6 = BachiraAwakening.Finish:Clone();
    u6.Parent = game_Workspace;
    u6.Position = SpawnPos.Position + Vector3.new(0, 1, 0);
    SoundManager.SpawnSound("BachiraCutscene", 1, u6, 100);
    local Descendants = u1.Rnd:GetDescendants();

    local function EnableParticles(p7, u8) -- Line: 26
        local Descendants2 = p7:GetDescendants();

        for _, v in pairs(Descendants2) do
            if v:IsA("ParticleEmitter") then
                task.defer(function() -- Line: 30
                    -- upvalues: v (copy), u8 (copy)
                    v.Enabled = u8;
                end);
            end;
        end;

        table.clear(Descendants2);
    end;

    local function EmitParticles(p9) -- Line: 38
        local Descendants2 = p9:GetDescendants();

        for _, v in pairs(Descendants2) do
            if v:IsA("ParticleEmitter") then
                task.defer(function() -- Line: 42
                    -- upvalues: v (copy)
                    v:Emit(v:GetAttribute("EmitCount"));
                end);
            end;
        end;

        table.clear(Descendants2);
    end;

    for _, v in pairs(Descendants) do
        if v:IsA("Beam") then
            local v10 = TweenService:Create(v, TweenInfo.new(0.5, Linear, InOut), {
                Width0 = 2
            });
            v10:Play();
            Debris:AddItem(v10, 0.5);
            local v11 = TweenService:Create(v, TweenInfo.new(0.5, Linear, InOut), {
                Width1 = 10
            });
            v11:Play();
            Debris:AddItem(v11, 0.5);
        end;
    end;

    table.clear(Descendants);
    EnableParticles(u1.Rnd, true);
    EnableParticles(u4, true);
    task.wait(0.25);
    EmitParticles(u2);
    task.wait(2.5);
    EnableParticles(u4, false);
    task.spawn(function() -- Line: 110
        -- upvalues: Popup (ref)
        Popup.Subtitle(game.Players.LocalPlayer, "A \"Monster\"?");
    end);
    task.wait(1);
    EnableParticles(u3, true);
    EmitParticles(u5);
    task.wait(3);
    EmitParticles(u5);
    EnableParticles(u6, true);
    task.wait(1);
    EnableParticles(u6, false);
    task.wait(1);
    EnableParticles(u3, false);
    task.wait(2);
    task.spawn(function() -- Line: 143
        -- upvalues: u1 (copy)
        u1.Plr.Character:WaitForChild("Bachira").Volume = 0.5;
    end);
    local Descendants2 = u1.Rnd:GetDescendants();

    for _, v in pairs(Descendants2) do
        if v:IsA("Beam") then
            local v12 = TweenService:Create(v, TweenInfo.new(0.5, Linear, InOut), {
                Width0 = 0
            });
            v12:Play();
            Debris:AddItem(v12, 0.25);
            local v13 = TweenService:Create(v, TweenInfo.new(0.5, Linear, InOut), {
                Width1 = 0
            });
            v13:Play();
            Debris:AddItem(v13, 0.25);
        end;
    end;

    table.clear(Descendants2);
    EnableParticles(u1.Rnd, false);
    task.delay(8, function() -- Line: 164
        -- upvalues: u2 (copy), u3 (copy), u5 (copy), u6 (copy), u4 (copy)
        u2:Destroy();
        u3:Destroy();
        u5:Destroy();
        u6:Destroy();
        u4:Destroy();
    end);
end;