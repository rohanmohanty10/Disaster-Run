 

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Debris");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local StarterGui = game:GetService("StarterGui");
local vfxUtil = require(ReplicatedStorage.util.vfxUtil);

function checkProperty(p1, p2)
    local _ = p1[p2];
end;

return function(p3) -- Line: 13
    -- upvalues: vfxUtil (copy), Players (copy), StarterGui (copy), RunService (copy), TweenService (copy)
    if vfxUtil.IsSettingOn(Players.LocalPlayer, "NoVFXAtAll") then
        return;
    end;

    local v4 = p3 or {};
    local u5 = v4.Speed or 0.25;
    local u6 = v4.Color or Color3.fromRGB(255, 255, 255);
    local u7 = v4.Color2 or Color3.fromRGB(0, 0, 0);
    local u8 = v4.ImageTransparency or 0.2;
    local u9 = v4.Brightness or 0.3;
    local Whitelist = v4.Whitelist;
    local u10 = v4.CFrames or nil;
    local u11 = { "Model", "LocalScript", "Script", "Sound" };
    local u12 = { "Katana" };

    if not Whitelist then
        return;
    end;

    local u13 = script.BackgroundHighlight:Clone();
    local ViewportFrame = u13.ViewportFrame;
    ViewportFrame.BackgroundColor3 = v4.Color or Color3.fromRGB(0, 0, 0);
    local Moyai = ViewportFrame.WorldModel.Moyai;
    u13.Parent = StarterGui;
    ViewportFrame.CurrentCamera = workspace.CurrentCamera;
    local os_clock_ret = os.clock();
    task.spawn(function() -- Line: 40
        -- upvalues: Moyai (copy), u11 (copy), os_clock_ret (copy), u5 (copy), u5 (copy), u10 (copy), RunService (ref), u12 (copy), Whitelist (copy), ViewportFrame (copy), u9 (copy), u8 (copy), u6 (copy), TweenService (ref), u7 (copy), u13 (copy)
        local function sp() -- Line: 41
            -- upvalues: Moyai (ref), u11 (ref), os_clock_ret (ref), u5 (ref), u5 (ref), u10 (ref), RunService (ref), u12 (ref), Whitelist (ref)
            local function addEntityV2(p14) -- Line: 42
                -- upvalues: Moyai (ref), u11 (ref), os_clock_ret (ref), u5 (ref), u5 (ref), u10 (ref), RunService (ref), u12 (ref)
                local Model = Instance.new("Model");
                Model.Parent = Moyai;

                local function clonePart(u15) -- Line: 46
                    -- upvalues: u11 (ref), Model (copy), os_clock_ret (ref), u5 (ref), u5 (ref), u10 (ref), RunService (ref)
                    if table.find(u11, u15.ClassName) then
                        return;
                    end;

                    if u15.Name == "VISUALRADAR0" then
                        return;
                    end;

                    local u16 = u15:Clone();
                    u16.Parent = Model;

                    if u16:IsA("Humanoid") then
                        u16.DisplayDistanceType = "None";
                        u16.HealthDisplayType = "AlwaysOff";
                    end;

                    for _, child in pairs(u16:GetChildren()) do
                        if child:IsA("Motor6D") or (child:IsA("Weld") or child:IsA("Sound")) then
                            child:Destroy();
                        end;
                    end;

                    if u16:IsA("Accessory") then
                        u16 = u16:FindFirstChild("handle") or u16:FindFirstChild("Handle");
                        u15 = u15:FindFirstChild("handle") or u15:FindFirstChild("Handle");
                    end;

                    local u17 = nil;

                    local function UpdateCFrame() -- Line: 73
                        -- upvalues: u15 (ref), os_clock_ret (ref), u5 (ref), u5 (ref), u17 (ref), u16 (ref)
                        if u15 and os.clock() - os_clock_ret < u5 + u5 then
                            u16.CFrame = u15.CFrame;

                            return;
                        end;

                        u17:Disconnect();
                    end;

                    if u16:IsA("BasePart") then
                        u16.Anchored = true;
                    end;

                    if pcall(function() -- Line: 84
                        -- upvalues: u16 (ref)
                        checkProperty(u16, "Position");
                    end) and not u10 then
                        u17 = RunService.RenderStepped:Connect(UpdateCFrame);
                    end;
                end;

                if table.find(u12, p14.Name) then
                    clonePart(p14);
                end;

                for _, child in pairs(p14:GetChildren()) do
                    clonePart(child);
                end;
            end;

            for i = 1, #Whitelist do
                addEntityV2(Whitelist[i]);
                local _ = i;
            end;
        end;

        ViewportFrame.BackgroundTransparency = u9;
        ViewportFrame.ImageTransparency = u8;
        ViewportFrame.ImageColor3 = u6;
        task.spawn(sp);
        TweenService:Create(ViewportFrame, TweenInfo.new(u5 / 2, Enum.EasingStyle.Linear), {
            ImageColor3 = u7
        }):Play();
        TweenService:Create(ViewportFrame, TweenInfo.new(u5, Enum.EasingStyle.Linear), {
            BackgroundTransparency = 1,
            ImageTransparency = 1
        }):Play();
        task.wait(u5);
        u13:Destroy();
    end);
end;