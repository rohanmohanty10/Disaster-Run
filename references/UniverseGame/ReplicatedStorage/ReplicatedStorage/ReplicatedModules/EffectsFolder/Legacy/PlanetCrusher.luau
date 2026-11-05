  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);

return function(p1, p2, p3) -- Line: 6
    -- upvalues: ReplicatedStorage (copy), ParticleHandler (copy), TweenService (copy)
    local v4 = p3 or {};
    local Size = v4.Size;
    local DelayTime = v4.DelayTime;
    local Speed = v4.Speed;
    local SkinName = v4.SkinName;
    local Shift = v4.Shift;
    local u5 = ReplicatedStorage["Client Assets"].Assets.Abilities.Broly.PlanetCrusher:Clone();
    u5.Parent = workspace.Effects;
    u5.CFrame = CFrame.new(p1, p2);

    if SkinName == "Cucumber" then
        u5.Color = Color3.fromRGB(255, 0, 0);
    end;

    if Shift then
        u5.Color = ParticleHandler.HSVShift(u5.Color, Shift);
        u5.Inner.Color = ParticleHandler.HSVShift(u5.Inner.Color, Shift);

        for _, child in pairs(u5:GetChildren()) do
            if child:IsA("ParticleEmitter") then
                child.Color = ParticleHandler.HSVShift(child.Color, Shift);
            end;
        end;
    end;

    coroutine.wrap(function() -- Line: 32
        -- upvalues: DelayTime (copy), Speed (copy), u5 (copy)
        for _ = 1, (DelayTime + Speed + 1) * 10 do
            pcall(function() -- Line: 34
                -- upvalues: u5 (ref)
                for _, child in pairs(u5:GetChildren()) do
                    if child:IsA("ParticleEmitter") then
                        local v6 = { NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, u5.Size.X * 0.75) };
                        child.Size = NumberSequence.new(v6);
                    end;
                end;

                wait(0.1);
            end);
        end;
    end)();
    TweenService:Create(u5, TweenInfo.new(DelayTime, Enum.EasingStyle.Linear), {
        Size = u5.Size * Size
    }):Play();
    TweenService:Create(u5.Inner, TweenInfo.new(DelayTime, Enum.EasingStyle.Linear), {
        Size = u5.Inner.Size * Size
    }):Play();
    wait(DelayTime);
    TweenService:Create(u5, TweenInfo.new(Speed, Enum.EasingStyle.Linear), {
        CFrame = CFrame.new(p2)
    }):Play();
    wait(Speed);
    TweenService:Create(u5, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
        Size = u5.Size * 1.1
    }):Play();
    TweenService:Create(u5.Inner, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
        Size = u5.Inner.Size * 1.1
    }):Play();
    wait(0.1);
    TweenService:Create(u5, TweenInfo.new(0.7, Enum.EasingStyle.Elastic), {
        Size = u5.Size / 20
    }):Play();
    TweenService:Create(u5.Inner, TweenInfo.new(0.7, Enum.EasingStyle.Elastic), {
        Size = u5.Inner.Size / 20
    }):Play();
    wait(0.5);
    u5:Destroy();
end;