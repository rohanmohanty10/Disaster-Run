 
 

return {
    { 0, function(p1, p2) -- Line: 3
            p1.HumanoidRootPart.StreetcatBillboard.Size = UDim2.new(12, 0, 7, 0);
            local TweenService = game:GetService("TweenService");
            local Top = p2.Top;
            Top.Position = UDim2.fromScale(1, 0);
            local Position = Top.Position;
            local TweenInfo_new_ret = TweenInfo.new(5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, -1, false);
            TweenService:Create(Top, TweenInfo_new_ret, {
                Position = Position - UDim2.fromScale(1, 0)
            }):Play();
            local Bottom = p2.Bottom;
            Bottom.Position = UDim2.fromScale(-1, 0.917);
            TweenService:Create(Bottom, TweenInfo_new_ret, {
                Position = Bottom.Position + UDim2.fromScale(1, 0)
            }):Play();

            for _, descendant in pairs(p1:GetDescendants()) do
                if descendant.Name == "StreetcatRecolor" or descendant.Name == "LyricsText" then
                    if descendant:IsA("TextLabel") then
                        descendant.TextColor3 = Color3.fromRGB(136, 86, 203);
                        descendant.TextStrokeColor3 = Color3.fromRGB(170, 85, 255);
                    end;

                    if descendant:IsA("ParticleEmitter") then
                        descendant.Color = ColorSequence.new(Color3.fromRGB(136, 86, 203));
                    end;

                    if descendant:IsA("Highlight") then
                        descendant.OutlineColor = Color3.fromRGB(170, 85, 255);
                        descendant.FillColor = Color3.fromRGB(136, 86, 203);
                    end;
                end;
            end;

            for _, descendant in pairs(p2:GetDescendants()) do
                if descendant.Name == "StreetcatRecolor" then
                    if descendant:IsA("TextLabel") then
                        descendant.TextColor3 = Color3.fromRGB(136, 86, 203);
                    end;

                    if descendant:IsA("ImageLabel") then
                        descendant.ImageColor3 = Color3.fromRGB(136, 86, 203);
                    end;
                end;
            end;

            local Top2 = p2.Top;
            local Bottom2 = p2.Bottom;
            Top2.Paras.Visible = true;
            Bottom2.Paras.Visible = true;
            Top2.Texts.Visible = false;
            Bottom2.Texts.Visible = false;
        end },
    { 84, function(p3, p4) -- Line: 60
            for _, descendant in pairs(p3:GetDescendants()) do
                if descendant.Name == "StreetcatRecolor" or descendant.Name == "LyricsText" then
                    if descendant:IsA("TextLabel") then
                        descendant.TextColor3 = Color3.fromRGB(216, 108, 105);
                        descendant.TextStrokeColor3 = Color3.fromRGB(170, 0, 0);
                    end;

                    if descendant:IsA("ParticleEmitter") then
                        descendant.Color = ColorSequence.new(Color3.fromRGB(216, 108, 105));
                    end;

                    if descendant:IsA("Highlight") then
                        descendant.OutlineColor = Color3.fromRGB(170, 0, 0);
                        descendant.FillColor = Color3.fromRGB(216, 108, 105);
                    end;
                end;
            end;

            for _, descendant in pairs(p4:GetDescendants()) do
                if descendant.Name == "StreetcatRecolor" then
                    if descendant:IsA("TextLabel") then
                        descendant.TextColor3 = Color3.fromRGB(216, 108, 105);
                    end;

                    if descendant:IsA("ImageLabel") then
                        descendant.ImageColor3 = Color3.fromRGB(216, 108, 105);
                    end;
                end;
            end;
        end },
    { 170, function(p5, p6) -- Line: 93
            for _, descendant in pairs(p5:GetDescendants()) do
                if descendant.Name == "StreetcatRecolor" or descendant.Name == "LyricsText" then
                    if descendant:IsA("TextLabel") then
                        descendant.TextColor3 = Color3.fromRGB(254, 214, 127);
                        descendant.TextStrokeColor3 = Color3.fromRGB(255, 170, 0);
                    end;

                    if descendant:IsA("ParticleEmitter") then
                        descendant.Color = ColorSequence.new(Color3.fromRGB(254, 214, 127));
                    end;

                    if descendant:IsA("Highlight") then
                        descendant.OutlineColor = Color3.fromRGB(255, 170, 0);
                        descendant.FillColor = Color3.fromRGB(254, 214, 127);
                    end;
                end;
            end;

            for _, descendant in pairs(p6:GetDescendants()) do
                if descendant.Name == "StreetcatRecolor" then
                    if descendant:IsA("TextLabel") then
                        descendant.TextColor3 = Color3.fromRGB(254, 214, 127);
                    end;

                    if descendant:IsA("ImageLabel") then
                        descendant.ImageColor3 = Color3.fromRGB(254, 214, 127);
                    end;
                end;
            end;
        end },
    { 256, function(p7, p8) -- Line: 126
            for _, descendant in pairs(p7:GetDescendants()) do
                if descendant.Name == "StreetcatRecolor" or descendant.Name == "LyricsText" then
                    if descendant:IsA("TextLabel") then
                        descendant.TextColor3 = Color3.fromRGB(123, 211, 123);
                        descendant.TextStrokeColor3 = Color3.fromRGB(0, 170, 0);
                    end;

                    if descendant:IsA("ParticleEmitter") then
                        descendant.Color = ColorSequence.new(Color3.fromRGB(123, 211, 123));
                    end;

                    if descendant:IsA("Highlight") then
                        descendant.OutlineColor = Color3.fromRGB(0, 170, 0);
                        descendant.FillColor = Color3.fromRGB(123, 211, 123);
                    end;
                end;
            end;

            for _, descendant in pairs(p8:GetDescendants()) do
                if descendant.Name == "StreetcatRecolor" then
                    if descendant:IsA("TextLabel") then
                        descendant.TextColor3 = Color3.fromRGB(123, 211, 123);
                    end;

                    if descendant:IsA("ImageLabel") then
                        descendant.ImageColor3 = Color3.fromRGB(123, 211, 123);
                    end;
                end;
            end;
        end },
    { 345, function(p9, p10) -- Line: 159
            for _, descendant in pairs(p9:GetDescendants()) do
                if descendant.Name == "StreetcatRecolor" or descendant.Name == "LyricsText" then
                    if descendant:IsA("TextLabel") then
                        descendant.TextColor3 = Color3.fromRGB(253, 185, 135);
                        descendant.TextStrokeColor3 = Color3.fromRGB(170, 85, 0);
                    end;

                    if descendant:IsA("ParticleEmitter") then
                        descendant.Color = ColorSequence.new(Color3.fromRGB(253, 185, 135));
                    end;

                    if descendant:IsA("Highlight") then
                        descendant.OutlineColor = Color3.fromRGB(170, 85, 0);
                        descendant.FillColor = Color3.fromRGB(253, 185, 135);
                    end;
                end;
            end;

            for _, descendant in pairs(p10:GetDescendants()) do
                if descendant.Name == "StreetcatRecolor" then
                    if descendant:IsA("TextLabel") then
                        descendant.TextColor3 = Color3.fromRGB(253, 185, 135);
                    end;

                    if descendant:IsA("ImageLabel") then
                        descendant.ImageColor3 = Color3.fromRGB(253, 185, 135);
                    end;
                end;
            end;
        end },
    { 432, function(p11, p12) -- Line: 192
            p11.HumanoidRootPart.StreetcatBillboard.Size = UDim2.new(12, 0, 7, 0);

            for _, descendant in pairs(p11:GetDescendants()) do
                if descendant.Name == "StreetcatRecolor" or descendant.Name == "LyricsText" then
                    if descendant:IsA("TextLabel") then
                        descendant.TextColor3 = Color3.fromRGB(136, 86, 203);
                        descendant.TextStrokeColor3 = Color3.fromRGB(170, 85, 255);
                    end;

                    if descendant:IsA("ParticleEmitter") then
                        descendant.Color = ColorSequence.new(Color3.fromRGB(136, 86, 203));
                    end;

                    if descendant:IsA("Highlight") then
                        descendant.OutlineColor = Color3.fromRGB(170, 85, 255);
                        descendant.FillColor = Color3.fromRGB(136, 86, 203);
                    end;
                end;
            end;

            for _, descendant in pairs(p12:GetDescendants()) do
                if descendant.Name == "StreetcatRecolor" then
                    if descendant:IsA("TextLabel") then
                        descendant.TextColor3 = Color3.fromRGB(136, 86, 203);
                    end;

                    if descendant:IsA("ImageLabel") then
                        descendant.ImageColor3 = Color3.fromRGB(136, 86, 203);
                    end;
                end;
            end;
        end },
    { 482, function(p13, p14) -- Line: 228
            p13.HumanoidRootPart.StreetcatBillboard.Size = UDim2.new(12, 0, 1, 0);
        end },
    { 516, function(p15, p16) -- Line: 233
            for _, descendant in pairs(p15:GetDescendants()) do
                if descendant.Name == "StreetcatRecolor" or descendant.Name == "LyricsText" then
                    if descendant:IsA("TextLabel") then
                        descendant.TextColor3 = Color3.fromRGB(216, 108, 105);
                        descendant.TextStrokeColor3 = Color3.fromRGB(170, 0, 0);
                    end;

                    if descendant:IsA("ParticleEmitter") then
                        descendant.Color = ColorSequence.new(Color3.fromRGB(216, 108, 105));
                    end;

                    if descendant:IsA("Highlight") then
                        descendant.OutlineColor = Color3.fromRGB(170, 0, 0);
                        descendant.FillColor = Color3.fromRGB(216, 108, 105);
                    end;
                end;
            end;

            for _, descendant in pairs(p16:GetDescendants()) do
                if descendant.Name == "StreetcatRecolor" then
                    if descendant:IsA("TextLabel") then
                        descendant.TextColor3 = Color3.fromRGB(216, 108, 105);
                    end;

                    if descendant:IsA("ImageLabel") then
                        descendant.ImageColor3 = Color3.fromRGB(216, 108, 105);
                    end;
                end;
            end;
        end },
    { 602, function(p17, p18) -- Line: 266
            for _, descendant in pairs(p17:GetDescendants()) do
                if descendant.Name == "StreetcatRecolor" or descendant.Name == "LyricsText" then
                    if descendant:IsA("TextLabel") then
                        descendant.TextColor3 = Color3.fromRGB(254, 214, 127);
                        descendant.TextStrokeColor3 = Color3.fromRGB(255, 170, 0);
                    end;

                    if descendant:IsA("ParticleEmitter") then
                        descendant.Color = ColorSequence.new(Color3.fromRGB(254, 214, 127));
                    end;

                    if descendant:IsA("Highlight") then
                        descendant.OutlineColor = Color3.fromRGB(255, 170, 0);
                        descendant.FillColor = Color3.fromRGB(254, 214, 127);
                    end;
                end;
            end;

            for _, descendant in pairs(p18:GetDescendants()) do
                if descendant.Name == "StreetcatRecolor" then
                    if descendant:IsA("TextLabel") then
                        descendant.TextColor3 = Color3.fromRGB(254, 214, 127);
                    end;

                    if descendant:IsA("ImageLabel") then
                        descendant.ImageColor3 = Color3.fromRGB(254, 214, 127);
                    end;
                end;
            end;
        end },
    { 688, function(p19, p20) -- Line: 299
            for _, descendant in pairs(p19:GetDescendants()) do
                if descendant.Name == "StreetcatRecolor" or descendant.Name == "LyricsText" then
                    if descendant:IsA("TextLabel") then
                        descendant.TextColor3 = Color3.fromRGB(123, 211, 123);
                        descendant.TextStrokeColor3 = Color3.fromRGB(0, 170, 0);
                    end;

                    if descendant:IsA("ParticleEmitter") then
                        descendant.Color = ColorSequence.new(Color3.fromRGB(123, 211, 123));
                    end;

                    if descendant:IsA("Highlight") then
                        descendant.OutlineColor = Color3.fromRGB(0, 170, 0);
                        descendant.FillColor = Color3.fromRGB(123, 211, 123);
                    end;
                end;
            end;

            for _, descendant in pairs(p20:GetDescendants()) do
                if descendant.Name == "StreetcatRecolor" then
                    if descendant:IsA("TextLabel") then
                        descendant.TextColor3 = Color3.fromRGB(123, 211, 123);
                    end;

                    if descendant:IsA("ImageLabel") then
                        descendant.ImageColor3 = Color3.fromRGB(123, 211, 123);
                    end;
                end;
            end;
        end },
    { 700, function(p21, p22) -- Line: 332
            p21.HumanoidRootPart.StreetcatBillboard.Size = UDim2.new(12, 0, 7, 0);
        end },
    { 777, function(p23, p24) -- Line: 337
            for _, descendant in pairs(p23:GetDescendants()) do
                if descendant.Name == "StreetcatRecolor" or descendant.Name == "LyricsText" then
                    if descendant:IsA("TextLabel") then
                        descendant.TextColor3 = Color3.fromRGB(253, 185, 135);
                        descendant.TextStrokeColor3 = Color3.fromRGB(170, 85, 0);
                    end;

                    if descendant:IsA("ParticleEmitter") then
                        descendant.Color = ColorSequence.new(Color3.fromRGB(253, 185, 135));
                    end;

                    if descendant:IsA("Highlight") then
                        descendant.OutlineColor = Color3.fromRGB(170, 85, 0);
                        descendant.FillColor = Color3.fromRGB(253, 185, 135);
                    end;
                end;
            end;

            for _, descendant in pairs(p24:GetDescendants()) do
                if descendant.Name == "StreetcatRecolor" then
                    if descendant:IsA("TextLabel") then
                        descendant.TextColor3 = Color3.fromRGB(253, 185, 135);
                    end;

                    if descendant:IsA("ImageLabel") then
                        descendant.ImageColor3 = Color3.fromRGB(253, 185, 135);
                    end;
                end;
            end;
        end },
    { 860, function(p25, p26) -- Line: 370
            p25.HumanoidRootPart.StreetcatBillboard.Size = UDim2.new(12, 0, 7, 0);

            for _, descendant in pairs(p25:GetDescendants()) do
                if descendant.Name == "StreetcatRecolor" or descendant.Name == "LyricsText" then
                    if descendant:IsA("TextLabel") then
                        descendant.TextColor3 = Color3.fromRGB(136, 86, 203);
                        descendant.TextStrokeColor3 = Color3.fromRGB(170, 85, 255);
                    end;

                    if descendant:IsA("ParticleEmitter") then
                        descendant.Color = ColorSequence.new(Color3.fromRGB(136, 86, 203));
                    end;

                    if descendant:IsA("Highlight") then
                        descendant.OutlineColor = Color3.fromRGB(170, 85, 255);
                        descendant.FillColor = Color3.fromRGB(136, 86, 203);
                    end;
                end;
            end;

            for _, descendant in pairs(p26:GetDescendants()) do
                if descendant.Name == "StreetcatRecolor" then
                    if descendant:IsA("TextLabel") then
                        descendant.TextColor3 = Color3.fromRGB(136, 86, 203);
                    end;

                    if descendant:IsA("ImageLabel") then
                        descendant.ImageColor3 = Color3.fromRGB(136, 86, 203);
                    end;
                end;
            end;
        end },
    { 944, function(p27, p28) -- Line: 405
            for _, descendant in pairs(p27:GetDescendants()) do
                if descendant.Name == "StreetcatRecolor" or descendant.Name == "LyricsText" then
                    if descendant:IsA("TextLabel") then
                        descendant.TextColor3 = Color3.fromRGB(216, 108, 105);
                        descendant.TextStrokeColor3 = Color3.fromRGB(170, 0, 0);
                    end;

                    if descendant:IsA("ParticleEmitter") then
                        descendant.Color = ColorSequence.new(Color3.fromRGB(216, 108, 105));
                    end;

                    if descendant:IsA("Highlight") then
                        descendant.OutlineColor = Color3.fromRGB(170, 0, 0);
                        descendant.FillColor = Color3.fromRGB(216, 108, 105);
                    end;
                end;
            end;

            for _, descendant in pairs(p28:GetDescendants()) do
                if descendant.Name == "StreetcatRecolor" then
                    if descendant:IsA("TextLabel") then
                        descendant.TextColor3 = Color3.fromRGB(216, 108, 105);
                    end;

                    if descendant:IsA("ImageLabel") then
                        descendant.ImageColor3 = Color3.fromRGB(216, 108, 105);
                    end;
                end;
            end;
        end },
    { 1030, function(p29, p30) -- Line: 438
            for _, descendant in pairs(p29:GetDescendants()) do
                if descendant.Name == "StreetcatRecolor" or descendant.Name == "LyricsText" then
                    if descendant:IsA("TextLabel") then
                        descendant.TextColor3 = Color3.fromRGB(254, 214, 127);
                        descendant.TextStrokeColor3 = Color3.fromRGB(255, 170, 0);
                    end;

                    if descendant:IsA("ParticleEmitter") then
                        descendant.Color = ColorSequence.new(Color3.fromRGB(254, 214, 127));
                    end;

                    if descendant:IsA("Highlight") then
                        descendant.OutlineColor = Color3.fromRGB(255, 170, 0);
                        descendant.FillColor = Color3.fromRGB(254, 214, 127);
                    end;
                end;
            end;

            for _, descendant in pairs(p30:GetDescendants()) do
                if descendant.Name == "StreetcatRecolor" then
                    if descendant:IsA("TextLabel") then
                        descendant.TextColor3 = Color3.fromRGB(254, 214, 127);
                    end;

                    if descendant:IsA("ImageLabel") then
                        descendant.ImageColor3 = Color3.fromRGB(254, 214, 127);
                    end;
                end;
            end;
        end },
    { 1116, function(p31, p32) -- Line: 471
            for _, descendant in pairs(p31:GetDescendants()) do
                if descendant.Name == "StreetcatRecolor" or descendant.Name == "LyricsText" then
                    if descendant:IsA("TextLabel") then
                        descendant.TextColor3 = Color3.fromRGB(123, 211, 123);
                        descendant.TextStrokeColor3 = Color3.fromRGB(0, 170, 0);
                    end;

                    if descendant:IsA("ParticleEmitter") then
                        descendant.Color = ColorSequence.new(Color3.fromRGB(123, 211, 123));
                    end;

                    if descendant:IsA("Highlight") then
                        descendant.OutlineColor = Color3.fromRGB(0, 170, 0);
                        descendant.FillColor = Color3.fromRGB(123, 211, 123);
                    end;
                end;
            end;

            for _, descendant in pairs(p32:GetDescendants()) do
                if descendant.Name == "StreetcatRecolor" then
                    if descendant:IsA("TextLabel") then
                        descendant.TextColor3 = Color3.fromRGB(123, 211, 123);
                    end;

                    if descendant:IsA("ImageLabel") then
                        descendant.ImageColor3 = Color3.fromRGB(123, 211, 123);
                    end;
                end;
            end;
        end },
    { 1180, function(p33, p34) -- Line: 504
            p33.HumanoidRootPart.StreetcatBillboard.Size = UDim2.new(12, 0, 1, 0);
        end },
    { 1205, function(p35, p36) -- Line: 509
            for _, descendant in pairs(p35:GetDescendants()) do
                if descendant.Name == "StreetcatRecolor" or descendant.Name == "LyricsText" then
                    if descendant:IsA("TextLabel") then
                        descendant.TextColor3 = Color3.fromRGB(253, 185, 135);
                        descendant.TextStrokeColor3 = Color3.fromRGB(170, 85, 0);
                    end;

                    if descendant:IsA("ParticleEmitter") then
                        descendant.Color = ColorSequence.new(Color3.fromRGB(253, 185, 135));
                    end;

                    if descendant:IsA("Highlight") then
                        descendant.OutlineColor = Color3.fromRGB(170, 85, 0);
                        descendant.FillColor = Color3.fromRGB(253, 185, 135);
                    end;
                end;
            end;

            for _, descendant in pairs(p36:GetDescendants()) do
                if descendant.Name == "StreetcatRecolor" then
                    if descendant:IsA("TextLabel") then
                        descendant.TextColor3 = Color3.fromRGB(253, 185, 135);
                    end;

                    if descendant:IsA("ImageLabel") then
                        descendant.ImageColor3 = Color3.fromRGB(253, 185, 135);
                    end;
                end;
            end;
        end },
    { 1292, function(p37, p38) -- Line: 542
            for _, descendant in pairs(p37:GetDescendants()) do
                if descendant.Name == "StreetcatRecolor" or descendant.Name == "LyricsText" then
                    if descendant:IsA("TextLabel") then
                        descendant.TextColor3 = Color3.fromRGB(136, 86, 203);
                        descendant.TextStrokeColor3 = Color3.fromRGB(170, 85, 255);
                    end;

                    if descendant:IsA("ParticleEmitter") then
                        descendant.Color = ColorSequence.new(Color3.fromRGB(136, 86, 203));
                    end;

                    if descendant:IsA("Highlight") then
                        descendant.OutlineColor = Color3.fromRGB(170, 85, 255);
                        descendant.FillColor = Color3.fromRGB(136, 86, 203);
                    end;
                end;
            end;

            for _, descendant in pairs(p38:GetDescendants()) do
                if descendant.Name == "StreetcatRecolor" then
                    if descendant:IsA("TextLabel") then
                        descendant.TextColor3 = Color3.fromRGB(136, 86, 203);
                    end;

                    if descendant:IsA("ImageLabel") then
                        descendant.ImageColor3 = Color3.fromRGB(136, 86, 203);
                    end;
                end;
            end;
        end },
    { 1402, function(p39, p40) -- Line: 575
            p39.HumanoidRootPart.StreetcatBillboard.Size = UDim2.new(12, 0, 7, 0);
            local Top = p40.Top;
            local Bottom = p40.Bottom;
            Top.Paras.Visible = false;
            Bottom.Paras.Visible = false;
            Top.Texts.Visible = true;
            Bottom.Texts.Visible = true;

            for _, descendant in pairs(p40:GetDescendants()) do
                if descendant.Name == "StreetcatRecolor" and descendant:IsA("TextLabel") then
                    descendant.Text = "(So come and hit me with a strike)";
                end;
            end;

            for _, descendant in pairs(p39:GetDescendants()) do
                if descendant.Name == "StreetcatRecolor" or descendant.Name == "LyricsText" then
                    if descendant:IsA("TextLabel") then
                        descendant.TextColor3 = Color3.fromRGB(216, 108, 105);
                        descendant.TextStrokeColor3 = Color3.fromRGB(170, 0, 0);
                    end;

                    if descendant:IsA("ParticleEmitter") then
                        descendant.Color = ColorSequence.new(Color3.fromRGB(216, 108, 105));
                    end;

                    if descendant:IsA("Highlight") then
                        descendant.OutlineColor = Color3.fromRGB(170, 0, 0);
                        descendant.FillColor = Color3.fromRGB(216, 108, 105);
                    end;
                end;
            end;

            for _, descendant in pairs(p40:GetDescendants()) do
                if descendant.Name == "StreetcatRecolor" then
                    if descendant:IsA("TextLabel") then
                        descendant.TextColor3 = Color3.fromRGB(216, 108, 105);
                    end;

                    if descendant:IsA("ImageLabel") then
                        descendant.ImageColor3 = Color3.fromRGB(216, 108, 105);
                    end;
                end;
            end;
        end },
    { 1408, function(p41, p42) -- Line: 626
            shared.vfx.emit(p41.HumanoidRootPart.VFX.a.Exit);
            task.wait(0.1);
            shared.vfx.emit(p41.HumanoidRootPart.VFX.b.Caution);
            task.wait(0.1);
            shared.vfx.emit(p41.HumanoidRootPart.VFX.c.Loiter);
            task.wait(0.1);
            shared.vfx.emit(p41.HumanoidRootPart.VFX.d.Parking);
            task.wait(0.1);
            shared.vfx.emit(p41.HumanoidRootPart.VFX.e.Slow);
        end },
    { 1462, function(p43, p44) -- Line: 639
            for _, descendant in pairs(p43:GetDescendants()) do
                if descendant.Name == "StreetcatRecolor" or descendant.Name == "LyricsText" then
                    if descendant:IsA("TextLabel") then
                        descendant.TextColor3 = Color3.fromRGB(254, 214, 127);
                        descendant.TextStrokeColor3 = Color3.fromRGB(255, 170, 0);
                    end;

                    if descendant:IsA("ParticleEmitter") then
                        descendant.Color = ColorSequence.new(Color3.fromRGB(254, 214, 127));
                    end;

                    if descendant:IsA("Highlight") then
                        descendant.OutlineColor = Color3.fromRGB(255, 170, 0);
                        descendant.FillColor = Color3.fromRGB(254, 214, 127);
                    end;
                end;
            end;

            for _, descendant in pairs(p44:GetDescendants()) do
                if descendant.Name == "StreetcatRecolor" then
                    if descendant:IsA("TextLabel") then
                        descendant.TextColor3 = Color3.fromRGB(254, 214, 127);
                    end;

                    if descendant:IsA("ImageLabel") then
                        descendant.ImageColor3 = Color3.fromRGB(254, 214, 127);
                    end;
                end;
            end;
        end },
    { 1470, function(p45, p46) -- Line: 672
            shared.vfx.emit(p45.HumanoidRootPart.VFX.a.Loiter);
            task.wait(0.1);
            shared.vfx.emit(p45.HumanoidRootPart.VFX.b.Exit);
            task.wait(0.1);
            shared.vfx.emit(p45.HumanoidRootPart.VFX.c.Parking);
            task.wait(0.1);
            shared.vfx.emit(p45.HumanoidRootPart.VFX.d.Slow);
            task.wait(0.1);
            shared.vfx.emit(p45.HumanoidRootPart.VFX.e.Caution);
        end },
    { 1525, function(p47, p48) -- Line: 685
            shared.vfx.emit(p47.HumanoidRootPart.VFX.d.Exit);
            task.wait(0.1);
            shared.vfx.emit(p47.HumanoidRootPart.VFX.e.Loiter);
            task.wait(0.1);
            shared.vfx.emit(p47.HumanoidRootPart.VFX.a.Parking);
            task.wait(0.1);
            shared.vfx.emit(p47.HumanoidRootPart.VFX.b.Slow);
            task.wait(0.1);
            shared.vfx.emit(p47.HumanoidRootPart.VFX.c.Caution);
        end },
    { 1548, function(p49, p50) -- Line: 698
            for _, descendant in pairs(p49:GetDescendants()) do
                if descendant.Name == "StreetcatRecolor" or descendant.Name == "LyricsText" then
                    if descendant:IsA("TextLabel") then
                        descendant.TextColor3 = Color3.fromRGB(123, 211, 123);
                        descendant.TextStrokeColor3 = Color3.fromRGB(0, 170, 0);
                    end;

                    if descendant:IsA("ParticleEmitter") then
                        descendant.Color = ColorSequence.new(Color3.fromRGB(123, 211, 123));
                    end;

                    if descendant:IsA("Highlight") then
                        descendant.OutlineColor = Color3.fromRGB(0, 170, 0);
                        descendant.FillColor = Color3.fromRGB(123, 211, 123);
                    end;
                end;
            end;

            for _, descendant in pairs(p50:GetDescendants()) do
                if descendant.Name == "StreetcatRecolor" then
                    if descendant:IsA("TextLabel") then
                        descendant.TextColor3 = Color3.fromRGB(123, 211, 123);
                    end;

                    if descendant:IsA("ImageLabel") then
                        descendant.ImageColor3 = Color3.fromRGB(123, 211, 123);
                    end;
                end;
            end;
        end },
    { 1580, function(p51, p52) -- Line: 731
            shared.vfx.emit(p51.HumanoidRootPart.VFX.c.Exit);
            task.wait(0.1);
            shared.vfx.emit(p51.HumanoidRootPart.VFX.d.Loiter);
            task.wait(0.1);
            shared.vfx.emit(p51.HumanoidRootPart.VFX.e.Caution);
            task.wait(0.1);
            shared.vfx.emit(p51.HumanoidRootPart.VFX.a.Slow);
            task.wait(0.1);
            shared.vfx.emit(p51.HumanoidRootPart.VFX.b.Parking);

            for _, descendant in pairs(p52:GetDescendants()) do
                if descendant.Name == "StreetcatRecolor" and descendant:IsA("TextLabel") then
                    descendant.Text = "(Oh, it reminds me I\'m alive)";
                end;
            end;
        end },
    { 1637, function(p53, p54) -- Line: 752
            for _, descendant in pairs(p53:GetDescendants()) do
                if descendant.Name == "StreetcatRecolor" or descendant.Name == "LyricsText" then
                    if descendant:IsA("TextLabel") then
                        descendant.TextColor3 = Color3.fromRGB(253, 185, 135);
                        descendant.TextStrokeColor3 = Color3.fromRGB(170, 85, 0);
                    end;

                    if descendant:IsA("ParticleEmitter") then
                        descendant.Color = ColorSequence.new(Color3.fromRGB(253, 185, 135));
                    end;

                    if descendant:IsA("Highlight") then
                        descendant.OutlineColor = Color3.fromRGB(170, 85, 0);
                        descendant.FillColor = Color3.fromRGB(253, 185, 135);
                    end;
                end;
            end;

            for _, descendant in pairs(p54:GetDescendants()) do
                if descendant.Name == "StreetcatRecolor" then
                    if descendant:IsA("TextLabel") then
                        descendant.TextColor3 = Color3.fromRGB(253, 185, 135);
                    end;

                    if descendant:IsA("ImageLabel") then
                        descendant.ImageColor3 = Color3.fromRGB(253, 185, 135);
                    end;
                end;
            end;
        end },
    { 1649, function(p55, p56) -- Line: 785
            shared.vfx.emit(p55.HumanoidRootPart.VFX.a.Exit);
            task.wait(0.1);
            shared.vfx.emit(p55.HumanoidRootPart.VFX.b.Caution);
            task.wait(0.1);
            shared.vfx.emit(p55.HumanoidRootPart.VFX.c.Loiter);
            task.wait(0.1);
            shared.vfx.emit(p55.HumanoidRootPart.VFX.d.Parking);
            task.wait(0.1);
            shared.vfx.emit(p55.HumanoidRootPart.VFX.e.Slow);
        end },
    { 1700, function(p57, p58) -- Line: 798
            p57.HumanoidRootPart.StreetcatBillboard.Size = UDim2.new(12, 0, 7, 0);

            for _, descendant in pairs(p57:GetDescendants()) do
                if descendant.Name == "StreetcatRecolor" or descendant.Name == "LyricsText" then
                    if descendant:IsA("TextLabel") then
                        descendant.TextColor3 = Color3.fromRGB(136, 86, 203);
                        descendant.TextStrokeColor3 = Color3.fromRGB(170, 85, 255);
                    end;

                    if descendant:IsA("ParticleEmitter") then
                        descendant.Color = ColorSequence.new(Color3.fromRGB(136, 86, 203));
                    end;

                    if descendant:IsA("Highlight") then
                        descendant.OutlineColor = Color3.fromRGB(170, 85, 255);
                        descendant.FillColor = Color3.fromRGB(136, 86, 203);
                    end;
                end;
            end;

            for _, descendant in pairs(p58:GetDescendants()) do
                if descendant.Name == "StreetcatRecolor" then
                    if descendant:IsA("TextLabel") then
                        descendant.TextColor3 = Color3.fromRGB(136, 86, 203);
                    end;

                    if descendant:IsA("ImageLabel") then
                        descendant.ImageColor3 = Color3.fromRGB(136, 86, 203);
                    end;
                end;
            end;
        end },
    { 1711, function(p59, p60) -- Line: 833
            shared.vfx.emit(p59.HumanoidRootPart.VFX.a.Loiter);
            task.wait(0.1);
            shared.vfx.emit(p59.HumanoidRootPart.VFX.b.Exit);
            task.wait(0.1);
            shared.vfx.emit(p59.HumanoidRootPart.VFX.c.Parking);
            task.wait(0.1);
            shared.vfx.emit(p59.HumanoidRootPart.VFX.d.Slow);
            task.wait(0.1);
            shared.vfx.emit(p59.HumanoidRootPart.VFX.e.Caution);
        end },
    { 1740, function(p61, p62) -- Line: 846
            local Top = p62.Top;
            local Bottom = p62.Bottom;
            Top.Paras.Visible = true;
            Bottom.Paras.Visible = true;
            Top.Texts.Visible = false;
            Bottom.Texts.Visible = false;
        end },
    { 1766, function(p63, p64) -- Line: 857
            shared.vfx.emit(p63.HumanoidRootPart.VFX.d.Exit);
            task.wait(0.1);
            shared.vfx.emit(p63.HumanoidRootPart.VFX.e.Loiter);
            task.wait(0.1);
            shared.vfx.emit(p63.HumanoidRootPart.VFX.a.Parking);
            task.wait(0.1);
            shared.vfx.emit(p63.HumanoidRootPart.VFX.b.Slow);
            task.wait(0.1);
            shared.vfx.emit(p63.HumanoidRootPart.VFX.c.Caution);
        end },
    { 1784, function(p65, p66) -- Line: 870
            for _, descendant in pairs(p65:GetDescendants()) do
                if descendant.Name == "StreetcatRecolor" or descendant.Name == "LyricsText" then
                    if descendant:IsA("TextLabel") then
                        descendant.TextColor3 = Color3.fromRGB(216, 108, 105);
                        descendant.TextStrokeColor3 = Color3.fromRGB(170, 0, 0);
                    end;

                    if descendant:IsA("ParticleEmitter") then
                        descendant.Color = ColorSequence.new(Color3.fromRGB(216, 108, 105));
                    end;

                    if descendant:IsA("Highlight") then
                        descendant.OutlineColor = Color3.fromRGB(170, 0, 0);
                        descendant.FillColor = Color3.fromRGB(216, 108, 105);
                    end;
                end;
            end;

            for _, descendant in pairs(p66:GetDescendants()) do
                if descendant.Name == "StreetcatRecolor" then
                    if descendant:IsA("TextLabel") then
                        descendant.TextColor3 = Color3.fromRGB(216, 108, 105);
                    end;

                    if descendant:IsA("ImageLabel") then
                        descendant.ImageColor3 = Color3.fromRGB(216, 108, 105);
                    end;
                end;
            end;
        end },
    { 1821, function(p67, p68) -- Line: 903
            shared.vfx.emit(p67.HumanoidRootPart.VFX.c.Exit);
            task.wait(0.1);
            shared.vfx.emit(p67.HumanoidRootPart.VFX.d.Loiter);
            task.wait(0.1);
            shared.vfx.emit(p67.HumanoidRootPart.VFX.e.Caution);
            task.wait(0.1);
            shared.vfx.emit(p67.HumanoidRootPart.VFX.a.Slow);
            task.wait(0.1);
            shared.vfx.emit(p67.HumanoidRootPart.VFX.b.Parking);
        end },
    { 1870, function(p69, p70) -- Line: 916
            for _, descendant in pairs(p69:GetDescendants()) do
                if descendant.Name == "StreetcatRecolor" or descendant.Name == "LyricsText" then
                    if descendant:IsA("TextLabel") then
                        descendant.TextColor3 = Color3.fromRGB(254, 214, 127);
                        descendant.TextStrokeColor3 = Color3.fromRGB(255, 170, 0);
                    end;

                    if descendant:IsA("ParticleEmitter") then
                        descendant.Color = ColorSequence.new(Color3.fromRGB(254, 214, 127));
                    end;

                    if descendant:IsA("Highlight") then
                        descendant.OutlineColor = Color3.fromRGB(255, 170, 0);
                        descendant.FillColor = Color3.fromRGB(254, 214, 127);
                    end;
                end;
            end;

            for _, descendant in pairs(p70:GetDescendants()) do
                if descendant.Name == "StreetcatRecolor" then
                    if descendant:IsA("TextLabel") then
                        descendant.TextColor3 = Color3.fromRGB(254, 214, 127);
                    end;

                    if descendant:IsA("ImageLabel") then
                        descendant.ImageColor3 = Color3.fromRGB(254, 214, 127);
                    end;
                end;
            end;
        end },
    { 1880, function(p71, p72) -- Line: 949
            p71.HumanoidRootPart.StreetcatBillboard.Size = UDim2.new(12, 0, 1, 0);
        end },
    { 1885, function(p73, p74) -- Line: 954
            shared.vfx.emit(p73.HumanoidRootPart.VFX.a.Exit);
            task.wait(0.1);
            shared.vfx.emit(p73.HumanoidRootPart.VFX.b.Caution);
            task.wait(0.1);
            shared.vfx.emit(p73.HumanoidRootPart.VFX.c.Loiter);
            task.wait(0.1);
            shared.vfx.emit(p73.HumanoidRootPart.VFX.d.Parking);
            task.wait(0.1);
            shared.vfx.emit(p73.HumanoidRootPart.VFX.e.Slow);
        end },
    { 1947, function(p75, p76) -- Line: 967
            shared.vfx.emit(p75.HumanoidRootPart.VFX.a.Loiter);
            task.wait(0.1);
            shared.vfx.emit(p75.HumanoidRootPart.VFX.b.Exit);
            task.wait(0.1);
            shared.vfx.emit(p75.HumanoidRootPart.VFX.c.Parking);
            task.wait(0.1);
            shared.vfx.emit(p75.HumanoidRootPart.VFX.d.Slow);
            task.wait(0.1);
            shared.vfx.emit(p75.HumanoidRootPart.VFX.e.Caution);
        end },
    { 1956, function(p77, p78) -- Line: 980
            for _, descendant in pairs(p77:GetDescendants()) do
                if descendant.Name == "StreetcatRecolor" or descendant.Name == "LyricsText" then
                    if descendant:IsA("TextLabel") then
                        descendant.TextColor3 = Color3.fromRGB(123, 211, 123);
                        descendant.TextStrokeColor3 = Color3.fromRGB(0, 170, 0);
                    end;

                    if descendant:IsA("ParticleEmitter") then
                        descendant.Color = ColorSequence.new(Color3.fromRGB(123, 211, 123));
                    end;

                    if descendant:IsA("Highlight") then
                        descendant.OutlineColor = Color3.fromRGB(0, 170, 0);
                        descendant.FillColor = Color3.fromRGB(123, 211, 123);
                    end;
                end;
            end;

            for _, descendant in pairs(p78:GetDescendants()) do
                if descendant.Name == "StreetcatRecolor" then
                    if descendant:IsA("TextLabel") then
                        descendant.TextColor3 = Color3.fromRGB(123, 211, 123);
                    end;

                    if descendant:IsA("ImageLabel") then
                        descendant.ImageColor3 = Color3.fromRGB(123, 211, 123);
                    end;
                end;
            end;
        end },
    { 2002, function(p79, p80) -- Line: 1013
            shared.vfx.emit(p79.HumanoidRootPart.VFX.d.Exit);
            task.wait(0.1);
            shared.vfx.emit(p79.HumanoidRootPart.VFX.e.Loiter);
            task.wait(0.1);
            shared.vfx.emit(p79.HumanoidRootPart.VFX.a.Parking);
            task.wait(0.1);
            shared.vfx.emit(p79.HumanoidRootPart.VFX.b.Slow);
            task.wait(0.1);
            shared.vfx.emit(p79.HumanoidRootPart.VFX.c.Caution);
        end },
    { 2045, function(p81, p82) -- Line: 1026
            for _, descendant in pairs(p81:GetDescendants()) do
                if descendant.Name == "StreetcatRecolor" or descendant.Name == "LyricsText" then
                    if descendant:IsA("TextLabel") then
                        descendant.TextColor3 = Color3.fromRGB(253, 185, 135);
                        descendant.TextStrokeColor3 = Color3.fromRGB(170, 85, 0);
                    end;

                    if descendant:IsA("ParticleEmitter") then
                        descendant.Color = ColorSequence.new(Color3.fromRGB(253, 185, 135));
                    end;

                    if descendant:IsA("Highlight") then
                        descendant.OutlineColor = Color3.fromRGB(170, 85, 0);
                        descendant.FillColor = Color3.fromRGB(253, 185, 135);
                    end;
                end;
            end;

            for _, descendant in pairs(p82:GetDescendants()) do
                if descendant.Name == "StreetcatRecolor" then
                    if descendant:IsA("TextLabel") then
                        descendant.TextColor3 = Color3.fromRGB(253, 185, 135);
                    end;

                    if descendant:IsA("ImageLabel") then
                        descendant.ImageColor3 = Color3.fromRGB(253, 185, 135);
                    end;
                end;
            end;
        end },
    { 2057, function(p83, p84) -- Line: 1059
            shared.vfx.emit(p83.HumanoidRootPart.VFX.c.Exit);
            task.wait(0.1);
            shared.vfx.emit(p83.HumanoidRootPart.VFX.d.Loiter);
            task.wait(0.1);
            shared.vfx.emit(p83.HumanoidRootPart.VFX.e.Caution);
            task.wait(0.1);
            shared.vfx.emit(p83.HumanoidRootPart.VFX.a.Slow);
            task.wait(0.1);
            shared.vfx.emit(p83.HumanoidRootPart.VFX.b.Parking);
        end },
    { 2083, function(p85, p86) -- Line: 1072
            p85.HumanoidRootPart.StreetcatBillboard.Size = UDim2.new(12, 0, 7, 0);
            local Top = p86.Top;
            local Bottom = p86.Bottom;
            Top.Paras.Visible = false;
            Bottom.Paras.Visible = false;
            Top.Texts.Visible = true;
            Bottom.Texts.Visible = true;

            for _, descendant in pairs(p86:GetDescendants()) do
                if descendant.Name == "StreetcatRecolor" and descendant:IsA("TextLabel") then
                    descendant.Text = "(So come and hit me with a strike)";
                end;
            end;
        end },
    { 2116, function(p87, p88) -- Line: 1093
            shared.vfx.emit(p87.HumanoidRootPart.VFX.a.Exit);
            task.wait(0.1);
            shared.vfx.emit(p87.HumanoidRootPart.VFX.b.Caution);
            task.wait(0.1);
            shared.vfx.emit(p87.HumanoidRootPart.VFX.c.Loiter);
            task.wait(0.1);
            shared.vfx.emit(p87.HumanoidRootPart.VFX.d.Parking);
            task.wait(0.1);
            shared.vfx.emit(p87.HumanoidRootPart.VFX.e.Slow);
        end },
    { 2132, function(p89, p90) -- Line: 1106
            p89.HumanoidRootPart.StreetcatBillboard.Size = UDim2.new(12, 0, 7, 0);

            for _, descendant in pairs(p89:GetDescendants()) do
                if descendant.Name == "StreetcatRecolor" or descendant.Name == "LyricsText" then
                    if descendant:IsA("TextLabel") then
                        descendant.TextColor3 = Color3.fromRGB(136, 86, 203);
                        descendant.TextStrokeColor3 = Color3.fromRGB(170, 85, 255);
                    end;

                    if descendant:IsA("ParticleEmitter") then
                        descendant.Color = ColorSequence.new(Color3.fromRGB(136, 86, 203));
                    end;

                    if descendant:IsA("Highlight") then
                        descendant.OutlineColor = Color3.fromRGB(170, 85, 255);
                        descendant.FillColor = Color3.fromRGB(136, 86, 203);
                    end;
                end;
            end;

            for _, descendant in pairs(p90:GetDescendants()) do
                if descendant.Name == "StreetcatRecolor" then
                    if descendant:IsA("TextLabel") then
                        descendant.TextColor3 = Color3.fromRGB(136, 86, 203);
                    end;

                    if descendant:IsA("ImageLabel") then
                        descendant.ImageColor3 = Color3.fromRGB(136, 86, 203);
                    end;
                end;
            end;
        end },
    { 2178, function(p91, p92) -- Line: 1141
            shared.vfx.emit(p91.HumanoidRootPart.VFX.a.Loiter);
            task.wait(0.1);
            shared.vfx.emit(p91.HumanoidRootPart.VFX.b.Exit);
            task.wait(0.1);
            shared.vfx.emit(p91.HumanoidRootPart.VFX.c.Parking);
            task.wait(0.1);
            shared.vfx.emit(p91.HumanoidRootPart.VFX.d.Slow);
            task.wait(0.1);
            shared.vfx.emit(p91.HumanoidRootPart.VFX.e.Caution);
        end },
    { 2216, function(p93, p94) -- Line: 1154
            for _, descendant in pairs(p93:GetDescendants()) do
                if descendant.Name == "StreetcatRecolor" or descendant.Name == "LyricsText" then
                    if descendant:IsA("TextLabel") then
                        descendant.TextColor3 = Color3.fromRGB(216, 108, 105);
                        descendant.TextStrokeColor3 = Color3.fromRGB(170, 0, 0);
                    end;

                    if descendant:IsA("ParticleEmitter") then
                        descendant.Color = ColorSequence.new(Color3.fromRGB(216, 108, 105));
                    end;

                    if descendant:IsA("Highlight") then
                        descendant.OutlineColor = Color3.fromRGB(170, 0, 0);
                        descendant.FillColor = Color3.fromRGB(216, 108, 105);
                    end;
                end;
            end;

            for _, descendant in pairs(p94:GetDescendants()) do
                if descendant.Name == "StreetcatRecolor" then
                    if descendant:IsA("TextLabel") then
                        descendant.TextColor3 = Color3.fromRGB(216, 108, 105);
                    end;

                    if descendant:IsA("ImageLabel") then
                        descendant.ImageColor3 = Color3.fromRGB(216, 108, 105);
                    end;
                end;
            end;
        end },
    { 2224, function(p95, p96) -- Line: 1187
            p95.HumanoidRootPart.StreetcatBillboard.Size = UDim2.new(18, 0, 3.5, 0);
        end },
    { 2233, function(p97, p98) -- Line: 1192
            shared.vfx.emit(p97.HumanoidRootPart.VFX.d.Exit);
            task.wait(0.1);
            shared.vfx.emit(p97.HumanoidRootPart.VFX.e.Loiter);
            task.wait(0.1);
            shared.vfx.emit(p97.HumanoidRootPart.VFX.a.Parking);
            task.wait(0.1);
            shared.vfx.emit(p97.HumanoidRootPart.VFX.b.Slow);
            task.wait(0.1);
            shared.vfx.emit(p97.HumanoidRootPart.VFX.c.Caution);
        end },
    { 2277, function(p99, p100) -- Line: 1205
            p99.HumanoidRootPart.StreetcatBillboard.Size = UDim2.new(12, 0, 7, 0);

            for _, descendant in pairs(p100:GetDescendants()) do
                if descendant.Name == "StreetcatRecolor" and descendant:IsA("TextLabel") then
                    descendant.Text = "(Oh, it reminds me I\'m alive)";
                end;
            end;
        end },
    { 2288, function(p101, p102) -- Line: 1218
            shared.vfx.emit(p101.HumanoidRootPart.VFX.c.Exit);
            task.wait(0.1);
            shared.vfx.emit(p101.HumanoidRootPart.VFX.d.Loiter);
            task.wait(0.1);
            shared.vfx.emit(p101.HumanoidRootPart.VFX.e.Caution);
            task.wait(0.1);
            shared.vfx.emit(p101.HumanoidRootPart.VFX.a.Slow);
            task.wait(0.1);
            shared.vfx.emit(p101.HumanoidRootPart.VFX.b.Parking);
        end },
    { 2302, function(p103, p104) -- Line: 1231
            for _, descendant in pairs(p103:GetDescendants()) do
                if descendant.Name == "StreetcatRecolor" or descendant.Name == "LyricsText" then
                    if descendant:IsA("TextLabel") then
                        descendant.TextColor3 = Color3.fromRGB(254, 214, 127);
                        descendant.TextStrokeColor3 = Color3.fromRGB(255, 170, 0);
                    end;

                    if descendant:IsA("ParticleEmitter") then
                        descendant.Color = ColorSequence.new(Color3.fromRGB(254, 214, 127));
                    end;

                    if descendant:IsA("Highlight") then
                        descendant.OutlineColor = Color3.fromRGB(255, 170, 0);
                        descendant.FillColor = Color3.fromRGB(254, 214, 127);
                    end;
                end;
            end;

            for _, descendant in pairs(p104:GetDescendants()) do
                if descendant.Name == "StreetcatRecolor" then
                    if descendant:IsA("TextLabel") then
                        descendant.TextColor3 = Color3.fromRGB(254, 214, 127);
                    end;

                    if descendant:IsA("ImageLabel") then
                        descendant.ImageColor3 = Color3.fromRGB(254, 214, 127);
                    end;
                end;
            end;
        end },
    { 2348, function(p105, p106) -- Line: 1264
            shared.vfx.emit(p105.HumanoidRootPart.VFX.a.Exit);
            task.wait(0.1);
            shared.vfx.emit(p105.HumanoidRootPart.VFX.b.Caution);
            task.wait(0.1);
            shared.vfx.emit(p105.HumanoidRootPart.VFX.c.Loiter);
            task.wait(0.1);
            shared.vfx.emit(p105.HumanoidRootPart.VFX.d.Parking);
            task.wait(0.1);
            shared.vfx.emit(p105.HumanoidRootPart.VFX.e.Slow);
        end },
    { 2388, function(p107, p108) -- Line: 1277
            for _, descendant in pairs(p107:GetDescendants()) do
                if descendant.Name == "StreetcatRecolor" or descendant.Name == "LyricsText" then
                    if descendant:IsA("TextLabel") then
                        descendant.TextColor3 = Color3.fromRGB(123, 211, 123);
                        descendant.TextStrokeColor3 = Color3.fromRGB(0, 170, 0);
                    end;

                    if descendant:IsA("ParticleEmitter") then
                        descendant.Color = ColorSequence.new(Color3.fromRGB(123, 211, 123));
                    end;

                    if descendant:IsA("Highlight") then
                        descendant.OutlineColor = Color3.fromRGB(0, 170, 0);
                        descendant.FillColor = Color3.fromRGB(123, 211, 123);
                    end;
                end;
            end;

            for _, descendant in pairs(p108:GetDescendants()) do
                if descendant.Name == "StreetcatRecolor" then
                    if descendant:IsA("TextLabel") then
                        descendant.TextColor3 = Color3.fromRGB(123, 211, 123);
                    end;

                    if descendant:IsA("ImageLabel") then
                        descendant.ImageColor3 = Color3.fromRGB(123, 211, 123);
                    end;
                end;
            end;
        end },
    { 2410, function(p109, p110) -- Line: 1310
            shared.vfx.emit(p109.HumanoidRootPart.VFX.a.Loiter);
            task.wait(0.1);
            shared.vfx.emit(p109.HumanoidRootPart.VFX.b.Exit);
            task.wait(0.1);
            shared.vfx.emit(p109.HumanoidRootPart.VFX.c.Parking);
            task.wait(0.1);
            shared.vfx.emit(p109.HumanoidRootPart.VFX.d.Slow);
            task.wait(0.1);
            shared.vfx.emit(p109.HumanoidRootPart.VFX.e.Caution);
        end },
    { 2430, function(p111, p112) -- Line: 1323
            local Top = p112.Top;
            local Bottom = p112.Bottom;
            Top.Paras.Visible = true;
            Bottom.Paras.Visible = true;
            Top.Texts.Visible = false;
            Bottom.Texts.Visible = false;
        end },
    { 2465, function(p113, p114) -- Line: 1334
            shared.vfx.emit(p113.HumanoidRootPart.VFX.d.Exit);
            task.wait(0.1);
            shared.vfx.emit(p113.HumanoidRootPart.VFX.e.Loiter);
            task.wait(0.1);
            shared.vfx.emit(p113.HumanoidRootPart.VFX.a.Parking);
            task.wait(0.1);
            shared.vfx.emit(p113.HumanoidRootPart.VFX.b.Slow);
            task.wait(0.1);
            shared.vfx.emit(p113.HumanoidRootPart.VFX.c.Caution);
        end },
    { 2477, function(p115, p116) -- Line: 1347
            for _, descendant in pairs(p115:GetDescendants()) do
                if descendant.Name == "StreetcatRecolor" or descendant.Name == "LyricsText" then
                    if descendant:IsA("TextLabel") then
                        descendant.TextColor3 = Color3.fromRGB(253, 185, 135);
                        descendant.TextStrokeColor3 = Color3.fromRGB(170, 85, 0);
                    end;

                    if descendant:IsA("ParticleEmitter") then
                        descendant.Color = ColorSequence.new(Color3.fromRGB(253, 185, 135));
                    end;

                    if descendant:IsA("Highlight") then
                        descendant.OutlineColor = Color3.fromRGB(170, 85, 0);
                        descendant.FillColor = Color3.fromRGB(253, 185, 135);
                    end;
                end;
            end;

            for _, descendant in pairs(p116:GetDescendants()) do
                if descendant.Name == "StreetcatRecolor" then
                    if descendant:IsA("TextLabel") then
                        descendant.TextColor3 = Color3.fromRGB(253, 185, 135);
                    end;

                    if descendant:IsA("ImageLabel") then
                        descendant.ImageColor3 = Color3.fromRGB(253, 185, 135);
                    end;
                end;
            end;
        end },
    { 2520, function(p117, p118) -- Line: 1380
            shared.vfx.emit(p117.HumanoidRootPart.VFX.c.Exit);
            task.wait(0.1);
            shared.vfx.emit(p117.HumanoidRootPart.VFX.d.Loiter);
            task.wait(0.1);
            shared.vfx.emit(p117.HumanoidRootPart.VFX.e.Caution);
            task.wait(0.1);
            shared.vfx.emit(p117.HumanoidRootPart.VFX.a.Slow);
            task.wait(0.1);
            shared.vfx.emit(p117.HumanoidRootPart.VFX.b.Parking);
        end },
    { 2565, function(p119, p120) -- Line: 1393
            for _, descendant in pairs(p119:GetDescendants()) do
                if descendant.Name == "StreetcatRecolor" or descendant.Name == "LyricsText" then
                    if descendant:IsA("TextLabel") then
                        descendant.TextColor3 = Color3.fromRGB(216, 108, 105);
                        descendant.TextStrokeColor3 = Color3.fromRGB(170, 0, 0);
                    end;

                    if descendant:IsA("ParticleEmitter") then
                        descendant.Color = ColorSequence.new(Color3.fromRGB(216, 108, 105));
                    end;

                    if descendant:IsA("Highlight") then
                        descendant.OutlineColor = Color3.fromRGB(170, 0, 0);
                        descendant.FillColor = Color3.fromRGB(216, 108, 105);
                    end;
                end;
            end;

            for _, descendant in pairs(p120:GetDescendants()) do
                if descendant.Name == "StreetcatRecolor" then
                    if descendant:IsA("TextLabel") then
                        descendant.TextColor3 = Color3.fromRGB(216, 108, 105);
                    end;

                    if descendant:IsA("ImageLabel") then
                        descendant.ImageColor3 = Color3.fromRGB(216, 108, 105);
                    end;
                end;
            end;
        end },
    { 2582, function(p121, p122) -- Line: 1426
            p121.HumanoidRootPart.StreetcatBillboard.Size = UDim2.new(12, 0, 1, 0);
        end },
    { 2597, function(p123, p124) -- Line: 1431
            shared.vfx.emit(p123.HumanoidRootPart.VFX.a.Exit);
            task.wait(0.1);
            shared.vfx.emit(p123.HumanoidRootPart.VFX.b.Caution);
            task.wait(0.1);
            shared.vfx.emit(p123.HumanoidRootPart.VFX.c.Loiter);
            task.wait(0.1);
            shared.vfx.emit(p123.HumanoidRootPart.VFX.d.Parking);
            task.wait(0.1);
            shared.vfx.emit(p123.HumanoidRootPart.VFX.e.Slow);
        end },
    { 2649, function(p125, p126) -- Line: 1444
            for _, descendant in pairs(p125:GetDescendants()) do
                if descendant.Name == "StreetcatRecolor" or descendant.Name == "LyricsText" then
                    if descendant:IsA("TextLabel") then
                        descendant.TextColor3 = Color3.fromRGB(123, 211, 123);
                        descendant.TextStrokeColor3 = Color3.fromRGB(0, 170, 0);
                    end;

                    if descendant:IsA("ParticleEmitter") then
                        descendant.Color = ColorSequence.new(Color3.fromRGB(123, 211, 123));
                    end;

                    if descendant:IsA("Highlight") then
                        descendant.OutlineColor = Color3.fromRGB(0, 170, 0);
                        descendant.FillColor = Color3.fromRGB(123, 211, 123);
                    end;
                end;
            end;

            for _, descendant in pairs(p126:GetDescendants()) do
                if descendant.Name == "StreetcatRecolor" then
                    if descendant:IsA("TextLabel") then
                        descendant.TextColor3 = Color3.fromRGB(123, 211, 123);
                    end;

                    if descendant:IsA("ImageLabel") then
                        descendant.ImageColor3 = Color3.fromRGB(123, 211, 123);
                    end;
                end;
            end;
        end },
    { 2659, function(p127, p128) -- Line: 1477
            shared.vfx.emit(p127.HumanoidRootPart.VFX.a.Loiter);
            task.wait(0.1);
            shared.vfx.emit(p127.HumanoidRootPart.VFX.b.Exit);
            task.wait(0.1);
            shared.vfx.emit(p127.HumanoidRootPart.VFX.c.Parking);
            task.wait(0.1);
            shared.vfx.emit(p127.HumanoidRootPart.VFX.d.Slow);
            task.wait(0.1);
            shared.vfx.emit(p127.HumanoidRootPart.VFX.e.Caution);
        end },
    { 2714, function(p129, p130) -- Line: 1490
            shared.vfx.emit(p129.HumanoidRootPart.VFX.d.Exit);
            task.wait(0.1);
            shared.vfx.emit(p129.HumanoidRootPart.VFX.e.Loiter);
            task.wait(0.1);
            shared.vfx.emit(p129.HumanoidRootPart.VFX.a.Parking);
            task.wait(0.1);
            shared.vfx.emit(p129.HumanoidRootPart.VFX.b.Slow);
            task.wait(0.1);
            shared.vfx.emit(p129.HumanoidRootPart.VFX.c.Caution);
        end },
    { 2735, function(p131, p132) -- Line: 1503
            for _, descendant in pairs(p131:GetDescendants()) do
                if descendant.Name == "StreetcatRecolor" or descendant.Name == "LyricsText" then
                    if descendant:IsA("TextLabel") then
                        descendant.TextColor3 = Color3.fromRGB(254, 214, 127);
                        descendant.TextStrokeColor3 = Color3.fromRGB(255, 170, 0);
                    end;

                    if descendant:IsA("ParticleEmitter") then
                        descendant.Color = ColorSequence.new(Color3.fromRGB(254, 214, 127));
                    end;

                    if descendant:IsA("Highlight") then
                        descendant.OutlineColor = Color3.fromRGB(255, 170, 0);
                        descendant.FillColor = Color3.fromRGB(254, 214, 127);
                    end;
                end;
            end;

            for _, descendant in pairs(p132:GetDescendants()) do
                if descendant.Name == "StreetcatRecolor" then
                    if descendant:IsA("TextLabel") then
                        descendant.TextColor3 = Color3.fromRGB(254, 214, 127);
                    end;

                    if descendant:IsA("ImageLabel") then
                        descendant.ImageColor3 = Color3.fromRGB(254, 214, 127);
                    end;
                end;
            end;
        end },
    { 2767, function(p133, p134) -- Line: 1536
            shared.vfx.emit(p133.HumanoidRootPart.VFX.c.Exit);
            task.wait(0.1);
            shared.vfx.emit(p133.HumanoidRootPart.VFX.d.Loiter);
            task.wait(0.1);
            shared.vfx.emit(p133.HumanoidRootPart.VFX.e.Caution);
            task.wait(0.1);
            shared.vfx.emit(p133.HumanoidRootPart.VFX.a.Slow);
            task.wait(0.1);
            shared.vfx.emit(p133.HumanoidRootPart.VFX.b.Parking);
        end },
    { 2807, function(p135, p136) -- Line: 1549
            p135.HumanoidRootPart.StreetcatBillboard.Size = UDim2.new(12, 0, 7, 0);

            for _, descendant in pairs(p135:GetDescendants()) do
                if descendant.Name == "StreetcatRecolor" or descendant.Name == "LyricsText" then
                    if descendant:IsA("TextLabel") then
                        descendant.TextColor3 = Color3.fromRGB(136, 86, 203);
                        descendant.TextStrokeColor3 = Color3.fromRGB(170, 85, 255);
                    end;

                    if descendant:IsA("ParticleEmitter") then
                        descendant.Color = ColorSequence.new(Color3.fromRGB(136, 86, 203));
                    end;

                    if descendant:IsA("Highlight") then
                        descendant.OutlineColor = Color3.fromRGB(170, 85, 255);
                        descendant.FillColor = Color3.fromRGB(136, 86, 203);
                    end;
                end;
            end;

            for _, descendant in pairs(p136:GetDescendants()) do
                if descendant.Name == "StreetcatRecolor" then
                    if descendant:IsA("TextLabel") then
                        descendant.TextColor3 = Color3.fromRGB(136, 86, 203);
                    end;

                    if descendant:IsA("ImageLabel") then
                        descendant.ImageColor3 = Color3.fromRGB(136, 86, 203);
                    end;
                end;
            end;
        end }
};