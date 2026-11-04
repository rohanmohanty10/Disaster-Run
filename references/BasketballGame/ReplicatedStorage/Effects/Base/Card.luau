 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.Essentials);
require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Controllers.LightingController);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Knit = require(ReplicatedStorage.Packages.Knit);
local LocalPlayer = game.Players.LocalPlayer;

return function(p1, u2) -- Line: 14
    -- upvalues: Knit (copy), ReplicatedStorage (copy), LocalPlayer (copy), RunService (copy), TweenService (copy)
    local Controller = Knit.GetController("Network");

    local function Increment(u3, u4) -- Line: 17
        task.spawn(function() -- Line: 18
            -- upvalues: u3 (copy), u4 (copy)
            u3.LineHeight = 3;
            local v5 = (u4 + 1) / 2;
            local v6 = u4;
            local v7 = (v6 - v5) * 1 / 60;
            local os_clock_ret = os.clock();

            while v5 < v6 do
                local _ = os.clock() - os_clock_ret;
                v5 = math.min(v5 + (v7 > 4 and (v7 / 4 or 1) or 1), v6);
                local math_floor_ret = math.floor(v5);
                u3.Text = tostring(math_floor_ret);
                task.wait();
            end;
        end);
    end;

    local OVR = u2.OVR;
    local Points = u2.Points;
    local Blocks = u2.Blocks;
    local Assists = u2.Assists;
    local u8 = ReplicatedStorage.Assets.Cards[u2.Card]:Clone();
    u8.UIGradient.Offset = Vector2.new(-2, 0);
    u8.Parent = LocalPlayer.PlayerGui.Misc;
    u8.Player.Visible = true;
    u2.Char.Archivable = true;
    local u9 = u2.Char:Clone();
    local Camera = Instance.new("Camera");
    Camera.Parent = u8.Player;
    u9.Parent = u8.Player.WorldModel;

    for _, child in u9:GetChildren() do
        child:IsA("Part");
    end;

    u8.Player.CurrentCamera = Camera;
    local u10 = nil;
    u10 = RunService.RenderStepped:Connect(function() -- Line: 73
        -- upvalues: u2 (copy), u10 (ref), u9 (copy), u8 (copy)
        if u2.Char then
            for _, child in u9:GetChildren() do
                if child:IsA("BasePart") and (u2.Char:FindFirstChild(child.Name) and not u2.Char[child.Name]:IsA("Model")) then
                    child.CFrame = u2.Char[child.Name].CFrame;
                    child.Anchored = true;
                end;
            end;

            u8.Player.Camera.CFrame = u9.HumanoidRootPart.CFrame * CFrame.new(0, 0, -6) * CFrame.fromEulerAngles(0, 3.141592653589793, 0);

            return;
        end;

        u10:Disconnect();
        u9:Destroy();
    end);
    local Points2 = u8.Points;
    task.spawn(function() -- Line: 18
        -- upvalues: Points2 (copy), Points (copy)
        Points2.LineHeight = 3;
        local v11 = (Points + 1) / 2;
        local v12 = Points;
        local v13 = (v12 - v11) * 1 / 60;
        local os_clock_ret = os.clock();

        while v11 < v12 do
            local _ = os.clock() - os_clock_ret;
            v11 = math.min(v11 + (v13 > 4 and (v13 / 4 or 1) or 1), v12);
            local math_floor_ret = math.floor(v11);
            Points2.Text = tostring(math_floor_ret);
            task.wait();
        end;
    end);
    local Blocks2 = u8.Blocks;
    task.spawn(function() -- Line: 18
        -- upvalues: Blocks2 (copy), Blocks (copy)
        Blocks2.LineHeight = 3;
        local v14 = (Blocks + 1) / 2;
        local v15 = Blocks;
        local v16 = (v15 - v14) * 1 / 60;
        local os_clock_ret = os.clock();

        while v14 < v15 do
            local _ = os.clock() - os_clock_ret;
            v14 = math.min(v14 + (v16 > 4 and (v16 / 4 or 1) or 1), v15);
            local math_floor_ret = math.floor(v14);
            Blocks2.Text = tostring(math_floor_ret);
            task.wait();
        end;
    end);
    local Assists2 = u8.Assists;
    task.spawn(function() -- Line: 18
        -- upvalues: Assists2 (copy), Assists (copy)
        Assists2.LineHeight = 3;
        local v17 = (Assists + 1) / 2;
        local v18 = Assists;
        local v19 = (v18 - v17) * 1 / 60;
        local os_clock_ret = os.clock();

        while v17 < v18 do
            local _ = os.clock() - os_clock_ret;
            v17 = math.min(v17 + (v19 > 4 and (v19 / 4 or 1) or 1), v18);
            local math_floor_ret = math.floor(v17);
            Assists2.Text = tostring(math_floor_ret);
            task.wait();
        end;
    end);
    local OVR2 = u8.OVR;
    task.spawn(function() -- Line: 18
        -- upvalues: OVR2 (copy), OVR (copy)
        OVR2.LineHeight = 3;
        local v20 = (OVR + 1) / 2;
        local v21 = OVR;
        local v22 = (v21 - v20) * 1 / 60;
        local os_clock_ret = os.clock();

        while v20 < v21 do
            local _ = os.clock() - os_clock_ret;
            v20 = math.min(v20 + (v22 > 4 and (v22 / 4 or 1) or 1), v21);
            local math_floor_ret = math.floor(v20);
            OVR2.Text = tostring(math_floor_ret);
            task.wait();
        end;
    end);

    local function Move(p23) -- Line: 92
        -- upvalues: TweenService (ref)
        for _, child in p23:GetChildren() do
            if child:IsA("ImageLabel") or child:IsA("ImageButton") then
                local Attribute = child:GetAttribute("OriginalPosition");

                if not Attribute then
                    Attribute = child.Position;
                    child:SetAttribute("OriginalPosition", Attribute);
                end;

                TweenService:Create(child, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Position = Attribute + UDim2.new(0.6, 0, 0, 0)
                }):Play();
                task.delay(4, function() -- Line: 104
                    -- upvalues: TweenService (ref), child (copy), Attribute (ref)
                    TweenService:Create(child, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        Position = Attribute
                    }):Play();
                end);
            end;
        end;
    end;

    Move(LocalPlayer.PlayerGui.Mobile.NoBall);
    Move(LocalPlayer.PlayerGui.Mobile.Ball);

    if u2.CardsSFX and (Controller.Player.Customization.Settings.AllCardsSFX and ReplicatedStorage.Assets.SFX.Cards:FindFirstChild(u2.Card)) then
        for _, child in ReplicatedStorage.Assets.SFX.Cards[u2.Card]:GetChildren() do
            local u24 = child:Clone();
            u24.Parent = LocalPlayer.PlayerGui;
            u24:Play();
            task.delay(u24:GetAttribute("Duration") or 5, function() -- Line: 119
                -- upvalues: TweenService (ref), u24 (copy)
                TweenService:Create(u24, TweenInfo.new(1), {
                    Volume = 0
                }):Play();
                task.delay(1, function() -- Line: 121
                    -- upvalues: u24 (ref)
                    u24:Destroy();
                end);
            end);
        end;
    end;

    TweenService:Create(u8.UIGradient, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
        Offset = Vector2.new(0, 0)
    }):Play();

    if not workspace:FindFirstChild("CamRig") then
        task.spawn(function() -- Line: 131
            -- upvalues: TweenService (ref), LocalPlayer (ref)
            TweenService:Create(LocalPlayer.PlayerGui.InGame.BG.Controls, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Position = UDim2.new(1, 0, 0.5, 0)
            }):Play();
            TweenService:Create(LocalPlayer.PlayerGui.InGame.BG.ControlsPC, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Position = UDim2.new(1, 0, 0.5, 0)
            }):Play();
            TweenService:Create(LocalPlayer.PlayerGui.InGame.BG.ControlsConsole, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Position = UDim2.new(1, 0, 0.5, 0)
            }):Play();
            TweenService:Create(LocalPlayer.PlayerGui.InGame.BG.Bottom, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Position = UDim2.new(0.5, 0, 1.24, 0)
            }):Play();
            task.wait(4);
            TweenService:Create(LocalPlayer.PlayerGui.InGame.BG.Controls, TweenInfo.new(0.25, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                Position = UDim2.new(0.5, 0, 0.5, 0)
            }):Play();
            TweenService:Create(LocalPlayer.PlayerGui.InGame.BG.ControlsPC, TweenInfo.new(0.25, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                Position = UDim2.new(0.5, 0, 0.5, 0)
            }):Play();
            TweenService:Create(LocalPlayer.PlayerGui.InGame.BG.ControlsConsole, TweenInfo.new(0.25, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                Position = UDim2.new(0.5, 0, 0.5, 0)
            }):Play();
            TweenService:Create(LocalPlayer.PlayerGui.InGame.BG.Bottom, TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                Position = UDim2.new(0.5, 0, 0.914, 0)
            }):Play();
        end);
    end;

    task.wait(4);
    TweenService:Create(u8.UIGradient, TweenInfo.new(0.5, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
        Offset = Vector2.new(1, 0)
    }):Play();
    task.wait(1);
    u9:Destroy();
    Camera:Destroy();

    if u10 then
        u10:Disconnect();
    end;

    u8:Destroy();
end;