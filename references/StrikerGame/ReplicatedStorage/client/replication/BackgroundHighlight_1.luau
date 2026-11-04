 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
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

local function getViewport(p3) -- Line: 22
    -- upvalues: u1 (copy)
    local table_remove_ret = table.remove(u1);

    if table_remove_ret then
        table_remove_ret.Parent = p3.PlayerGui;

        return table_remove_ret;
    end;

    local v4 = script.BackgroundHighlight:Clone();
    v4.Parent = p3.PlayerGui;

    return v4;
end;

local function releaseViewport(p5) -- Line: 34
    -- upvalues: u1 (copy)
    local ViewportFrame = p5.ViewportFrame;
    ViewportFrame.ImageTransparency = 1;
    ViewportFrame.BackgroundTransparency = 1;
    ViewportFrame:ClearAllChildren();
    local WorldModel = Instance.new("WorldModel");
    WorldModel.Name = "WorldModel";
    WorldModel.Parent = ViewportFrame;
    local Folder = Instance.new("Folder");
    Folder.Name = "Moyai";
    Folder.Parent = WorldModel;
    p5.Parent = nil;
    table.insert(u1, p5);
end;

return function(p6) -- Line: 52
    -- upvalues: Players (copy), vfxUtil (copy), u1 (copy), u2 (copy), TweenService (copy), RunService (copy)
    local LocalPlayer = Players.LocalPlayer;

    if not LocalPlayer then
        return;
    end;

    if vfxUtil.IsSettingOn(LocalPlayer, "NoVFXAtAll") then
        return;
    end;

    local u7 = p6 or {};
    local u8 = u7.Speed or 0.25;
    local u9 = u7.Count or 1;
    local math_max_ret = math.max(u7.CountSpeed or (u7.countSpeed or 0.08), 0.01);
    local u10 = u7.ImageTransparency or 0.25;
    local u11 = u7.Color or Color3.fromRGB(255, 255, 255);
    local _ = u7.Color2 or u11;
    local u12 = u7.Brightness or 0.3;
    local Whitelist = u7.Whitelist;
    local v13 = u7.BlacklistedParts or {};
    local StopAttribute = u7.StopAttribute;

    if not (Whitelist and LocalPlayer:FindFirstChild("PlayerGui")) then
        return;
    end;

    local v14 = vfxUtil.IsOptimizationSettingOn(LocalPlayer, "WeakerAfterimages");
    local table_remove_ret = table.remove(u1);

    if table_remove_ret then
        table_remove_ret.Parent = LocalPlayer.PlayerGui;
    else
        table_remove_ret = script.BackgroundHighlight:Clone();
        table_remove_ret.Parent = LocalPlayer.PlayerGui;
    end;

    task.delay(u9 * math_max_ret + u8 * 2 + 1, function() -- Line: 79
        -- upvalues: u9 (ref), table_remove_ret (copy)
        u9 = 0;
        table_remove_ret:Destroy();
    end);
    local ViewportFrame = table_remove_ret.ViewportFrame;
    ViewportFrame.BackgroundColor3 = u11;
    ViewportFrame.CurrentCamera = workspace.CurrentCamera;
    local Moyai = ViewportFrame.WorldModel.Moyai;
    local u15 = {};

    for _, v in ipairs(Whitelist) do
        if v and v:IsA("Model") then
            v.Archivable = true;

            if v14 then
                if v:FindFirstChild("Head") then
                    local v16 = script.lowqualityModel:Clone();

                    for _, child in ipairs(v:GetChildren()) do
                        if child:IsA("BasePart") then
                            local v17 = v16:FindFirstChild(child.Name);

                            if v17 then
                                v17.CFrame = child.CFrame;
                            end;
                        end;
                    end;

                    u15[v] = v16;
                end;
            else
                local v18 = v:Clone();

                for _, descendant in ipairs(v18:GetDescendants()) do
                    if v13[descendant.Name] or u2[descendant.ClassName] then
                        descendant:Destroy();
                    end;
                end;

                u15[v] = v18;
            end;
        end;
    end;

    task.spawn(function() -- Line: 121
        -- upvalues: Moyai (copy), u2 (ref), u15 (copy), ViewportFrame (copy), u12 (copy), u10 (copy), u7 (copy), u11 (copy), TweenService (ref), u8 (copy), u9 (ref), RunService (ref), StopAttribute (copy), Whitelist (copy), math_max_ret (copy), table_remove_ret (copy)
        local function spawnEntity(p19, p20) -- Line: 122
            -- upvalues: Moyai (ref), u2 (ref)
            local Model = Instance.new("Model");
            Model.Parent = Moyai;

            for _, child in ipairs(p20:GetChildren()) do
                if child.Name ~= "VISUALRADAR0" and not u2[child.ClassName] then
                    if child:IsA("Accessory") then
                        local v21 = child:FindFirstChild("Handle") or child:FindFirstChild("handle");

                        if v21 then
                            local v22 = v21:Clone();
                            v22.Anchored = true;
                            v22.Parent = Model;
                            local v23 = p19:FindFirstChild(child.Name);

                            if v23 then
                                local v24 = v23:FindFirstChild("Handle") or v23:FindFirstChild("handle");

                                if v24 then
                                    v22.CFrame = v24.CFrame;
                                end;
                            end;
                        end;
                    else
                        local v25 = child:Clone();
                        v25.Parent = Model;

                        if v25:IsA("Humanoid") then
                            v25.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;
                            v25.HealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOff;
                        elseif v25:IsA("BasePart") then
                            v25.Anchored = true;
                            local v26 = p19:FindFirstChild(v25.Name);

                            if v26 then
                                v25.CFrame = v26.CFrame;
                            end;
                        end;
                    end;
                end;
            end;
        end;

        local function spawnAll() -- Line: 162
            -- upvalues: u15 (ref), spawnEntity (copy)
            for i, v in pairs(u15) do
                spawnEntity(i, v);
            end;
        end;

        ViewportFrame.BackgroundTransparency = u12;
        ViewportFrame.ImageTransparency = u10;
        local v27 = u7.ImageColor or u11;
        local v28 = u7.ImageColor2 or v27;
        ViewportFrame.ImageColor3 = v27;
        TweenService:Create(ViewportFrame, TweenInfo.new(u8 / 2, Enum.EasingStyle.Linear), {
            ImageColor3 = v28
        }):Play();

        if u9 then
            local u29 = 0;
            local u30 = nil;
            u30 = RunService.PreRender:Connect(function(p31) -- Line: 185
                -- upvalues: StopAttribute (ref), Whitelist (ref), u9 (ref), u30 (ref), u29 (ref), math_max_ret (ref), spawnAll (copy)
                if StopAttribute and not Whitelist[1]:GetAttribute(StopAttribute) then
                    u9 = 0;
                end;

                if u9 <= 0 then
                    u30:Disconnect();

                    return;
                end;

                u29 = u29 + p31;

                if math_max_ret <= u29 then
                    u29 = u29 % math_max_ret;
                    task.spawn(spawnAll);
                    u9 = u9 - 1;
                end;

                if u9 <= 0 then
                    u30:Disconnect();
                end;
            end);

            repeat
                task.wait();
            until u9 <= 0;
        else
            for i, v in pairs(u15) do
                spawnEntity(i, v);
            end;
        end;

        TweenService:Create(ViewportFrame, TweenInfo.new(u8, Enum.EasingStyle.Linear), {
            BackgroundTransparency = 1,
            ImageTransparency = 1
        }):Play();
        task.wait(u8);

        for _, v in pairs(u15) do
            v:Destroy();
        end;

        table_remove_ret:Destroy();
    end);
end;