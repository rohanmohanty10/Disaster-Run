  

 

local u1 = game.ReplicatedStorage["Client Assets"];
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local ParticleInfo = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleInfo);
local Particle = require(PathShortcuts.ReplicatedModules.Classes.Particle);
local Maid = require(game.ReplicatedStorage.ReplicatedModules.Maid);
local PathShortcuts2 = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local ParticleHandler = require(PathShortcuts2.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local Output = game.ReplicatedStorage.Remotes.Output;

return function(p2, ...) -- Line: 11
    -- upvalues: ParticleHandler (copy), u1 (copy), ParticleInfo (copy), Particle (copy), Maid (copy), Output (copy)
    local wait = task.wait;
    local delay = task.delay;

    local function emit(p3, p4) -- Line: 13
        for _, descendant in ipairs(p3:GetDescendants()) do
            if descendant.ClassName == "ParticleEmitter" then
                descendant:Emit(p4);
            end;
        end;
    end;

    ({
        Universal = function(p5, p6, p7) -- Line: 22
            -- upvalues: ParticleHandler (ref)
            local v8 = type(p7) == "table" and p7 and p7 or {};
            local v9 = (typeof(p5) == "CFrame" and p5 and p5 or p5[v8.Part or "HumanoidRootPart"].CFrame) * (v8.Offset or CFrame.new());
            local v10 = p6:Clone();
            local v11 = 1;

            for _, descendant in ipairs(v10:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") and v11 < descendant.Lifetime.Max then
                    v11 = descendant.Lifetime.Max;
                end;
            end;

            local v12 = ParticleHandler.GetUnusualHSVData({
                Character = p5
            });

            if v12 ~= nil then
                ParticleHandler.Unusualify(v10, {
                    HSVData = v12
                });
            end;

            v10.Anchored = true;
            v10.CanCollide = false;
            v10.CFrame = v9;
            v10.Parent = workspace.Effects;

            for _, descendant in ipairs(v10:GetDescendants()) do
                if descendant.ClassName == "ParticleEmitter" then
                    descendant:Emit(v8.Amount or (tonumber(descendant.Name) or 1));
                end;
            end;

            task.delay(v11 + 1, v10.Destroy, v10);
        end,

        MortalDash = function(u13, u14, p15) -- Line: 50
            -- upvalues: u1 (ref), ParticleHandler (ref), wait (copy), delay (copy)
            local u16 = u1.Yone.Dash:Clone();

            if p15 ~= nil then
                ParticleHandler.Unusualify(u16, {
                    HSVData = p15
                });
            end;

            u16.CFrame = u13.HumanoidRootPart.CFrame;
            u16.Parent = workspace.Effects;
            local u17 = os.clock();
            pcall(function() -- Line: 58
                -- upvalues: u17 (copy), u14 (copy), u16 (copy), u13 (copy), wait (ref)
                while os.clock() - u17 <= u14 do
                    u16.CFrame = u13.HumanoidRootPart.CFrame;
                    wait();
                end;
            end);

            for _, descendant in pairs(u16:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;

            delay(6, u16.Destroy, u16);
        end,

        CosmicDust = function(p18, p19) -- Line: 71
            -- upvalues: u1 (ref), wait (copy), delay (copy)
            local v20 = p19 or 3;
            local v21 = u1.Sol.CosmicDust:Clone();
            local ParticleEmitter = v21.Star.ParticleEmitter;
            local ParticleEmitter2 = v21.Area.ParticleEmitter;
            local ParticleEmitter3 = v21.Rain.ParticleEmitter;
            ParticleEmitter.Speed = NumberRange.new(15 / v20);
            v21.Rain.Position = Vector3.new(0, 15, 0);
            ParticleEmitter.Lifetime = NumberRange.new(v20);
            ParticleEmitter2.Lifetime = NumberRange.new(v20);
            v21.CFrame = p18.HumanoidRootPart.CFrame;
            v21.Parent = workspace.Effects;
            ParticleEmitter:Emit(1);
            ParticleEmitter2:Emit(1);
            wait(v20);
            ParticleEmitter3.Enabled = true;
            wait(0.25);
            ParticleEmitter3.Enabled = false;
            delay(1.5, v21.Destroy, v21);
        end,

        DawnEnchant = function(p22, p23, p24, p25) -- Line: 92
            -- upvalues: u1 (ref), ParticleHandler (ref), wait (copy), delay (copy)
            local v26 = u1.Dawn.DawnEnchant:Clone();
            local Attachment = v26.Attachment;
            v26.CFrame = p22.HumanoidRootPart.CFrame;
            v26.Parent = workspace.Effects;

            for i, v in pairs(p23) do
                Attachment[i].Color = ColorSequence.new(v);
            end;

            local v27 = ParticleHandler.GetSkinInfo(p25);
            local v28 = type(v27) == "table" and ((v27.Radiance or {}).HSVShift or (v27.Metadata or {}).HSVShift);

            if v28 then
                ParticleHandler.HSVShiftParticles(v26, v28);
            end;

            Attachment.Rain.Enabled = true;
            Attachment.Rain2.Enabled = true;
            Attachment.InnerSwirls.Enabled = true;
            Attachment.OuterSwirls.Enabled = true;
            wait(p24 or 1.5);
            Attachment.Wind:Emit(15);
            Attachment.Rain.Enabled = false;
            Attachment.Rain2.Enabled = false;
            Attachment.InnerSwirls.Enabled = false;
            Attachment.OuterSwirls.Enabled = false;
            delay(Attachment.InnerSwirls.Lifetime.Max + 1, v26.Destroy, v26);
        end,

        DawnWhirlingInferno = function(p29, p30, p31) -- Line: 125
            -- upvalues: ParticleInfo (ref), Particle (ref)
            local v32 = game.Players:GetPlayerFromCharacter(p29);
            local v33 = ParticleInfo.GetParticleInfo("DawnWhirl");

            if v32 then
                v32 = v32.Data.Skin:GetAttribute("SkinName");
            end;

            local u34 = Particle.new({
                Particle = v33.Object:Clone(),
                ParticleInfo = v33.ParticleInfo,
                SkinName = v32
            });
            u34:AttachTo(p29.HumanoidRootPart);
            local Left = u34:GetObject().Left;

            if v32 == "Dusk" then
                Left.inner.Color = ColorSequence.new(Color3.fromRGB(255, 85, 0));
                Left.background.Color = ColorSequence.new(Color3.new(1, 0, 0));
            end;

            for _, child in ipairs(Left:GetChildren()) do
                if child:IsA("Trail") then
                    child.Enabled = true;
                end;
            end;

            u34:Start();
            p31.AncestryChanged:Connect(function(p35, p36) -- Line: 162
                -- upvalues: Left (copy), u34 (copy)
                if not p36 then
                    Left.inner.Enabled = false;
                    Left.background.Enabled = false;
                    u34:Destroy();
                end;
            end);
        end,

        DawnTrueBlaze = function(u37, p38, p39) -- Line: 171
            -- upvalues: Maid (ref), u1 (ref), Output (ref), delay (copy)
            local u40 = Maid.new();
            local v41 = u1.Dawn.ChargeCount:Clone();
            local tl = v41.bg.tl;
            tl.UIGradient.Color = ColorSequence.new(p38.UIColor);
            v41.CFrame = u37.HumanoidRootPart.CFrame;
            v41.Parent = workspace.Effects;
            local u42 = u1.Dawn.TrueBlaze:Clone();
            local Attachment = u42.Attachment;
            u42.CFrame = u37.HumanoidRootPart.CFrame;
            u42.Parent = workspace.Effects;

            for i, v in pairs(p38) do
                if u42:FindFirstChild(i) then
                    u42[i].Color = ColorSequence.new(v);
                elseif Attachment:FindFirstChild(i) then
                    Attachment[i].Color = ColorSequence.new(v);
                end;
            end;

            local function changeParticle(p43) -- Line: 192
                -- upvalues: tl (copy), Attachment (copy), u42 (copy), Output (ref), u37 (copy)
                tl.Text = p43;

                if p43 ~= 2 then
                    if p43 == 3 then
                        Attachment.Lines.Enabled = true;
                        Attachment.Lines2.Enabled = true;
                        u42.Fire.Enabled = true;
                        u42.Rocks.Enabled = true;
                        Attachment.Flare.Enabled = true;
                        Attachment.Fillingsmoke.Enabled = false;
                        Attachment.Fillingsmoke2.Enabled = true;
                        Attachment.Shock.Enabled = false;
                        Attachment.Shock2.Enabled = true;
                        Attachment.Shock3.Enabled = true;
                        Attachment.Swirls.Enabled = true;
                        Attachment.OuterSwirls2.Enabled = false;
                        Attachment.OuterSwirls3.Enabled = true;
                        Output:FireServer(u37, "FX", "CameraShake", "Extreme");
                    end;

                    return;
                end;

                Attachment.InnerSwirls.Enabled = true;
                Attachment.OuterSwirls.Enabled = true;
                Attachment.OuterSwirls2.Enabled = true;
                Attachment.Fillingsmoke.Enabled = true;
                u42.Fire2.Enabled = true;
                u42.Fire.Enabled = true;
                u42.Rocks.Enabled = true;
            end;

            Attachment.Shock.Enabled = true;
            u42.Dots.Enabled = true;
            changeParticle(p39.Value);
            u40:GiveTask(v41);
            u40:GiveTask(u37.AncestryChanged:Connect(function() -- Line: 228
                -- upvalues: u37 (copy), u40 (copy), u42 (copy)
                if u37.Parent then
                    return;
                end;

                u40:Destroy();
                pcall(u42.Destroy, u42);
            end));
            u40:GiveTask(p39.Changed:Connect(changeParticle));
            u40:GiveTask(p39.AncestryChanged:Connect(function(p44, p45) -- Line: 235
                -- upvalues: u40 (copy), u42 (copy), delay (ref), Attachment (copy)
                if not p45 then
                    u40:Destroy();

                    for _, descendant in ipairs(u42:GetDescendants()) do
                        if descendant:IsA("ParticleEmitter") then
                            descendant.Enabled = false;
                        end;
                    end;

                    delay(Attachment.InnerSwirls.Lifetime.Max + 1, u42.Destroy, u42);
                end;
            end));
        end
    })[p2](...);
end;