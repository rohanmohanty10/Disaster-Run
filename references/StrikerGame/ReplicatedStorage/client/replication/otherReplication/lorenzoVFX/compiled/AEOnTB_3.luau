 

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Util = require(ReplicatedStorage.util.Util);
local vfxUtil = require(ReplicatedStorage.util.vfxUtil);

return {
    { 0, function(p1, p2, p3, p4) -- Line: 8
            for _, descendant in pairs(p4:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") then
                    descendant.Enabled = true;
                end;
            end;

            for _, descendant in pairs(p3.FirstEff:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(p3.ThirdEff:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 15, function(p5, p6, p7, p8) -- Line: 27
            for _, descendant in pairs(p6.AceEater.Confused:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 27, function(p9, p10, p11, p12) -- Line: 36
            for _, descendant in pairs(p11.FirstEff:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 93, function(p13, p14, p15, p16) -- Line: 45
            for _, descendant in pairs(p15.TransitionAceEater:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 96, function(p17, p18, p19, p20) -- Line: 54
            for _, descendant in pairs(p19.TransitionAceEater:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 99, function(p21, p22, p23, p24) -- Line: 63
            for _, descendant in pairs(p23.TransitionAceEater:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 102, function(p25, p26, p27, p28) -- Line: 72
            for _, descendant in pairs(p27.TransitionAceEater:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 104, function(p29, p30, p31, p32) -- Line: 81
            for _, descendant in pairs(p30.AceEater.Two:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 180, function(p33, p34, p35, p36) -- Line: 90
            for _, descendant in pairs(p35.SecondEff:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(p35.ThirdEff:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;

            for _, descendant in pairs(p35.FirstEff:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;

            for _, descendant in pairs(p33.AceEaterEnable:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 214, function(p37, p38, p39, p40, p41, p42) -- Line: 115
            -- upvalues: vfxUtil (copy), Util (copy)
            vfxUtil.EzLeanHueTowardsColor(nil, p42, Util.Gif(p41, 24));
        end },
    { 228, function(p43, p44, p45, p46) -- Line: 121
            for _, descendant in pairs(p43.AceEaterEnable:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 234, function(p47, p48, p49, p50) -- Line: 130
            for _, descendant in pairs(p48.AceEater.Three:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;

            for _, descendant in pairs(p49.SecondEff:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;

            for _, descendant in pairs(p49.ThirdEff:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 300, function(p51, p52, p53, p54) -- Line: 149
            for _, descendant in pairs(p53.FirstEff:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(p53.SecondEff:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(p53.ThirdEff:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;
        end }
};