 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local Players = game:GetService("Players");
local UserInputService = game:GetService("UserInputService");
game:GetService("SoundService");
local GuiService = game:GetService("GuiService");
local _ = Players.LocalPlayer;
local v1 = require(ReplicatedStorage.Packages.Knit).CreateController({
    Name = script.Name
});
local Random_new_ret = Random.new();
local u2 = {};

function v1.ChillOut(p3) -- Line: 21
    -- upvalues: TweenService (copy), Random_new_ret (copy), u2 (copy)
    local MapFolder = workspace:FindFirstChild("MapFolder");

    if not MapFolder then
        return;
    end;

    local Crowd = MapFolder:FindFirstChild("Crowd");

    if not Crowd then
        return;
    end;

    for _, child in Crowd:GetChildren() do
        local Attribute = child:GetAttribute("Y");

        if not Attribute then
            child:SetAttribute("Y", child.Position.Y);
        end;

        local Position = child.Position;
        child.Position = Vector3.new(Position.X, Attribute, Position.Z);
        local v4 = TweenService:Create(child, TweenInfo.new(Random_new_ret:NextNumber(0.15, 0.25), Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
            CFrame = child.CFrame * CFrame.new(0, Random_new_ret:NextNumber(0.6, 0.85), 0)
        });
        v4:Play();
        table.insert(u2, v4);
    end;
end;

function v1.CancelChillOut(p5) -- Line: 41
    -- upvalues: u2 (copy)
    local MapFolder = workspace:FindFirstChild("MapFolder");

    if not MapFolder then
        return;
    end;

    local Crowd = MapFolder:FindFirstChild("Crowd");

    if not Crowd then
        return;
    end;

    for _, child in Crowd:GetChildren() do
        local Attribute = child:GetAttribute("Y");

        if not Attribute then
            child:SetAttribute("Y", child.Position.Y);
        end;

        local Position = child.Position;
        child.Position = Vector3.new(Position.X, Attribute, Position.Z);
    end;

    for _, v in u2 do
        v:Cancel();
    end;

    table.clear(u2);
end;

function v1.Cheer(u6) -- Line: 63
    -- upvalues: TweenService (copy), Random_new_ret (copy)
    local MapFolder = workspace:FindFirstChild("MapFolder");

    if not MapFolder then
        return;
    end;

    local Crowd = MapFolder:FindFirstChild("Crowd");

    if not Crowd then
        return;
    end;

    local u7 = Crowd:GetAttribute("Cheering") or 0;
    Crowd:SetAttribute("Cheering", u7 + 1);
    u6:CancelChillOut();

    for _, child in Crowd:GetChildren() do
        local Attribute = child:GetAttribute("Y");

        if not Attribute then
            child:SetAttribute("Y", child.Position.Y);
        end;

        local Position = child.Position;
        child.Position = Vector3.new(Position.X, Attribute, Position.Z);
        TweenService:Create(child, TweenInfo.new(Random_new_ret:NextNumber(0.1, 0.2), Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 6, true), {
            CFrame = child.CFrame * CFrame.new(0, Random_new_ret:NextNumber(0.8, 1.5), 0)
        }):Play();
    end;

    task.delay(2.5, function() -- Line: 85
        -- upvalues: Crowd (copy), u7 (copy), u6 (copy)
        Crowd:SetAttribute("Cheering", u7 - 1);

        if Crowd:GetAttribute("Cheering") <= 0 then
            u6:ChillOut();
        end;
    end);
end;

function v1.Score(p8) -- Line: 93
    -- upvalues: ReplicatedStorage (copy)
    if ReplicatedStorage.GameValues.State.Value == "Intermission" then
        return;
    end;

    p8:Cheer();
end;

function v1.KnitStart(u9) -- Line: 100
    -- upvalues: GuiService (copy), UserInputService (copy), ReplicatedStorage (copy), u2 (copy)
    local MapFolder = workspace:WaitForChild("MapFolder", 5);

    if not MapFolder then
        return;
    end;

    local Crowd = MapFolder:WaitForChild("Crowd", 5);

    if not Crowd then
        return;
    end;

    if GuiService:IsTenFootInterface() or UserInputService.TouchEnabled and not (UserInputService.KeyboardEnabled or UserInputService.MouseEnabled) then
        local Children = Crowd:GetChildren();

        for i = 1, math.ceil(#Children * 0.5) do
            Children[i]:Destroy();
            local _ = i;
        end;
    end;

    for _, child in Crowd:GetChildren() do
        child:SetAttribute("Y", child.Position.Y);
    end;

    u9:ChillOut();
    local GameValues = ReplicatedStorage.GameValues;
    GameValues.Away:GetPropertyChangedSignal("Value"):Connect(function() -- Line: 122
        -- upvalues: u9 (copy)
        u9:Score();
    end);
    GameValues.Home:GetPropertyChangedSignal("Value"):Connect(function() -- Line: 126
        -- upvalues: u9 (copy)
        u9:Score();
    end);
    workspace:GetAttributeChangedSignal("CurrentMap"):Connect(function() -- Line: 130
        -- upvalues: u2 (ref), u9 (copy)
        for _, v in u2 do
            v:Cancel();
        end;

        table.clear(u2);
        local Crowd2 = workspace.MapFolder:FindFirstChild("Crowd");

        if Crowd2 then
            for _, child in Crowd2:GetChildren() do
                child:SetAttribute("Y", child.Position.Y);
            end;
        end;

        u9:ChillOut();
    end);
end;

return v1;