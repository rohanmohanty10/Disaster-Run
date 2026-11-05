  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local u1 = require(ReplicatedStorage.ReplicatedModules.EffectsHandler).GetEffect("checkProperty");
local LocalPlayer = Players.LocalPlayer;

return function(p2) -- Line: 11
    -- upvalues: ReplicatedStorage (copy), LocalPlayer (copy), u1 (copy), RunService (copy), TweenService (copy)
    local v3 = p2 or {};
    local u4 = v3.Duration or 5;
    local u5 = v3.Speed or 0.25;
    local v6 = v3.Brightness or 0.3;
    local Whitelist = v3.Whitelist;
    local u7 = v3.IncludeStand or false;
    local u8 = { "Texture" };
    local u9 = { "Model", "LocalScript", "Script", "Sound" };
    local u10 = { "BlueHeart" };
    local v11 = v3.ReplicatedGui or ReplicatedStorage["Client Assets"].Universal.HighlightEffect:Clone();
    local ViewportFrame = v11.ViewportFrame;
    local Moyai = ViewportFrame:WaitForChild("WorldModel", 3).Moyai;
    v11.Parent = LocalPlayer.PlayerGui;
    ViewportFrame.CurrentCamera = workspace.Camera;
    local u12 = os.clock();

    local function addStand(p13) -- Line: 31
        -- upvalues: u8 (copy), Moyai (copy), u12 (copy), u4 (copy), u5 (copy), u1 (ref), RunService (ref)
        for _, descendant in pairs(p13:GetDescendants()) do
            if pcall(function() -- Line: 34
                -- upvalues: descendant (copy)
                descendant.Transparency = descendant.Transparency * 1;
            end) and not table.find(u8, descendant.ClassName) then
                local u14 = descendant:Clone();
                u14.Parent = Moyai;
                local u15 = nil;
                local u16 = nil;

                local function UpdateCFrame() -- Line: 44
                    -- upvalues: descendant (copy), u12 (ref), u4 (ref), u5 (ref), u15 (ref), u14 (copy)
                    if descendant and os.clock() - u12 < u4 + u5 then
                        u14.CFrame = descendant.CFrame;

                        return;
                    end;

                    u15:Disconnect();
                end;

                local function UpdateTransparency() -- Line: 51
                    -- upvalues: descendant (copy), u12 (ref), u4 (ref), u16 (ref), u14 (copy)
                    if descendant and u4 > os.clock() - u12 then
                        u14.Transparency = descendant.Transparency;

                        return;
                    end;

                    u16:Disconnect();
                end;

                if pcall(function() -- Line: 58
                    -- upvalues: u1 (ref), descendant (copy)
                    u1(descendant, "Position");
                end) then
                    u14.Anchored = true;
                    u15 = RunService.RenderStepped:Connect(UpdateCFrame);
                    u16 = RunService.RenderStepped:Connect(UpdateTransparency);
                end;
            end;
        end;
    end;

    local function addEntityV2(p17) -- Line: 70
        -- upvalues: Moyai (copy), u12 (copy), u4 (copy), u5 (copy), u1 (ref), RunService (ref), u10 (copy), u9 (copy), u7 (copy), addStand (copy)
        local Model = Instance.new("Model");
        Model.Parent = Moyai;

        local function clonePart(u18) -- Line: 74
            -- upvalues: Model (copy), u12 (ref), u4 (ref), u5 (ref), u1 (ref), RunService (ref)
            if not u18.Archivable then
                return;
            end;

            local u19 = u18:Clone();
            u19.Parent = Model;

            if u19:IsA("Humanoid") then
                u19.DisplayDistanceType = "None";
                u19.HealthDisplayType = "AlwaysOff";
            end;

            for _, child in pairs(u19:GetChildren()) do
                if child:IsA("Motor6D") or child:IsA("Weld") then
                    child:Destroy();
                end;
            end;

            if u19:IsA("Accessory") then
                u19 = u19:FindFirstChild("handle") or u19:FindFirstChild("Handle");
                u18 = u18:FindFirstChild("handle") or u18:FindFirstChild("Handle");
            end;

            local u20 = nil;

            local function v21() -- Line: 97
                -- upvalues: u18 (ref), u12 (ref), u4 (ref), u5 (ref), u20 (ref), u19 (ref)
                if u18 and os.clock() - u12 < u4 + u5 then
                    u19.CFrame = u18.CFrame;

                    return;
                end;

                u20:Disconnect();
            end;

            if pcall(function() -- Line: 105
                -- upvalues: u1 (ref), u19 (ref)
                u1(u19, "Position");
            end) then
                u19.Anchored = true;
                u20 = RunService.RenderStepped:Connect(v21);
            end;
        end;

        if table.find(u10, p17.Name) then
            clonePart(p17);
        end;

        for _, child in pairs(p17:GetChildren()) do
            if not table.find(u9, child.ClassName) then
                clonePart(child);
            end;
        end;

        if p17:FindFirstChild("Stand") and u7 then
            addStand(p17.Stand);
        end;
    end;

    if Whitelist then
        for i = 1, #Whitelist do
            addEntityV2(Whitelist[i]);
        end;
    else
        for _, child in pairs(workspace.Living:GetChildren()) do
            addEntityV2(child);
        end;
    end;

    TweenService:Create(ViewportFrame, TweenInfo.new(u5, Enum.EasingStyle.Linear), {
        ImageTransparency = 0,
        BackgroundTransparency = v6
    }):Play();
    wait(u5 + u4);
    TweenService:Create(ViewportFrame, TweenInfo.new(u5, Enum.EasingStyle.Linear), {
        BackgroundTransparency = 1,
        ImageTransparency = 1
    }):Play();
    wait(u5);
    v11:Destroy();
end;