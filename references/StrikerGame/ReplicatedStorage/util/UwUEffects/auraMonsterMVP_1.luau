 
 

return {
    [1] = function(p1) -- Line: 2
        for _, descendant in ipairs(p1.Camera.camera.Lines:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end,

    [0] = function(p2) -- Line: 11
        for _, descendant in ipairs(p2.Camera.camera.Main:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
                descendant:Clear();
            end;
        end;
    end,

    [3.8] = function(p3) -- Line: 21
        for _, descendant in ipairs(p3.Character["Left Leg"].One:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
            end;
        end;
    end,

    [8.6] = function(p4) -- Line: 29
        for _, descendant in ipairs(p4.Character["Left Leg"].One:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
            end;
        end;
    end,

    [16.25] = function(p5) -- Line: 37
        for _, descendant in ipairs(p5.Character.Head.Eye:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
            end;
        end;
    end,

    [1.48] = function(p6) -- Line: 45
        for _, descendant in ipairs(p6.Camera.camera.Lines:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
                descendant:Clear();
            end;
        end;
    end,

    [1.52] = function(p7) -- Line: 55
        for _, descendant in ipairs(p7.Camera.camera.Main:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end,

    [4.25] = function(p8) -- Line: 63
        for _, descendant in ipairs(p8.Character["Right Leg"].One:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
            end;
        end;
    end,

    [9.17] = function(p9) -- Line: 71
        for _, descendant in ipairs(p9.Character["Right Leg"].One:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
            end;
        end;
    end,

    [1.5] = function(p10) -- Line: 79
        for _, descendant in ipairs(p10.Character["Right Leg"].One:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
            end;
        end;
    end,

    [13.8] = function(p11) -- Line: 87
        for _, descendant in ipairs(p11.Character["Right Leg"].Two2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
            end;
        end;
    end,

    [4.87] = function(p12) -- Line: 95
        for _, descendant in ipairs(p12.Camera.camera.Main.BG.Attachment:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
            end;
        end;
    end,

    [2.38] = function(p13) -- Line: 103
        for _, descendant in ipairs(p13.Character["Right Leg"].One:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
            end;
        end;
    end,

    [13.48] = function(p14) -- Line: 111
        for _, descendant in ipairs(p14.Character["Right Leg"].Two:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
            end;
        end;
    end,

    [1.95] = function(p15) -- Line: 119
        for _, descendant in ipairs(p15.Character["Left Leg"].One:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
            end;
        end;
    end,

    [11.22] = function(p16) -- Line: 127
        for _, descendant in ipairs(p16.Character["Right Leg"].One:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
            end;
        end;
    end,

    [5.67] = function(p17) -- Line: 135
        for _, descendant in ipairs(p17.Character["Left Leg"].One:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
            end;
        end;
    end,

    [12.17] = function(p18) -- Line: 143
        for _, descendant in ipairs(p18.Character["Right Leg"].One:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
            end;
        end;
    end,

    [10.53] = function(p19) -- Line: 151
        for _, descendant in ipairs(p19.Character["Left Leg"].One:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
            end;
        end;
    end,

    [12.83] = function(p20) -- Line: 159
        for _, descendant in ipairs(p20.Character["Left Leg"].Two:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
            end;
        end;
    end,

    [2.82] = function(p21) -- Line: 167
        for _, descendant in ipairs(p21.Character["Left Leg"].One:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
            end;
        end;
    end,

    [11.55] = function(p22) -- Line: 175
        for _, descendant in ipairs(p22.Character["Left Leg"].One:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
            end;
        end;
    end,

    [8.13] = function(p23) -- Line: 183
        for _, descendant in ipairs(p23.Character["Right Leg"].One:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
            end;
        end;
    end,

    [10.08] = function(p24) -- Line: 191
        for _, descendant in ipairs(p24.Character["Right Leg"].One:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
            end;
        end;
    end,

    [9.67] = function(p25) -- Line: 199
        for _, descendant in ipairs(p25.Character["Left Leg"].One:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
            end;
        end;
    end,

    [7.18] = function(p26) -- Line: 207
        for _, descendant in ipairs(p26.Character["Right Leg"].One:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
            end;
        end;
    end,

    [5.3] = function(p27) -- Line: 215
        for _, descendant in ipairs(p27.Character["Right Leg"].One:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
            end;
        end;
    end,

    [6.25] = function(p28) -- Line: 223
        for _, descendant in ipairs(p28.Character["Right Leg"].One:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
            end;
        end;
    end,

    [4.73] = function(p29) -- Line: 231
        for _, descendant in ipairs(p29.Character["Left Leg"].One:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
            end;
        end;
    end,

    [6.65] = function(p30) -- Line: 239
        for _, descendant in ipairs(p30.Character["Left Leg"].One:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
            end;
        end;
    end,

    [7.65] = function(p31) -- Line: 247
        for _, descendant in ipairs(p31.Character["Left Leg"].One:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
            end;
        end;
    end,

    [3.33] = function(p32) -- Line: 255
        for _, descendant in ipairs(p32.Character["Right Leg"].One:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
            end;
        end;
    end,

    [9.53] = function(p33) -- Line: 263
        for _, descendant in ipairs(p33.Camera.camera.Main.BG.Attachment:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
            end;
        end;
    end
};