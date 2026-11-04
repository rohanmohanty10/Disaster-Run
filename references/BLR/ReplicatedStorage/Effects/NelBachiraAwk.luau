  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.Popup);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);

function EmitAll(p1)
    local function emit(u2) -- Line: 12
        if u2:IsA("ParticleEmitter") or (u2:IsA("Beam") or u2:IsA("Trail")) then
            local Attribute = u2:GetAttribute("EmitDelay");
            local Attribute2 = u2:GetAttribute("EmitCount");

            if Attribute2 and Attribute2 ~= 0 then
                if Attribute and Attribute ~= 0 then
                    task.delay(Attribute, function() -- Line: 19
                        -- upvalues: u2 (copy), Attribute2 (copy)
                        u2:Emit(Attribute2);
                    end);

                    return;
                end;

                u2:Emit(Attribute2);
            end;
        end;
    end;

    if typeof(p1) == "table" then
        for _, v in p1 do
            if v:IsA("ParticleEmitter") or (v:IsA("Beam") or v:IsA("Trail")) then
                emit(v);
            else
                for _, descendant in v:GetDescendants() do
                    emit(descendant);
                end;
            end;
        end;

        return;
    end;

    if p1:IsA("ParticleEmitter") or (p1:IsA("Beam") or p1:IsA("Trail")) then
        emit(p1);

        return;
    end;

    for _, descendant in p1:GetDescendants() do
        emit(descendant);
    end;
end;

return function(p3) -- Line: 50
    -- upvalues: SoundManager (copy), ReplicatedStorage (copy), TweenService (copy)
    local Character = p3.Plr.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local _ = game.Workspace;
    local Folder = Instance.new("Folder");
    Folder.Parent = workspace.Debris;
    SoundManager.SpawnSoundId("rbxassetid://120234833406886", 3, workspace, 150);
    tick();
    local FieldOfView = game.Workspace.CurrentCamera.FieldOfView;
    local u4 = 0;
    local u7 = game:GetService("RunService").RenderStepped:Connect(function(p5) -- Line: 71
        -- upvalues: u4 (ref)
        u4 = u4 + p5 * 60;
        local script_FOV = script.FOV;
        local math_ceil_ret = math.ceil(u4);
        local v6 = script_FOV:FindFirstChild((tonumber(math_ceil_ret)));

        if not v6 then
            return;
        end;

        game.Workspace.CurrentCamera.FieldOfView = v6.Value;
    end);
    task.spawn(function() -- Line: 83
        -- upvalues: ReplicatedStorage (ref), TweenService (ref)
        local v8 = ReplicatedStorage.Assets.UI.Popup:Clone();
        v8.Parent = game.Players.LocalPlayer.PlayerGui:FindFirstChild("Vignette");
        v8.Position = UDim2.new(0.5, 0, 0.8, 0);
        v8.Size = UDim2.new(1, 0, 0.1, 0);
        v8.BackgroundTransparency = 1;
        v8.AnchorPoint = Vector2.new(0.5, 0.5);
        v8.Font = Enum.Font.ArialBold;
        v8.MaxVisibleGraphemes = 0;
        local UIStroke = Instance.new("UIStroke");
        UIStroke.Parent = v8;
        UIStroke.Thickness = 4;
        UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual;
        v8.MaxVisibleGraphemes = 0;
        v8.TextTransparency = 0;
        v8.TextStrokeTransparency = 0;
        UIStroke.Transparency = 0;
        v8.Text = "I love it...";
        TweenService:Create(v8, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
            MaxVisibleGraphemes = #v8.Text
        }):Play();
        task.wait(1);
        v8.MaxVisibleGraphemes = 0;
        v8.TextTransparency = 0;
        v8.TextStrokeTransparency = 0;
        UIStroke.Transparency = 0;
        task.wait(1);
        v8.Text = "This is getting fun...";
        TweenService:Create(v8, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
            MaxVisibleGraphemes = #v8.Text
        }):Play();
        task.wait(2);
        v8.MaxVisibleGraphemes = 0;
        v8.TextTransparency = 0;
        v8.TextStrokeTransparency = 0;
        UIStroke.Transparency = 0;
        v8.Text = "It\'s my turn again at last...";
        TweenService:Create(v8, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
            MaxVisibleGraphemes = #v8.Text
        }):Play();
        task.wait(2);
        v8.MaxVisibleGraphemes = 0;
        v8.TextTransparency = 0;
        v8.TextStrokeTransparency = 0;
        UIStroke.Transparency = 0;
        v8.Text = "To be super special too...";
        TweenService:Create(v8, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
            MaxVisibleGraphemes = #v8.Text
        }):Play();
        task.wait(1.5);
        v8.MaxVisibleGraphemes = 0;
        v8.TextTransparency = 0;
        v8.TextStrokeTransparency = 0;
        UIStroke.Transparency = 0;
        task.wait(2);
        v8.Text = "Huh???";
        TweenService:Create(v8, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
            MaxVisibleGraphemes = #v8.Text
        }):Play();
        task.wait(1);
        v8.MaxVisibleGraphemes = 0;
        v8.TextTransparency = 0;
        v8.TextStrokeTransparency = 0;
        UIStroke.Transparency = 0;
        v8.TextColor3 = Color3.new(1, 0.772549, 0.243137);
        v8.Text = "Are you scared?";
        TweenService:Create(v8, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
            MaxVisibleGraphemes = #v8.Text
        }):Play();
        task.wait(1);
        v8.MaxVisibleGraphemes = 0;
        v8.TextTransparency = 0;
        v8.TextStrokeTransparency = 0;
        UIStroke.Transparency = 0;
    end);
    local u9 = {};
    local u10 = {};

    for _, child in pairs(game:GetService("Lighting"):GetChildren()) do
        local v11 = child:Clone();
        table.insert(u9, v11);
        child:Destroy();
    end;

    for _, child in pairs(script.Lighting:GetChildren()) do
        local v12 = child:Clone();
        table.insert(u10, v12);
        v12.Parent = game:GetService("Lighting");
    end;

    for _, child in pairs(script.BashiraFace:GetChildren()) do
        local u13 = child:Clone();
        table.insert(u10, u13);
        u13.Parent = Character.Head;
        task.delay(6.3, function() -- Line: 195
            -- upvalues: u13 (copy)
            EmitAll(u13);

            if u13.Name == "Beams" then
                for _, descendant in pairs(u13:GetDescendants()) do
                    if descendant:IsA("Beam") or descendant:IsA("ParticleEmitter") then
                        descendant.Enabled = true;
                    end;
                end;
            end;
        end);
    end;

    for _, child in pairs(script.Assets:GetChildren()) do
        local v14 = child:Clone();
        local v15 = script.HumanoidRootPart.CFrame:Inverse() * child:GetPivot();
        v14:PivotTo(HumanoidRootPart.CFrame * v15);
        v14.Parent = Folder;

        if v14.Name == "Monsters" then
            EmitAll(v14);

            for _, descendant in pairs(v14:GetDescendants()) do
                if descendant:IsA("Beam") or descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end;
    end;

    task.delay(11.1, function() -- Line: 224
        -- upvalues: u7 (ref), FieldOfView (copy), Folder (copy), u9 (copy), u10 (copy)
        if u7 then
            u7:Disconnect();
        end;

        game.Workspace.CurrentCamera.FieldOfView = FieldOfView;
        Folder:Destroy();

        for _, v in pairs(u9) do
            v.Parent = game:GetService("Lighting");
        end;

        for _, v in pairs(u10) do
            v:Destroy();
        end;
    end);
end;