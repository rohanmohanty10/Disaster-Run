  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("Debris");
local _ = game.Lighting;
local Essentials = require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
local u1 = { "Torso", "Left Arm", "Right Arm", "Left Leg", "Right Leg" };

return function(p2) -- Line: 20
    -- upvalues: Essentials (copy), VfxManager (copy), u1 (copy), TweenService (copy)
    local Char = p2.Char;
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    local u3 = script.RUN:Clone();
    u3.Parent = workspace.Debris;
    u3.CFrame = HumanoidRootPart.CFrame * CFrame.new(0.299, -0.212, -1.174);
    Essentials:Weld(HumanoidRootPart, u3);
    VfxManager.Enable(u3, true);
    task.delay(0.7, function() -- Line: 29
        -- upvalues: VfxManager (ref), u3 (copy)
        VfxManager.Enable(u3, false);
    end);
    task.delay(3, u3.Destroy, u3);
    local script_Aura = script.Aura;
    local u4 = {};

    for _, v in u1 do
        local v5 = Char:FindFirstChild(v);

        if v5 then
            for _, child in script_Aura:GetChildren() do
                local u6 = child:Clone();
                u6.Parent = v5;
                u4[u6] = u6;
                u6.Enabled = true;
                task.delay(0.7, function() -- Line: 47
                    -- upvalues: u6 (ref)
                    u6.Enabled = false;
                end);
            end;
        end;
    end;

    for _, child in script.Head:GetChildren() do
        local v7 = child:Clone();
        v7.Parent = Char:FindFirstChild("Head");

        if v7:IsA("Attachment") then
            VfxManager.Emit(v7);

            for _, descendant in v7:GetDescendants() do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                    TweenService:Create(descendant, TweenInfo.new(1), {
                        Width1 = 0
                    }):Play();
                    task.delay(1, function() -- Line: 63
                        -- upvalues: descendant (copy)
                        descendant.Enabled = false;
                    end);
                end;
            end;
        elseif v7:IsA("ParticleEmitter") then
            v7:Emit(v7:GetAttribute("EmitCount") or 5);
        end;
    end;

    task.delay(3, function() -- Line: 73
        -- upvalues: u4 (copy)
        for _, v in u4 do
            v:Destroy();
        end;
    end);
end;