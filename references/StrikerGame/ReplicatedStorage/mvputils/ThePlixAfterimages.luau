 

 

local TweenService = game:GetService("TweenService");
local Debris = game:GetService("Debris");
local v1 = {};
local u2 = { Color3.new(1, 1, 1), Color3.new(1, 1, 1), Color3.new(1, 1, 1) };
local u3 = 0;

local function clonePart(u4: userdata, p5: number) -- Line: 28
    if u4.Name == "HumanoidRootPart" then
        return nil;
    end;

    local Archivable = u4.Archivable;
    u4.Archivable = true;
    local success, result = pcall(function() -- Line: 35
        -- upvalues: u4 (copy)
        return u4:Clone();
    end);
    u4.Archivable = Archivable;

    if not (success and (result and result:IsA("BasePart"))) then
        return nil;
    end;

    for _, descendant in result:GetDescendants() do
        if descendant:IsA("LuaSourceContainer") or (descendant:IsA("JointInstance") or (descendant:IsA("Constraint") or (descendant:IsA("ProximityPrompt") or (descendant:IsA("ClickDetector") or (descendant:IsA("Highlight") or (descendant:IsA("Sound") or descendant:IsA("SoundEffect"))))))) then
            descendant:Destroy();
        end;
    end;

    result.Anchored = true;
    result.CanCollide = false;
    result.CanTouch = false;
    result.CanQuery = false;
    result.CastShadow = false;
    result.Massless = true;
    result.CFrame = u4.CFrame;
    result.Transparency = math.max(u4.Transparency, p5);

    return result;
end;

local function addAppearance(p6: userdata, p7: userdata) -- Line: 70
    for _, descendant in p6:GetDescendants() do
        if descendant:IsA("Shirt") or (descendant:IsA("Pants") or (descendant:IsA("ShirtGraphic") or (descendant:IsA("BodyColors") or descendant:IsA("CharacterMesh")))) then
            local Archivable = descendant.Archivable;
            descendant.Archivable = true;
            local success, result = pcall(function() -- Line: 79
                -- upvalues: descendant (copy)
                return descendant:Clone();
            end);
            descendant.Archivable = Archivable;

            if success and result then
                result.Parent = p7;
            end;
        end;
    end;
end;

function v1.Fire(p8: userdata, p9: table?) -- Line: 91
    -- upvalues: u2 (copy), u3 (ref), clonePart (copy), addAppearance (copy), TweenService (copy), Debris (copy)
    if not (p8 and p8.Parent) then
        return nil;
    end;

    local v10 = p9 or {};
    local math_max_ret = math.max(v10.HoldTime or 0.1, 0);
    local math_max_ret2 = math.max(v10.FadeTime or 0.3, 0.03);
    local math_clamp_ret = math.clamp(v10.StartTransparency or 0.78, 0, 1);
    local v11 = v10.TintTransparency or math.min(math_clamp_ret, 0.25);
    local math_clamp_ret2 = math.clamp(v11, 0, 1);
    local v12 = v10.CFrameOffset or CFrame.identity;
    local v13 = v10.EndCFrameOffset or CFrame.identity;
    local v14 = v10.Colors or u2;
    u3 = u3 + 1;
    local v15 = v10.Color or (v14[(u3 - 1) % math.max(#v14, 1) + 1] or Color3.new(1, 1, 1));
    local Model = Instance.new("Model");
    Model.Name = p8.Name .. "\'s thepliximage";
    Model:SetAttribute("thepliximage", true);
    local Humanoid = Instance.new("Humanoid");
    Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;
    Humanoid.HealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOff;
    Humanoid.BreakJointsOnDeath = false;
    Humanoid.EvaluateStateMachine = false;
    Humanoid.Parent = Model;
    local u16 = {};

    for _, descendant in p8:GetDescendants() do
        if descendant:IsA("BasePart") then
            local v17 = clonePart(descendant, math_clamp_ret);

            if v17 then
                v17.Parent = Model;
                table.insert(u16, v17);
            end;
        end;
    end;

    if #u16 == 0 then
        Model:Destroy();

        return nil;
    end;

    addAppearance(p8, Model);

    for _, descendant in Model:GetDescendants() do
        if descendant:IsA("Highlight") then
            descendant:Destroy();
        end;
    end;

    local Highlight = Instance.new("Highlight");
    Highlight.Name = "Tint";
    Highlight.Adornee = Model;
    Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop;
    Highlight.FillColor = v15;
    Highlight.FillTransparency = math_clamp_ret2;
    Highlight.OutlineColor = v15;
    Highlight.OutlineTransparency = math_clamp_ret2;
    Highlight.Parent = Model;
    Model.Parent = v10.Parent or workspace;
    local HumanoidRootPart = p8:FindFirstChild("HumanoidRootPart", true);

    if HumanoidRootPart and HumanoidRootPart:IsA("BasePart") then
        local Part = Instance.new("Part");
        Part.Name = "HumanoidRootPart";
        Part.Size = HumanoidRootPart.Size;
        Part.CFrame = HumanoidRootPart.CFrame;
        Part.Transparency = 1;
        Part.Anchored = true;
        Part.CanCollide = false;
        Part.CanTouch = false;
        Part.CanQuery = false;
        Part.CastShadow = false;
        Part.Parent = Model;
        Model.PrimaryPart = Part;
    end;

    local TweenInfo_new_ret = TweenInfo.new(math_max_ret2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);

    if HumanoidRootPart and (HumanoidRootPart:IsA("BasePart") and Model.PrimaryPart) then
        local v18 = HumanoidRootPart.CFrame * v12;
        local v19 = nil;

        if v10.TweenToPlayer == true then
            v19 = HumanoidRootPart.CFrame;
        elseif v10.TweenToPlayer == false and v10.TweenToOffset == true then
            v19 = HumanoidRootPart.CFrame * v13;
        end;

        if v19 then
            Model:PivotTo(v18);
            local CFrameValue = Instance.new("CFrameValue");
            CFrameValue.Name = "TweenHRP";
            CFrameValue.Value = v18;
            CFrameValue.Parent = Model;
            local u20 = CFrameValue:GetPropertyChangedSignal("Value"):Connect(function() -- Line: 192
                -- upvalues: Model (copy), CFrameValue (copy)
                if Model.Parent then
                    Model:PivotTo(CFrameValue.Value);
                end;
            end);
            local v21 = TweenService:Create(CFrameValue, TweenInfo_new_ret, {
                Value = v19
            });
            v21.Completed:Once(function() -- Line: 201
                -- upvalues: u20 (copy)
                u20:Disconnect();
            end);
            v21:Play();
        end;
    end;

    task.delay(math_max_ret2 + math_max_ret, function() -- Line: 208
        -- upvalues: Model (copy), u16 (copy), TweenService (ref), TweenInfo_new_ret (copy), Highlight (copy)
        if not Model.Parent then
            return;
        end;

        for _, v in u16 do
            TweenService:Create(v, TweenInfo_new_ret, {
                Transparency = 1
            }):Play();

            for _, descendant in v:GetDescendants() do
                if descendant:IsA("Decal") or descendant:IsA("Texture") then
                    TweenService:Create(descendant, TweenInfo_new_ret, {
                        Transparency = 1
                    }):Play();
                end;
            end;
        end;

        TweenService:Create(Highlight, TweenInfo_new_ret, {
            FillTransparency = 1,
            OutlineTransparency = 1
        }):Play();
    end);
    local v22 = math_max_ret2 + math_max_ret + math_max_ret2;
    Debris:AddItem(Model, v22 + 0.2);
    task.delay(v22, function() -- Line: 230
        -- upvalues: Model (copy)
        if Model.Parent then
            Model:Destroy();
        end;
    end);

    return Model;
end;

return v1;