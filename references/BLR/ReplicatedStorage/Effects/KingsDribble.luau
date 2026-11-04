  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("RunService");
local Debris = game:GetService("Debris");
local Essentials = require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);

return function(u1) -- Line: 11
    -- upvalues: ReplicatedStorage (copy), Essentials (copy), SoundManager (copy), TweenService (copy), VfxManager (copy), Debris (copy)
    local Torso = u1.Humrp.Parent.Torso;
    local u2 = ReplicatedStorage.Assets.Vfx.Chops.ChopsFloorTrail:Clone();
    u2.Parent = Torso;
    u2.CFrame = Torso.CFrame * CFrame.new(0, -3, 0);
    Essentials:Weld(u2, Torso);
    local u3 = ReplicatedStorage.Assets.Vfx.KingsDribble.RunPlr:Clone();
    u3.Parent = Torso;
    u3.CFrame = Torso.CFrame;
    Essentials:Weld(u3, Torso);
    local u4 = SoundManager.SpawnSound("KingDribble", 1, Torso, 100, false, true);
    u4:Play();
    tick();

    local function finish() -- Line: 31
        -- upvalues: TweenService (ref), u4 (copy), VfxManager (ref), u2 (copy), u3 (copy), u1 (copy)
        local u5 = TweenService:Create(u4, TweenInfo.new(0.25), {
            Volume = 0
        });
        u5:Play();
        VfxManager.Enable(u2, false);
        VfxManager.Enable(u3, false);
        task.delay(0.25, function() -- Line: 38
            -- upvalues: u4 (ref), u5 (copy), u2 (ref), u3 (ref)
            u4:Destroy();
            u5:Destroy();
            u2:Destroy();
            u3:Destroy();
        end);
        table.clear(u1);
    end;

    for i = 1, 3 do
        if u1.Humrp.Parent.Values.HasBall.Value == false then
            finish();

            return;
        end;

        local v6 = ReplicatedStorage.Assets.Vfx.Chops.EmitChopStart:Clone();
        v6.Anchored = true;
        v6.Parent = workspace.Debris;
        v6.CFrame = Torso.CFrame;
        VfxManager.Emit(v6);
        Debris:AddItem(v6, 3);
        task.wait(0.32);
        local v7 = ReplicatedStorage.Assets.Vfx.Chops.EmitChopStart:Clone();
        v7.Anchored = true;
        v7.Parent = workspace.Debris;
        v7.CFrame = Torso.CFrame;
        VfxManager.Emit(v7);
        Debris:AddItem(v7, 3);
        local _ = i;
    end;

    finish();
end;