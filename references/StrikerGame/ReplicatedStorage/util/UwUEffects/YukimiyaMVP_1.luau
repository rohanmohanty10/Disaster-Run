 
 

game:GetService("TweenService");
game:GetService("Lighting");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Util = require(ReplicatedStorage.util.Util);

return {
    [2.184] = function(p1) -- Line: 8
        for _, descendant in pairs(p1.Effects.Footstep:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end,

    [4.586] = function(p2) -- Line: 16
        for _, descendant in pairs(p2.Effects.Footstep:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end,

    [5.484] = function(p3) -- Line: 24
        for _, descendant in pairs(p3.Effects.Drip:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end,

    [6.884] = function(p4) -- Line: 32
        -- upvalues: Util (copy), ReplicatedStorage (copy)
        Util.Gif(ReplicatedStorage.Resources.mvpAssets.yukimiyaMVP.ImpactFrames, 24);

        for _, descendant in pairs(p4.Effects.FinalPartvfx1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end
};