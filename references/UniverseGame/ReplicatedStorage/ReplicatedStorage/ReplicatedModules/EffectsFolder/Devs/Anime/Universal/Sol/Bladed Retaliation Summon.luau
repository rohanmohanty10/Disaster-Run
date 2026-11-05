  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local u1 = ReplicatedStorage:FindFirstChild("Client Assets");
local TweenService = game:GetService("TweenService");
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local SoundGroups = require(game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedModules"):WaitForChild("SoundGroups"));

return function(p2) -- Line: 8
    -- upvalues: u1 (copy), ParticleHandler (copy), SoundGroups (copy), TweenService (copy)
    local Delay = p2.Delay;
    local Time = p2.Time;
    local Easing = p2.Easing;
    local EasingDirection = p2.EasingDirection;
    local Target = p2.Target;
    local LookV = p2.LookV;
    local Vector = p2.Vector;

    if Target and Target:FindFirstChild("HumanoidRootPart") then
        local HumanoidRootPart = Target.HumanoidRootPart;
        local u3 = u1.Sol["Sol Sword"]:Clone();

        if p2.HSVData ~= nil then
            ParticleHandler.Unusualify(u3, {
                IncludeParts = true,
                HSVData = p2.HSVData
            });
        end;

        local Handle = u3.ModelVFXHere.Handle;
        Handle.CFrame = HumanoidRootPart.CFrame * CFrame.new(Handle.CFrame.LookVector * -LookV + Vector);
        Handle.CFrame = CFrame.lookAt(Handle.Position, HumanoidRootPart.Position);
        u3.Parent = game:GetService("Workspace").Effects;
        SoundGroups:AssignSoundTag(Handle.Summon);
        Handle.Summon:Play();
        game:GetService("Debris"):AddItem(u3, 2);
        local v4 = next;
        local v5, v6 = Handle.Summon:GetChildren();

        for _, v in v4, v5, v6 do
            if v:IsA("ParticleEmitter") then
                v:Emit(v:GetAttribute("EmitCount"));
            end;
        end;

        task.wait(Delay);
        TweenService:Create(Handle, TweenInfo.new(Time, Easing, EasingDirection), {
            CFrame = Handle.CFrame * CFrame.new(0, 0, LookV + 1)
        }):Play();
        task.delay(Time / 1.2, function() -- Line: 28
            -- upvalues: u3 (copy), Handle (copy)
            for _, descendant in ipairs(u3:GetDescendants()) do
                task.spawn(function() -- Line: 30
                    -- upvalues: descendant (copy)
                    if descendant:IsA("BasePart") then
                        descendant.Transparency = 1;
                    end;
                end);
            end;

            local v7 = next;
            local v8, v9 = Handle.Explode:GetChildren();

            for _, v in v7, v8, v9 do
                if v:IsA("ParticleEmitter") then
                    v:Emit(v:GetAttribute("EmitCount"));
                end;
            end;
        end);
    end;
end;