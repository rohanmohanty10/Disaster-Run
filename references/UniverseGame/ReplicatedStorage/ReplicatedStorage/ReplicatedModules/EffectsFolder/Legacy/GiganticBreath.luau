  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);

return function(p1, p2, p3) -- Line: 6
    -- upvalues: ReplicatedStorage (copy), ParticleHandler (copy), TweenService (copy)
    if p2 == true then
        local v4 = ReplicatedStorage["Client Assets"].Broly.GiganticBreath:Clone();
        local Start = v4.Start;
        local End = Start.End;
        local v5 = p3 or {};

        for _, descendant in pairs(Start:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Color = ParticleHandler.HSVShift(descendant.Color, v5);
            end;
        end;

        local Motor6D = Instance.new("Motor6D");
        Motor6D.Part0 = p1;
        Motor6D.Part1 = Start;
        Motor6D.C0 = CFrame.new(0, 1, -1);
        Motor6D.Parent = Start;
        v4.Parent = p1;

        for _, descendant in pairs(Start:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;

        TweenService:Create(End, TweenInfo.new(0.25, Enum.EasingStyle.Cubic), {
            C0 = CFrame.new(0, 0, -40)
        }):Play();
    end;

    if p2 == false then
        local GiganticBreath = p1:FindFirstChild("GiganticBreath");

        for _, descendant in pairs(GiganticBreath.Start:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            elseif descendant:IsA("Beam") then
                pcall(function() -- Line: 43
                    -- upvalues: TweenService (ref), descendant (copy)
                    TweenService:Create(descendant, TweenInfo.new(0.5, Enum.EasingStyle.Cubic), {
                        Width0 = 0,
                        Width1 = 0
                    }):Play();
                end);
            end;
        end;

        wait(0.5);
        GiganticBreath:Destroy();
    end;
end;