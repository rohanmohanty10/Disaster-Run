 
 

local function enablePoorIsagi(p1) -- Line: 1
    local PoorIsagi = p1:FindFirstChild("PoorIsagi");

    if PoorIsagi then
        local Beam = PoorIsagi:FindFirstChild("Beam");

        for _, descendant in pairs(PoorIsagi:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            elseif descendant:IsA("Beam") then
                descendant.Enabled = true;
                local v2, v3;

                if Beam and descendant:IsDescendantOf(Beam) then
                    v2 = 4.735;
                    v3 = 2.46;
                else
                    v2 = 3.85;
                    v3 = 2;
                end;

                descendant.Width0 = v2;
                descendant.Width1 = v3;
                descendant.TextureSpeed = -3;
                local TweenInfo_new_ret = TweenInfo.new(4, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);
                game:GetService("TweenService"):Create(descendant, TweenInfo_new_ret, {
                    Width0 = 0,
                    Width1 = 0
                }):Play();
                local TweenInfo_new_ret2 = TweenInfo.new(2.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);
                game:GetService("TweenService"):Create(descendant, TweenInfo_new_ret2, {
                    TextureSpeed = -0.4
                }):Play();
            end;
        end;

        task.wait(0.2);

        for _, descendant in pairs(PoorIsagi:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        task.wait(7.8);

        for _, descendant in pairs(PoorIsagi:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;
    end;
end;

return {
    { 0, function(p4, p5, p6) -- Line: 65
            shared.vfx.emit(p5.CamPart["BeamFull water"], p5.CamPart["BeamMagical dust"], p5.CamPart["Faint Smoke Lens Flare"], p5.CamPart.Beam, p5.CamPart["Rainbow Lens Flare"], p6[3].Torso["puzzle piece fried spinning 2"], p6[3].Torso["chromatic burst spec"], p6[3].Torso["puzzle piece fried spinning"], p6[3].Torso["Sideways Spec 58"], p6[3].Torso["LE Multiple Spec 1"], p6[3].Torso["Fire coloured blast"]);
        end },
    { 85, function(p7, p8, p9) -- Line: 70
            shared.vfx.emit(p8.CamPart["1"], p8.CamPart.flare1second, p8.CamPart.rainbow1second, p9[3].Head.Spec24, p9[3].Head["puzzle piece fried spinning"], p9[3].Head["Low Res Smoke Updown"], p9[3].Head.Attachment.Flare315New, p9[3].Head.Attachment.Flare319New, p9[3].Head.Attachment.Flare120New);
        end },
    { 154, function(p10, p11, p12) -- Line: 75
            shared.vfx.emit(p11.CamPart["nagithing.5"], p11.CamPart["chrome.5"], p11.CamPart["blur.5"], p11.CamPart["dust.5"], p11.CamPart["dust2.5"], p12[1].Head.Attachment["Bubble 3"], p12[1].Head.Attachment.Flare187New, p12[1].Head.Attachment.Flares1, p12[1].Head:FindFirstChild("Grey Galaxy Smoke"), p12[1].Head["Grey Galaxy Smoke"], p12[1].Head["Chromatic Glassy Spec"], p12[1].Head["Shaded Spec AOE"], p12[1].Head:FindFirstChild("Shaded Spec AOE"), p12[1].Head["Sideways Spec 103"], p12[1].Head["Smoke with glowing circle specs"], p12[1].Head.Spec2);
        end },
    { 195, function(p13, p14) -- Line: 80
            shared.vfx.emit(p14.CamPart["blur.8"], p14.CamPart["chrome.8"], p14.CamPart["dust.8"], p14.CamPart["dust2.8"], p14.CamPart["barouthing.8"]);
        end },
    { 196, function(p15, p16, p17) -- Line: 85
            shared.vfx.emit(p17[2].Head["Different Lightning"], p17[2].Head["Thin Bezier Smoke Fog 8x8"], p17[2].Head.Lightning37, p17[2].Head.ParticleEmitter, p17[2].Head["New fixed lightning arc"], p17[2].Head["Inverted impact shards"], p17[2].Head.Lightning43, p17[2].Head["Realistic Smoke 11"], p17[2].Head.Attachment["Blurry Chromatic Quant Fog"], p17[2].Head.Attachment.LensFlare_01, p17[2].Head.Attachment.Flare7New, p17[2].Head.Attachment.Flare137New);
        end },
    { 246, function(p18, p19, p20) -- Line: 90
            shared.vfx.emit(p19.CamPart["1"], p19.CamPart.flare1second, p19.CamPart.rainbow1second, p20[3].Head.Spec24, p20[3].Head["puzzle piece fried spinning"], p20[3].Head["Low Res Smoke Updown"], p20[3].Head.Attachment.Flare315New, p20[3].Head.Attachment.Flare319New, p20[3].Head.Attachment.Flare120New);
        end },
    { 301, function(p21, p22) -- Line: 95
            shared.vfx.emit(p22.CamPart.Attachmentjj);
        end },
    { 334, function(p23, p24) -- Line: 100
            shared.vfx.emit(p24.CamPart.chromeEND, p24.CamPart["BeamFilled Smoke"], p24.CamPart["BeamFractal outlines"], p24.CamPart.Beam109, p24.CamPart["BeamBroken Fractal"], p24.CamPart.BeamEND);
        end },
    { 335, function(p25, p26, p27) -- Line: 105
            shared.vfx.emit(p27[3].HumanoidRootPart.thingy);
        end },
    { 336, function(p28) -- Line: 110
            -- upvalues: enablePoorIsagi (copy)
            enablePoorIsagi(p28);
        end }
};