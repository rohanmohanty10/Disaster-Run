 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Players = game:GetService("Players");
local vfxUtil = require(ReplicatedStorage.util.vfxUtil);
local u1 = {};
local u2 = {
    Model = true,
    LocalScript = true,
    Script = true,
    Sound = true,
    ParticleEmitter = true,
    Beam = true,
    HumanoidRootPart = true,
    Motor6D = true,
    Weld = true
};

local function parseColor(p3, p4, p5) -- Line: 21
    return ((p3 > 1 or p4 > 1) and true or p5 > 1) and Color3.fromRGB(p3, p4, p5) or Color3.new(p3, p4, p5);
end;

local function getViewport(p6) -- Line: 46
    -- upvalues: u1 (copy)
    local table_remove_ret = table.remove(u1);

    if table_remove_ret then
        table_remove_ret.Parent = p6.PlayerGui;

        return table_remove_ret;
    end;

    local v7 = script.BackgroundHighlight:Clone();
    v7.Parent = p6.PlayerGui;

    return v7;
end;

local function releaseViewport(p8) -- Line: 58
    -- upvalues: u1 (copy)
    local ViewportFrame = p8.ViewportFrame;
    ViewportFrame.ImageTransparency = 1;
    ViewportFrame.BackgroundTransparency = 1;
    ViewportFrame:ClearAllChildren();
    local WorldModel = Instance.new("WorldModel");
    WorldModel.Name = "WorldModel";
    WorldModel.Parent = ViewportFrame;
    local Folder = Instance.new("Folder");
    Folder.Name = "Moyai";
    Folder.Parent = WorldModel;
    p8.Parent = nil;
    table.insert(u1, p8);
end;

return function(u9: any, u10: table) -- Line: 76
    -- upvalues: Players (copy), vfxUtil (copy), u1 (copy), u2 (copy), TweenService (copy)
    local v11 = {
        Whitelist = { u9 },
        BlacklistedParts = { "Ball" },
        Speed = u10.Duration,
        Brightness = u10.Brightness,
        ImageTransparency = u10.Transparency,
        CountSpeed = u10.Delay,
        Count = u10.Count
    };
    local v12 = u10.Color[2];
    local v13 = u10.Color[3];
    local v14 = u10.Color[4];
    v11.Color = ((v12 > 1 or v13 > 1) and true or v14 > 1) and Color3.fromRGB(v12, v13, v14) or Color3.new(v12, v13, v14);
    local v15 = u10.Color2[2];
    local v16 = u10.Color2[3];
    local v17 = u10.Color2[4];
    v11.Color2 = ((v15 > 1 or v16 > 1) and true or v17 > 1) and Color3.fromRGB(v15, v16, v17) or Color3.new(v15, v16, v17);
    local LocalPlayer = Players.LocalPlayer;

    if not LocalPlayer then
        return;
    end;

    if u9 then
        u9 = u9:FindFirstChild("HumanoidRootPart");
    end;

    local _ = not u10.Attached;
    local u18 = u10.Start and CFrame.new(-u10.Start[2], u10.Start[3], -u10.Start[4]) or CFrame.identity;
    local u19 = u10.End and CFrame.new(-u10.End[2], u10.End[3], -u10.End[4]) or CFrame.identity;
    local u20 = v11 or {};
    local u21 = u20.Speed or 0.25;
    local u22 = u20.Count or 1;
    local u23 = u20.CountSpeed or (u20.countSpeed or 0.08);
    local u24 = u20.ImageTransparency or 0.25;
    local u25 = u20.Color or Color3.fromRGB(255, 255, 255);
    local _ = u20.Color2 or u25;
    local u26 = u20.Brightness or 0.3;
    local Whitelist = u20.Whitelist;
    local v27 = u20.BlacklistedParts or {};

    if not (Whitelist and LocalPlayer:FindFirstChild("PlayerGui")) then
        return;
    end;

    local v28 = vfxUtil.IsOptimizationSettingOn(LocalPlayer, "WeakerAfterimages");

    if u10.ForceQuality then
        v28 = false;
    end;

    local v29 = u10.ForceLowQuality and true or v28;
    local table_remove_ret = table.remove(u1);

    if table_remove_ret then
        table_remove_ret.Parent = LocalPlayer.PlayerGui;
    else
        table_remove_ret = script.BackgroundHighlight:Clone();
        table_remove_ret.Parent = LocalPlayer.PlayerGui;
    end;

    local ViewportFrame = table_remove_ret.ViewportFrame;
    ViewportFrame.BackgroundColor3 = u25;
    ViewportFrame.CurrentCamera = workspace.CurrentCamera;
    local Moyai = ViewportFrame.WorldModel.Moyai;
    local u30 = {};

    for _, v in ipairs(Whitelist) do
        if v and v:IsA("Model") then
            v.Archivable = true;

            if v29 then
                if v:FindFirstChild("Head") then
                    local v31 = script.lowqualityModel:Clone();

                    for _, child in ipairs(v:GetChildren()) do
                        if child:IsA("BasePart") then
                            local v32 = v31:FindFirstChild(child.Name);

                            if v32 then
                                v32.CFrame = child.CFrame;
                            end;
                        end;
                    end;

                    u30[v] = v31;
                end;
            else
                local v33 = v:Clone();

                for _, descendant in ipairs(v33:GetDescendants()) do
                    if v27[descendant.Name] or u2[descendant.ClassName] then
                        descendant:Destroy();
                    end;
                end;

                u30[v] = v33;
            end;
        end;
    end;

    task.spawn(function() -- Line: 163
        -- upvalues: Moyai (copy), u18 (copy), u9 (copy), u10 (copy), TweenService (ref), u21 (copy), u19 (copy), u2 (ref), u30 (copy), ViewportFrame (copy), u26 (copy), u24 (copy), u20 (copy), u25 (copy), u22 (copy), u23 (copy), table_remove_ret (copy)
        local u34 = {};

        local function spawnEntity(p35, p36) -- Line: 165
            -- upvalues: Moyai (ref), u18 (ref), u9 (ref), u10 (ref), TweenService (ref), u21 (ref), u19 (ref), u2 (ref), u34 (copy)
            local Model = Instance.new("Model");
            Model.Parent = Moyai;
            local Vector3Value = Instance.new("Vector3Value");
            Vector3Value.Parent = Model;
            Vector3Value.Value = u18 ~= CFrame.identity and CFrame.lookAt(u9.Position, (u9.CFrame * u18).Position).LookVector * u18.Position.Magnitude or CFrame.identity.Position;
            local NumberValue = Instance.new("NumberValue");
            NumberValue.Parent = Model;
            NumberValue.Value = 0;

            if u10.EasingStyleForMove then
                TweenService:Create(Vector3Value, TweenInfo.new(u21, Enum[u10.EasingStyleForMove[4]][u10.EasingStyleForMove[2]], Enum[u10.EasingDirectionForMove[4]][u10.EasingDirectionForMove[2]]), {
                    Value = u19 ~= CFrame.identity and CFrame.lookAt(u9.Position, (u9.CFrame * u19).Position).LookVector * u19.Position.Magnitude or CFrame.identity.Position
                }):Play();
                TweenService:Create(NumberValue, TweenInfo.new(u21, Enum[u10.EasingStyleForMove[4]][u10.EasingStyleForMove[2]], Enum[u10.EasingDirectionForMove[4]][u10.EasingDirectionForMove[2]]), {
                    Value = 1
                }):Play();
            end;

            for _, child in ipairs(p36:GetChildren()) do
                if child.Name ~= "VISUALRADAR0" and not u2[child.ClassName] then
                    if child:IsA("Accessory") then
                        local v37 = child:FindFirstChild("Handle") or child:FindFirstChild("handle");

                        if v37 then
                            local v38 = v37:Clone();
                            v38.Anchored = true;
                            v38.Parent = Model;

                            for _, child2 in v38:GetChildren() do
                                if child2:IsA("Weld") then
                                    child2:Destroy();
                                end;
                            end;

                            local v39 = p35:FindFirstChild(child.Name);

                            if v39 then
                                local v40 = v39:FindFirstChild("Handle") or v39:FindFirstChild("handle");

                                if v40 then
                                    v38.CFrame = v40.CFrame + Vector3Value.Value;
                                    local v41, v42, v43 = v38.CFrame:ToEulerAngles();
                                    table.insert(u34, {
                                        Clone = v38,
                                        RealPart = v40,
                                        isAttached = u10.Attached,
                                        OriginalCFrame = v40.CFrame,
                                        OriginalRotation = {
                                            x = v41,
                                            y = v42,
                                            z = v43
                                        },
                                        Tracker = Vector3Value,
                                        numtracker = NumberValue
                                    });
                                end;
                            end;
                        end;
                    else
                        local v44 = child:Clone();
                        v44.Parent = Model;

                        if v44:IsA("Humanoid") then
                            v44.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;
                            v44.HealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOff;
                        elseif v44:IsA("BasePart") then
                            v44.Anchored = true;
                            local v45 = p35:FindFirstChild(v44.Name);

                            if v45 then
                                v44.CFrame = v45.CFrame + Vector3Value.Value;
                                local v46, v47, v48 = v44.CFrame:ToEulerAngles();
                                table.insert(u34, {
                                    Clone = v44,
                                    RealPart = v45,
                                    isAttached = u10.Attached,
                                    OriginalCFrame = v45.CFrame,
                                    OriginalRotation = {
                                        x = v46,
                                        y = v47,
                                        z = v48
                                    },
                                    Tracker = Vector3Value,
                                    numtracker = NumberValue
                                });
                            end;
                        end;
                    end;
                end;
            end;
        end;

        local function spawnAll() -- Line: 263
            -- upvalues: u30 (ref), spawnEntity (copy)
            for i, v in pairs(u30) do
                spawnEntity(i, v);
            end;
        end;

        local v50 = game:GetService("RunService").PreRender:Connect(function(p49) -- Line: 269
            -- upvalues: u34 (copy), u10 (ref), u18 (ref), u9 (ref), u19 (ref)
            for _, v in u34 do
                local Value = v.Tracker.Value;

                if u10.UpdateDirection then
                    Value = (u18 ~= CFrame.identity and CFrame.lookAt(u9.Position, (u9.CFrame * u18).Position).LookVector * u18.Position.Magnitude or CFrame.identity.Position):Lerp(u19 ~= CFrame.identity and CFrame.lookAt(u9.Position, (u9.CFrame * u19).Position).LookVector * u19.Position.Magnitude or CFrame.identity.Position, v.numtracker.Value);
                end;

                if v.isAttached then
                    v.Clone.CFrame = v.RealPart.CFrame + Value;
                else
                    v.Clone.Position = v.OriginalCFrame.Position + Value;
                end;
            end;
        end);
        ViewportFrame.BackgroundTransparency = u26;
        ViewportFrame.ImageTransparency = u24;
        local v51 = u20.ImageColor or u25;
        local v52 = u20.ImageColor2 or v51;
        ViewportFrame.ImageColor3 = v51;
        TweenService:Create(ViewportFrame, TweenInfo.new(u21 / 2, Enum.EasingStyle.Linear), {
            ImageColor3 = v52
        }):Play();

        if u22 then
            for i = 1, u22 do
                task.spawn(spawnAll);
                task.wait(u23);
                local _ = i;
            end;
        else
            for i, v in pairs(u30) do
                spawnEntity(i, v);
            end;
        end;

        TweenService:Create(ViewportFrame, TweenInfo.new(u21, Enum.EasingStyle.Linear), {
            BackgroundTransparency = 1,
            ImageTransparency = 1
        }):Play();
        task.wait(u21);

        for _, v in pairs(u30) do
            v:Destroy();
        end;

        table_remove_ret:Destroy();

        if v50 then
            v50:Disconnect();
        end;
    end);
end;