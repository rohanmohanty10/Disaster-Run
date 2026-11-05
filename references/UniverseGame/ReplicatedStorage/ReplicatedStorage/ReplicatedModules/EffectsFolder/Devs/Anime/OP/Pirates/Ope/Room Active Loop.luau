  

 

local RunService = game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Lighting = game:GetService("Lighting");
local _ = game:GetService("Players").LocalPlayer;
local CurrentCamera = workspace.CurrentCamera;
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(Knit.Util.Trove);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local FXHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.FXHandler);
local _ = ReplicatedStorage["Client Assets"];
local u1 = RaycastParams.new();
u1.FilterType = Enum.RaycastFilterType.Include;
u1.FilterDescendantsInstances = { workspace.Map };
local u2 = Random.new();

return function(u3) -- Line: 26
    -- upvalues: ParticleHandler (copy), AssetHandler (copy), FXHandler (copy), u2 (copy), u1 (copy), Trove (copy), Lighting (copy), RunService (copy), CurrentCamera (copy), TweenService (copy)
    local Character = u3.Character;
    local u4 = u3.Model or workspace.Effects:WaitForChild(Character.Name .. " Room", 5);
    local MaxSize = u3.MaxSize;
    local TweenSize = u3.TweenSize;

    if not (u4 and u4:IsDescendantOf(game)) then
        return;
    end;

    local u5 = ParticleHandler.GetUnusualHSVData({
        Character = Character
    });

    if TweenSize then
        u4.Size = Vector3.new(1, 1, 1);
        AssetHandler.ScaleAsset(u4, {
            TweenInfo = { 1.35, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out },
            Scale = TweenSize
        });
    end;

    local u6 = {
        Particles = {},
        Beams = {}
    };

    for _, descendant in u4:GetDescendants() do
        if descendant:IsA("ParticleEmitter") then
            u6.Particles[descendant] = descendant.TimeScale;
        end;

        if descendant:IsA("Beam") then
            u6.Beams[descendant] = descendant.TextureSpeed;
        end;
    end;

    local v7 = FXHandler.ScaleQuality(u2:NextInteger(12, 16));
    local Model = Instance.new("Model");
    Model.Parent = workspace.Effects;
    local Highlight = Instance.new("Highlight");
    Highlight.FillTransparency = 1;
    Highlight.OutlineTransparency = 0.7;
    Highlight.OutlineColor = ParticleHandler.TryHSVShift(Color3.fromRGB(15, 159, 255), u5);
    Highlight.FillColor = ParticleHandler.TryHSVShift(Color3.fromRGB(116, 206, 255), u5);
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.Parent = Model;
    local u8 = {};

    for i = 1, v7 do
        local v9 = AssetHandler.GetAsset("Particles/Room/OuterRock", {
            AbilityName = "Ope",
            SkinName = u3.SkinName
        }):Clone();
        v9.CastShadow = false;
        v9.Anchored = true;
        local CFrame2 = u4.CFrame;
        local Angles = CFrame.Angles;
        local v10 = u2:NextNumber(-360, 360);
        local v11 = math.rad(v10);
        local v12 = u2:NextNumber(-360, 360);
        local v13 = math.rad(v12);
        local v14 = u2:NextNumber(-360, 360);
        v9.CFrame = CFrame2 * Angles(v11, v13, (math.rad(v14)));
        v9.Parent = Model;
        local v15 = workspace:Raycast(Character.HumanoidRootPart.Position, Vector3.new(0, -10, 0), u1);

        if v15 then
            v9.Material = v15.Material;
            v9.Color = v15.Instance.Color;
            local v16 = v15.Instance:FindFirstChildOfClass("Texture") or v15.Instance:FindFirstChildOfClass("Decal");

            if v16 then
                for _, v in { "Front", "Back", "Bottom", "Top", "Left", "Right" } do
                    local v17 = v16:Clone();
                    v17.Face = v;
                    v17.Parent = v9;
                end;
            end;
        end;

        u8[v9] = {
            Sine = 0,
            Scale = u2:NextNumber(0.04, 0.093) * MaxSize,
            Factor = u2:NextNumber(-0.1, 0.1),
            Angle = 6.283185307179586 / v7 * i
        };

        for _, child in v9.Trails:GetChildren() do
            child.TextureLength = child.TextureLength * u8[v9].Scale;
        end;
    end;

    local u18 = Trove.new();
    u18:Connect(u4.AncestryChanged, function(p19, p20) -- Line: 113
        -- upvalues: u18 (copy)
        if not p20 then
            u18:Destroy();
        end;
    end);
    local u21;

    if Lighting:FindFirstChild("Room Correction") then
        u21 = nil;
    else
        u21 = u18:Construct(Instance, "ColorCorrectionEffect");
        u21.Name = "Room Correction";
        u21.Parent = Lighting;
    end;

    local u22 = true;
    local u23 = nil;
    local u24 = 1;
    u18:Connect(RunService.RenderStepped, function(p25) -- Line: 130
        -- upvalues: u4 (copy), u21 (ref), CurrentCamera (ref), u22 (ref), u23 (ref), TweenService (ref), ParticleHandler (ref), Character (copy), u5 (copy), u8 (copy), u24 (ref), MaxSize (copy), u6 (copy)
        local v26 = u4.Size.X / 2;

        if u21 and u21:IsDescendantOf(game) then
            local v27 = (CurrentCamera.CFrame.Position - u4.Position).Magnitude <= v26;

            if u22 ~= v27 then
                if u23 then
                    u23:Pause();
                end;

                local v28 = TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
                local v29 = {};
                local v30;

                if v27 then
                    if ParticleHandler.GetUnusualType(Character) == "BLACK" then
                        v30 = Color3.new(0.7, 0.7, 0.7);
                    else
                        v30 = ParticleHandler.TryHSVShift(Color3.fromRGB(197, 219, 255), u5);
                    end;

                    if not v30 then
                        v30 = Color3.fromRGB(255, 255, 255);
                    end;
                else
                    v30 = Color3.fromRGB(255, 255, 255);
                end;

                v29.TintColor = v30;
                v29.Brightness = v27 and 0.02 or 0;
                v29.Saturation = v27 and 0.1 or 0;
                u23 = TweenService:Create(u21, v28, v29);
                u23:Play();
            end;

            u22 = v27;
        end;

        for i, v in u8 do
            v.Angle = v.Angle - 3.141592653589793 * p25 % 6.283185307179586 * u24;
            v.Sine = v.Sine + 3.141592653589793 * p25 * u24;

            if v.Sine == 6.283185307179586 then
                v.Sine = 0;
            end;

            local v31 = v26 / MaxSize * v.Scale;
            local v32 = math.sin(v.Sine) * (v26 * v.Factor);
            local v33 = v26 * v.Factor + v32;
            local v34 = u4.CFrame * CFrame.new(math.cos(v.Angle) * v26, v33, math.sin(v.Angle) * v26);
            TweenService:Create(i, TweenInfo.new(p25), {
                Size = Vector3.new(1, 1, 1) * v31 * 1.5,
                Position = v34.Position
            }):Play();

            for _, child in i.Trails:GetChildren() do
                local v35 = Character:IsDescendantOf(game) and Character:GetAttribute("Room");
                child.Enabled = v35;
            end;
        end;

        local v36 = Character:IsDescendantOf(game) and Character:GetAttribute("Timestopped");
        u24 = math.clamp(u24 + (v36 and -1 or 1) * 0.5 * p25, 0.007, 1);

        for i, v in u6.Beams do
            i.TextureSpeed = v * u24;
        end;

        for i, v in u6.Particles do
            i.TimeScale = v * u24;
        end;
    end);
    u18:Add(function() -- Line: 191
        -- upvalues: Model (copy), u8 (copy)
        Model:Destroy();
        table.clear(u8);
    end);
    local v37;

    if u5 == nil then
        TweenService:Create(u4, TweenInfo.new(1.75, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, (1 / 0), true, 0.5), {
            Color = Color3.fromRGB(15, 131, 214)
        }):Play();
        v37 = 0;
    else
        v37 = 0;
    end;

    while true do
        v37 = v37 + task.wait();

        if v37 >= 0.016666666666666666 and u24 >= 1 then
            v37 = v37 - 0.016666666666666666;
            task.spawn(function() -- Line: 215
                -- upvalues: AssetHandler (ref), u3 (copy), ParticleHandler (ref), u5 (copy), u2 (ref), u4 (copy), TweenService (ref)
                local v38 = AssetHandler.GetAsset("Particles/Room/Trail", {
                    AbilityName = "Ope",
                    SkinName = u3.SkinName
                }):Clone();
                ParticleHandler.Unusualify(v38, {
                    HSVData = u5
                });

                if u5 and u5.Chroma then
                    ParticleHandler.Chromaify(v38, {
                        Character = u3.Character
                    });
                end;

                local v39 = u2:NextNumber(1.03, 1.135);
                local v40 = u4.Size.X / 2 * v39;
                local v41 = u2:NextNumber(-360, 360);
                local v42 = u2:NextNumber(-8, 8);
                local v43 = os.clock();
                local v44 = u2:NextNumber(1, 1.35);

                while v42 > -3 and v42 < 3 do
                    v42 = u2:NextNumber(-8, 8);
                end;

                local v45 = u2:NextNumber(-360, 360);
                local v46 = math.rad(v45);
                local CFrame2 = u4.CFrame;
                local Angles = CFrame.Angles;
                local v47 = u2:NextNumber(-360, 360);
                local v48 = math.rad(v47);
                local v49 = u2:NextNumber(-360, 360);
                local v50 = math.rad(v49);
                local v51 = u2:NextNumber(-360, 360);
                local v52 = CFrame2 * Angles(v48, v50, (math.rad(v51)));
                local new = CFrame.new;
                local v53 = math.rad(v41);
                local v54 = math.cos(v53) * v40;
                local v55 = math.rad(v41);
                v38.CFrame = v52 * new(v54, 0, math.sin(v55) * v40);
                v38.Parent = workspace.Effects;
                v38.Trail.WidthScale = NumberSequence.new((math.min(v40 / 300, 0.055)));
                task.delay(v44 + 1, v38.Destroy, v38);
                local v56 = 0;

                while v38:IsDescendantOf(game) and (os.clock() - v43 <= v44 and u4:IsDescendantOf(game)) do
                    local v57 = task.wait();
                    v56 = v56 + v57;

                    if v56 >= 0.016666666666666666 then
                        v56 = v56 - 0.016666666666666666;
                        local v58 = u4.Size.X / 2 * v39;
                        local v59 = TweenInfo.new(v57, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut);
                        local v60 = {};
                        local new2 = CFrame.new;
                        local v61 = math.rad(v41);
                        local v62 = math.cos(v61) * v58;
                        local v63 = math.rad(v41);
                        v60.CFrame = v52 * new2(v62, 0, math.sin(v63) * v58) * CFrame.Angles(0, v46, 0);
                        TweenService:Create(v38, v59, v60):Play();
                        v41 = v41 + v42;
                    end;
                end;

                v38.Trail.Enabled = false;
            end);
            task.wait(u2:NextNumber(0.8, 1.2));
        end;

        if not (u4 and u4:IsDescendantOf(game)) then
            return;
        end;
    end;
end;